

   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER007.INC'),ONCE        !Local module procedure declarations
                     END


Function_Save_Delivered PROCEDURE  (PAR:File)         ! Declare Procedure
LOC:ingredient_ID    STRING(15)
LOC:Summert_Aktive   LONG
LOC:Summert_Kg       LONG
LOC:Summert_Sekker   LONG
LOC:Date             DATE
LOC:File             STRING(320000)
LOC:LinePnt          LONG,DIM(40000)
LOC:Pointers         LONG,DIM(20)
LOC:StrBuffer        STRING(60)
  CODE
! lagrer data om leveringer hentet med DeliveredRead kommandoen fra Proxy.
! Format:     1:  2010-07-23 12:40:13; Test source; Test; 3;

   LOC:File = PAR:File

   FREE(QDataLines)
   FREE(QDeliveredNode)

   L# = LEN(CLIP(LOC:File))

   I# = 1

   LOC:LinePnt[1] = -1    ! Start av data
   T# = 2

   LOOP L# TIMES
      IF LOC:File[I#] = '<13>' THEN

         LOC:LinePnt[T#] = I#

         QDL:LineDataStr = LOC:File[(LOC:LinePnt[T#-1]+2):(LOC:LinePnt[T#]-1)]

         ADD(QDataLines)

         T# += 1
      END

      I# += 1
   END

   I# = 1

   LOOP
     GET(QDataLines, I#)
     IF ERRORCODE() THEN
        BREAK
     ELSE

        J#=1
        K#=3

        L#   = LEN(CLIP(QDL:LineDataStr))

        LOOP L# TIMES
           IF QDL:LineDataStr[J#] = ';' THEN
              LOC:Pointers[K#] = J#
              K# += 1
           END

           J# += 1
        END

        LOC:Pointers[1] = 1                                         ! Start av linje
        LOC:Pointers[2] = INSTRING(':',CLIP(QDL:LineDataStr),1,1)   ! Slutt på id nummer

        P1# = LOC:Pointers[1]
        P2# = LOC:Pointers[2]
        P3# = LOC:Pointers[3]
        P4# = LOC:Pointers[4]
        P5# = LOC:Pointers[5]
        P6# = LOC:Pointers[6]
        P7# = LOC:Pointers[7]
        P8# = LOC:Pointers[8]
        P9# = LOC:Pointers[9]
        P10# = LOC:Pointers[10]
        P11# = LOC:Pointers[11]

        QDN:ID_DeliverNode = I#
        QDN:id             = QDL:LineDataStr[P1#:P2#-1]              ! id for levering
        QDN:date           = QDL:LineDataStr[P2#+1:P3#-1]           ! Negativ verdi for å ungå problem med 'deleted'
        QDN:source         = QDL:LineDataStr[P3#+2:P4#-1]            ! Leverandør
        QDN:reference      = QDL:LineDataStr[P4#+2:P5#-1]            ! NYTT FELT - Referanse fra leverandør for produkt
        QDN:status         = QDL:LineDataStr[P5#+2:P6#-1]            ! Status
        QDN:iId            = QDL:LineDataStr[P6#+2:P7#-1]            ! NYTT FELT - ingredient id for leveransen
        QDN:barcode        = QDL:LineDataStr[P7#+2:P8#-1]            ! NYTT FELT - Barcode for leveringen
        QDN:count          = QDL:LineDataStr[P8#+2:P9#-1]            ! NYTT FELT - Antall enheter i leveringen
        QDN:perItem        = QDL:LineDataStr[P9#+2:P10#-1]           ! NYTT FELT - Vekt i kg for hver enhet
        QDN:used           = QDL:LineDataStr[P10#+2:P11#-1]           ! NYTT FELT - Antall enhet i levering som er brukt
        QDN:notes          = QDL:LineDataStr[P11#+2:L#]

!        QDN:linjer         = QDL:LineDataStr[P7#+2:P8#-1] dette feltet er ikke lengre i bruk


        ADD(QDeliveredNode)

      END

      I# += 1
   END

!    <id>: <date>; <source>; <reference>; <status>; <iId>; <barcode>; <count>; <peritem>; <used>; <notes>

   STREAM(DelNode)
   IF ERRORCODE() THEN
      MESSAGE(ERROR())
   ELSE

      J# = 1

      LOOP (I#-1) TIMES
         GET(QDeliveredNode,J#)
         IF ERRORCODE() THEN
            MESSAGE(ERROR())
            BREAK
         ELSE
            DNO:Barkode = QDN:barcode
            IF Access:DelNode.Fetch(DNO:K_Barkode) NOT= Level:Benign THEN

!               DNO:ID_DelNode       = QDN:ID_DeliverNode
               DNO:ID_DeliveredNode = QDN:id
               DNO:Dato             = 0                   
               DNO:Time             = 0                   
               DNO:DatoTimeStr      = QDN:date           
               DNO:Kilde            = QDN:source         
               DNO:Referanse        = QDN:reference      
               DNO:Status           = QDN:status         
               DNO:ingredient_id    = QDN:iId            
               DNO:Barkode          = QDN:barcode        
               DNO:Antall           = QDN:count
               DNO:Antall_kg        = DEFORMAT(QDN:count) * DEFORMAT(QDN:perItem)
               DNO:Enhets_Vekt      = QDN:perItem        
               DNO:Brukt            = QDN:used
               DNO:Brukt_kg         = DEFORMAT(QDN:used) * DEFORMAT(QDN:perItem)
               DNO:Lager            = FORMAT((DEFORMAT(QDN:count) - DEFORMAT(QDN:used)), @N_8B)
               DNO:Lager_kg         = DNO:Antall_kg - DNO:Brukt_kg
               DNO:Notater          = QDN:notes

               IF INSTRING('Deleted', DNO:DatoTimeStr,1,1) THEN
                  DNO:Deleted_Flag = 'Deleted'
                  DNO:DatoTimeStr  = DNO:DatoTimeStr[ 12:12+18 ]
               ELSE
                  DNO:Deleted_Flag = ''
                  DNO:DatoTimeStr  = DNO:DatoTimeStr[  3:3+18 ]
               END

               DNO:Dato = DEFORMAT(DNO:DatoTimeStr[1:10],@D010)
               DNO:Time = DEFORMAT(DNO:DatoTimeStr[12:20],@T4)

               IF Access:DelNode.Insert() NOT= Level:Benign THEN
                  MESSAGE('Feil ved lagring til lokalt DelNode register.')
                  BREAK
               END

            ELSE

!               DNO:ID_DelNode       = QDN:ID_DeliverNode
               DNO:ID_DeliveredNode = QDN:id
               DNO:Dato             = 0                   
               DNO:Time             = 0                   
               DNO:DatoTimeStr      = QDN:date           
               DNO:Kilde            = QDN:source         
               DNO:Referanse        = QDN:reference      
               DNO:Status           = QDN:status         
               DNO:ingredient_id    = QDN:iId            
               DNO:Barkode          = QDN:barcode        
               DNO:Antall           = QDN:count
               DNO:Antall_kg        = DEFORMAT(QDN:count) * DEFORMAT(QDN:perItem)
               DNO:Enhets_Vekt      = QDN:perItem        
               DNO:Brukt            = QDN:used
               DNO:Brukt_kg         = DEFORMAT(QDN:used) * DEFORMAT(QDN:perItem)
               DNO:Lager            = FORMAT((DEFORMAT(QDN:count) - DEFORMAT(QDN:used)), @N_8B)
               DNO:Lager_kg         = DNO:Antall_kg - DNO:Brukt_kg
               DNO:Notater          = QDN:notes

               IF INSTRING('Deleted', DNO:DatoTimeStr,1,1) THEN
                  DNO:Deleted_Flag = 'Deleted'
                  DNO:DatoTimeStr  = DNO:DatoTimeStr[ 12:12+18 ]
               ELSE
                  DNO:Deleted_Flag = ''
                  DNO:DatoTimeStr  = DNO:DatoTimeStr[  3:3+18 ]
               END

               DNO:Dato = DEFORMAT(DNO:DatoTimeStr[1:10],@D010)
               DNO:Time = DEFORMAT(DNO:DatoTimeStr[12:20],@T4)

               IF Access:DelNode.Update() NOT= Level:Benign THEN
                  MESSAGE('Feil ved lagring til lokalt DelNode register.')
                  BREAK
               END

            END
         END

         J# += 1
      END

      FLUSH(DelNode)
      IF ERRORCODE() THEN MESSAGE(ERROR()) END
    
   END

   POSTER# = RECORDS(DelNode)
   IF POSTER# THEN

      STREAM(ingredient)

      CLEAR(LOC:ingredient_ID)
      CLEAR(LOC:Summert_Sekker)
      CLEAR(LOC:Summert_Aktive)
      CLEAR(LOC:Summert_Kg)

      CLEAR(DNO:ingredient_id, -1)
      SET(DNO:K_ingredient_id, DNO:K_ingredient_id)

      LOOP POSTER# TIMES
         IF Access:DelNode.Next() NOT= Level:Benign THEN
            BREAK
         END

         IF LOC:ingredient_ID = 0 THEN
            LOC:ingredient_ID = DNO:ingredient_id
         END

         IF LOC:ingredient_ID NOT= DNO:ingredient_id

!            MESSAGE('LOC:ingredient_ID  = ' & LOC:ingredient_ID   & '|' & |
!                    'LOC:Summert_Aktive = ' & LOC:Summert_Aktive  & '|' & |
!                    'LOC:Summert_Kg     = ' & LOC:Summert_Kg )

            ING:id = LOC:ingredient_ID

            IF Access:ingredient.Fetch(ING:K_id) NOT= Level:Benign THEN
!               MESSAGE('Feil ved innhenting av data fra lokalt ingredient register.')
            ELSE
               ING:Lager_Sekker      = LOC:Summert_Sekker
               ING:Aktive_Leveranser = LOC:Summert_Aktive
               ING:Lager_Kg          = LOC:Summert_Kg

               IF Access:ingredient.Update() NOT= Level:Benign THEN
                  MESSAGE('Feil ved lagring av post til lokalt ingredient register.')
               END
            END

            CLEAR(LOC:Summert_Sekker)
            CLEAR(LOC:Summert_Aktive)
            CLEAR(LOC:Summert_Kg)
         END

         LOC:ingredient_ID = DNO:ingredient_id

         IF DNO:Lager_kg NOT= 0 THEN
            LOC:Summert_Aktive += 1
            LOC:Summert_Kg      = LOC:Summert_Kg + DNO:Lager_kg
         END

      END

      FLUSH(Ingredient)

   END

   GLO:Browse_Delivered_Refresh += 1    ! Trigger refresh i browse









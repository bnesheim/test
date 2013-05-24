

   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER005.INC'),ONCE        !Local module procedure declarations
                     END


Function_Save_Tank   PROCEDURE                        ! Declare Procedure
LOC:Pointers         LONG,DIM(20)
LOC:File             STRING(32000)
  CODE
! Rutinen lagrer oppdaterte data for Tank hentet fra data-proxy

   FREE(Qtank)

   I# = 1

   LOOP 
      GET(QDataLines, I#)
      IF ERRORCODE() THEN
         BREAK
      ELSE
         POS# = INSTRING(':',CLIP(QDL:LineDataStr),1,1)

         J#=1
         K#=1

         LOOP POS# TIMES

            IF QDL:LineDataStr[J#] = ' ' THEN
               LOC:Pointers[K#] = J#
               K# += 1
            END

            J# += 1
         END

         P1# = LOC:Pointers[1]
         P2# = LOC:Pointers[2]
         P3# = LOC:Pointers[3]

         QTA:tanknummer = QDL:LineDataStr[1:P1#]
         QTA:mengde     = QDL:LineDataStr[P1#+1:P2#]
         QTA:id         = QDL:LineDataStr[P2#+1:P3#]
         QTA:code       = QDL:LineDataStr[P3#+1:POS#-1]
         QTA:name       = QDL:LineDataStr[POS#+1:LEN(CLIP(QDL:LineDataStr))]
         QTA:RawDataStr = QDL:LineDataStr

         ADD(Qtank)
      END

      I# += 1
   END

   STREAM(sourcetank)
   STREAM(TankData)

   IF ERRORCODE() THEN
      MESSAGE(ERROR())
   ELSE
      J# = 1

      LOOP (I#-1) TIMES
         GET(Qtank,J#)
         IF ERRORCODE() THEN
            MESSAGE(ERROR())
            BREAK
         ELSE
            SOU:tanknummer    = QTA:tanknummer

            IF Access:sourcetank.Fetch(SOU:K_tanknummer) NOT= Level:Benign THEN

!               SOU:ID_sourcetank = J#
               SOU:tanknummer    = QTA:tanknummer
               SOU:mengde        = QTA:mengde
               SOU:id            = QTA:id
               SOU:code          = QTA:code
               SOU:name          = QTA:name
               SOU:RawDataStr    = QTA:RawDataStr
      
               IF Access:sourcetank.Insert() NOT= Level:Benign THEN
                  MESSAGE('Feil ved lagring til lokalt sourcetank register.')
               ELSE
                  TAN:id_tank    = SOU:tanknummer
                  TAN:barcode    = ''
                  TAN:warning    = '0'
                  TAN:alarm      = '0'
                  TAN:maximum    = '0'
                  TAN:volume     = '0'
                  TAN:weightname = ''
                  TAN:notes      = ''

                  IF Access:TankData.Insert() NOT= Level:Benign THEN
                     MESSAGE('Feil ved oppretting av post i lokalt TankData register.')
                     BREAK
                  END
               END
            ELSE
               SOU:tanknummer    = QTA:tanknummer

               IF Access:sourcetank.Fetch(SOU:K_tanknummer) = Level:Benign THEN

                  SOU:tanknummer    = QTA:tanknummer
                  SOU:mengde        = QTA:mengde
                  SOU:id            = QTA:id
                  SOU:code          = QTA:code
                  SOU:name          = QTA:name
                  SOU:RawDataStr    = QTA:RawDataStr

                  IF Access:sourcetank.Update() NOT=Level:Benign THEN
                     MESSAGE('Feil ved updatering av lokalt tank register.')
                  END
               ELSE

                  SOU:tanknummer    = QTA:tanknummer
                  SOU:mengde        = QTA:mengde
                  SOU:id            = QTA:id
                  SOU:code          = QTA:code
                  SOU:name          = QTA:name
                  SOU:RawDataStr    = QTA:RawDataStr

                  IF Access:sourcetank.Update() NOT=Level:Benign THEN
                     MESSAGE('Feil ved updatering av lokalt tank register.')
                  ELSE
                     TAN:id_tank    = SOU:tanknummer
                     TAN:barcode    = ''
                     TAN:warning    = '0'
                     TAN:alarm      = '0'
                     TAN:maximum    = '0'
                     TAN:volume     = '0'
                     TAN:weightname = ''
                     TAN:notes      = ''

                     IF Access:TankData.Insert() NOT= Level:Benign THEN
                        MESSAGE('Feil ved oppretting av post i lokalt TankData register.')
                        BREAK
                     END
                  END

               END
            END

         END

         J# += 1
      END
   END

   FLUSH(sourcetank)
   IF ERRORCODE() THEN MESSAGE(ERROR()) END

   FLUSH(TankData)
   IF ERRORCODE() THEN MESSAGE(ERROR()) END

   POST(EVENT:SelfReset)








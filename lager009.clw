

   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER009.INC'),ONCE        !Local module procedure declarations
                     END


Function_Save_TankData PROCEDURE                      ! Declare Procedure
LOC:Pointers         LONG,DIM(20)
  CODE
! Lager data returnert fra proxy for TankDataRead kommandoen.
! format:<tankNo>: <barcode> <notes>
!
! Felter: ID_TankData       STRING(15)
!         id                STRING(15)
!         barcode           STRING(25)
!         weightname        STRING(15)
!         notes             STRING(150)

   FREE(QTankData)

   I# = 1

   LOOP
      GET(QDataLines, I#)
      IF ERRORCODE() THEN
         BREAK
      ELSE
         LOC:Pointers[1] = 1        ! Start av linje

         J#=1
         K#=2

         L#   = LEN(CLIP(QDL:LineDataStr))

         LOOP L# TIMES
            IF QDL:LineDataStr[J#] = ' ' THEN
               LOC:Pointers[K#] = J#
               K# += 1
            END
            J# += 1
         END

         P1# = LOC:Pointers[1]      ! Start av linje
         P2# = LOC:Pointers[2]      ! Slutt på ID = tanknummer
         P3# = LOC:Pointers[3]      ! Slutt på barcode
         P4# = LOC:Pointers[4]      ! Slutt på warb
         P5# = LOC:Pointers[5]      ! Slutt på alarm
         P6# = LOC:Pointers[6]      ! Slutt på maximum
         P7# = LOC:Pointers[7]      ! Slutt på volumer
         P8# = L#                   ! Slutt på notater (=END_OF_LINE)

         QTA:ID_Tankdata = I#
         QTA:weightname  = ''
         QTA:id_tank     = QDL:LineDataStr[P1#:P2#-2]
         QTA:barcode     = QDL:LineDataStr[P2#+1:P3#]
         QTA:warning     = QDL:LineDataStr[P3#+1:P4#]
         QTA:alarm       = QDL:LineDataStr[P4#+1:P5#]
         QTA:maximum     = QDL:LineDataStr[P5#+1:P6#]
         QTA:volume      = QDL:LineDataStr[P6#+1:P7#]
         QTA:notes       = QDL:LineDataStr[P7#+1:P8#]

         ADD(QTankData)

      END

      I# += 1
   END

   STREAM(Tankdata)
   IF ERRORCODE() THEN
      MESSAGE(ERROR())
   ELSE

      J# = 1

      LOOP RECORDS(QTankData) TIMES

         GET(QTankData,J#)
         IF ERRORCODE() THEN
            MESSAGE(ERROR())
            BREAK
         ELSE
            TAN:id_tank     = QTA:id_tank

            IF Access:TankData.Fetch(TAN:K_id_tank) NOT= Level:Benign THEN
!               MESSAGE('Feil ved innhenting av lokal lagringspost for TankData.')
               BREAK
            ELSE
               TAN:weightname  = QTA:weightname
               TAN:id_tank     = QTA:id_tank
               TAN:barcode     = QTA:barcode
               TAN:warning     = QTA:warning
               TAN:alarm       = QTA:alarm
               TAN:maximum     = QTA:maximum
               TAN:volume      = QTA:volume
               TAN:notes       = QTA:notes

               IF Access:TankData.Update() NOT= Level:Benign THEN
                  MESSAGE('Feil ved lagring av lokal TankData post.')
                  BREAK
               END
            END
         END

         J# += 1
      END

      FLUSH(Tankdata)
      IF ERRORCODE() THEN MESSAGE(ERROR()) END
    
   END

   POST(EVENT:SelfReset)




















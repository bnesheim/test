

   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER022.INC'),ONCE        !Local module procedure declarations
                     END


Funksjon_LargeLabel  PROCEDURE                        ! Declare Procedure
LOC:RecordAntall     LONG
LOC:Kode             STRING(20)
LOC:Antall           LONG
LOC:Tekst            STRING(20)
! oppsett for file

LabelData      FILE,DRIVER('ASCII'),NAME(FileName),CREATE,PRE(LAB)
RECORD            RECORD
LabelStr             STRING(250)
                  END
               END
  CODE
! Oppsett av filedata for label fra QUEUE
! Eksempelformat:
!
!   ^02L
!   H07
!   D11
!   19110060155001510K-14WATT1234567890
!   19110050133002510K-15WATT
!   19110050111002510K-16WATT1234567890
!   D21
!   1e8207000350070166
!   191100400100100166
!   E
!
!                         BcH  Row  Col
!   stringformat: 1 2 1 1 000 0005 0005

   FileName = 'LabelStr.txt'

   LOC:RecordAntall = RECORDS(QPrintLabelData)

   IF LOC:RecordAntall > 0 THEN

      CREATE(LabelData)
      IF ERRORCODE() THEN
        IF ERRORCODE() = 90 THEN
          MESSAGE('Error: '& FILEERROR())
        ELSE
          MESSAGE('Error: '& ERROR())
        END
      END

      OPEN(LabelData)
      IF ERRORCODE() THEN
        IF ERRORCODE() = 90 THEN
          MESSAGE('Error: '& FILEERROR())
        ELSE
          MESSAGE('Error: '& ERROR())
        END
      END

      I# = 1

      LOOP LOC:RecordAntall TIMES

         GET(QPrintLabelData,I#)
         IF ERRORCODE() THEN
            MESSAGE( ERROR() )
            BREAK
         ELSE

            LAB:LabelStr = '^02L'                                         & |
                           '<13><10>H07'                                  & |
                           '<13><10>D11'                                  & |
                           '<13><10>191100601550025' & CLIP(QPL:Text1)    & |
                           '<13><10>191100501330025' & CLIP(QPL:Text2)    & |
                           '<13><10>191100501110025' & CLIP(QPL:Text3)    & |
                           '<13><10>D21'                                  & |
                           '<13><10>1e8207000350070' & CLIP(QPL:Barcode)  & |
                           '<13><10>D11'                                  & |
                           '<13><10>191100400100100' & CLIP(QPL:Barcode)  & |
                           '<13><10>E'

            LOOP QPL:KopiAntall TIMES
              APPEND(LabelData)
              IF ERRORCODE() THEN
                IF ERRORCODE() = 90 THEN
                  MESSAGE('Error: '& FILEERROR())
                ELSE
                  MESSAGE('Error: '& ERROR())
                END
                BREAK
              END
            END
            I# += 1
         END
      END
      CLOSE(LabelData)
   END

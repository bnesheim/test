

   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER021.INC'),ONCE        !Local module procedure declarations
                     END


Funksjon_MakeLabel   PROCEDURE  (PAR:Kode,PAR:Tekst,PAR:Antall) ! Declare Procedure
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
! Oppsett av filedata for label

  FileName = 'LabelStr.txt'

  LOC:Kode   = CLIP(PAR:Kode)
  LOC:Tekst  = CLIP(PAR:Tekst)
  LOC:Antall = DEFORMAT(PAR:Antall)

  IF LOC:Antall < 1 THEN
    LOC:Antall = 1
  END

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

  LAB:LabelStr = '^02L<13><10>H07<13><10>D11<13><10>191100601500050' & CLIP(LOC:Tekst) & |
                 '<13><10>1e8210000400050' & CLIP(LOC:Kode) &                            |
                 '<13><10>191100400150100' & CLIP(LOC:Kode) &                            |
                 '<13><10>E'

  LOOP LOC:Antall TIMES
    APPEND(LabelData)
    IF ERRORCODE() THEN
      IF ERRORCODE() = 90 THEN
        MESSAGE('Error: '& FILEERROR())
      ELSE
        MESSAGE('Error: '& ERROR())
      END
    END
  END

  CLOSE(LabelData)


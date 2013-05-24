

   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER014.INC'),ONCE        !Local module procedure declarations
                     END


Function_Display_QDataLines PROCEDURE  (PAR:Beskrivelse) ! Declare Procedure
LOC:Beskrivelse      STRING(200)
LOC:LineBuffer       STRING(320000)
  CODE
! Setter opp MESSAGE() med data lagret i QDataLines køen.

   LOC:Beskrivelse = PAR:Beskrivelse

   LOC:LineBuffer = ''

   I# = 1

   LOOP RECORDS(QDataLines) TIMES

      GET(QDataLines, I#)
      E# = ERRORCODE()
      IF E# THEN
         MESSAGE( 'QUEUE error: ' & ERROR() )
      ELSE
         LOC:LineBuffer = CLIP(LOC:LineBuffer)   & |
                          CLIP(QDL:LineDataStr)  & |
                          '|'
         I# += 1
      END
   END

   IF LOC:LineBuffer NOT= '' THEN
      LOC:LineBuffer = CLIP(LOC:Beskrivelse) & '|' & CLIP(LOC:LineBuffer)
!      MESSAGE(LOC:LineBuffer)
   END

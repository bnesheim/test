

   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER024.INC'),ONCE        !Local module procedure declarations
                     END


Function_Set_QDataLines PROCEDURE  (PAR:File)         ! Declare Procedure
LOC:File             STRING(320000)
LOC:LinePnt          LONG,DIM(40000)
LOC:Pointers         LONG,DIM(20)
  CODE
! Setter QDataLines QUEUE fra proxy returndata.

   LOC:File = PAR:File

   FREE(QDataLines)
 
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

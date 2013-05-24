

   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER006.INC'),ONCE        !Local module procedure declarations
                     END


Function_Save_Weights PROCEDURE                       ! Declare Procedure
LOC:Pointers         LONG,DIM(20)
  CODE
! lagrer data om vekter hentet med ListWeights kommandoen fra Proxy.
! Returformatet for denne kommandoen lister allle navne på en linje.

   FREE(Qweights)

   GET(QDataLines, 1)
   IF ERRORCODE() THEN
!      MESSAGE(ERROR())
   ELSE

      L#=LEN(CLIP(QDL:LineDataStr))

      J#=1
      K#=2

      LOC:Pointers[1] = 0   ! Setter Start av linjen

      LOOP L# TIMES
         IF (QDL:LineDataStr[J#] = ',') OR (J# = L#) THEN
            LOC:Pointers[K#] = J#

            P1# = LOC:Pointers[K#-1]

            IF J# = L# THEN
               P2# = J#+1
            ELSE
               P2# = LOC:Pointers[K#]
            END

            QWE:WeightName = LEFT(QDL:LineDataStr[P1#+1:P2#-1])

            MESSAGE(QWE:WeightName)

            ADD(Qweights)

            K# += 1
         END

         J# += 1
      END
   END

   STREAM(weight)
   IF ERRORCODE() THEN
      MESSAGE(ERROR())
   ELSE
      A# = 1
      B# = K#

      LOOP (B#-1) TIMES
         GET(Qweights,A#)
         IF ERRORCODE() THEN
            MESSAGE(ERROR())
            BREAK
         ELSE

            WEI:ID_weight  = A#
            WEI:weight     = QWE:WeightName
            WEI:visualName = QWE:WeightName
   
            ADD(weight)
            IF ERRORCODE() THEN
               MESSAGE('Feil ved lagring: ' & ERROR())
               BREAK
            END

         END

         A# += 1
      END
   END

   FLUSH(weight)
   IF ERRORCODE() THEN MESSAGE(ERROR()) END








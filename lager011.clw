

   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER011.INC'),ONCE        !Local module procedure declarations
                     END


Function_Save_IngDataRead PROCEDURE                   ! Declare Procedure
LOC:File             STRING(320000)
LOC:LinePnt          LONG,DIM(40000)
LOC:Pointers         LONG,DIM(20)
LOC:SemiKollons      LONG,DIM(20)
  CODE
! Lagrer mottatt fra proxy for IngDataRead kommandoen

   FREE(QIngData)

   I# = 1

   LOOP
      GET(QDataLines, I#)
      IF ERRORCODE() THEN
         BREAK
      ELSE

         L#   = LEN(CLIP(QDL:LineDataStr))
         POS# = INSTRING(':', QDL:LineDataStr,1,1)

         QID:ID_IngData        = I#
         QID:ingredientId      = QDL:LineDataStr[1:POS#-1]
         QID:Notes             = QDL:LineDataStr[POS#+2:L#]
         QID:OrginalDataStr    = CLIP(QDL:LineDataStr)

         ADD(QIngData)

      END

      I# += 1
   END

   STREAM(IngData)
   IF ERRORCODE() THEN
      MESSAGE(ERROR())
   ELSE

      J# = 1

      LOOP (I#-1) TIMES
         GET(QIngData,J#)
         IF ERRORCODE() THEN
            MESSAGE(ERROR())
            BREAK
         ELSE
            IND:ingredientId = QID:ingredientId

            IF Access:IngData.Fetch(IND:K_ingredientId) NOT= Level:Benign THEN

               IF QID:ingredientId = 0 THEN
                  MESSAGE('Feil ved innhenting av lagringspost for IngData.')
               ELSE
                  IND:ingredientId      = QID:ingredientId
                  IND:Notes             = QID:Notes
                  IND:OrginalDataStr    = QID:OrginalDataStr

                  IF Access:IngData.Insert() NOT= Level:Benign THEN
                     MESSAGE('Feil ved lagring av IngData post.')
                     BREAK
                  END
               END

            ELSE

               IND:ingredientId      = QID:ingredientId
               IND:Notes             = QID:Notes
               IND:OrginalDataStr    = QID:OrginalDataStr

               IF Access:IngData.Update() NOT= Level:Benign THEN
                  MESSAGE('Feil ved lagring av IngData post.')
                  BREAK
               END
            END

         END

         J# += 1
      END

   END

   FLUSH(IngData)
   IF ERRORCODE() THEN MESSAGE(ERROR()) END





























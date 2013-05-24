

   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER004.INC'),ONCE        !Local module procedure declarations
                     END


Function_Save_Ingredients PROCEDURE                   ! Declare Procedure
LOC:LinePnt          LONG,DIM(40000)
LOC:Oppdater_Flag    LONG
  CODE
! Rutinen lagrer oppdaterte data for Ingredients hentet fra data-proxy

   FREE(Qingredient)

   I# = 1

   LOOP 10000 TIMES
      GET(QDataLines, I#)
      IF ERRORCODE() THEN
         BREAK
      ELSE
         POS# = INSTRING(':',CLIP(QDL:LineDataStr),1,1)
         P1#  = INSTRING(' ',CLIP(QDL:LineDataStr),1,1)        ! Første kommando
         P2#  = LEN(CLIP(QDL:LineDataStr))

         QIN:RawDataStr    = CLIP(QDL:LineDataStr)
         QIN:id            = CLIP(QDL:LineDataStr[1:P1#])
         QIN:code          = QDL:LineDataStr[P1#+1:POS#-1]
         QIN:name          = QDL:LineDataStr[POS#+2:LEN(CLIP(QDL:LineDataStr))]

         ADD(Qingredient)
         I# += 1
      END
   END

   STREAM(ingredient)
   STREAM(IngData)
   IF ERRORCODE() THEN
      MESSAGE(ERROR())
   ELSE
      J# = 1

      LOOP (I#-1) TIMES
         GET(Qingredient,J#)
         IF ERRORCODE() THEN
            MESSAGE(ERROR())
            BREAK
         ELSE
            ING:id = QIN:id

            IF Access:ingredient.Fetch(ING:K_id) NOT= Level:Benign THEN

               ING:RawDataStr    = QIN:RawDataStr
               ING:name          = QIN:name
               ING:id            = QIN:id
               ING:code          = QIN:code
               ING:code_name_str = CLIP(QIN:code) & ': ' & CLIP(QIN:name)

               IF Access:ingredient.Insert() NOT= Level:Benign THEN
                  MESSAGE('Feil ved oppdatering av lokalt ingredient register.')
               ELSE
                  IND:ingredientId       = ING:id
                  IND:Notes              = ''
                  IND:OrginalDataStr     = ''

                  IF Access:IngData.Insert() NOT= Level:Benign THEN
                     MESSAGE('Feil ved oppretting av tilhørende lokal post for ingredient info')
                  END
               END
            ELSE
               ING:RawDataStr    = QIN:RawDataStr
               ING:name          = QIN:name
               ING:id            = QIN:id
               ING:code          = QIN:code
               ING:code_name_str = CLIP(QIN:code) & ': ' & CLIP(QIN:name)

               IF Access:ingredient.Update() NOT= Level:Benign THEN
                  MESSAGE('Feil ved oppdatering av lokalt ingredient register.')
               END
            END

            J# += 1
         END
      END

      FLUSH(ingredient)
      IF ERRORCODE() THEN MESSAGE(ERROR()) END
   
      FLUSH(IngData)
      IF ERRORCODE() THEN MESSAGE(ERROR()) END

   END



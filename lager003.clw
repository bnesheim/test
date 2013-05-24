

   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER003.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('LAGER004.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER005.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER006.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER007.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER009.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER010.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER011.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER012.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER014.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER015.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER024.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER025.INC'),ONCE        !Req'd for module callout resolution
                     END


Function_ReadCompleted PROCEDURE  (PAR:Command,PAR:File) ! Declare Procedure
LOC:LinePnt          LONG,DIM(4000)
LOC:ingredient_ID    STRING(15)
LOC:ReturnInfo       STRING(100)
LOC:Command          STRING(60)
LOC:Command_Str      STRING(200)
LOC:WorkFile         STRING(200000)
  CODE
! Behandler data lest inn fra proxy

   LOC:Command  = PAR:Command
   LOC:WorkFile = PAR:File

   DISPLAY()

   CASE LOC:Command

   OF 'RefillCheck'
      GLO:Liste_Paafyllingsvarsel = LOC:WorkFile

   OF 'BarcodeReadCode'

       L# = LEN(CLIP(LOC:WorkFile))

       I# = 1

       LOC:LinePnt[1] = 1    ! Start av data
       T# = 2

       LOOP L# TIMES
          IF LOC:WorkFile[I#] = ';' THEN

             LOC:LinePnt[T#] = I#

             T# += 1
          END

          I# += 1
       END

       P1# = LOC:LinePnt[5]
       P2# = LOC:LinePnt[6]

!    <id>: <date>; <source>; <reference>; <status>; <iId>; <barcode>; <count>; <peritem>; <used>; <notes>

      GLO:Valgt_Delivered_ID      = LOC:WorkFile[1:(INSTRING(':',LOC:WorkFile)-1)]
      GLO:Valgt_Delivered_Count   = LOC:WorkFile[LOC:LinePnt[7]+1:LOC:LinePnt[8]-1]
      GLO:Valgt_Delivered_perItem = LOC:WorkFile[LOC:LinePnt[8]+1:LOC:LinePnt[9]-1]

!      MESSAGE( GLO:Valgt_Delivered_Count & '|' & CLIP(LOC:WorkFile) )

      LOC:ingredient_ID = LOC:WorkFile[P1#+1:P2#]
      MY# = DEFORMAT(LOC:ingredient_ID)
      LOC:ingredient_ID = MY#

      GLO:Valgt_Ingredient_ID = CLIP(LOC:ingredient_ID)

      IF GLO:Valgt_Ingredient_ID NOT= '' THEN
         POST(EVENT:CheckRefillCodes)
      END


   OF 'BarcodeSetNew'
      GET(QDataLines, 1)
      NY# = DEFORMAT( QDL:LineDataStr )
      GLO:Ny_Barcode = NY#

      DISPLAY()

      Function_Add_Command( 'BarcodeSet', 'BarcodeSet ' & GLO:Ny_Barcode & '; New; Delivery' )

   OF 'DeliveredSetNew'
      Function_Display_QDataLines('Status register leveringnode:')

      GET(QDataLines, 1)
      NY# = DEFORMAT( QDL:LineDataStr[3:LEN(QDL:LineDataStr)] )
      GLO:ID_DeliveredLine = NY#

   OF 'DeliveredLinesSetNew'
      Function_Display_QDataLines('Ny Linje for levering:')

   OF 'DeliveredRead'
      Function_Save_Delivered(LOC:WorkFile)

   OF 'DeliveredCancel'
      Function_Display_QDataLines('Levering slettet:')

   OF 'ListIngredients'
      Function_Set_QDataLines(LOC:WorkFile)
      Function_Save_Ingredients()

   OF 'UsedLine'
      Function_Display_QDataLines('Forbruk registert:')

   OF 'UsedLineHistory'
      Function_Set_QDataLines(LOC:WorkFile)
      Function_Save_UsedLineHistory()

   OF 'ListWeights'
      Function_Save_Weights()

   OF 'Tank'
      Function_Set_QDataLines(LOC:WorkFile)
      Function_Save_Tank()

   OF 'TankAdd'
      Function_Display_QDataLines('Tankmengde oppdatert:')

   OF 'TankDataRead'
      Function_Set_QDataLines(LOC:WorkFile)
      Function_Save_TankData()

   OF 'TankDataSet'
      Function_Display_QDataLines('Tankdata oppdatert:')

   OF 'BarcodeRead'
      Function_Save_BarcodeRead(LOC:WorkFile)

   OF 'BarcodeSet'
      Function_Display_QDataLines('barcodeSet utført:')

   OF 'IngDataSet'
      Function_Display_QDataLines('IngDataSet utført:')

   OF 'IngDataRead'
      Function_Set_QDataLines(LOC:WorkFile)
      Function_Save_IngDataRead()

   OF 'LogOpen'
      GLO:File = LOC:WorkFile
      START(Display_Log, 50000)

   OF 'LogPage'
      GLO:File = LOC:WorkFile
!     DISPLAY()

   OF 'LogWrite'
      Function_Display_QDataLines('Data skrevet til log:')

   OF 'Unique'
      Function_Display_QDataLines('Unique test:')

   OF 'LampOn'
      Function_Display_QDataLines('LampOn test:')

   OF 'LampOff'
      Function_Display_QDataLines('LampOff test:')

   OF 'Status'
      Function_Display_QDataLines('Status test:')

   ELSE
!      MESSAGE('Ukjent proxy-kommando: ' & LOC:Command)
   END


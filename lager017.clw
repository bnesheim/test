

   MEMBER('lager.clw')                                ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LAGER017.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('LAGER012.INC'),ONCE        !Req'd for module callout resolution
                     END


Oppdater_IngData_Notes PROCEDURE (PAR:ID_Ingredients,PAR:ID_IngData) !Generated from procedure template - Window

LOC:Notes            STRING(150)
LOC:Update_Flag      LONG(0)
LOC:Command          STRING(100)
LOC:Command_Str      STRING(200)
LOC:ID_Ingredients   LONG
LOC:ID_IngData       LONG
Window               WINDOW('Oppdater mengdedata for ingrediens'),AT(,,421,168),FONT('MS Sans Serif',8,,FONT:regular),ICON(ICON:Application),SYSTEM,GRAY,MAX,RESIZE,IMM
                       PANEL,AT(1,2,417,147),USE(?Panel1)
                       STRING(@s10),AT(12,9),USE(ING:id),FONT(,12,,FONT:bold)
                       STRING(@s10),AT(12,26),USE(ING:code),FONT(,12,,FONT:bold)
                       STRING(@s60),AT(12,43,399,14),USE(ING:name),FONT(,12,,FONT:bold)
                       STRING('Notater for ingrediens'),AT(17,68),USE(?Str_Notater),FONT(,12,,)
                       TEXT,AT(16,84,381,49),USE(LOC:Notes),FONT(,12,,)
                       BUTTON('Oppdater ingrediens notater'),AT(119,151,219,16),USE(?But_Oppdater),FONT(,14,,)
                       BUTTON('Avbryt'),AT(5,151,57,16),USE(?Close),FONT(,14,,)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()
  RETURN(LOC:Update_Flag)


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Oppdater_IngData_Notes')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SELF.AddItem(?Close,RequestCancelled)
  Relate:IngData.Open
  Relate:ingredient.Open
  SELF.FilesOpened = True
  OPEN(Window)
  SELF.Opened=True
  ! Henter verdier for valgt post
  
     LOC:ID_Ingredients = DEFORMAT( PAR:ID_Ingredients )
     LOC:ID_IngData     = DEFORMAT( PAR:ID_IngData )
  
     ING:ID_ingredient = LOC:ID_Ingredients
  
     IF Access:ingredient.Fetch(ING:K_ID_ingredient) NOT= Level:Benign THEN
        MESSAGE('Feil ved innhenting av data fra lokalt ingredients register.')
     ELSE
        IND:ID_IngData = LOC:ID_IngData
  
        IF Access:IngData.Fetch(IND:K_ID_IngData) NOT= Level:Benign THEN
           MESSAGE('Feil ved innhenting av data fra lokalt IngData register.')
        ELSE
           LOC:Notes = IND:Notes
        END
     END
  
  
  
  
  INIMgr.Fetch('Oppdater_IngData_Notes',Window)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:IngData.Close
    Relate:ingredient.Close
  END
  IF SELF.Opened
    INIMgr.Update('Oppdater_IngData_Notes',Window)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?But_Oppdater
      ThisWindow.Update
      ! Lagrer oppdatering
      
         IF LOC:Notes = '' THEN
            IND:Notes = '.'
         ELSE
            IND:Notes = CLIP(LOC:Notes)
         END
      
         IF Access:IngData.Update() NOT= Level:Benign THEN
            MESSAGE('Feil ved lagring til lokalt IngData register.')
         END
      
         LOC:Command     = 'IngDataSet'
         LOC:Command_Str = 'IngDataSet '                    & |
                            CLIP(IND:ingredientId)  & '; '  & |
                            CLIP(IND:Notes)
      
         Function_Add_Command( LOC:Command, LOC:Command_Str)
      
         LOC:Update_Flag = 1    ! = Oppdatert
      
         POST(EVENT:CloseWindow)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue




   MEMBER('lager.clw')                                ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LAGER023.INC'),ONCE        !Local module procedure declarations
                     END


Registrer_Merknad_usedline PROCEDURE (PAR:Merknad)    !Generated from procedure template - Window

LOC:Merknad          STRING(150)
LOC:Return_Tekst     STRING(150)
Window               WINDOW('Rediger programmets oppstartsverdier'),AT(,,320,95),FONT('Arial',10,,,CHARSET:ANSI),GRAY
                       STRING('Les inn forbruksmerknad'),AT(98,5),USE(?Str_Header),TRN,FONT(,16,,)
                       PANEL,AT(1,21,318,48),USE(?Panel3)
                       TEXT,AT(3,26,313,35),USE(LOC:Merknad),HVSCROLL,FONT('Arial',12,,FONT:regular,CHARSET:ANSI)
                       PANEL,AT(1,69,318,24),USE(?Panel2),FILL(COLOR:Teal),BEVEL(2,-2)
                       BUTTON('Avbryt'),AT(257,73,55,16),USE(?Close),FONT(,14,,)
                       BUTTON('Bruk innlesing'),AT(9,73,93,16),USE(?Button1),FONT(,14,,,CHARSET:ANSI)
                       PANEL,AT(1,1,318,20),USE(?Panel1),FILL(080B000H),BEVEL(2,-2)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()
  RETURN(LOC:Return_Tekst)


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Registrer_Merknad_usedline')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Str_Header
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SELF.AddItem(?Close,RequestCancelled)
  OPEN(Window)
  SELF.Opened=True
  ! Setter verdier ved oppstart av funksjon
  
     LOC:Merknad = PAR:Merknad
  
     CLEAR(LOC:Return_Tekst)
  INIMgr.Fetch('Registrer_Merknad_usedline',Window)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('Registrer_Merknad_usedline',Window)
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
    OF ?Button1
      ThisWindow.Update
      ! Lagrer verdier for oppstart av program
      
         IF LOC:Merknad = '' THEN
            LOC:Return_Tekst = 'none'
         ELSE
            LOC:Return_Tekst = CLIP(LOC:Merknad)
         END
      
         POST(EVENT:CloseWindow)
      
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


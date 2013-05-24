

   MEMBER('lager.clw')                                ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LAGER015.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('LAGER012.INC'),ONCE        !Req'd for module callout resolution
                     END


Display_Log PROCEDURE                                 !Generated from procedure template - Window

LOC:PageLines        LONG(20)
LOC:PageStart        LONG(-1)
LOC:PageEnd          LONG(-5)
LOC:ReadList         STRING(32000)
LOC:ReadListOrg      STRING(32000)
Window               WINDOW('Log registreringer'),AT(,,527,283),FONT('Arial',8,,FONT:regular),ICON(ICON:Application),SYSTEM,GRAY,MAX,RESIZE,AUTO,IMM
                       TEXT,AT(4,3,522,258),USE(GLO:File),HVSCROLL
                       BUTTON('Avslutt'),AT(5,265,,16),USE(?Button1),FONT(,14,,,CHARSET:ANSI)
                       BUTTON('Neste side'),AT(136,266,82,16),USE(?But_Neste_Side),FONT(,14,,,CHARSET:ANSI)
                       BUTTON('Forrige side'),AT(231,266,82,16),USE(?But_Forrige_Side),FONT(,14,,)
                       PROMPT('Linjer per side'),AT(324,269),USE(?LOC:PageLines:Prompt),TRN,FONT('Arial',10,,,CHARSET:ANSI)
                       ENTRY(@n-_8B),AT(381,267,27,13),USE(LOC:PageLines),RIGHT(3),FONT(,10,,)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Display_Log')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?GLO:File
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  OPEN(Window)
  SELF.Opened=True
  INIMgr.Fetch('Display_Log',Window)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('Display_Log',Window)
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
      ! Lukker vinduet
      
         POST(EVENT:CloseWindow)
      
    OF ?But_Neste_Side
      ThisWindow.Update
      ! Visning av logside (neste side)
      
         LOC:PageStart = LOC:PageStart - LOC:PageLines
         LOC:PageEnd   = LOC:PageEnd   - LOC:PageLines
      
         Function_Add_Command( 'LogPage', 'Log ' & LOC:PageStart & ' ' & LOC:PageEnd )
      
         POST(EVENT:WriteCommand,,1,)
      
    OF ?But_Forrige_Side
      ThisWindow.Update
      ! Visning av logside (forrige side)
      
         LOC:PageStart = LOC:PageStart + LOC:PageLines
         LOC:PageEnd   = LOC:PageEnd   + LOC:PageLines
      
         Function_Add_Command( 'LogPage', 'Log ' & LOC:PageStart & ' ' & LOC:PageEnd )
      
         POST(EVENT:WriteCommand,,1,)
      
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


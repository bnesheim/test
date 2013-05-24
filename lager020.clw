

   MEMBER('lager.clw')                                ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LAGER020.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('LAGER021.INC'),ONCE        !Req'd for module callout resolution
                     END


Test_LabelPrinter PROCEDURE                           !Generated from procedure template - Window

LOC:Antall           LONG(1)
LOC:Label_Nummer     STRING(20)
LOC:Label_Tekst      STRING(20)
Window               WINDOW('Standard vindu'),AT(,,300,230),FONT('Arial',10,,,CHARSET:ANSI),SYSTEM,GRAY,MAX,RESIZE,IMM
                       PANEL,AT(1,1,298,22),USE(?Panel_Header),FILL(0FF8000H),BEVEL(2,-2)
                       STRING('<<Headertekst>'),AT(119,5),USE(?Str_Header),TRN,FONT(,14,,)
                       PANEL,AT(1,23,298,184),USE(?Panel_Body)
                       PROMPT('Nummer'),AT(7,38),USE(?LOC:Label_Nummer:Prompt),FONT(,12,,)
                       ENTRY(@s20),AT(42,38),USE(LOC:Label_Nummer),FONT(,12,,),MSG('- Number som brukes på testlabel'),TIP('- Number som brukes på testlabel')
                       PROMPT('Tekst'),AT(18,55),USE(?LOC:Label_Tekst:Prompt),FONT(,12,,)
                       ENTRY(@s20),AT(42,55),USE(LOC:Label_Tekst),FONT(,12,,,CHARSET:ANSI),MSG('- Tekst brukt på testlabel'),TIP('- Tekst brukt på testlabel')
                       STRING('Antall'),AT(18,72),USE(?String2),FONT(,12,,,CHARSET:ANSI)
                       ENTRY(@n_10B),AT(42,72,30,13),USE(LOC:Antall),RIGHT(3),FONT(,12,,,CHARSET:ANSI),MSG('- Tekst brukt på testlabel'),TIP('- Tekst brukt på testlabel')
                       BUTTON('TestLabel'),AT(191,211,98,14),USE(?Button2),FONT(,14,,)
                       PANEL,AT(1,207,298,22),USE(?Panel_Footer),FILL(0808040H),BEVEL(2,-2)
                       BUTTON('&Avbryt'),AT(10,211,45,14),USE(?Avbryt),FONT(,14,,)
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
  GlobalErrors.SetProcedureName('Test_LabelPrinter')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel_Header
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  OPEN(Window)
  SELF.Opened=True
  INIMgr.Fetch('Test_LabelPrinter',Window)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('Test_LabelPrinter',Window)
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
    CASE ACCEPTED()
    OF ?Button2
      ! Test oppsett av label (Trenger configverdier for Filenavn og printernavn)
      
         Funksjon_MakeLabel(LOC:Label_Nummer, LOC:Label_Tekst, LOC:Antall)
      
         CASE MESSAGE('Skriv ut label?','Skriv ut label',ICON:Question,'&Labelprinter|Standard|&Avbryt',2,1)
            OF 1                   
               MESSAGE('rp.exe <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
               RUN('rp <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
               POST(Event:CloseWindow)
      
            OF 2
               MESSAGE('rp.exe -d ' & CLIP(FileName))
               RUN('rp.exe -d ' & CLIP(FileName),1)
               POST(Event:CloseWindow)
      
            OF 3                                            !No button
               POST(Event:CloseWindow)
         END
      
      
    OF ?Avbryt
      ! Avslutter test av label utskrift
      
         POST(Event:CloseWindow)
    END
  ReturnValue = PARENT.TakeAccepted()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


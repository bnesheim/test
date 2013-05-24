

   MEMBER('lager.clw')                                ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LAGER018.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('LAGER012.INC'),ONCE        !Req'd for module callout resolution
                     END


Oppdater_sourcetank_Mengde PROCEDURE (PAR:ID_sourcetank,PAR:ID_TankData) !Generated from procedure template - Window

LOC:Notes            STRING(150)
LOC:Command          STRING(100)
LOC:Command_Str      STRING(200)
LOC:ID_sourcetank    LONG
LOC:ID_TankData      LONG
LOC:Hold_Nummer      LONG
LOC:Mengde           LONG
LOC:Str_Mengde       STRING(20)
LOC:Status           LONG(0)
Window               WINDOW('Oppdater mengdedata for ingrediens'),AT(,,419,224),FONT('MS Sans Serif',8,,FONT:regular),ICON(ICON:Application),SYSTEM,GRAY,MAX,RESIZE,IMM
                       ENTRY(@n-_8B),AT(136,111,78,16),USE(LOC:Mengde),RIGHT(2),FONT(,12,,FONT:bold,CHARSET:ANSI),MSG('- minimum verdi for antall kilo i siloen'),TIP('- minimum verdi for antall kilo i siloen')
                       STRING('Merknad'),AT(74,135),USE(?Str_Merknad),HIDE,FONT(,12,,FONT:bold)
                       TEXT,AT(136,137,275,58),USE(LOC:Notes),DISABLE,HIDE,HVSCROLL,FONT('Arial',12,,,CHARSET:ANSI)
                       BUTTON('Endre mengde på tank'),AT(133,206,176,16),USE(?Button2),FONT(,14,,)
                       BUTTON('Avbryt'),AT(5,206,57,16),USE(?Close),FONT(,14,,)
                       PANEL,AT(1,2,415,200),USE(?Panel1)
                       STRING(@s10),AT(136,9),USE(SOU:tanknummer),FONT(,12,,FONT:bold)
                       STRING('Tanknummer'),AT(52,9),USE(?String7),FONT(,12,,FONT:bold)
                       STRING(@s10),AT(136,90),USE(SOU:mengde),FONT(,12,,FONT:bold)
                       STRING('Tilhørende vekt'),AT(39,61),USE(?String11),FONT(,12,,FONT:bold)
                       STRING(@s15),AT(136,61),USE(TAN:weightname),FONT(,12,,FONT:bold)
                       STRING(@s10),AT(136,26),USE(SOU:id),FONT(,12,,FONT:bold)
                       STRING('Ingrediens ID'),AT(48,26),USE(?String8),FONT(,12,,FONT:bold)
                       STRING(@s60),AT(136,43,274,14),USE(SOU:name),FONT(,12,,FONT:bold)
                       STRING('Ingrediens navn'),AT(35,43),USE(?String9),FONT(,12,,FONT:bold)
                       STRING('Registert vekt i tank'),AT(13,90),USE(?String10),FONT(,12,,FONT:bold)
                       STRING('Oppdatert vekt i tank'),AT(8,113),USE(?String4),FONT(,12,,FONT:bold)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()
  RETURN(LOC:Status)


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Oppdater_sourcetank_Mengde')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?LOC:Mengde
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SELF.AddItem(?Close,RequestCancelled)
  Relate:Tankdata.Open
  Relate:sourcetank.Open
  SELF.FilesOpened = True
  OPEN(Window)
  SELF.Opened=True
  ! Henter verdier for valgt post
  
     LOC:ID_sourcetank = DEFORMAT( PAR:ID_sourcetank )
     LOC:ID_TankData   = DEFORMAT( PAR:ID_TankData )
  
     SOU:ID_sourcetank = LOC:ID_sourcetank
  
     IF Access:sourcetank.Fetch(SOU:K_ID_sourcetank) NOT= Level:Benign THEN
        MESSAGE('Feil ved innhenting av data fra sourcetank register.')
     ELSE
        TAN:ID_Tankdata = LOC:ID_TankData
  
        IF Access:TankData.Fetch(TAN:K_ID_Tankdata) NOT= Level:Benign THEN
           MESSAGE('Feil ved innhenting av data fra TankData register.')
        END
     END
  
  
  
  
  INIMgr.Fetch('Oppdater_sourcetank_Mengde',Window)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Tankdata.Close
    Relate:sourcetank.Close
  END
  IF SELF.Opened
    INIMgr.Update('Oppdater_sourcetank_Mengde',Window)
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
    OF ?Button2
      ThisWindow.Update
      ! Endre mengde på tanken
      
         LOC:Status = 0             !Markerer at ikke skal oppdateres
      
         IF LOC:Mengde NOT= '' THEN
      
            LOC:Hold_Nummer = LOC:Mengde
      
            LOC:Mengde = LOC:Mengde - DEFORMAT(SOU:mengde)
      
            SOU:mengde = LOC:Hold_Nummer
      
            IF Access:sourcetank.Update() NOT= Level:Benign THEN
               MESSAGE('Feil ved lokal lagring av data.')
            END
      
            LOC:Str_Mengde = LOC:Mengde
      
            LOC:Command     = 'TankAdd'
            LOC:Command_Str = 'TankAdd ' & CLIP(SOU:tanknummer) & ' ' & CLIP(LOC:Str_Mengde)
      
            Function_Add_Command( LOC:Command, LOC:Command_Str)
      
            LOC:Status = 1             !Markerer at data skal oppdateres
      
         END
      
         POST( EVENT:CloseWindow )
    OF ?Close
      ThisWindow.Update
      ! Setter LOC:Status = 0 for å markere at oppdateringen ble avbrutt
      
         LOC:Status = 0
      
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


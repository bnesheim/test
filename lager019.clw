

   MEMBER('lager.clw')                                ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LAGER019.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('LAGER012.INC'),ONCE        !Req'd for module callout resolution
                     END


Oppdater_TankData PROCEDURE (PAR:ID_sourcetank,PAR:ID_TankData) !Generated from procedure template - Window

LOC:Warning          LONG
LOC:Alarm            LONG
LOC:Maximum          LONG
LOC:Volume           LONG
LOC:Notes            STRING(150)
LOC:Command          STRING(100)
LOC:Command_Str      STRING(200)
LOC:ID_sourcetank    LONG
LOC:ID_TankData      LONG
LOC:Status           LONG(0)
Window               WINDOW('Oppdater mengdedata for ingrediens'),AT(,,391,279),FONT('MS Sans Serif',8,,FONT:regular),ICON(ICON:Application),SYSTEM,GRAY,MAX,RESIZE,IMM
                       ENTRY(@n-_14),AT(118,124,61,15),USE(LOC:Warning),RIGHT(3),FONT(,12,,)
                       ENTRY(@n-_14),AT(118,143,61,15),USE(LOC:Alarm),RIGHT(3),FONT(,12,,)
                       ENTRY(@n-_14),AT(118,162,61,15),USE(LOC:Maximum),RIGHT(3),FONT(,12,,)
                       ENTRY(@n-_14),AT(118,181,61,15),USE(LOC:Volume),RIGHT(3),FONT(,12,,)
                       TEXT,AT(118,209,235,42),USE(LOC:Notes),VSCROLL,FONT(,12,,,CHARSET:ANSI)
                       BUTTON('Lagre oppdateringer for tank'),AT(120,261,213,16),USE(?Button2),FONT(,14,,)
                       BUTTON('Avbryt'),AT(5,261,57,16),USE(?Close),FONT(,14,,)
                       PANEL,AT(1,2,389,113),USE(?Panel1)
                       STRING(@s10),AT(118,9),USE(SOU:tanknummer),FONT(,12,,FONT:bold)
                       STRING('Tanknummer'),AT(29,9),USE(?String7),FONT(,12,,FONT:bold)
                       STRING(@s25),AT(118,61),USE(TAN:barcode),FONT(,12,,FONT:bold)
                       STRING('Tilhørende vekt'),AT(16,78),USE(?String11),FONT(,12,,FONT:bold)
                       STRING(@s15),AT(118,78),USE(TAN:weightname),FONT(,12,,FONT:bold)
                       PANEL,AT(1,115,389,143),USE(?Panel2)
                       STRING('Barcode'),AT(53,94),USE(?Str_BarcodeReg),FONT(,12,,FONT:bold)
                       STRING(@s25),AT(118,94),USE(TAN:barcode,,?TAN:barcode:2),FONT(,12,,FONT:bold)
                       STRING('Advarsel'),AT(51,124),USE(?String14),FONT(,12,,FONT:bold)
                       STRING('Alarm'),AT(67,143),USE(?String15),FONT(,12,,FONT:bold)
                       STRING('Maksimum'),AT(41,162),USE(?String16),FONT(,12,,FONT:bold)
                       STRING('Volume'),AT(57,181),USE(?String17),FONT(,12,,FONT:bold)
                       STRING('Notater for tank'),AT(13,209),USE(?Str_Notater),FONT(,12,,FONT:bold)
                       STRING(@s10),AT(118,26),USE(SOU:id),FONT(,12,,FONT:bold)
                       STRING('Ingrediens ID'),AT(25,26),USE(?String8),FONT(,12,,FONT:bold)
                       STRING(@s60),AT(118,43,265,14),USE(SOU:name),FONT(,12,,FONT:bold)
                       STRING('Ingrediens navn'),AT(12,43),USE(?String9),FONT(,12,,FONT:bold)
                       STRING('Tank barcode'),AT(25,61),USE(?String10),FONT(,12,,FONT:bold)
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
  GlobalErrors.SetProcedureName('Oppdater_TankData')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?LOC:Warning
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
        MESSAGE('Feil ved innhenting av data fra lokalt sourcetank register.')
     ELSE
        TAN:ID_Tankdata = LOC:ID_TankData
  
        IF Access:TankData.Fetch(TAN:K_ID_Tankdata) NOT= Level:Benign THEN
           MESSAGE('Feil ved innhenting av data fra TankData register.')
        ELSE
           LOC:Warning = TAN:warning
           LOC:Alarm   = TAN:alarm
           LOC:Maximum = TAN:maximum
           LOC:Volume  = TAN:volume
           LOC:Notes   = TAN:notes
        END
     END
  
  
  INIMgr.Fetch('Oppdater_TankData',Window)
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
    INIMgr.Update('Oppdater_TankData',Window)
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
      ! Lagrer oppdateringer av TankData
      
         TAN:warning = LEFT(FORMAT(LOC:Warning, @N-_8))
         TAN:alarm   = LEFT(FORMAT(LOC:Alarm, @N-_8))
         TAN:maximum = LEFT(FORMAT(LOC:Maximum, @N-_8))
         TAN:volume  = LEFT(FORMAT(LOC:Volume, @N-_8))
         TAN:notes   = CLIP(LOC:Notes)
      
         IF Access:TankData.Update() NOT= Level:Benign THEN
            MESSAGE('Feil ved lagring av oppdatering lokalt')
         END
      
         LOC:Command     = 'TankDataSet'
         LOC:Command_Str = 'TankDataSet '               & |
                            CLIP(SOU:tanknummer)  & ' ' & |
                            CLIP(TAN:barcode)    & '; ' & |
                            CLIP(TAN:warning)    & '; ' & |
                            CLIP(TAN:alarm)      & '; ' & |
                            CLIP(TAN:maximum)    & '; ' & |
                            CLIP(TAN:volume)     & '; ' & |
                            CLIP(TAN:Notes)
      
         Function_Add_Command( LOC:Command, LOC:Command_Str)
      
         LOC:Status = 1             !Markerer at data skal oppdateres
      
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


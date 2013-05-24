

   MEMBER('lager.clw')                                ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LAGER026.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('LAGER012.INC'),ONCE        !Req'd for module callout resolution
                     END


Oppdater_Delivered_Antall PROCEDURE (PAR:ID_DelNode)  !Generated from procedure template - Window

LOC:Notes            STRING(150)
LOC:Command          STRING(100)
LOC:Command_Str      STRING(200)
LOC:ID_DelNode       LONG
LOC:Hold_Nummer      LONG
LOC:Antall           LONG
LOG:Kg               LONG
LOC:Brukt            LONG
LOC:Str_Brukt        STRING(20)
LOC:Status           LONG(0)
Window               WINDOW('Oppdater mengdedata for ingrediens'),AT(,,526,196),FONT('MS Sans Serif',8,,FONT:regular),ICON(ICON:Application),SYSTEM,GRAY,MAX,RESIZE,IMM
                       ENTRY(@n-_8B),AT(435,62),USE(LOC:Antall),DISABLE,HIDE,FONT(,12,,)
                       ENTRY(@n-_8B),AT(435,82,55,16),USE(LOG:Kg),DISABLE,HIDE,FONT(,12,,)
                       ENTRY(@n-_8B),AT(118,111),USE(LOC:Brukt),FONT(,12,,)
                       TEXT,AT(118,134,397,34),USE(LOC:Notes),HVSCROLL,FONT('Arial',12,,,CHARSET:ANSI)
                       BUTTON('Endre antall  for levering'),AT(133,177,176,16),USE(?But_Endre),FONT(,14,,)
                       BUTTON('Avbryt'),AT(465,177,57,16),USE(?Close),FONT(,14,,)
                       STRING('Merknad forbruk'),AT(11,134),USE(?Str_Merknad),FONT(,12,,FONT:bold)
                       PANEL,AT(1,2,522,104),USE(?Panel1)
                       STRING('Leveringkode'),AT(28,9),USE(?String16),FONT(,12,,FONT:bold)
                       STRING(@s25),AT(118,9,59,14),USE(DN2:Barkode),FONT(,12,,FONT:bold)
                       STRING(@s15),AT(118,81,41,14),USE(DN2:Brukt),RIGHT,FONT(,12,,FONT:bold)
                       PANEL,AT(1,106,522,70),USE(?Panel2)
                       STRING('Korrekt antall'),AT(344,62),USE(?String13),HIDE,FONT(,12,,FONT:bold)
                       STRING('Korrekt kg'),AT(360,81),USE(?String13:2),HIDE,FONT(,12,,FONT:bold)
                       STRING('Korrekt brukt'),AT(29,111),USE(?String14),FONT(,12,,FONT:bold)
                       STRING(@s15),AT(118,45,41,14),USE(DN2:Antall),RIGHT,FONT(,12,,FONT:bold)
                       STRING('Kg per enhet'),AT(31,63),USE(?String12),FONT(,12,,FONT:bold)
                       STRING(@s15),AT(118,63,41,14),USE(DN2:Enhets_Vekt),RIGHT,FONT(,12,,FONT:bold)
                       STRING('Ingrediens'),AT(43,23),USE(?String8),FONT(,12,,FONT:bold)
                       STRING(@s60),AT(118,23,398,14),USE(ING:code_name_str),FONT(,12,,FONT:bold)
                       STRING('Levert antall'),AT(33,45),USE(?String10),FONT(,12,,FONT:bold)
                       STRING('Brukt antall'),AT(37,81),USE(?String4),FONT(,12,,FONT:bold)
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
  GlobalErrors.SetProcedureName('Oppdater_Delivered_Antall')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?LOC:Antall
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SELF.AddItem(?Close,RequestCancelled)
  Relate:DelNode.Open
  Relate:DelNode2.Open
  Relate:Used.Open
  Relate:ingredient.Open
  SELF.FilesOpened = True
  OPEN(Window)
  SELF.Opened=True
  ! Henter verdier for valgt post
  
     LOC:ID_DelNode = DEFORMAT( PAR:ID_DelNode )
  
     DN2:ID_DelNode = LOC:ID_DelNode
  
     IF Access:DelNode2.Fetch(DN2:K_ID_DelNode) NOT= Level:Benign THEN
        MESSAGE('Feil ved innhenting av data fra lokalt leveringsregister.')
     ELSE
  
        ING:id = DN2:ingredient_id
  
        IF ACCESS:ingredient.Fetch(ING:K_id) NOT= Level:Benign THEN
           MESSAGE('Feil ved innhenting av ingrdiensdata fra lokalt register.')
        END
     END
  
  INIMgr.Fetch('Oppdater_Delivered_Antall',Window)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:DelNode.Close
    Relate:DelNode2.Close
    Relate:Used.Close
    Relate:ingredient.Close
  END
  IF SELF.Opened
    INIMgr.Update('Oppdater_Delivered_Antall',Window)
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
    OF ?But_Endre
      ThisWindow.Update
      ! Endre mengde på tanken
      
         LOC:Status = 0             !Markerer at ikke skal oppdateres
      
         IF LOC:Brukt NOT= '' THEN
      
            LOC:Hold_Nummer = LOC:Brukt
      
            LOC:Brukt = LOC:Brukt - DEFORMAT(DN2:Brukt)
      
            DN2:Brukt = LOC:Hold_Nummer
      
            ANTALL# = DEFORMAT(DN2:Antall)
            BRUKT#  = DEFORMAT(DN2:Brukt)
            ENHET#  = DEFORMAT(DN2:Enhets_Vekt)
      
            LAGER# = ANTALL# - BRUKT#
      
            DN2:Brukt    = FORMAT(BRUKT#,@N_8)
            DN2:Brukt_kg = BRUKT# * ENHET#
            DN2:Lager    = FORMAT(LAGER#,@N_8)
            DN2:Lager_kg = LAGER# * ENHET#
      
            IF Access:DelNode2.Update() NOT= Level:Benign THEN
               MESSAGE('Feil ved lokal lagring av data.')
            END
      !      ELSE
      !         USE:id            = QUS:id
      !         USE:dline_id      = DNO:ID_DeliveredNode
      !         USE:used          = FORMAT(LOC:Brukt,@N-_8)
      !         USE:Dato          = TODAY()
      !         USE:Tid           = CLOCK()
      !         USE:date_time_str = ''
      !         USE:notes         = CLIP(LOC:Notes)
      !
      !         IF Access:Used.Insert() NOT= Level:Benign THEN
      !            MESSAGE('Feil ved lagring av UseLineHistory til lokalt register.')
      !         END
      !      END
      
            LOC:Str_Brukt = LEFT(FORMAT(LOC:Brukt,@N-_8))
      
            LOC:Command     = 'UsedLine'
            LOC:Command_Str = ('UsedLine ' & CLIP(DN2:ID_DeliveredNode)  & '; ' & |
                                             CLIP(LOC:Str_Brukt)         & '; ' & |
                                             CLIP(LOC:Notes) )
            Function_Add_Command( LOC:Command, LOC:Command_Str)
      
            Function_Add_Command( 'UsedLineHistory', 'UsedLineHistory' & ' ' & CLIP(DN2:ID_DeliveredNode))
      
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


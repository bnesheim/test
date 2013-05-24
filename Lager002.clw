

   MEMBER('lager.clw')                                ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LAGER002.INC'),ONCE        !Local module procedure declarations
                     END


Display_ReadList PROCEDURE (PAR:ReadList,PAR:ReadListOrg) !Generated from procedure template - Window

LOC:ReadList         STRING(400000)
LOC:ReadListOrg      STRING(400000)
Window               WINDOW('Read-data mottatt fra siste proxykommando'),AT(,,528,283),FONT('MS Sans Serif',8,,FONT:regular),ICON(ICON:Application),SYSTEM,GRAY,MAX,RESIZE,IMM
                       SHEET,AT(1,3,521,275),USE(?Sheet1)
                         TAB(' Formatert tekst (innlagt linjeskift)'),USE(?Tab1)
                           TEXT,AT(5,20,513,254),USE(LOC:ReadList),HVSCROLL
                         END
                         TAB(' Kun Read-data mottatt'),USE(?Tab2)
                           TEXT,AT(5,20,513,254),USE(LOC:ReadListOrg),HVSCROLL
                         END
                       END
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Display_ReadList')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?LOC:ReadList
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  ! Setter oppstartsverdi for variabler
  
     LOC:ReadList    = PAR:ReadList
     LOC:ReadListOrg = PAR:ReadListOrg
  
  
  OPEN(Window)
  SELF.Opened=True
  INIMgr.Fetch('Display_ReadList',Window)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('Display_ReadList',Window)
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


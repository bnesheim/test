

   MEMBER('lager.clw')                                ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LAGER013.INC'),ONCE        !Local module procedure declarations
                     END


Velg_Ingrediens PROCEDURE ()                          !Generated from procedure template - Window

LOC:ID_IngData       LONG
LOC:ID_Ingredient    LONG
BRW1::View:Browse    VIEW(ingredient)
                       PROJECT(ING:code)
                       PROJECT(ING:name)
                       PROJECT(ING:ID_ingredient)
                       PROJECT(ING:id)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
ING:code               LIKE(ING:code)                 !List box control field - type derived from field
ING:name               LIKE(ING:name)                 !List box control field - type derived from field
ING:ID_ingredient      LIKE(ING:ID_ingredient)        !Browse hot field - type derived from field
ING:id                 LIKE(ING:id)                   !Browse hot field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
Window               WINDOW('Velg Ingrediens'),AT(,,421,278),FONT('MS Sans Serif',8,,FONT:regular),ICON(ICON:Application),SYSTEM,GRAY,MAX,RESIZE,IMM
                       SHEET,AT(2,1,413,250),USE(?Sheet1),FONT(,12,,)
                         TAB('Kode'),USE(?Tab2),FONT(,12,,)
                         END
                         TAB('Navn'),USE(?Tab3),FONT(,12,,)
                         END
                       END
                       LIST,AT(5,21,405,228),USE(?List),IMM,HVSCROLL,FONT(,12,,,CHARSET:ANSI),MSG('Browsing Records'),FORMAT('55L(2)|M~Kode~C(0)@s10@240L(2)|M~Ingrediens beskrivelse~@s60@'),FROM(Queue:Browse)
                       BUTTON('Avbryt'),AT(7,254,74,20),USE(?Button1),FONT(,14,,,CHARSET:ANSI)
                       BUTTON('Bruk valgt ingrediens'),AT(143,254,174,20),USE(?Button2),FONT(,14,,),DEFAULT
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)               !Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
                     END

BRW1::Sort0:Locator  IncrementalLocatorClass          !Default Locator
BRW1::Sort2:Locator  IncrementalLocatorClass          !Conditional Locator - CHOICE(?Sheet1)=2

  CODE
  GlobalResponse = ThisWindow.Run()
  RETURN(LOC:ID_Ingredient)


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Velg_Ingrediens')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  Relate:IngData.Open
  Relate:ingredient.Open
  SELF.FilesOpened = True
  BRW1.Init(?List,Queue:Browse.ViewPosition,BRW1::View:Browse,Queue:Browse,Relate:ingredient,SELF)
  OPEN(Window)
  SELF.Opened=True
  BRW1.Q &= Queue:Browse
  BRW1.AddSortOrder(,ING:K_name)
  BRW1.AddLocator(BRW1::Sort2:Locator)
  BRW1::Sort2:Locator.Init(,ING:name,1,BRW1)
  BRW1.AddSortOrder(,ING:K_code)
  BRW1.AddLocator(BRW1::Sort0:Locator)
  BRW1::Sort0:Locator.Init(,ING:code,1,BRW1)
  BRW1.AddField(ING:code,BRW1.Q.ING:code)
  BRW1.AddField(ING:name,BRW1.Q.ING:name)
  BRW1.AddField(ING:ID_ingredient,BRW1.Q.ING:ID_ingredient)
  BRW1.AddField(ING:id,BRW1.Q.ING:id)
  INIMgr.Fetch('Velg_Ingrediens',Window)
  BRW1.AddToolbarTarget(Toolbar)
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
    INIMgr.Update('Velg_Ingrediens',Window)
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
      ! Avbryt valget av ingrediens
      
         LOC:ID_Ingredient = 0
         POST(EVENT:CloseWindow)
      
    OF ?Button2
      ThisWindow.Update
      ! Setter verdi for valgt ingrediens
      
         LOC:ID_Ingredient = ING:ID_ingredient
         POST(EVENT:CloseWindow)
      
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRW1.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?Sheet1)=2
    RETURN SELF.SetSort(1,Force)
  ELSE
    RETURN SELF.SetSort(2,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


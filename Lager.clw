   PROGRAM



   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('EQUATES.CLW'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
! Extra include files

   INCLUDE('SWrench.inc')

   MAP
     MODULE('LAGERBC.CLW')
DctInit     PROCEDURE
DctKill     PROCEDURE
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('LAGER001.CLW')
Main                   PROCEDURE   !
     END
     INCLUDE('OCX.CLW')
   END
   INCLUDE('OCXEVENT.CLW')

GLO:Config_IP      STRING(25)
GLO:Config_Port    STRING(10)
GLO:Config_Leveranse LONG
GLO:Config_Paafylling LONG
GLO:Config_Administrasjon LONG
GLO:Config_System  LONG
GLO:Config_Test    LONG
GLO:Config_Vekt    LONG
GLO:Browse_Delivered_Refresh LONG(1)
GLO:Valgt_Ingredient_ID STRING(15)
GLO:Save_Mode      STRING(20)
GLO:Valgt_Delivered_Count STRING(15)
GLO:Valgt_Levering_Barcode STRING(35)
GLO:Valgt_Ingredient_Navn STRING(60)
GLO:Valgt_Delivered_ID STRING(15)
GLO:Valgt_Delivered_perItem STRING(15)
GLO:Valgt_Tank     STRING(15)
GLO:Valgt_Tank_Barkode STRING(35)
GLO:Valgt_Tank_ingredient_ID STRING(15)
GLO:Liste_Paafyllingsvarsel STRING(32000)
GLO:ID_DeliveredLine LONG
GLO:Ny_Barcode     STRING(35)
GLO:Oppsett_Flag   STRING(20)
GLO:ActiveCommand  STRING(100)
GLO:File           STRING(32000)
G:LastOCXErrCode   STRING(20)
G:LastOCXErrMsg    STRING(40)
FileName           STRING(220)
SilentRunning        BYTE(0)                         !Set true when application is running in silent mode

weight               FILE,DRIVER('TOPSPEED'),NAME('weight'),PRE(WEI),CREATE,BINDABLE,THREAD
K_ID_Weight              KEY(WEI:ID_weight),NOCASE,OPT,PRIMARY
K_visualName             KEY(WEI:visualName),DUP,NOCASE,OPT
Record                   RECORD,PRE()
ID_weight                   LONG
weight                      STRING(10)
visualName                  STRING(25)
comment                     STRING(25)
                         END
                     END                       

Used                 FILE,DRIVER('TOPSPEED'),NAME('Used'),PRE(USE),CREATE,BINDABLE,THREAD
K_ID_Used                KEY(USE:ID_Used),NOCASE,OPT,PRIMARY
K_id                     KEY(USE:id),DUP,NOCASE,OPT
K_dline_id               KEY(USE:dline_id),DUP,NOCASE,OPT
K_Dato_Asc               KEY(USE:Dato),DUP,NOCASE,OPT
K_Dato_Des               KEY(-USE:Dato),DUP,NOCASE,OPT
K_date_time_str          KEY(USE:date_time_str),DUP,NOCASE,OPT
Record                   RECORD,PRE()
ID_Used                     LONG
id                          STRING(15)
dline_id                    STRING(15)
used                        STRING(15)
Dato                        DATE
Tid                         TIME
date_time_str               STRING(35)
notes                       STRING(150)
                         END
                     END                       

WorkLine             FILE,DRIVER('TOPSPEED'),NAME('WorkLine'),PRE(WLI),CREATE,BINDABLE,THREAD
K_ID_WorkLine            KEY(WLI:ID_WorkLine),NOCASE,OPT,PRIMARY
K_Ingrediens_id          KEY(WLI:Ingrediens_id),DUP,NOCASE,OPT
K_Barkode                KEY(WLI:Barkode),DUP,NOCASE,OPT
K_Dato                   KEY(WLI:Dato),DUP,NOCASE,OPT
K_Status                 KEY(WLI:Status),DUP,NOCASE,OPT
Record                   RECORD,PRE()
ID_WorkLine                 LONG
Ingrediens_id               STRING(15)
Barkode                     STRING(25)
Dato                        DATE
Antall                      LONG
Unit                        STRING(20)
VektEnhet                   LONG
Total_Vekt                  LONG
Status                      STRING(20)
Antall_Labler               LONG
Utskrevet_Flag              STRING(5)
                         END
                     END                       

Tankdata             FILE,DRIVER('TOPSPEED'),NAME('Tankdata'),PRE(TAN),CREATE,BINDABLE,THREAD
K_ID_Tankdata            KEY(TAN:ID_Tankdata),NOCASE,OPT,PRIMARY
K_id_tank                KEY(TAN:id_tank),DUP,NOCASE,OPT
K_barcode                KEY(TAN:barcode),DUP,NOCASE,OPT
k_weightname             KEY(TAN:weightname),DUP,NOCASE,OPT
Record                   RECORD,PRE()
ID_Tankdata                 LONG
weightname                  STRING(15)
id_tank                     STRING(15)
barcode                     STRING(25)
warning                     STRING(15)
alarm                       STRING(15)
maximum                     STRING(15)
volume                      STRING(15)
notes                       STRING(150)
                         END
                     END                       

sourcetank           FILE,DRIVER('TOPSPEED'),NAME('sourcetank'),PRE(SOU),CREATE,BINDABLE,THREAD
K_ID_sourcetank          KEY(SOU:ID_sourcetank),NOCASE,OPT,PRIMARY
K_tanknummer             KEY(SOU:tanknummer),DUP,NOCASE,OPT
K_id                     KEY(SOU:id),DUP,NOCASE,OPT
Record                   RECORD,PRE()
ID_sourcetank               LONG
tanknummer                  STRING(10)
mengde                      STRING(10)
id                          STRING(10)
code                        STRING(10)
name                        STRING(60)
RawDataStr                  STRING(200)
                         END
                     END                       

ingredient           FILE,DRIVER('TOPSPEED'),NAME('ingredient'),PRE(ING),CREATE,BINDABLE,THREAD
K_ID_ingredient          KEY(ING:ID_ingredient),NOCASE,OPT,PRIMARY
K_id                     KEY(ING:id),DUP,NOCASE,OPT
K_code                   KEY(ING:code),DUP,NOCASE,OPT
K_name                   KEY(ING:name),DUP,NOCASE,OPT
Record                   RECORD,PRE()
ID_ingredient               LONG
id                          STRING(10)
code                        STRING(10)
name                        STRING(60)
code_name_str               STRING(60)
RawDataStr                  STRING(200)
Lager_Sekker                LONG
Lager_Kg                    LONG
Aktive_Leveranser           LONG
                         END
                     END                       

IngData              FILE,DRIVER('TOPSPEED'),NAME('IngData'),PRE(IND),CREATE,BINDABLE,THREAD
K_ID_IngData             KEY(IND:ID_IngData),NOCASE,OPT,PRIMARY
K_ingredientId           KEY(IND:ingredientId),DUP,NOCASE,OPT
Record                   RECORD,PRE()
ID_IngData                  LONG
ingredientId                STRING(15)
Notes                       STRING(150)
OrginalDataStr              STRING(200)
                         END
                     END                       

DelNode              FILE,DRIVER('TOPSPEED'),NAME('DelNode'),PRE(DNO),CREATE,BINDABLE,THREAD
K_ID_DelNode             KEY(DNO:ID_DelNode),NOCASE,OPT,PRIMARY
K_ID_DeliveredNode       KEY(DNO:ID_DeliveredNode),DUP,NOCASE,OPT
K_Dato                   KEY(DNO:Dato),DUP,NOCASE,OPT
K_DatoStr_Asc            KEY(DNO:DatoTimeStr),DUP,NOCASE,OPT
K_DatoStr_Des            KEY(-DNO:DatoTimeStr),DUP,NOCASE,OPT
K_Kilde                  KEY(DNO:Kilde),DUP,NOCASE,OPT
K_Referanse              KEY(DNO:Referanse),DUP,NOCASE,OPT
K_Status                 KEY(DNO:Status),DUP,NOCASE,OPT
K_ingredient_id          KEY(DNO:ingredient_id),DUP,NOCASE,OPT
K_Barkode                KEY(DNO:Barkode),DUP,NOCASE,OPT
Record                   RECORD,PRE()
ID_DelNode                  LONG
Deleted_Flag                STRING(15)
ID_DeliveredNode            STRING(15)
Dato                        DATE
Time                        TIME
DatoTimeStr                 STRING(40)
Kilde                       STRING(60)
Referanse                   STRING(60)
Status                      STRING(20)
ingredient_id               STRING(15)
Barkode                     STRING(25)
Antall                      STRING(15)
Antall_kg                   LONG
Enhets_Vekt                 STRING(15)
Brukt                       STRING(15)
Brukt_kg                    LONG
Lager                       STRING(15)
Lager_kg                    LONG
Notater                     STRING(150)
                         END
                     END                       

Barcode              FILE,DRIVER('TOPSPEED'),NAME('Barcode'),PRE(BAR),CREATE,BINDABLE,THREAD
K_ID_Barcode             KEY(BAR:ID_Barcode),NOCASE,OPT,PRIMARY
K_barcode                KEY(BAR:barcode),DUP,NOCASE,OPT
K_type                   KEY(BAR:type),DUP,NOCASE,OPT
Record                   RECORD,PRE()
ID_Barcode                  LONG
barcode                     STRING(25)
type                        STRING(20)
typeinfo                    STRING(150)
                         END
                     END                       

ingredient2          FILE,DRIVER('TOPSPEED'),NAME('ingredient'),PRE(IN2),CREATE,BINDABLE,THREAD
K_ID_ingredient          KEY(IN2:ID_ingredient),NOCASE,OPT,PRIMARY
K_id                     KEY(IN2:id),DUP,NOCASE,OPT
K_code                   KEY(IN2:code),DUP,NOCASE,OPT
K_name                   KEY(IN2:name),DUP,NOCASE,OPT
Record                   RECORD,PRE()
ID_ingredient               LONG
id                          STRING(10)
code                        STRING(10)
name                        STRING(60)
code_name_str               STRING(60)
RawDataStr                  STRING(200)
Lager_Sekker                LONG
Lager_Kg                    LONG
Aktive_Leveranser           LONG
                         END
                     END                       

DelNode2             FILE,DRIVER('TOPSPEED'),NAME('DelNode'),PRE(DN2),CREATE,BINDABLE,THREAD
K_ID_DelNode             KEY(DN2:ID_DelNode),NOCASE,OPT,PRIMARY
K_ID_DeliveredNode       KEY(DN2:ID_DeliveredNode),DUP,NOCASE,OPT
K_Dato                   KEY(DN2:Dato),DUP,NOCASE,OPT
K_DatoStr_Asc            KEY(DN2:DatoTimeStr),DUP,NOCASE,OPT
K_DatoStr_Des            KEY(-DN2:DatoTimeStr),DUP,NOCASE,OPT
K_Kilde                  KEY(DN2:Kilde),DUP,NOCASE,OPT
K_Referanse              KEY(DN2:Referanse),DUP,NOCASE,OPT
K_Status                 KEY(DN2:Status),DUP,NOCASE,OPT
K_ingredient_id          KEY(DN2:ingredient_id),DUP,NOCASE,OPT
K_Barkode                KEY(DN2:Barkode),DUP,NOCASE,OPT
Record                   RECORD,PRE()
ID_DelNode                  LONG
Deleted_Flag                STRING(15)
ID_DeliveredNode            STRING(15)
Dato                        DATE
Time                        TIME
DatoTimeStr                 STRING(40)
Kilde                       STRING(60)
Referanse                   STRING(60)
Status                      STRING(20)
ingredient_id               STRING(15)
Barkode                     STRING(25)
Antall                      STRING(15)
Antall_kg                   LONG
Enhets_Vekt                 STRING(15)
Brukt                       STRING(15)
Brukt_kg                    LONG
Lager                       STRING(15)
Lager_kg                    LONG
Notater                     STRING(150)
                         END
                     END                       



! Definitions of global data structures

EVENT:WriteCommand        EQUATE (32000)
EVENT:CheckRefillCodes    EQUATE (32001)
EVENT:SelfReset           EQUATE (32002)
!EVENT:ReadCompleted       EQUATE (32000)


! QUEUE definisjoner

! Kø for linjer slik de ble mottatt.

QDataLines            QUEUE,STATIC,BINDABLE,PRE(QDL)
LineDataStr              STRING(300)    !- Data mottatt fra proxy
                      END

! Kø for kommandoer som skal sendes til proxy

QCommandStack         QUEUE,STATIC,BINDABLE,PRE(QCS)
Command                  STRING(100)
CommandStr               STRING(200)
                      END

QConfig               QUEUE,STATIC,BINDABLE,PRE(QCO)
IP                       STRING(25)     ! IP nummer i tekstformat
Port                     STRING(10)     ! Port nummer i tekstformat
Leveranse                LONG           ! Flag for om siden skal brukes.
Paafylling               LONG           ! 1 = 'Bruk', 0='Ikke bruk'
Administrasjon           LONG           !
System                   LONG           !
Test                     LONG           !
Vekt                     STRING(15)     ! Navn på vekten tilknyttet arbeistasjon (Micro/Cons)
                      END


! Memory tabel for Barcode label data

QPrintLabelData       QUEUE,STATIC,BINDABLE,PRE(QPL)
Text1                    STRING(50)
Text2                    STRING(50)
Text3                    STRING(50)
Barcode                  STRING(50)
BarcodeText              STRING(50)
KopiAntall               LONG
                      END

! Memory tabel for usedline data

QUsed                QUEUE,STATIC,BINDABLE,PRE(QUS)
id                      STRING(15)          ! id fra proxy for usedline post
dline_id                STRING(15)          ! Delivered id som forbtuk gjelder
used                    STRING(15)          ! Verdi som angir antall sekker brukt
dato                    DATE                ! DEFORMATET dato fra date_str
tid                     TIME                ! DEFORMATET tid fra date_str
date_str                STRING(35)          ! Streng som angir dato og tid
notes                   STRING(150)         ! Merknad knyttet til forbruk
                     END

! Memory tabel for ingredient data

Qingredient           QUEUE,STATIC,BINDABLE,PRE(QIN)
id                      STRING(10)     !- Unik verdi for denne posten i databasen som proxyen bruker
code                    STRING(10)     !- er kodenummer som Fiskå bruke i sin resepter og dokumentasjon
name                    STRING(60)     !- navn på produktet
RawDataStr              STRING(200)    !- Data mottatt fra proxy
                      END

! Memory tabel for tank data

Qtank                QUEUE,STATIC,BINDABLE,PRE(QTA)
tanknummer              STRING(10)     !- Unik verdi tank i databasen som proxyen bruker
mengde                  STRING(10)     !- Tall som angir registert vekt av ingrediens i tanken.
id                      STRING(10)     !- Unik verdi ingrediens i databasen som proxyen bruker
code                    STRING(10)     !- er kodenummer som Fiskå bruke i sin resepter og dokumentasjon
name                    STRING(60)     !- navn på produktet
RawDataStr              STRING(200)    !- Data mottatt fra proxy
                     END

! Memory tabel for vekt data

Qweights             QUEUE,STATIC,BINDABLE,PRE(QWE)
WeightName              STRING(20)
                     END

! Memory tabel for leveransenode data
! Format fra proxy:  <id>:  <date>; <source>; <status>; <dlines>; <notes>

QDeliveredNode       QUEUE,STATIC,BINDABLE,PRE(QDN)
ID_DeliverNode          LONG           !- Index verdi for post verd lagring til .tps file.
id                      STRING(15)     !- Unik verdi ingrediens i databasen som proxyen bruker
date                    STRING(40)     !- Dato for levering
source                  STRING(60)     !- Navn på leverandøren
reference               STRING(60)
status                  STRING(20)     !- Status for ordre (Nye, fullført, etc)
iId                     STRING(15)
barcode                 STRING(25)
count                   STRING(15)
perItem                 STRING(15)
used                    STRING(15)
notes                   STRING(150)    !- Notater knyttet til levering
                     END

! Memory tabel for leveringslinje data (QNL for Queue Node Lines

QDeliveredLine       QUEUE,STATIC,BINDABLE,PRE(QNL)
ID_DeliverLine          LONG           !- Index verdi for post verd lagring til .tps file.
id                      STRING(15)     !- Unik verdi ingrediens i databasen som proxyen bruker
deliveredId             STRING(15)     !- Kobling til DeliveredNode
ingredientId            STRING(15)     !- ingrediens ID for levering
barcode                 STRING(20)     !- barcode register for levering
count                   STRING(14)     !- Antall som er levert
unit                    STRING(20)     !- Kilo, Liter, Sekker, Paller ect
peritem                 STRING(15)     !- Antall kg i levert enhet (count * peritem = Totalvekt
used                    STRING(15)     !- Antall enheter som er brukt. (count-user = 0 for oppbrukt leveranse)
                     END

! Memory tabel for data fra TankDataRead kommandoen i proxyen

QTankData            QUEUE,STATIC,BINDABLE,PRE(QTA)
weightname              STRING(15)      !- id/navn pÕ vekten som tanken er koblet til
ID_Tankdata             LONG            !- Unik verdi for kobling mot andre register ( AutoInc. + Primary Key )(LONG)
id_tank                 STRING(15)      !- id lfor tank fra proxy
barcode                 STRING(25)      !- barcode satt opp for tanken
warning                 STRING(15)      !- <warn>     Varsel skal gis hvis vekt i tank kommer ned til denne kiloverdien
alarm                   STRING(15)      !- <alarm>    Alarmverdi skal settes hvis vekt i tank kommer ned til denne kiloverdien
maximum                 STRING(15)      !- <maxmimum> maximum antall kilo som skal fylles pÕ siloen
volume                  STRING(15)      !- <volume>   Volume angitt for siloen.
notes                   STRING(150)     !- Notater knyttet til vekten
                     END

! Memory tabel for data fra BarcodeRead kommandoen i proxyen

QBarcode            QUEUE,STATIC,BINDABLE,PRE(QBA)
ID_Barcode             LONG             !- Unik verdi for kobling mot andre register ( AutoInc. + Primary Key )(LONG)
barcode                STRING(25)       !- registert barcode (Unik verdi)
type                   STRING(20)       !- Brukt for å angi i hvilket register koden er brukt (Tank, delivery)
Typeinfo               STRING(150)      !- Basert på type inneholder denne tegnstrengen relevant ingo
                    END

! Memory tabel for data fra IngDataRead kommandoen i proxyen

QIngData            QUEUE,STATIC,BINDABLE,PRE(QID)
ID_IngData             LONG             !- Unik verdi for kobling mot andre register ( AutoInc. + Primary Key )(LONG)
ingredientId           STRING(15)       !- ingrediens ID for levering
minimum                STRING(15)       !- Minimum kg tanken skal inneholde
maximum                STRING(15)       !- Minimum kg tanken skal inneholde
volume                 STRING(15)       !- Totalt volume av tanken
LastRefillDateStr      STRING(25)       !- Dato for siste refill (=None når dato ikke er lagret)
NextRefillDateStr      STRING(25)       !- Dato for neste refill (=None når dato ikke er lagret)
notes                  STRING(150)      !- Notater knyttet til vekten
OrginalDataStr         STRING(150)      !- Raw string from proxydata for Last, Next og Notes
                    END









Access:weight        &FileManager
Relate:weight        &RelationManager
Access:Used          &FileManager
Relate:Used          &RelationManager
Access:WorkLine      &FileManager
Relate:WorkLine      &RelationManager
Access:Tankdata      &FileManager
Relate:Tankdata      &RelationManager
Access:sourcetank    &FileManager
Relate:sourcetank    &RelationManager
Access:ingredient    &FileManager
Relate:ingredient    &RelationManager
Access:IngData       &FileManager
Relate:IngData       &RelationManager
Access:DelNode       &FileManager
Relate:DelNode       &RelationManager
Access:Barcode       &FileManager
Relate:Barcode       &RelationManager
Access:ingredient2   &FileManager
Relate:ingredient2   &RelationManager
Access:DelNode2      &FileManager
Relate:DelNode2      &RelationManager
FuzzyMatcher         FuzzyClass
GlobalErrors         ErrorClass
INIMgr               INIClass
GlobalRequest        BYTE(0),THREAD
GlobalResponse       BYTE(0),THREAD
VCRRequest           LONG(0),THREAD
lCurrentFDSetting    LONG
lAdjFDSetting        LONG

  CODE
  GlobalErrors.Init
  DctInit
  FuzzyMatcher.Init
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)
  INIMgr.Init('lager.INI')
  SystemParametersInfo( 38, 0, lCurrentFDSetting, 0 )
  IF lCurrentFDSetting = 1
    SystemParametersInfo( 37, 0, lAdjFDSetting, 3 )
  END
  Main
  INIMgr.Update
  IF lCurrentFDSetting = 1
    SystemParametersInfo( 37, 1, lAdjFDSetting, 3 )
  END
  INIMgr.Kill
  FuzzyMatcher.Kill
  DctKill
  GlobalErrors.Kill



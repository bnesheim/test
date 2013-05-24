

   MEMBER('lager.clw')                                ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LAGER001.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('LAGER002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER012.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER013.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER017.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER018.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER019.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER020.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER021.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER022.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER023.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LAGER026.INC'),ONCE        !Req'd for module callout resolution
MainOCXEventHandler    PROCEDURE(*SHORT ref,SIGNED OLEControlFEQ,LONG OLEEvent),LONG
                     END


Main PROCEDURE                                        !Generated from procedure template - Window

LOC:UpdateTeller     REAL
LOC:Alarmperiode     LONG
LOC:warning_Paafyll  STRING(15)
LOC:alarm_Paafyll    STRING(15)
LOC:maximum_Paafyll  STRING(15)
LOC:volume_Paafyll   STRING(15)
LOC:notes_Paafyll    STRING(150)
LOC:Delivered_Ingrediens_id STRING(15)
LOC:Oppdaterings_Teller_Register LONG
LOC:Str_ID_DelNode   STRING(20)
LOC:Totalt_Levering_Antall LONG
LOC:Totalt_Levering_Antall_kg LONG
LOC:Total_Levering_Brukt LONG
LOC:Total_Levering_Brukt_kg LONG
LOC:Total_Levering_Lager LONG
LOC:Total_Levering_Lager_kg LONG
LOC:Paafyll_Used_Notes STRING(150)
LOC:Buffer_Tekst     STRING(240)
LOC:Info_Str         STRING(200)
LOC:Notater          STRING(150)
LOC:Teller_Aktive_Leveringer LONG
LOC:Paafyll_Fullfoert_Melding STRING(120)
LOC:Melding_Tank     STRING(80)
LOC:Melding_Ingrediens STRING(80)
LOC:Melding_Paafylling STRING(80)
LOC:Liste_Paafyllingsvarsel STRING(2000)
LOC:Valgt_Tank       STRING(15)
LOC:Valgt_Tank_Barkode STRING(35)
LOC:Valgt_Tank_ingredient_ID STRING(15)
LOC:Valgt_Tank_ingredient_Name STRING(60)
LOC:Valgt_Tank_ingredient_Info STRING(60)
LOC:Valgt_Ingredient_perItem LONG
LOC:Valgt_Ingredient_Info STRING(60)
LOC:Valgt_DelNode_Dato DATE
LOC:Valgt_DelNode_Antall STRING(15)
LOC:Valgt_DelNode_Brukt STRING(15)
LOC:Valgt_DelNode_Lager STRING(20)
LOC:Antall_Sekker    LONG
LOC:Lest_Barcode     STRING(35)
LOC:Test_Teller      LONG
LOC:Refresh_Teller   STRING(20)
LOC:Farve            STRING('0FF8080H {12}')
LOC:Ny_Start_Flag    STRING('0 {19}')
LOC:Delay_Flag       LONG
LOC:Connect_Status   STRING(20)
LOC:Str_ID_Ingredients STRING(20)
LOC:Str_Verdi        STRING(20)
LOC:ReDisplay_Flag   LONG(1)
LOC:Str_Dato_Tid     STRING(35)
LOC:Antall_Barkodelapper LONG
LOC:Antall_Enheter   LONG
LOC:Enhets_Vekt      LONG
LOC:Totalvekt_Levert LONG
LOC:Totalvekt_Paafylling LONG
LOC:Kilde            STRING(50)
LOC:Referanse        STRING(50)
LOC:Ny_Barkode       STRING(35)
LOC:Str_ID_IngData   STRING(20)
LOC:Str_ID_sourcetank STRING(20)
LOC:Str_ID_TankData  STRING(20)
LOC:Command          STRING(100)
LOC:CommandStr       STRING(200)
LOC:Command_Str      STRING(200)
LOC:Current_Date     DATE
LOC:Current_Time     TIME
LOC:ID_Ingrediens    LONG
LOC:Ingrediens_id    STRING(15)
LOC:Ingrediens_code  STRING(10)
LOC:Ingrediens_name  STRING(60)
LOC:LastRecived      STRING(2100)
LOC:List             STRING(800000)
LOC:List2            STRING(800000)
LOC:List_Display     STRING(800000)
LOC:ListOrg          STRING(64000)
LOC:Vekt             STRING(20)
LOC:Port_Number      STRING('30125 {1}')
L:MyIP               STRING(20)
L:BIPAddr            STRING('79.161.10.133 {7}')
L:Command            STRING(100)
L:EntryText          STRING(100)
L:BReply             STRING(20)
L:LastEvent          STRING(40)
L:LastCommand        STRING(200)
L:Status             STRING(40)
L:SendData           STRING(200)
L:Error              LONG
BRW5::View:Browse    VIEW(ingredient2)
                       PROJECT(IN2:code_name_str)
                       PROJECT(IN2:Aktive_Leveranser)
                       PROJECT(IN2:Lager_Kg)
                       PROJECT(IN2:id)
                       PROJECT(IN2:ID_ingredient)
                       PROJECT(IN2:name)
                       PROJECT(IN2:code)
                       JOIN(IND:K_ingredientId,IN2:id)
                         PROJECT(IND:Notes)
                         PROJECT(IND:ID_IngData)
                       END
                     END
Queue:Browse:3       QUEUE                            !Queue declaration for browse/combo box using ?List_ingredients
IN2:code_name_str      LIKE(IN2:code_name_str)        !List box control field - type derived from field
IN2:Aktive_Leveranser  LIKE(IN2:Aktive_Leveranser)    !List box control field - type derived from field
IN2:Lager_Kg           LIKE(IN2:Lager_Kg)             !List box control field - type derived from field
IND:Notes              LIKE(IND:Notes)                !List box control field - type derived from field
IN2:id                 LIKE(IN2:id)                   !Browse hot field - type derived from field
IN2:ID_ingredient      LIKE(IN2:ID_ingredient)        !Browse hot field - type derived from field
IND:ID_IngData         LIKE(IND:ID_IngData)           !Browse hot field - type derived from field
LOC:Ingrediens_id      LIKE(LOC:Ingrediens_id)        !Browse hot field - type derived from local data
IN2:name               LIKE(IN2:name)                 !Browse key field - type derived from field
IN2:code               LIKE(IN2:code)                 !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW4::View:Browse    VIEW(sourcetank)
                       PROJECT(SOU:tanknummer)
                       PROJECT(SOU:mengde)
                       PROJECT(SOU:code)
                       PROJECT(SOU:name)
                       PROJECT(SOU:ID_sourcetank)
                       PROJECT(SOU:id)
                       JOIN(TAN:K_id_tank,SOU:tanknummer)
                         PROJECT(TAN:alarm)
                         PROJECT(TAN:warning)
                         PROJECT(TAN:maximum)
                         PROJECT(TAN:volume)
                         PROJECT(TAN:notes)
                         PROJECT(TAN:weightname)
                         PROJECT(TAN:ID_Tankdata)
                       END
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?List_Tank
SOU:tanknummer         LIKE(SOU:tanknummer)           !List box control field - type derived from field
TAN:alarm              LIKE(TAN:alarm)                !List box control field - type derived from field
TAN:warning            LIKE(TAN:warning)              !List box control field - type derived from field
TAN:maximum            LIKE(TAN:maximum)              !List box control field - type derived from field
TAN:volume             LIKE(TAN:volume)               !List box control field - type derived from field
SOU:mengde             LIKE(SOU:mengde)               !List box control field - type derived from field
SOU:code               LIKE(SOU:code)                 !List box control field - type derived from field
SOU:name               LIKE(SOU:name)                 !List box control field - type derived from field
TAN:notes              LIKE(TAN:notes)                !List box control field - type derived from field
TAN:weightname         LIKE(TAN:weightname)           !List box control field - type derived from field
SOU:ID_sourcetank      LIKE(SOU:ID_sourcetank)        !Browse hot field - type derived from field
SOU:id                 LIKE(SOU:id)                   !Browse hot field - type derived from field
TAN:ID_Tankdata        LIKE(TAN:ID_Tankdata)          !Browse hot field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW2::View:Browse    VIEW(DelNode)
                       PROJECT(DNO:Dato)
                       PROJECT(DNO:Antall)
                       PROJECT(DNO:Brukt)
                       PROJECT(DNO:Barkode)
                       PROJECT(DNO:ID_DelNode)
                       PROJECT(DNO:Deleted_Flag)
                       PROJECT(DNO:Lager_kg)
                       PROJECT(DNO:DatoTimeStr)
                       PROJECT(DNO:ingredient_id)
                       JOIN(ING:K_id,DNO:ingredient_id)
                         PROJECT(ING:code_name_str)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List_Levert
DNO:Dato               LIKE(DNO:Dato)                 !List box control field - type derived from field
DNO:Antall             LIKE(DNO:Antall)               !List box control field - type derived from field
DNO:Brukt              LIKE(DNO:Brukt)                !List box control field - type derived from field
DNO:Barkode            LIKE(DNO:Barkode)              !List box control field - type derived from field
ING:code_name_str      LIKE(ING:code_name_str)        !List box control field - type derived from field
DNO:ID_DelNode         LIKE(DNO:ID_DelNode)           !Browse hot field - type derived from field
DNO:Deleted_Flag       LIKE(DNO:Deleted_Flag)         !Browse hot field - type derived from field
DNO:Lager_kg           LIKE(DNO:Lager_kg)             !Browse hot field - type derived from field
DNO:DatoTimeStr        LIKE(DNO:DatoTimeStr)          !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW3::View:Browse    VIEW(DelNode2)
                       PROJECT(DN2:Dato)
                       PROJECT(DN2:Barkode)
                       PROJECT(DN2:Antall)
                       PROJECT(DN2:Antall_kg)
                       PROJECT(DN2:Brukt)
                       PROJECT(DN2:Brukt_kg)
                       PROJECT(DN2:Lager)
                       PROJECT(DN2:Lager_kg)
                       PROJECT(DN2:Kilde)
                       PROJECT(DN2:Deleted_Flag)
                       PROJECT(DN2:Referanse)
                       PROJECT(DN2:ID_DeliveredNode)
                       PROJECT(DN2:ingredient_id)
                       PROJECT(DN2:ID_DelNode)
                       PROJECT(DN2:DatoTimeStr)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List
DN2:Dato               LIKE(DN2:Dato)                 !List box control field - type derived from field
DN2:Barkode            LIKE(DN2:Barkode)              !List box control field - type derived from field
DN2:Antall             LIKE(DN2:Antall)               !List box control field - type derived from field
DN2:Antall_kg          LIKE(DN2:Antall_kg)            !List box control field - type derived from field
DN2:Brukt              LIKE(DN2:Brukt)                !List box control field - type derived from field
DN2:Brukt_kg           LIKE(DN2:Brukt_kg)             !List box control field - type derived from field
DN2:Lager              LIKE(DN2:Lager)                !List box control field - type derived from field
DN2:Lager_kg           LIKE(DN2:Lager_kg)             !List box control field - type derived from field
DN2:Kilde              LIKE(DN2:Kilde)                !List box control field - type derived from field
DN2:Deleted_Flag       LIKE(DN2:Deleted_Flag)         !List box control field - type derived from field
DN2:Referanse          LIKE(DN2:Referanse)            !List box control field - type derived from field
DN2:ID_DeliveredNode   LIKE(DN2:ID_DeliveredNode)     !Browse hot field - type derived from field
DN2:ingredient_id      LIKE(DN2:ingredient_id)        !Browse hot field - type derived from field
DN2:ID_DelNode         LIKE(DN2:ID_DelNode)           !Browse hot field - type derived from field
DN2:DatoTimeStr        LIKE(DN2:DatoTimeStr)          !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW6::View:Browse    VIEW(Used)
                       PROJECT(USE:Dato)
                       PROJECT(USE:Tid)
                       PROJECT(USE:used)
                       PROJECT(USE:notes)
                       PROJECT(USE:dline_id)
                       PROJECT(USE:ID_Used)
                     END
Queue:Browse:4       QUEUE                            !Queue declaration for browse/combo box using ?List:2
USE:Dato               LIKE(USE:Dato)                 !List box control field - type derived from field
USE:Tid                LIKE(USE:Tid)                  !List box control field - type derived from field
USE:used               LIKE(USE:used)                 !List box control field - type derived from field
USE:notes              LIKE(USE:notes)                !List box control field - type derived from field
USE:dline_id           LIKE(USE:dline_id)             !Browse hot field - type derived from field
USE:ID_Used            LIKE(USE:ID_Used)              !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
Window               WINDOW('Lager versjon 1.04 (2012-06-08)'),AT(,,677,443),FONT('MS Sans Serif',8,,FONT:regular),ICON('C:\Source_C55\Lager\Images\CLARION.ICO'),TIMER(100),SYSTEM,GRAY,MAX,RESIZE,AUTO,IMM
                       SHEET,AT(1,0,673,364),USE(?Sheet1),BELOW
                         TAB(' Leveranser'),USE(?Tab_Levering)
                           BUTTON('&Start registrering'),AT(11,32,169,20),USE(?But_Start_Registering),FONT(,14,,,CHARSET:ANSI)
                           BUTTON('&Avbryt registering'),AT(208,317,137,20),USE(?But_Avbryt_Registering),DISABLE,FONT(,14,,,CHARSET:ANSI)
                           BUTTON('Vis registrerte levering'),AT(191,33,169,20),USE(?Button33),HIDE,FONT(,14,,)
                           SHEET,AT(369,31,281,15),USE(?Sheet3),NOSHEET
                             TAB(' Dato (des)'),USE(?Tab_Dato_Des_LevList),FONT('Arial',,,,CHARSET:ANSI)
                             END
                             TAB(' Dato (asc)'),USE(?Tab_Dato_Asc_LevList)
                             END
                             TAB(' Barkode'),USE(?Tab_Barkode_LevList)
                             END
                             TAB(' Beskrivelse'),USE(?Tab_Beskrivelse_LevList)
                             END
                           END
                           PANEL,AT(5,30,360,312),USE(?Panel9)
                           STRING('Registrer leveranse av ingredienser til lager'),AT(53,10),USE(?String27),TRN,FONT(,14,,)
                           STRING('Liste av aktive leveringer'),AT(445,10),USE(?String30),TRN,FONT(,14,,)
                           STRING('Antall:'),AT(607,34),USE(?String55)
                           STRING(@n-_8B),AT(629,34),USE(LOC:Teller_Aktive_Leveringer)
                           PANEL,AT(366,4,304,26),USE(?Panel10),FILL(COLOR:Silver),BEVEL(2,-2)
                           PANEL,AT(366,30,304,312),USE(?Panel8)
                           GROUP(' Velg antall barkoder som skal skrives ut.'),AT(14,263,345,47),USE(?Group_Barkoder),DISABLE,BOXED,FONT(,12,,)
                             BUTTON('1'),AT(66,278),USE(?But_Nummer_1),FONT(,14,,,CHARSET:ANSI)
                             BUTTON('5'),AT(112,278),USE(?But_Nummer_5),FONT(,14,,,CHARSET:ANSI)
                             BUTTON('10'),AT(158,278),USE(?But_Nummer10),FONT(,14,,,CHARSET:ANSI)
                             STRING('Antall:'),AT(26,284),USE(?String28),TRN,FONT(,12,,FONT:bold)
                             BUTTON('Ferdig'),AT(20,317,151,20),USE(?Button_Ferdig),DISABLE,FONT(,14,,)
                           END
                           BUTTON('Skriv_Barkode'),AT(555,318,110,20),USE(?But_Skriv_Barkode),DISABLE,FONT('Arial',14,,,CHARSET:ANSI)
                           GROUP(' Ingrediensdata'),AT(11,155,345,30),USE(?Group_Ingrediensdata),DISABLE,BOXED,FONT(,12,,)
                             STRING('Ingrediens'),AT(17,168),USE(?Str_Kode),FONT(,12,,FONT:bold,CHARSET:ANSI)
                             STRING(@s10),AT(83,168,51,14),USE(LOC:Ingrediens_code),LEFT,FONT(,12,,FONT:bold,CHARSET:ANSI)
                             STRING(@s60),AT(139,168,214,12),USE(LOC:Ingrediens_name),LEFT,FONT(,12,,FONT:bold,CHARSET:ANSI)
                           END
                           GROUP('Registrer lever antall sekker'),AT(11,186,345,52),USE(?Group_Antall),DISABLE,BOXED,FONT(,12,,)
                             STRING('Antall sekker'),AT(20,204),USE(?String19),FONT(,12,,FONT:bold)
                             ENTRY(@n-_8B),AT(106,199),USE(LOC:Antall_Enheter),RIGHT(3),FONT(,12,,),COLOR(,COLOR:Black,COLOR:Aqua)
                             ENTRY(@n-_8B),AT(270,199),USE(LOC:Enhets_Vekt),RIGHT(3),FONT(,12,,,CHARSET:ANSI),COLOR(,COLOR:Black,COLOR:Aqua)
                             STRING('Vekt per sekk'),AT(183,204),USE(?String20),FONT(,12,,FONT:bold)
                             STRING('Totalvekt for leveranse:'),AT(135,220),USE(?String54),FONT(,12,,FONT:bold)
                             STRING(@n-_8B),AT(272,220),USE(LOC:Totalvekt_Levert),TRN,FONT(,12,,FONT:bold)
                           END
                           BUTTON('&Lagre oppsatt levering'),AT(11,242,169,20),USE(?Button_Lagre_Oppsett),DISABLE,FONT(,14,,)
                           BUTTON('Kanseler registrering'),AT(183,242,169,20),USE(?Button_Kanseler),DISABLE,HIDE,FONT(,14,,)
                           GROUP(' Navn på leverandør'),AT(11,53,343,77),USE(?Group_Leverandoer),DISABLE,BOXED,FONT(,12,,)
                             STRING('Leverandør'),AT(15,69),USE(?String12),FONT(,12,,FONT:bold,CHARSET:ANSI)
                             ENTRY(@s50),AT(89,67,257,16),USE(LOC:Kilde),FONT(,12,,,CHARSET:ANSI),COLOR(,COLOR:Black,COLOR:Aqua)
                             STRING('Referanse'),AT(20,89),USE(?String52),FONT(,12,,FONT:bold)
                             ENTRY(@s50),AT(89,87,154,16),USE(LOC:Referanse),FONT(,12,,,CHARSET:ANSI),COLOR(,COLOR:Black,COLOR:Aqua)
                             STRING('Notater'),AT(37,109),USE(?String56),FONT(,12,,FONT:bold)
                             ENTRY(@s150),AT(89,107,254,16),USE(LOC:Notater),FONT(,12,,,CHARSET:ANSI),COLOR(,COLOR:Black,COLOR:Aqua)
                           END
                           LIST,AT(371,47,291,268),USE(?List_Levert),IMM,HVSCROLL,COLOR(,COLOR:Black,COLOR:Aqua),MSG('Browsing Records'),FORMAT('47L(2)|M~Dato~C(0)@D06-@32R(2)|M~Antall~C(0)@s15@31R(2)|M~Brukt~C(0)@s15@34C(2)|' &|
   'M~Barkode~C(0)@s25@240L(3)|M~Kode: Ingrediens beskrivelse~@s60@'),FROM(Queue:Browse)
                           BUTTON('Velg ingrediens'),AT(11,135,169,20),USE(?But_Velg_Ingrediens),DISABLE,FONT(,14,,)
                           BUTTON('20'),AT(239,138),USE(?But_Nummer20),DISABLE,HIDE,FONT(,14,,)
                           BUTTON('+1'),AT(280,138),USE(?But_Pluss_1),DISABLE,HIDE,FONT(,14,,)
                           BUTTON('+5'),AT(317,139),USE(?But_Pluss_5),DISABLE,HIDE,FONT(,14,,,CHARSET:ANSI)
                           PANEL,AT(5,4,360,26),USE(?Panel2),FILL(COLOR:Silver),BEVEL(2,-2)
                         END
                         TAB(' Administrasjon'),USE(?Tab_Admin)
                           SHEET,AT(5,4,663,343),USE(?Sheet2)
                             TAB(' Oppdater tankdata'),USE(?Tab6)
                               LIST,AT(10,22,652,290),USE(?List_Tank),IMM,HVSCROLL,FONT(,10,,),MSG('Browsing Records'),FORMAT('40R(3)|M~Nummer~C(0)@s10@45R(3)|M~Alarm~C(0)@s15@45R(3)|M~Advarsel~C(0)@s15@45R(' &|
   '3)|M~Maks.~C(0)@s15@45R(3)|M~Volume~C(0)@s15@40R(3)|M~mengde~C(0)@s10@45L(3)|M~c' &|
   'ode~C(0)@s10@180L(3)|M~name~L(2)@s60@600L(2)|M~notes~@s150@37L(2)|M~Vekt~C(0)@s1' &|
   '5@'),FROM(Queue:Browse:2)
                               BUTTON('Endre tankdata'),AT(47,317,149,16),USE(?Button26),FONT(,14,,)
                               BUTTON('Skriv ut barcode for tank'),AT(214,317,182,16),USE(?Button38),FONT(,14,,)
                               BUTTON('Endre tankmengde'),AT(417,318,149,16),USE(?Button55),DISABLE,HIDE,FONT(,14,,)
                             END
                             TAB('Oppdatering av verdier knyttet til ingredienser'),USE(?Tab_IngData_Update)
                               SHEET,AT(9,20,655,158),USE(?Sheet4)
                                 TAB(' Kode'),USE(?Tab_Admin_Ing_Kode)
                                 END
                                 TAB(' Beskrivelse'),USE(?Tab_Admin_Ing_Beskrivelse)
                                 END
                               END
                               LIST,AT(15,36,644,135),USE(?List_ingredients),IMM,HVSCROLL,FONT(,8,,),COLOR(,COLOR:Black,COLOR:Aqua),MSG('Browsing Records'),FORMAT('194L(2)|M~Kode: Ingrediens beskrivelse~@s60@44R(2)|M~Leveranser~C(0)@n-_8B@44R(2' &|
   ')|M~Lager(kg)~C(0)@n-_8B@600L(2)|M~Notes~@s150@'),FROM(Queue:Browse:3)
                               LIST,AT(13,211,383,114),USE(?List),IMM,HVSCROLL,COLOR(,COLOR:Black,COLOR:Aqua),MSG('Browsing Records'),FORMAT('46L(2)|M~Dato~C(0)@d06.@37L(2)|M~Barkode~C(0)@s25@30R(2)|M~Antall~C(0)@s15@30R(2' &|
   ')|M~kg~C(0)@n-_8B@30R(2)|M~Brukt~C(0)@s15@30R(2)|M~kg~C(0)@n-_8@30R(2)|M~Lager~C' &|
   '(0)@s15@30R(2)|M~kg~C(0)@n-_8B@123L(2)|M~Kilde~@s60@60L(2)|M~Avsluttet~@s15@69L(' &|
   '2)|M~Referanse~@s60@'),FROM(Queue:Browse:1)
                               PANEL,AT(399,208,266,121),USE(?Panel18)
                               LIST,AT(403,211,256,114),USE(?List:2),IMM,COLOR(,COLOR:Black,COLOR:Aqua),MSG('Browsing Records'),FORMAT('50L(3)|M~Dato~C(0)@D06-B@28C|M~Tid~@t7@30R(3)|M~Antall~L(2)@s15@600L(2)|M~Merkna' &|
   'der til forbruk~@s150@'),FROM(Queue:Browse:4)
                               SHEET,AT(9,195,390,149),USE(?Sheet5)
                                 TAB(' Aktive leveranser'),USE(?Tab_Aktive_Leveranser)
                                 END
                                 TAB(' Alle leveranser'),USE(?Tab_Alle_Leveranser)
                                 END
                               END
                               BUTTON('Korriger antall'),AT(295,327,101,14),USE(?Button56),FONT(,12,,FONT:bold)
                               STRING('Toalt:'),AT(74,330),USE(?String62),TRN
                               STRING(@n-_8B),AT(93,330),USE(LOC:Totalt_Levering_Antall),TRN,RIGHT,FONT(,8,,)
                               STRING(@n-_8B),AT(154,330),USE(LOC:Total_Levering_Brukt),TRN,RIGHT,FONT(,8,,)
                               STRING(@n-_8B),AT(127,330),USE(LOC:Totalt_Levering_Antall_kg),TRN,RIGHT,FONT(,8,,)
                               STRING(@n-_8B),AT(189,330),USE(LOC:Total_Levering_Brukt_kg),TRN,RIGHT,FONT(,8,,)
                               STRING(@n-_8B),AT(220,330),USE(LOC:Total_Levering_Lager),TRN,RIGHT,FONT(,8,,)
                               STRING(@n-_8B),AT(250,330),USE(LOC:Total_Levering_Lager_kg),TRN,RIGHT,FONT(,8,,)
                               BUTTON('Endre notater for ingrediens'),AT(9,179,229,16),USE(?But_Oppdater_IngData_Notes),FONT(,14,,)
                               STRING('Forbruk fra valgt levering'),AT(403,199),USE(?String61)
                             END
                           END
                         END
                         TAB(' Påfylling'),USE(?Tab_Paafylling)
                           PANEL,AT(4,3,664,83),USE(?Panel_Farge),FILL(0C8D0D4H)
                           STRING(@s60),AT(129,14,401,17),USE(LOC:Melding_Tank),TRN,CENTER,FONT(,14,,)
                           STRING(@s80),AT(12,34,633,25),USE(LOC:Melding_Paafylling),TRN,CENTER,FONT(,24,,)
                           STRING(@s80),AT(129,60,401,17),USE(LOC:Melding_Ingrediens),TRN,CENTER,FONT(,14,,)
                           GROUP('Antall'),AT(7,254,652,34),USE(?Group_Pafyllings:Antall),DISABLE
                             BUTTON('0'),AT(196,257,50,26),USE(?But_Nullstill),FONT(,24,,)
                             BUTTON('+ 1'),AT(257,257,50,26),USE(?But_Pluss_En),FONT(,24,,)
                             BUTTON('+ 5'),AT(312,257,50,26),USE(?But_Pluss_Fem),FONT(,24,,)
                             BUTTON('+ 10'),AT(368,257,50,26),USE(?But_Pluss_Ti),FONT(,24,,)
                             BUTTON('+50'),AT(423,257,50,26),USE(?But_Pluss_Femti),FONT(,24,,)
                             STRING('Antall sekker:'),AT(13,262),USE(?String31),FONT(,18,,)
                             STRING(@n-_5B),AT(121,262),USE(LOC:Antall_Sekker),FONT(,18,,)
                             STRING('Totalvekt:'),AT(487,262),USE(?String53),FONT(,18,,)
                             STRING(@n-_9B),AT(555,262),USE(LOC:Totalvekt_Paafylling),TRN,FONT(,18,,)
                           END
                           PANEL,AT(4,294,664,20),USE(?Panel17)
                           STRING(@s120),AT(12,298,648,12),USE(LOC:Paafyll_Fullfoert_Melding),FONT('Arial',11,,,CHARSET:ANSI)
                           STRING('Barkode'),AT(13,97),USE(?String6),FONT(,18,,)
                           ENTRY(@s35),AT(106,95,106,),USE(LOC:Lest_Barcode),FONT(,18,,)
                           BUTTON('Oppslag barkode'),AT(224,95,155,22),USE(?Button32),FONT(,18,,),DEFAULT
                           BUTTON('Merknad'),AT(397,95,89,22),USE(?But_Merknad),FONT(,18,,)
                           STRING('Vekt:'),AT(555,101),USE(?String46),FONT(,12,,)
                           STRING(@s20),AT(591,101,60,),USE(LOC:Vekt),FONT(,12,,)
                           STRING(@s150),AT(104,121,556,12),USE(LOC:Paafyll_Used_Notes),FONT('Arial',12,,,CHARSET:ANSI)
                           BUTTON('Av'),AT(627,66,35,16),USE(?Button51),HIDE
                           BUTTON('Grønn'),AT(590,66,35,16),USE(?Button44),HIDE
                           PANEL,AT(4,137,664,55),USE(?Panel13)
                           PANEL,AT(4,192,664,55),USE(?Panel15)
                           STRING('barkode for leverings:'),AT(9,198),USE(?String37:2),TRN,FONT(,14,,)
                           STRING('Ingrediens:'),AT(153,198),USE(?String51),TRN,FONT(,14,,)
                           STRING(@s60),AT(226,198,433,17),USE(LOC:Valgt_Ingredient_Info),TRN,FONT(,14,,)
                           STRING(@s15),AT(11,213,103,34),USE(GLO:Valgt_Levering_Barcode),TRN,CENTER,FONT('Arial',36,,,CHARSET:ANSI)
                           STRING(@D17B),AT(226,222,82,17),USE(LOC:Valgt_DelNode_Dato),TRN,FONT(,14,,)
                           STRING('Antall:'),AT(302,222),USE(?String58),TRN,FONT(,14,,)
                           STRING(@s15),AT(343,222,45,17),USE(LOC:Valgt_DelNode_Antall),TRN,LEFT,FONT(,14,,)
                           STRING('Brukt:'),AT(390,222),USE(?String60),TRN,FONT(,14,,)
                           STRING(@s15),AT(429,222,45,17),USE(LOC:Valgt_DelNode_Brukt),TRN,LEFT,FONT(,14,,)
                           STRING('På lager:'),AT(476,222),USE(?String59),TRN,FONT(,14,,)
                           STRING(@s20),AT(532,222,130,17),USE(LOC:Valgt_DelNode_Lager),TRN,LEFT,FONT(,14,,)
                           STRING('Levert:'),AT(179,222),USE(?String57),FONT(,14,,)
                           STRING('Ingrediens:'),AT(153,141),USE(?String39),TRN,FONT(,14,,)
                           STRING(@s60),AT(226,141,433,17),USE(LOC:Valgt_Tank_ingredient_Info),TRN,LEFT,FONT(,14,,)
                           STRING(@s15),AT(11,158,103,33),USE(LOC:Valgt_Tank),TRN,CENTER,FONT('Arial',36,,,CHARSET:ANSI)
                           STRING('Alarm:'),AT(226,158),USE(?String66),FONT('Arial',12,,)
                           STRING(@s15),AT(255,158,31,13),USE(LOC:alarm_Paafyll),RIGHT,FONT('Arial',12,,)
                           STRING('Advarsel:'),AT(320,158),USE(?String67),FONT('Arial',12,,)
                           STRING(@s16),AT(361,158,31,13),USE(LOC:warning_Paafyll),RIGHT,FONT('Arial',12,,)
                           STRING('Maksimum:'),AT(428,158),USE(?String68),FONT('Arial',12,,)
                           STRING(@s15),AT(479,158,31,13),USE(LOC:maximum_Paafyll),RIGHT,FONT('Arial',12,,)
                           STRING('Volum:'),AT(546,158),USE(?String69),FONT('Arial',12,,)
                           STRING(@s15),AT(576,158,31,13),USE(LOC:volume_Paafyll),RIGHT,FONT('Arial',12,,)
                           STRING('Merknader:'),AT(226,174),USE(?String70),FONT('Arial',12,,)
                           STRING(@s150),AT(282,174,383,14),USE(LOC:notes_Paafyll),FONT('Arial',12,,)
                           STRING('Valgt tanknummer:'),AT(9,144),USE(?String37),TRN,FONT(,14,,)
                           PANEL,AT(4,247,664,47),USE(?Panel14)
                           BUTTON('Rød'),AT(552,66,35,16),USE(?Button45),HIDE
                           PANEL,AT(4,87,664,50),USE(?Panel12)
                           BUTTON('Avbryt påfylling'),AT(508,318,160,26),USE(?Button_Avbryt_Paafylling),FONT(,18,,,CHARSET:ANSI)
                           STRING(@s15),AT(611,353),USE(GLO:Valgt_Delivered_ID),RIGHT
                           BUTTON('Kvitter påfylling'),AT(12,318,160,26),USE(?But_Kvitter),DISABLE,FONT(,18,,)
                         END
                         TAB(' System oppsett'),USE(?Tab_Kontroll)
                           BUTTON('Vis liste for påfyllingsvarsel'),AT(503,201,147,16),USE(?But_RefillCheck)
                           BUTTON('Vis status for lamper'),AT(503,117,147,16),USE(?But_Status)
                           BUTTON('Skru på rød lampe'),AT(503,28,147,16),USE(?But_Lamp_Red_On)
                           BUTTON('Skru av rød lampe'),AT(503,47,147,16),USE(?But_Lamp_Red_Off)
                           BUTTON('Skru på grønn lampe'),AT(503,72,147,16),USE(?But_Lamp_Green_On)
                           BUTTON('Skru av grønn lampe'),AT(503,91,147,16),USE(?But_Lamp_Green_Off)
                           BUTTON('Vis linjer fra proxy log'),AT(503,177,147,16),USE(?Button22)
                           BUTTON('Test labelprinter'),AT(503,284,147,16),USE(?Button29),FONT(,10,,)
                           BUTTON('Test stor label'),AT(503,307,147,16),USE(?Button34),FONT(,10,,)
                           PANEL,AT(6,3,481,327),USE(?Panel5)
                           STRING('Returmeldinger'),AT(12,7),USE(?String41),FONT(,12,,FONT:bold)
                           STRING('Test av påfyllingslamper'),AT(527,10),USE(?String47),FONT(,10,,)
                           PANEL,AT(488,3,172,142),USE(?Panel16)
                           TEXT,AT(11,23,467,302),USE(LOC:List2),HVSCROLL
                         END
                         TAB('Test'),USE(?Tab_Test)
                           ENTRY(@S20),AT(74,7,69,12),USE(L:BIPAddr),MSG('Demo-B''s IP Address'),TIP('Demo-B''s IP Address')
                           STRING(@s200),AT(208,7,130,10),USE(L:LastCommand),LEFT
                           BUTTON('ListIngredients'),AT(394,7,84,14),USE(?But_ListIngredients)
                           BUTTON('DeliveredRead'),AT(484,7,84,14),USE(?But_DeliveredRead)
                           BUTTON('Unique'),AT(574,7,84,14),USE(?But_Unique)
                           PROMPT('Proxy IP-adrresse'),AT(12,12),USE(?L:BIPAddr:Prompt)
                           STRING(@s40),AT(208,20,130,10),USE(L:LastEvent),LEFT
                           ENTRY(@s6),AT(74,23,69,12),USE(LOC:Port_Number),MSG('- Portnummer for proxy'),TIP('- Portnummer for proxy')
                           BUTTON('Connect'),AT(150,23,45,14),USE(?ButtonConnect)
                           BUTTON('IngDataRead'),AT(394,23,84,14),USE(?Button11)
                           BUTTON('UsedLineHistory'),AT(484,23,84,14),USE(?Button54)
                           BUTTON('DeliveredLinesRead'),AT(583,328,84,14),USE(?But_DeliveredLinesRead),HIDE
                           PROMPT('Port Nummer:'),AT(24,28),USE(?LOC:Port_Number:Prompt)
                           STRING(@s40),AT(208,28,130,10),USE(L:Status),LEFT
                           STRING('Kommando navn'),AT(11,52),USE(?String1)
                           LIST,AT(71,52,110,12),USE(?List1),FORMAT('400L(2)|M~LOC : Command~@s100@'),DROP(10),FROM('Tank|ListIngredients|help')
                           BUTTON('ListWeights'),AT(394,52,84,14),USE(?But_ListWeights)
                           BUTTON('BarcodeRead'),AT(484,52,84,14),USE(?But_BarcodeRead)
                           STRING('Kommando text'),AT(15,62),USE(?String2)
                           ENTRY(@s100),AT(71,62,264,12),USE(L:EntryText),MSG('- Entry Text to Send'),TIP('- Entry Text to Send')
                           BUTTON('Tank'),AT(394,68,84,14),USE(?But_Tank)
                           BUTTON('Utfør kommando'),AT(71,78,81,14),USE(?Button2),DEFAULT
                           BUTTON('Formatert Liste'),AT(263,78,72,14),USE(?Button3)
                           BUTTON('TankDataRead'),AT(394,84,84,14),USE(?But_TankDataRead)
                           BUTTON('Sett standard config'),AT(574,113,84,14),USE(?Button52)
                         END
                       END
                       OLE,AT(279,424,19,15),USE(?OCX),HIDE,CREATE('Catalyst.SocketCtrl.1'),COMPATIBILITY(020H)
                       END
                       STRING(@s200),AT(303,428,301,10),USE(LOC:Info_Str)
                       STRING(@s8),AT(620,428),USE(GLO:Ny_Barcode),LEFT
                       STRING(@d08.B),AT(176,428),USE(LOC:Current_Date)
                       STRING(@t7B),AT(230,428),USE(LOC:Current_Time)
                       PANEL,AT(1,367,673,56),USE(?Panel_Varsel)
                       TEXT,AT(6,378,663,40),USE(GLO:Liste_Paafyllingsvarsel),VSCROLL,FONT(,12,,,CHARSET:ANSI),READONLY
                       BUTTON('Refresh'),AT(6,424,63,16),USE(?Button50),FONT(,,,FONT:bold)
                       BUTTON(' . '),AT(265,426,9,11),USE(?Button47),DEFAULT
                       STRING('Varsel for tanker som trenger påfylling:'),AT(6,368),USE(?String29),TRN,FONT(,10,,FONT:bold)
                       STRING(@s20),AT(88,428),USE(LOC:Connect_Status)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW5                 CLASS(BrowseClass)               !Browse using ?List_ingredients
Q                      &Queue:Browse:3                !Reference to browse queue
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
SetQueueRecord         PROCEDURE(),DERIVED
                     END

BRW5::Sort0:Locator  IncrementalLocatorClass          !Default Locator
BRW5::Sort1:Locator  IncrementalLocatorClass          !Conditional Locator - CHOICE(?Sheet4)=2
BRW4                 CLASS(BrowseClass)               !Browse using ?List_Tank
Q                      &Queue:Browse:2                !Reference to browse queue
                     END

BRW2                 CLASS(BrowseClass)               !Browse using ?List_Levert
Q                      &Queue:Browse                  !Reference to browse queue
ResetFromView          PROCEDURE(),DERIVED
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
                     END

BRW2::Sort0:Locator  IncrementalLocatorClass          !Default Locator
BRW2::Sort1:Locator  IncrementalLocatorClass          !Conditional Locator - CHOICE(?Sheet3)=2
BRW2::Sort2:Locator  IncrementalLocatorClass          !Conditional Locator - CHOICE(?Sheet3)=3
BRW3                 CLASS(BrowseClass)               !Browse using ?List
Q                      &Queue:Browse:1                !Reference to browse queue
ResetFromView          PROCEDURE(),DERIVED
ResetSort              PROCEDURE(BYTE Force),BYTE,PROC,DERIVED
                     END

BRW3::Sort0:Locator  StepLocatorClass                 !Default Locator
BRW3::Sort1:Locator  StepLocatorClass                 !Conditional Locator - CHOICE(?Sheet5)=2
BRW6                 CLASS(BrowseClass)               !Browse using ?List:2
Q                      &Queue:Browse:4                !Reference to browse queue
                     END

BRW6::Sort0:Locator  StepLocatorClass                 !Default Locator

  CODE
  GlobalResponse = ThisWindow.Run()


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?But_Start_Registering
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors
  CLEAR(GlobalRequest)
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  Relate:Barcode.Open
  Relate:DelNode.Open
  Relate:DelNode2.Open
  Relate:IngData.Open
  Relate:Tankdata.Open
  Relate:Used.Open
  Relate:ingredient.Open
  Relate:ingredient2.Open
  Relate:sourcetank.Open
  Relate:weight.Open
  SELF.FilesOpened = True
  BRW5.Init(?List_ingredients,Queue:Browse:3.ViewPosition,BRW5::View:Browse,Queue:Browse:3,Relate:ingredient2,SELF)
  BRW4.Init(?List_Tank,Queue:Browse:2.ViewPosition,BRW4::View:Browse,Queue:Browse:2,Relate:sourcetank,SELF)
  BRW2.Init(?List_Levert,Queue:Browse.ViewPosition,BRW2::View:Browse,Queue:Browse,Relate:DelNode,SELF)
  BRW3.Init(?List,Queue:Browse:1.ViewPosition,BRW3::View:Browse,Queue:Browse:1,Relate:DelNode2,SELF)
  BRW6.Init(?List:2,Queue:Browse:4.ViewPosition,BRW6::View:Browse,Queue:Browse:4,Relate:Used,SELF)
  OPEN(Window)
  SELF.Opened=True
  ! Henter inn verdier for oppstart/kaller opp rutine for oppstart hvis tabellen er tom
  
     LOC:Refresh_Teller = 15    ! 15 'ticks' til første oppdatering
  
     GLO:Save_Mode = 'Insert'         ! Insert = new records, Update = refresh records
  
!     OPP:ID_Oppsett = 1
!     IF Access:Oppsett.Fetch(OPP:K_ID_Oppsett) NOT= Level:Benign THEN
!
!        IF ERRORCODE() = 35 THEN
!           LOC:Ny_Start_Flag = 1      ! Angir at dette er 'Første' gang programmet starter.
!
!           IF Oppdater_Oppsett('New') = 'New' THEN
!              STOP('Oppstartsverdier er ikke angitt.|Programmet vil ikke fungere normalt.')
!           ELSE
!              OPP:ID_Oppsett = 1
!              IF Access:Oppsett.Fetch(OPP:K_ID_Oppsett) NOT= Level:Benign THEN
!                 STOP('Feil ved innhenting av oppstartsverdier.|Programmet vil ikke fungere normalt.' )
!              END
!           END
!        ELSE
!           STOP('Feil ved innhenting av oppstartsverdier.|Programmet vil ikke fungere normalt.' )
!        END
!     END
  
     ?OCX{'HostAddress'} = CLIP(GETINI('Oppsett','IP','79.161.10.133','Lager.INI'))   !  Set IP address of remote host to talk to
     ?OCX{'RemotePort'}  = CLIP(GETINI('Oppsett','Port','30125','Lager.INI'))        !  Connect to a listening port of remote host
  
     LOC:Vekt = GETINI('Oppsett','Vekt','Micro','Lager.INI')
  OCXRegisterEventProc(?OCX,MainOCXEventHandler)
  ?OCX{'AddressFamily'}   = AF_INET       !Part of the socket address, always AF_INET
  ?OCX{'Protocol'}        = IPPROTO_IP    !Use IP protocol
  ?OCX{'SocketType'}      = SOCK_STREAM   !Use streams as opposed to datagrams
  ?OCX{'Blocking'}        = FALSE         !Don't wait for socket operations to complete before continuing
  ?OCX{'AutoResolve'}     = FALSE         !Do not try to resolve host names (see notes)
  ?OCX{'BufferSize'}      = 5000          !Set size of send & rec buffers
  ?OCX{'Binary'}          = FALSE         !Reads on the socket terminated by CR/LF
  
  L:MyIP = ?OCX{'AdapterAddress(0)'}      !Display this machine's IP address on screen
  BRW5.Q &= Queue:Browse:3
  BRW5.AddSortOrder(,IN2:K_name)
  BRW5.AddLocator(BRW5::Sort1:Locator)
  BRW5::Sort1:Locator.Init(,IN2:name,1,BRW5)
  BRW5.AddSortOrder(,IN2:K_code)
  BRW5.AddLocator(BRW5::Sort0:Locator)
  BRW5::Sort0:Locator.Init(,IN2:code,1,BRW5)
  BIND('LOC:Ingrediens_id',LOC:Ingrediens_id)
  BRW5.AddField(IN2:code_name_str,BRW5.Q.IN2:code_name_str)
  BRW5.AddField(IN2:Aktive_Leveranser,BRW5.Q.IN2:Aktive_Leveranser)
  BRW5.AddField(IN2:Lager_Kg,BRW5.Q.IN2:Lager_Kg)
  BRW5.AddField(IND:Notes,BRW5.Q.IND:Notes)
  BRW5.AddField(IN2:id,BRW5.Q.IN2:id)
  BRW5.AddField(IN2:ID_ingredient,BRW5.Q.IN2:ID_ingredient)
  BRW5.AddField(IND:ID_IngData,BRW5.Q.IND:ID_IngData)
  BRW5.AddField(LOC:Ingrediens_id,BRW5.Q.LOC:Ingrediens_id)
  BRW5.AddField(IN2:name,BRW5.Q.IN2:name)
  BRW5.AddField(IN2:code,BRW5.Q.IN2:code)
  BRW4.Q &= Queue:Browse:2
  BRW4.AddSortOrder(,)
  BRW4.AddField(SOU:tanknummer,BRW4.Q.SOU:tanknummer)
  BRW4.AddField(TAN:alarm,BRW4.Q.TAN:alarm)
  BRW4.AddField(TAN:warning,BRW4.Q.TAN:warning)
  BRW4.AddField(TAN:maximum,BRW4.Q.TAN:maximum)
  BRW4.AddField(TAN:volume,BRW4.Q.TAN:volume)
  BRW4.AddField(SOU:mengde,BRW4.Q.SOU:mengde)
  BRW4.AddField(SOU:code,BRW4.Q.SOU:code)
  BRW4.AddField(SOU:name,BRW4.Q.SOU:name)
  BRW4.AddField(TAN:notes,BRW4.Q.TAN:notes)
  BRW4.AddField(TAN:weightname,BRW4.Q.TAN:weightname)
  BRW4.AddField(SOU:ID_sourcetank,BRW4.Q.SOU:ID_sourcetank)
  BRW4.AddField(SOU:id,BRW4.Q.SOU:id)
  BRW4.AddField(TAN:ID_Tankdata,BRW4.Q.TAN:ID_Tankdata)
  BRW2.Q &= Queue:Browse
  BRW2.FileLoaded = 1
  BRW2.AddSortOrder(,DNO:K_DatoStr_Asc)
  BRW2.AddLocator(BRW2::Sort1:Locator)
  BRW2::Sort1:Locator.Init(,DNO:DatoTimeStr,1,BRW2)
  BRW2.SetFilter('((DNO:Deleted_Flag <<> ''Deleted'') AND (DNO:Lager_kg NOT= 0))')
  BRW2.AddSortOrder(,DNO:K_Barkode)
  BRW2.AddLocator(BRW2::Sort2:Locator)
  BRW2::Sort2:Locator.Init(,DNO:Barkode,1,BRW2)
  BRW2.SetFilter('((DNO:Deleted_Flag <<> ''Deleted'') AND (DNO:Lager_kg NOT= 0))')
  BRW2.AddSortOrder(,)
  BRW2.AppendOrder('ING:name')
  BRW2.SetFilter('((DNO:Deleted_Flag <<> ''Deleted'') AND (DNO:Lager_kg NOT= 0))')
  BRW2.AddSortOrder(,DNO:K_DatoStr_Des)
  BRW2.AddLocator(BRW2::Sort0:Locator)
  BRW2::Sort0:Locator.Init(,DNO:DatoTimeStr,1,BRW2)
  BRW2.SetFilter('((DNO:Deleted_Flag <<> ''Deleted'') AND (DNO:Lager_kg NOT= 0))')
  BRW2.AddResetField(GLO:Browse_Delivered_Refresh)
  BRW2.AddField(DNO:Dato,BRW2.Q.DNO:Dato)
  BRW2.AddField(DNO:Antall,BRW2.Q.DNO:Antall)
  BRW2.AddField(DNO:Brukt,BRW2.Q.DNO:Brukt)
  BRW2.AddField(DNO:Barkode,BRW2.Q.DNO:Barkode)
  BRW2.AddField(ING:code_name_str,BRW2.Q.ING:code_name_str)
  BRW2.AddField(DNO:ID_DelNode,BRW2.Q.DNO:ID_DelNode)
  BRW2.AddField(DNO:Deleted_Flag,BRW2.Q.DNO:Deleted_Flag)
  BRW2.AddField(DNO:Lager_kg,BRW2.Q.DNO:Lager_kg)
  BRW2.AddField(DNO:DatoTimeStr,BRW2.Q.DNO:DatoTimeStr)
  BRW3.Q &= Queue:Browse:1
  BRW3.AddSortOrder(,DN2:K_DatoStr_Des)
  BRW3.AddLocator(BRW3::Sort1:Locator)
  BRW3::Sort1:Locator.Init(,DN2:DatoTimeStr,1,BRW3)
  BRW3.SetFilter('(CLIP(DN2:ingredient_id) = CLIP(IN2:id))')
  BRW3.AddResetField(LOC:Ingrediens_id)
  BRW3.AddSortOrder(,DN2:K_DatoStr_Des)
  BRW3.AddLocator(BRW3::Sort0:Locator)
  BRW3::Sort0:Locator.Init(,DN2:DatoTimeStr,1,BRW3)
  BRW3.SetFilter('((CLIP(DN2:ingredient_id) = CLIP(IN2:id)) AND (DN2:Lager_kg NOT= 0))')
  BRW3.AddResetField(LOC:Ingrediens_id)
  BRW3.AddField(DN2:Dato,BRW3.Q.DN2:Dato)
  BRW3.AddField(DN2:Barkode,BRW3.Q.DN2:Barkode)
  BRW3.AddField(DN2:Antall,BRW3.Q.DN2:Antall)
  BRW3.AddField(DN2:Antall_kg,BRW3.Q.DN2:Antall_kg)
  BRW3.AddField(DN2:Brukt,BRW3.Q.DN2:Brukt)
  BRW3.AddField(DN2:Brukt_kg,BRW3.Q.DN2:Brukt_kg)
  BRW3.AddField(DN2:Lager,BRW3.Q.DN2:Lager)
  BRW3.AddField(DN2:Lager_kg,BRW3.Q.DN2:Lager_kg)
  BRW3.AddField(DN2:Kilde,BRW3.Q.DN2:Kilde)
  BRW3.AddField(DN2:Deleted_Flag,BRW3.Q.DN2:Deleted_Flag)
  BRW3.AddField(DN2:Referanse,BRW3.Q.DN2:Referanse)
  BRW3.AddField(DN2:ID_DeliveredNode,BRW3.Q.DN2:ID_DeliveredNode)
  BRW3.AddField(DN2:ingredient_id,BRW3.Q.DN2:ingredient_id)
  BRW3.AddField(DN2:ID_DelNode,BRW3.Q.DN2:ID_DelNode)
  BRW3.AddField(DN2:DatoTimeStr,BRW3.Q.DN2:DatoTimeStr)
  BRW6.Q &= Queue:Browse:4
  BRW6.AddSortOrder(,USE:K_Dato_Des)
  BRW6.AddLocator(BRW6::Sort0:Locator)
  BRW6::Sort0:Locator.Init(,USE:Dato,1,BRW6)
  BRW6.SetFilter('(DN2:ID_DeliveredNode = USE:dline_id)')
  BRW6.AddResetField(DN2:ID_DeliveredNode)
  BRW6.AddField(USE:Dato,BRW6.Q.USE:Dato)
  BRW6.AddField(USE:Tid,BRW6.Q.USE:Tid)
  BRW6.AddField(USE:used,BRW6.Q.USE:used)
  BRW6.AddField(USE:notes,BRW6.Q.USE:notes)
  BRW6.AddField(USE:dline_id,BRW6.Q.USE:dline_id)
  BRW6.AddField(USE:ID_Used,BRW6.Q.USE:ID_Used)
  INIMgr.Fetch('Main',Window)
  ! Kobler program til proxy
  
     IF LOC:Connect_Status NOT= 'Connected' THEN
        ?OCX{'Action'}      = SOCKET_CONNECT         !  Try the connection
        L:Status = 'Attempting to Connect...'
     END
  
     FLAG# = GETINI('Oppsett','Leveranse','1','Lager.INI')
     IF  FLAG# NOT= 1 THEN
        HIDE(?Tab_Levering)
     END
  
     FLAG# = GETINI('Oppsett','Paafylling','1','Lager.INI')
     IF  FLAG# NOT= 1 THEN
        HIDE(?Tab_Paafylling)
     END
  
     FLAG# = GETINI('Oppsett','Administrasjon','1','Lager.INI')
     IF  FLAG# NOT= 1 THEN
        HIDE(?Tab_Admin)
     END
  
     FLAG# = GETINI('Oppsett','System','1','Lager.INI')
     IF  FLAG# NOT= 1 THEN
        HIDE(?Tab_Kontroll)
     END
  
     FLAG# = GETINI('Oppsett','Test','1','Lager.INI')
     IF  FLAG# NOT= 1 THEN
        HIDE(?Tab_Test)
     END
  
     
     ING:ID_ingredient = 1
     IF Access:ingredient.Fetch(ING:K_ID_ingredient) NOT= Level:Benign THEN
        Function_Add_Command( 'ListIngredients', 'ListIngredients' )
        LOC:Ny_Start_Flag = 1
     END
  
     IND:ID_IngData = 1
     IF Access:IngData.Fetch(IND:K_ID_IngData) NOT= Level:Benign THEN
        Function_Add_Command( 'IngDataRead', 'IngDataRead 1 -1' )
        LOC:Ny_Start_Flag = 1
     END
  
     SOU:ID_sourcetank = 1
     IF Access:sourcetank.Fetch(SOU:K_ID_sourcetank) NOT= Level:Benign THEN
        Function_Add_Command( 'Tank', 'Tank')
        LOC:Ny_Start_Flag = 1
     END
  
     TAN:ID_Tankdata = 1
     IF Access:Tankdata.Fetch(TAN:K_ID_Tankdata) NOT= Level:Benign THEN
        Function_Add_Command( 'TankDataRead', 'TankDataRead 1 -1' )
        LOC:Ny_Start_Flag = 1
     END
  
     DNO:ID_DelNode = 1
     IF Access:DelNode.Fetch(DNO:K_ID_DelNode) NOT= Level:Benign THEN
        Function_Add_Command( 'DeliveredRead', 'DeliveredRead 1 -1 0')
        LOC:Ny_Start_Flag = 1
     END
  
     BAR:ID_Barcode = 1
     IF Access:Barcode.Fetch(BAR:K_ID_Barcode) NOT= Level:Benign THEN
        Function_Add_Command( 'BarcodeRead', 'BarcodeRead' )
        LOC:Ny_Start_Flag = 1
     END
  
  
     IF LOC:Ny_Start_Flag = 1 THEN
        LOC:Ny_Start_Flag = 0
        LOC:Delay_Flag = 2   !Setter 2 sekund delay før ' POST(EVENT:WriteCommand) ' blir utført
     END
  
  ! Setter startverdi for variabler
  
     LOC:Melding_Tank       = 'Registrer barcode for tank'
     LOC:Melding_Ingrediens = 'Registrer barcode for ingrediens'
     LOC:Melding_Paafylling = ''
  
     LOC:Alarmperiode = DEFORMAT( GETINI('Oppsett','Alarmperiode','30','Lager.INI')  )
  
     CLEAR(LOC:UpdateTeller)
  
  !   USE:ID_Used = 1
  !   IF Access:Used.Fetch(USE:K_ID_Used) NOT= Level:Benign THEN
  !      Function_Add_Command( 'UsedLineHistory', 'UsedLineHistory')
  !      LOC:Ny_Start_Flag = 1
  !   END
  
  
  
  BRW5.AddToolbarTarget(Toolbar)
  BRW4.AddToolbarTarget(Toolbar)
  BRW2.AddToolbarTarget(Toolbar)
  BRW3.AddToolbarTarget(Toolbar)
  BRW6.AddToolbarTarget(Toolbar)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Barcode.Close
    Relate:DelNode.Close
    Relate:DelNode2.Close
    Relate:IngData.Close
    Relate:Tankdata.Close
    Relate:Used.Close
    Relate:ingredient.Close
    Relate:ingredient2.Close
    Relate:sourcetank.Close
    Relate:weight.Close
  END
  IF SELF.Opened
    INIMgr.Update('Main',Window)
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
    OF ?Button54
      ! Tester proxy'ens 'UsedLineHistory' funksjon.
      
         Function_Add_Command( 'UsedLineHistory', 'UsedLineHistory')
         POST(EVENT:WriteCommand)
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?But_Start_Registering
      ThisWindow.Update
      ! Start registering av levering
      
         DISABLE(?But_Skriv_Barkode)
      
         CLEAR(GLO:ID_DeliveredLine)
         CLEAR(GLO:Ny_Barcode)
      
         CLEAR(LOC:Referanse)
         CLEAR(LOC:Notater)
      
         CLEAR(ingredient)
      
         CLEAR(LOC:ID_Ingrediens)
         CLEAR(LOC:Ingrediens_id)
         CLEAR(LOC:Ingrediens_code)
         CLEAR(LOC:Ingrediens_name)
      
         CLEAR(LOC:Antall_Enheter)
         CLEAR(LOC:Enhets_Vekt)
         CLEAR(LOC:Totalvekt_Levert)
      
         CLEAR(LOC:Antall_Barkodelapper)
      
         ENABLE(?Group_Leverandoer)
         ENABLE(?But_Avbryt_Registering)
         ENABLE(?But_Velg_Ingrediens)
      
         DISABLE(?But_Start_Registering)
         DISABLE(?List_Levert)
      
         LOC:Enhets_Vekt = 0
      
         SELECT(?LOC:Kilde)
      
      ! Kaller opp Unique for nytt nummer til barkode.
      
         Function_Add_Command( 'BarcodeSetNew', 'Unique' )
         POST(EVENT:WriteCommand)
    OF ?But_Avbryt_Registering
      ThisWindow.Update
      ! Avbryter registering av levering
      
         CLEAR(LOC:Referanse)
         CLEAR(LOC:Notater)
      
         CLEAR(ingredient)
      
         CLEAR(LOC:ID_Ingrediens)
         CLEAR(LOC:Ingrediens_id)
         CLEAR(LOC:Ingrediens_code)
         CLEAR(LOC:Ingrediens_name)
      
         CLEAR(LOC:Antall_Enheter)
         CLEAR(LOC:Enhets_Vekt)
         CLEAR(LOC:Totalvekt_Levert)
      
         CLEAR(LOC:Antall_Barkodelapper)
      
         DISABLE(?Button_Lagre_Oppsett)
         DISABLE(?Group_Antall)
         DISABLE(?Group_Ingrediensdata)
         DISABLE(?Group_Leverandoer)
         DISABLE(?But_Velg_Ingrediens)
      
         DISABLE(?But_Avbryt_Registering)
      
         DISABLE(?Button_Ferdig)
      
         ENABLE(?List_Levert)
      
         ENABLE(?But_Start_Registering)
         SELECT(?But_Start_Registering)
      
      
    OF ?But_Nummer_1
      ThisWindow.Update
      ! Setter antall til 1
      
         LOC:Antall_Barkodelapper = 1
      
         FREE(QPrintLabelData)
      
         ING:code = LOC:Ingrediens_code
         IF Access:ingredient.Fetch(ING:K_id) NOT=Level:Benign THEN
            MESSAGE('Feil ved innhenting av data fra lokalt ingrediens register.')
         END
      
         QPL:Text1       = CLIP(LOC:Ingrediens_code) & '-' & CLIP(LOC:Ingrediens_name)
         QPL:Text2       = FORMAT(TODAY(),@d08-B)
         QPL:Text3       = 'Levert ' & LOC:Antall_Enheter & ' sekker A ' & LOC:Enhets_Vekt & ' kg.'
         QPL:Barcode     = CLIP(GLO:Ny_Barcode)
         QPL:BarcodeText = CLIP(GLO:Ny_Barcode)
         QPL:KopiAntall  = LOC:Antall_Barkodelapper
      
         ADD(QPrintLabelData)
      
         Funksjon_LargeLabel()
      
         RUN('rp <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
      
         ENABLE(?Button_Ferdig)
      
    OF ?But_Nummer_5
      ThisWindow.Update
      ! Setter antall til 5
      
         LOC:Antall_Barkodelapper = 5
      
         FREE(QPrintLabelData)
      
         ING:code = LOC:Ingrediens_code
         IF Access:ingredient.Fetch(ING:K_id) NOT=Level:Benign THEN
            MESSAGE('Feil ved innhenting av data fra lokalt ingrediens register.')
         END
      
         QPL:Text1       = CLIP(LOC:Ingrediens_code) & '-' & CLIP(LOC:Ingrediens_name)
         QPL:Text2       = FORMAT(TODAY(),@d08-B)
         QPL:Text3       = 'Levert ' & LOC:Antall_Enheter & ' sekker A ' & LOC:Enhets_Vekt & ' kg.'
         QPL:Barcode     = CLIP(GLO:Ny_Barcode)
         QPL:BarcodeText = CLIP(GLO:Ny_Barcode)
         QPL:KopiAntall  = LOC:Antall_Barkodelapper
      
         ADD(QPrintLabelData)
      
         Funksjon_LargeLabel()
      
         RUN('rp <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
      
         ENABLE(?Button_Ferdig)
      
    OF ?But_Nummer10
      ThisWindow.Update
      ! Setter antall til 10
      
         LOC:Antall_Barkodelapper = 10
      
      
         FREE(QPrintLabelData)
      
         ING:code = LOC:Ingrediens_code
         IF Access:ingredient.Fetch(ING:K_id) NOT=Level:Benign THEN
            MESSAGE('Feil ved innhenting av data fra lokalt ingrediens register.')
         END
      
         QPL:Text1       = CLIP(LOC:Ingrediens_code) & '-' & CLIP(LOC:Ingrediens_name)
         QPL:Text2       = FORMAT(TODAY(),@d08-B)
         QPL:Text3       = 'Levert ' & LOC:Antall_Enheter & ' sekker A ' & LOC:Enhets_Vekt & ' kg.'
         QPL:Barcode     = CLIP(GLO:Ny_Barcode)
         QPL:BarcodeText = CLIP(GLO:Ny_Barcode)
         QPL:KopiAntall  = LOC:Antall_Barkodelapper
      
         ADD(QPrintLabelData)
      
         Funksjon_LargeLabel()
      
         RUN('rp <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
      
         ENABLE(?Button_Ferdig)
      
    OF ?Button_Ferdig
      ThisWindow.Update
      ! Skriver ut barkoder for valgt registrering
      
      !   IF LOC:Antall_Barkodelapper = 0 THEN
      !      LOC:Antall_Barkodelapper = 1
      !   END
      !
      !   FREE(QPrintLabelData)
      !
      !   ING:code = LOC:Ingrediens_code
      !   IF Access:ingredient.Fetch(ING:K_id) NOT=Level:Benign THEN
      !      MESSAGE('Feil ved innhenting av data fra lokalt ingrediens register.')
      !   END
      !
      !   QPL:Text1       = CLIP(ING:code) & '-' & CLIP(ING:name)
      !   QPL:Text2       = FORMAT(TODAY(),@d08-B)
      !   QPL:Text3       = 'Levert ' & LOC:Antall_Enheter & ' sekker A ' & LOC:Enhets_Vekt & ' kg.'
      !   QPL:Barcode     = CLIP(GLO:Ny_Barcode)
      !   QPL:BarcodeText = CLIP(GLO:Ny_Barcode)
      !  QPL:KopiAntall  = LOC:Antall_Barkodelapper
      !
      !   ADD(QPrintLabelData)
      !
      !   Funksjon_LargeLabel()
      
      !   RUN('rp <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
      
      
      !   CASE MESSAGE('Skriv ut label?','Skriv ut label',ICON:Question,'&Labelprinter|Standard|&Avbryt',2,1)
      !
      !   OF 1
      !         MESSAGE('rp.exe <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
      !         RUN('rp <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
      !
      !   OF 2
      !         MESSAGE('rp.exe -d ' & CLIP(FileName))
      !         RUN('rp.exe -d ' & CLIP(FileName),1)
      !
      !   ELSE
      !
      !   END
      
         CLEAR(LOC:Referanse)
         CLEAR(LOC:Notater)
      
         CLEAR(ingredient)
      
         CLEAR(LOC:ID_Ingrediens)
         CLEAR(LOC:Ingrediens_id)
         CLEAR(LOC:Ingrediens_code)
         CLEAR(LOC:Ingrediens_name)
      
         CLEAR(LOC:Antall_Enheter)
         CLEAR(LOC:Enhets_Vekt)
         CLEAR(LOC:Totalvekt_Levert)
      
         CLEAR(LOC:Antall_Barkodelapper)
      
         DISABLE(?Button_Lagre_Oppsett)
         DISABLE(?Group_Antall)
         DISABLE(?Group_Ingrediensdata)
         DISABLE(?Group_Leverandoer)
         DISABLE(?But_Velg_Ingrediens)
      
         DISABLE(?But_Avbryt_Registering)
         DISABLE(?Button_Kanseler)
      
         DISABLE(?Group_Barkoder)
      
         DISABLE(?Button_Ferdig)
      
         ENABLE(?List_Levert)
      
         ENABLE(?But_Start_Registering)
         SELECT(?But_Start_Registering)
      
      
    OF ?But_Skriv_Barkode
      ThisWindow.Update
      ! Setter antall til 1
      
         LOC:Antall_Barkodelapper = 1
      
         FREE(QPrintLabelData)
      
      !   ING:code = LOC:Ingrediens_code
      !   IF Access:ingredient.Fetch(ING:K_id) NOT=Level:Benign THEN
      !      MESSAGE('Feil ved innhenting av data fra lokalt ingrediens register.')
      !   END
      
         QPL:Text1       = CLIP(ING:code) & '-' & CLIP(ING:name)
         QPL:Text2       = FORMAT(DNO:Dato,@d08-B)
         QPL:Text3       = 'Levert ' & CLIP(DNO:Antall) & ' sekker A ' & CLIP(DNO:Enhets_Vekt) & ' kg.'
         QPL:Barcode     = CLIP(DNO:Barkode)
         QPL:BarcodeText = CLIP(DNO:Barkode)
         QPL:KopiAntall  = 1
      
         ADD(QPrintLabelData)
      
         Funksjon_LargeLabel()
      
      !   RUN('rp <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
      
      !   CASE MESSAGE('Skriv ut label?','Skriv ut label',ICON:Question,'&Labelprinter|Standard|&Avbryt',2,1)
      !
      !   OF 1
      !         MESSAGE('rp.exe <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
               RUN('rp <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
      
      !   OF 2
      !         MESSAGE('rp.exe -d ' & CLIP(FileName))
      !         RUN('rp.exe -d ' & CLIP(FileName),1)
      !
      !   ELSE
      !
      !   END
      
         ENABLE(?Button_Ferdig)
      
    OF ?LOC:Antall_Enheter
      ! Summerer
      
         LOC:Totalvekt_Levert = LOC:Antall_Enheter * LOC:Enhets_Vekt
      
         IF LOC:Totalvekt_Levert THEN
            IF LOC:Enhets_Vekt NOT= 0 THEN
               ENABLE(?Button_Lagre_Oppsett)
               SELECT(?Button_Lagre_Oppsett)
            ELSE
               SELECT(?LOC:Enhets_Vekt)
            END
         END
      
         DISPLAY()
      
    OF ?LOC:Enhets_Vekt
      ! Summerer
      
         LOC:Totalvekt_Levert = LOC:Antall_Enheter * LOC:Enhets_Vekt
      
         IF LOC:Enhets_Vekt NOT= 0 THEN
            IF LOC:Antall_Enheter NOT= 0 THEN
               ENABLE(?Button_Lagre_Oppsett)
               SELECT(?Button_Lagre_Oppsett)
            ELSE
               SELECT(?LOC:Antall_Enheter)
            END
         END
      
         DISPLAY()
      
    OF ?Button_Lagre_Oppsett
      ThisWindow.Update
      ! Lager leveranser
      
         DISABLE(?But_Velg_Ingrediens)
         DISABLE(?But_Avbryt_Registering)
      
         DISABLE(?Group_Antall)
      
         ENABLE(?Group_Barkoder)
      
         DISABLE(?Button_Lagre_Oppsett)
      
         ENABLE(?Button_Kanseler)
      
         SELECT(?But_Nummer_1)
      
      !  DeliveredSet <id> <date> <source> <reference> <status> <iId> <barcode> <count> <peritem> <notes>
      
      ! Fullfører registering ved lagring til proxy
      
         LOC:Str_Dato_Tid = CLIP(FORMAT( TODAY(),@d10-)) & ' ' & CLIP(FORMAT( CLOCK(), @T04))
      
         IF LOC:Kilde = '' THEN
            LOC:Kilde = '-'
         END
      
         MESSAGE('GLO:Ny_Barcode = ' & CLIP(GLO:Ny_Barcode))
      
         LOC:Command     = 'DeliveredSetNew'
         LOC:Command_Str = ('DeliveredSet 0'                                  & '; ' & |
                                          CLIP(LOC:Str_Dato_Tid)              & '; ' & |
                                          CLIP(LOC:Kilde)                     & '; ' & |
                                          CLIP(LOC:Referanse)                 & '; ' & |
                                          'Levert'                            & '; ' & |
                                          CLIP(LOC:Delivered_Ingrediens_id)   & '; ' & |
                                          CLIP(GLO:Ny_Barcode)                & '; ' & |
                                          LOC:Antall_Enheter                  & '; ' & |
                                          LOC:Enhets_Vekt                     & '; ' & |
                                          CLIP(LOC:Notater)                   )
      
         Function_Add_Command( LOC:Command, LOC:Command_Str)
      
         POST(EVENT:WriteCommand)
      
      !   MESSAGE( CLIP(LOC:Command)     & '; ' & |
      !            CLIP(LOC:Command_Str) )
      
         DNO:Deleted_Flag     = ''
         DNO:ID_DeliveredNode = ''
         DNO:Dato             = TODAY()
         DNO:Time             = CLOCK()
         DNO:DatoTimeStr      = LOC:Str_Dato_Tid
         DNO:Kilde            = LOC:Kilde
         DNO:Referanse        = LOC:Referanse
         DNO:Status           = 'Levert'
         DNO:ingredient_id    = LOC:Delivered_Ingrediens_id
         DNO:Barkode          = GLO:Ny_Barcode
         DNO:Antall           = LOC:Antall_Enheter
         DNO:Antall_kg        = LOC:Antall_Enheter * LOC:Enhets_Vekt
         DNO:Enhets_Vekt      = LOC:Enhets_Vekt
         DNO:Brukt            = 0
         DNO:Brukt_kg         = 0
         DNO:Lager            = LOC:Antall_Enheter
         DNO:Lager_kg         = LOC:Antall_Enheter * LOC:Enhets_Vekt
         DNO:Notater          = LOC:Notater
      
         IF Access:DelNode.Insert() NOT= Level:Benign THEN
            MESSAGE('Feil ved oppdatering av lokalt delivered register.')
         END
      
         ING:id = LOC:Delivered_Ingrediens_id
      
         IF Access:ingredient.Fetch(ING:K_id) NOT= Level:Benign THEN
            MESSAGE('Feil ved innhenting av data for oppdatering i lokalt ingrediens register.')
         ELSE
            ING:Lager_Sekker       = ING:Lager_Sekker + LOC:Antall_Enheter
            ING:Lager_Kg           = ING:Lager_Kg + (LOC:Antall_Enheter * LOC:Enhets_Vekt)
            ING:Aktive_Leveranser += 1
      
            IF Access:ingredient.Update() NOT= Level:Benign THEN
               MESSAGE('Feil ved lagring av oppdaterte data til lokalt ingredient register.')
            END
      
         END
      
         Self.Reset(1)
      
         ENABLE(?Button_Ferdig)
    OF ?Button_Kanseler
      ThisWindow.Update
      ! Kanselerer siste innlesing ved å 'Slett' den i proxy-register med
      ! DeliveredDelete <id> funksjonen
      
         CASE MESSAGE('Bekreft kansellering.','Bekreft kansellering.',ICON:Question,'&OK|&Avbryt',2,1)
      
         OF 1
            LOC:Command     = 'DeliveredCancel'
            LOC:Command_Str = ('DeliveredCancel ' & LEFT(FORMAT(GLO:ID_DeliveredLine, @N_8B)) )
      
            MESSAGE(LOC:Command & '|' & LOC:Command_Str)
      
            Function_Add_Command(LOC:Command, LOC:Command_Str)
            POST(EVENT:WriteCommand)
      
         OF 2
      
         ELSE
      
         END
      
      
         CLEAR(ingredient)
      
         CLEAR(LOC:ID_Ingrediens)
         CLEAR(LOC:Ingrediens_id)
         CLEAR(LOC:Ingrediens_code)
         CLEAR(LOC:Ingrediens_name)
      
         CLEAR(LOC:Antall_Enheter)
         CLEAR(LOC:Enhets_Vekt)
      
         CLEAR(LOC:Antall_Barkodelapper)
      
         DISABLE(?Button_Lagre_Oppsett)
         DISABLE(?Group_Antall)
         DISABLE(?Group_Ingrediensdata)
         DISABLE(?Group_Leverandoer)
         DISABLE(?But_Velg_Ingrediens)
      
         DISABLE(?But_Avbryt_Registering)
         DISABLE(?Button_Kanseler)
      
         DISABLE(?Group_Barkoder)
      
         ENABLE(?List_Levert)
      
         ENABLE(?But_Start_Registering)
         SELECT(?But_Start_Registering)
    OF ?But_Velg_Ingrediens
      ThisWindow.Update
      ! Kaller opp vindu for valg av Ingrediens
      
         LOC:ID_Ingrediens = Velg_Ingrediens()
      
         IF LOC:ID_Ingrediens THEN
      
            ING:ID_ingredient = LOC:ID_Ingrediens
            IF Access:ingredient.Fetch(ING:K_ID_ingredient) NOT= Level:Benign THEN
      !         MESSAGE('Feil ved innhenting av data fra lokal ingredient register.')
            ELSE
               LOC:ID_Ingrediens             = ING:ID_ingredient
               LOC:Delivered_Ingrediens_id   = ING:id
               LOC:Ingrediens_code           = ING:code
               LOC:Ingrediens_name           = ING:name
      
               UNHIDE(?Group_Ingrediensdata)
               UNHIDE(?Group_Antall)
      
               DISABLE(?Group_Leverandoer)
      
               ENABLE(?Group_Antall)
      
               SELECT(?LOC:Antall_Enheter)
      
               DISPLAY()
            END
         END
    OF ?But_Nummer20
      ThisWindow.Update
      ! Setter antall til 20
      
         LOC:Antall_Barkodelapper = 20
      
    OF ?But_Pluss_1
      ThisWindow.Update
      ! Plusser på antall med 1
      
         LOC:Antall_Barkodelapper += 1
      
    OF ?But_Pluss_5
      ThisWindow.Update
      ! Plusser på antall med 5
      
         LOC:Antall_Barkodelapper += 5
      
    OF ?Button26
      ThisWindow.Update
      ! Kaller opp rutine for oppdatering av ingredients mengde på tanken.
      
         LOC:Str_ID_sourcetank = SOU:ID_sourcetank
         LOC:Str_ID_TankData   = TAN:ID_Tankdata
      
         RES# = Oppdater_TankData( LOC:Str_ID_sourcetank, LOC:Str_ID_TankData )
      
         IF RES# = 1 THEN
         
            Self.Reset(1)
      
            Function_Add_Command( 'RefillCheck', 'RefillCheck' )
      
            POST(EVENT:WriteCommand)
         END
      
         SELECT(?List_Tank)
    OF ?Button38
      ThisWindow.Update
      ! Skriver ut barkode for tank
      
         FREE(QPrintLabelData)
      
         QPL:Text1       = 'TANK:  ' & CLIP(SOU:tanknummer)
         QPL:Text2       = ''
         QPL:Text3       = ''
         QPL:Barcode     = CLIP(TAN:barcode)
         QPL:BarcodeText = CLIP(TAN:barcode)
         QPL:KopiAntall  = 2
      
         ADD(QPrintLabelData)
      
         Funksjon_LargeLabel()
      
      !   RUN('rp <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
      
      
         CASE MESSAGE('Skriv ut label?','Skriv ut label',ICON:Question,'&Labelprinter|Standard|&Avbryt',2,1)
      
         OF 1
      !         MESSAGE('rp.exe <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
               RUN('rp <34>Datamax M-4206 Mark II<34> ' & CLIP(FileName))
      
         OF 2
      !         MESSAGE('rp.exe -d ' & CLIP(FileName))
               RUN('rp.exe -d ' & CLIP(FileName),1)
      
         ELSE
      
         END
    OF ?Button55
      ThisWindow.Update
      ! Kaller opp rutine for oppdatering av ingredients mengde på tanken.
      
         LOC:Str_ID_sourcetank = SOU:ID_sourcetank
         LOC:Str_ID_TankData   = TAN:ID_Tankdata
      
         RES# = Oppdater_sourcetank_Mengde( LOC:Str_ID_sourcetank, LOC:Str_ID_TankData )
      
         IF RES# = 1 THEN
         
            Self.Reset(1)
      
            POST(EVENT:WriteCommand)
         END
      
         SELECT(?List_Tank)
    OF ?Button56
      ThisWindow.Update
      ! Kaller opp rutine for korrigering av antall og brukt.
      
         LOC:Str_ID_DelNode = DN2:ID_DelNode
      
         RES# = Oppdater_Delivered_Antall( LOC:Str_ID_DelNode )
      
         IF RES# = 1 THEN
      
            Self.Reset(1)
      
            POST(EVENT:WriteCommand)
         END
    OF ?But_Oppdater_IngData_Notes
      ThisWindow.Update
      ! Kaller opp rutine for oppdatering av IngData mengde verdier (=min,max,volume)
      
         LOC:Str_ID_Ingredients = IN2:ID_ingredient
         LOC:Str_ID_IngData     = IND:ID_IngData
      
         RES# = Oppdater_IngData_Notes( LOC:Str_ID_Ingredients, LOC:Str_ID_IngData )
      
         IF RES# = 1 THEN
            POST(EVENT:WriteCommand)
            Self.Reset(1)
         END
      
         SELECT(?List_ingredients)
      
      
    OF ?But_Nullstill
      ThisWindow.Update
      ! Reseter antall til 0
      
         LOC:Antall_Sekker = 0
         CLEAR(LOC:Totalvekt_Paafylling)
      
         DISABLE(?But_Kvitter)
      
         DISPLAY()
      
         SELECT(?LOC:Lest_Barcode)
    OF ?But_Pluss_En
      ThisWindow.Update
      ! +1 i antall sekker
      
         LOC:Antall_Sekker += 1
      
         LOC:Totalvekt_Paafylling = LOC:Antall_Sekker * GLO:Valgt_Delivered_perItem
      
         ENABLE(?But_Kvitter)
      
         DISPLAY()
      
         SELECT(?LOC:Lest_Barcode)
    OF ?But_Pluss_Fem
      ThisWindow.Update
      ! +5 i antall sekker
      
         LOC:Antall_Sekker += 5
         LOC:Totalvekt_Paafylling = LOC:Antall_Sekker * GLO:Valgt_Delivered_perItem
      
         ENABLE(?But_Kvitter)
      
         DISPLAY()
      
         SELECT(?LOC:Lest_Barcode)
    OF ?But_Pluss_Ti
      ThisWindow.Update
      ! +10 i antall sekker
      
         LOC:Antall_Sekker += 10
         LOC:Totalvekt_Paafylling = LOC:Antall_Sekker * GLO:Valgt_Delivered_perItem
      
         ENABLE(?But_Kvitter)
      
         DISPLAY()
      
         SELECT(?LOC:Lest_Barcode)
    OF ?But_Pluss_Femti
      ThisWindow.Update
      ! +50 i antall sekker
      
         LOC:Antall_Sekker += 50
      
         ENABLE(?But_Kvitter)
      
         DISPLAY(?LOC:Antall_Sekker)
      
         SELECT(?LOC:Lest_Barcode)
    OF ?Button32
      ThisWindow.Update
      ! Spør proxy etter data for lest barcode
      
         CLEAR(LOC:Paafyll_Fullfoert_Melding)
      
         IF LOC:Lest_Barcode = '' THEN
            MESSAGE('Les inn barkode først.')
         ELSE
      
            LOC:Lest_Barcode = LEFT(LOC:Lest_Barcode)
      
            IF LOC:Lest_Barcode[1:4] = 'Tank' THEN
      
               TAN:barcode = LOC:Lest_Barcode
      
               IF Access:TankData.Fetch(TAN:K_barcode) = Level:Benign THEN
      
                  SOU:tanknummer = TAN:id_tank
      
                  IF Access:sourcetank.Fetch(SOU:K_tanknummer) NOT= Level:Benign THEN
                     MESSAGE('Feil ved oppslag mot lokale tankdata.')
                  ELSE
                     LOC:Melding_Tank = ''
      
                     LOC:Valgt_Tank                 = TAN:id_tank
                     LOC:Valgt_Tank_Barkode         = TAN:barcode
                     LOC:Valgt_Tank_ingredient_ID   = SOU:id
                     LOC:Valgt_Tank_ingredient_Name = SOU:name
                     LOC:Valgt_Tank_ingredient_Info = CLIP(SOU:code) & ': ' & CLIP(SOU:name)

                     LOC:warning_Paafyll = TAN:warning
                     LOC:alarm_Paafyll   = TAN:alarm
                     LOC:maximum_Paafyll = TAN:maximum
                     LOC:volume_Paafyll  = TAN:volume
                     LOC:notes_Paafyll   = TAN:notes

!                     IF GLO:Valgt_Ingredient_ID NOT= '' THEN
                        POST(EVENT:CheckRefillCodes)
!                     END
                  END
               END
            ELSE
               GLO:Valgt_Levering_Barcode = LOC:Lest_Barcode
      
               LOC:Command     = 'BarcodeReadCode'
               LOC:Command_Str = 'DeliveredByBarcode ' & LEFT(CLIP(LOC:Lest_Barcode))
               Function_Add_Command( LOC:Command, LOC:Command_Str)
               POST(EVENT:WriteCommand)
            END
         END
      
         SELECT(?LOC:Lest_Barcode)
      
      
    OF ?But_Merknad
      ThisWindow.Update
      ! Kaller opp vindu for innlesing av merknad for forbruk
      
         LOC:Buffer_Tekst = Registrer_Merknad_usedline(LOC:Paafyll_Used_Notes)
      
         CASE LOC:Buffer_Tekst
      
         OF ''
      
         OF 'none'
            LOC:Paafyll_Used_Notes = ''
      
         ELSE
            LOC:Paafyll_Used_Notes = LOC:Buffer_Tekst
      
         END
      
         DISPLAY()
      
         SELECT(?LOC:Lest_Barcode)
    OF ?Button44
      ThisWindow.Update
      ! Test av farvebytting
      
         ?Panel_Farge{PROP:Fill} = 000FF00H
         DISPLAY(?Panel_Farge)
      
         SELECT(?LOC:Lest_Barcode)
    OF ?Button45
      ThisWindow.Update
      ! Test av farvebytting
      
         ?Panel_Farge{PROP:Fill} = 00000FFH
         DISPLAY(?Panel_Farge)
      
         SELECT(?LOC:Lest_Barcode)
    OF ?Button_Avbryt_Paafylling
      ThisWindow.Update
      ! Nullstiller verdier som er brukt og setter standard bakgrunnsfarve.
      
         ?Panel_Farge{PROP:Fill} = 0C8D0D4H
      
         CLEAR(LOC:Paafyll_Used_Notes)
      
         CLEAR(LOC:Lest_Barcode)
      
         CLEAR(LOC:Valgt_Tank_ingredient_Info)
         CLEAR(LOC:Valgt_Ingredient_Info)
      
         CLEAR(LOC:Valgt_Tank)
         CLEAR(LOC:Valgt_Tank_Barkode)
         CLEAR(LOC:Valgt_Tank_ingredient_ID)
         CLEAR(LOC:Valgt_Tank_ingredient_Name)
         
         CLEAR(LOC:warning_Paafyll)
         CLEAR(LOC:alarm_Paafyll)
         CLEAR(LOC:maximum_Paafyll)
         CLEAR(LOC:volume_Paafyll)
         CLEAR(LOC:notes_Paafyll)
      
         CLEAR(GLO:Valgt_Ingredient_ID)
         CLEAR(GLO:Valgt_Levering_Barcode)
         CLEAR(GLO:Valgt_Ingredient_Navn)
      
         CLEAR(GLO:Valgt_Delivered_ID)
      
         CLEAR(LOC:Antall_Sekker)
         CLEAR(LOC:Totalvekt_Paafylling)
      
         CLEAR(LOC:Valgt_DelNode_Dato)
         CLEAR(LOC:Valgt_DelNode_Antall)
         CLEAR(LOC:Valgt_DelNode_Brukt)
         CLEAR(LOC:Valgt_DelNode_Lager)
      
         DISABLE(?But_Kvitter)
         DISABLE(?Group_Pafyllings:Antall)
      
         LOC:Paafyll_Fullfoert_Melding =  'Påfylling av tank ble avbrutt.'
      
         LOC:Melding_Tank       = 'Registrer barcode for tank'
         LOC:Melding_Ingrediens = 'Registrer barcode for ingrediens'
         LOC:Melding_Paafylling = ''
      
         Function_Add_Command( 'LampOn', 'Lamp ' & CLIP(GETINI('Oppsett','Vekt','Micro','Lager.INI')) & ' Red 0' )
         Function_Add_Command( 'LampOn', 'Lamp ' & CLIP(GETINI('Oppsett','Vekt','Micro','Lager.INI')) & ' Green 0' )
         POST(EVENT:WriteCommand)
      
         DISPLAY()
      
         SELECT(?LOC:Lest_Barcode)
      
    OF ?But_Kvitter
      ThisWindow.Update
      ! Utfører kvittering av oppsett for påfylling. Følgene funksjoner blir utført:
!
! -  Oppdatering av vekt i tank         :   TankAdd <tank> <val>
!
! -  Oppdatering av lagerantall         :   UsedLine <dline_id> <used> <notes>
!
! -  Påfylling blir skrevet til Logg    :   LogWrite <logtype> <message>         - Logtype = Refill
!
! I tillegg så blir signal-panel satt til default farve og felter som inneholder
! data knyttet til Ingredient og sourcetank blir nullstilt slik at vinduet er klar
! for neste innlesing.

! Oppdater verdi for bruk direkte til lokalt register.

   DNO:ID_DeliveredNode = GLO:Valgt_Delivered_ID
   IF Access:DelNode.Fetch(DNO:K_ID_DeliveredNode) = Level:Benign THEN

      BRUKT# = DEFORMAT(DNO:Brukt)
      LAGER# = DEFORMAT(DNO:Lager)
      ENHET# = DEFORMAT(DNO:Enhets_Vekt)

      BRUKT# = BRUKT# + LOC:Antall_Sekker
      LAGER# = LAGER# - LOC:Antall_Sekker

      DNO:Brukt    = FORMAT(BRUKT#,@N_8)
      DNO:Brukt_kg = BRUKT# * ENHET#
      DNO:Lager    = FORMAT(LAGER#,@N_8)
      DNO:Lager_kg = LAGER# * ENHET#

      IF Access:DelNode.Update() NOT= Level:Benign THEN
         MESSAGE('Feil ved oppdateringa av lokal leveringsregister.')
      END
   END

! Oppdaterer mengde som er på tanken

   LOC:Command     = 'TankAdd'
   LOC:Command_Str = ('TankAdd ' & CLIP(LOC:Valgt_Tank) & ' ' & LEFT(FORMAT(LOC:Totalvekt_Paafylling,@N-_8)) )
   Function_Add_Command( LOC:Command, LOC:Command_Str)

! Lagrer innformasjon om påfyllingeb

   IF LOC:Paafyll_Used_Notes = '' THEN
      LOC:Paafyll_Used_Notes = 'none'
   END

   LOC:Command     = 'UsedLine'
   LOC:Command_Str = ('UsedLine ' & CLIP(GLO:Valgt_Delivered_ID)          & '; ' & |
                                    LEFT(FORMAT(LOC:Antall_Sekker,@N-_8)) & '; ' & |
                                    CLIP(LOC:Paafyll_Used_Notes) )
   Function_Add_Command( LOC:Command, LOC:Command_Str)

! Skriver linje i logg med info om hva som er gjort.

   LOC:Command     = 'LogWrite'
   LOC:Command_Str = ('LogWrite ' & 'Refill; ' & 'Påfyll av tank '                                   & |
                                                  CLIP(LOC:Valgt_Tank) & ' med '                     & |
                                                  LOC:Antall_Sekker & ' sekker '                     & |
                                                  CLIP(GLO:Valgt_Ingredient_Navn) & ' fra levering ' & |
                                                  CLIP(GLO:Valgt_Delivered_ID) )
   Function_Add_Command( LOC:Command, LOC:Command_Str)

! Henter oppdatert liste for varsel etter at påfylling er registrert

   Function_Add_Command( 'RefillCheck', 'RefillCheck' )

! Oppdatert lise for tankdata

   GLO:Save_Mode = 'Update'
   Function_Add_Command( 'Tank', 'Tank')

! Sørger for å skru av lamper

   Function_Add_Command( 'LampOn', 'Lamp ' & CLIP(GETINI('Oppsett','Vekt','Micro','Lager.INI')) & ' Red 0' )
   Function_Add_Command( 'LampOn', 'Lamp ' & CLIP(GETINI('Oppsett','Vekt','Micro','Lager.INI')) & ' Green 0' )

! Sørger for at oppdater 'log' hentes inn for forbruk

!      Function_Add_Command( 'UsedLineHistory', 'UsedLineHistory' & ' ' & CLIP(GLO:Valgt_Delivered_ID))

! Starter kjøring av oppsatte kommandoer

   POST(EVENT:WriteCommand)

! Skriver ut melding til skjerm som bekrefter utført operasjon

   LOC:Paafyll_Fullfoert_Melding =  'Påfyll av tank '                       & |
                                     CLIP(LOC:Valgt_Tank) & ' med '         & |
                                     LOC:Antall_Sekker & ' sekker av '      & |
                                     CLIP(GLO:Valgt_Ingredient_ID) & ': '   & |
                                     CLIP(GLO:Valgt_Ingredient_Navn)

! Nullstiller verdier som er brukt og setter standard bakgrunnsfarve.

   ?Panel_Farge{PROP:Fill} = 0C8D0D4H

   CLEAR(LOC:Paafyll_Used_Notes)

   CLEAR(LOC:Lest_Barcode)

   CLEAR(LOC:Valgt_Tank_ingredient_Info)
   CLEAR(LOC:Valgt_Ingredient_Info)

   CLEAR(LOC:Valgt_Tank)
   CLEAR(LOC:Valgt_Tank_Barkode)
   CLEAR(LOC:Valgt_Tank_ingredient_ID)
   CLEAR(LOC:Valgt_Tank_ingredient_Name)

   CLEAR(LOC:warning_Paafyll)
   CLEAR(LOC:alarm_Paafyll)
   CLEAR(LOC:maximum_Paafyll)
   CLEAR(LOC:volume_Paafyll)
   CLEAR(LOC:notes_Paafyll)

   CLEAR(GLO:Valgt_Ingredient_ID)
   CLEAR(GLO:Valgt_Levering_Barcode)
   CLEAR(GLO:Valgt_Ingredient_Navn)

   CLEAR(GLO:Valgt_Delivered_ID)

   CLEAR(LOC:Antall_Sekker)
   CLEAR(LOC:Totalvekt_Paafylling)

   CLEAR(LOC:Valgt_DelNode_Dato)
   CLEAR(LOC:Valgt_DelNode_Antall)
   CLEAR(LOC:Valgt_DelNode_Brukt)
   CLEAR(LOC:Valgt_DelNode_Lager)

   DISABLE(?But_Kvitter)
   DISABLE(?Group_Pafyllings:Antall)

   LOC:Melding_Tank       = 'Registrer barcode for tank'
   LOC:Melding_Ingrediens = 'Registrer barcode for ingrediens'
   LOC:Melding_Paafylling = ''

   DISPLAY()

   SELECT(?LOC:Lest_Barcode)

    OF ?But_RefillCheck
      ThisWindow.Update
      ! Tester proxy'ens RefillCheck
      
         Function_Add_Command( 'RefillCheck', 'RefillCheck' )
         POST(EVENT:WriteCommand)
    OF ?But_Status
      ThisWindow.Update
      ! Tester proxy'ens 'Status' funksjon.
      
         Function_Add_Command( 'Status', 'Status' )
         POST(EVENT:WriteCommand)
    OF ?But_Lamp_Red_On
      ThisWindow.Update
      ! Tester proxy'ens 'Tank' funksjon.
      
         Function_Add_Command( 'LampOn', 'Lamp ' & CLIP(GETINI('Oppsett','Vekt','Micro','Lager.INI')) & ' Red 1' )
         POST(EVENT:WriteCommand)
    OF ?But_Lamp_Red_Off
      ThisWindow.Update
      ! Tester proxy'ens 'LampOff' funksjon.
      
         Function_Add_Command( 'LampOn', 'Lamp ' & CLIP(GETINI('Oppsett','Vekt','Micro','Lager.INI')) & ' Red 0' )
         POST(EVENT:WriteCommand)
    OF ?But_Lamp_Green_On
      ThisWindow.Update
      ! Tester proxy'ens 'Tank' funksjon.
      
         Function_Add_Command( 'LampOn', 'Lamp ' & CLIP(GETINI('Oppsett','Vekt','Micro','Lager.INI')) & ' Green 1' )
         POST(EVENT:WriteCommand)
    OF ?But_Lamp_Green_Off
      ThisWindow.Update
      ! Tester proxy'ens 'Tank' funksjon.
      
         Function_Add_Command( 'LampOn', 'Lamp ' & CLIP(GETINI('Oppsett','Vekt','Micro','Lager.INI')) & ' Green 0' )
         POST(EVENT:WriteCommand)
    OF ?Button22
      ThisWindow.Update
      ! Test av liste for Log registeringer.
      
         Function_Add_Command( 'LogOpen', 'Log -1 -20' )
         POST(EVENT:WriteCommand)
    OF ?Button29
      ThisWindow.Update
      ! Starter test av labelprinter
      
         Test_LabelPrinter()
      
    OF ?Button34
      ThisWindow.Update
      ! Kaller opp rutine for utskrift av multitekstlinje label.
      
         CLEAR(QPrintLabelData)
      
         QPL:Text1       = 'Linje1-12345678901234567890'
         QPL:Text2       = 'Linje2-12345678901234567890'
         QPL:Text3       = 'Linje3-12345678901234567890'
         QPL:Barcode     = '200'
         QPL:BarcodeText = '200'
         QPL:KopiAntall  =  2
      
         ADD(QPrintLabelData)
      
         QPL:Text1       = 'Test1-12345678901234567890'
         QPL:Text2       = 'Test2-12345678901234567890'
         QPL:Text3       = 'Test3-12345678901234567890'
         QPL:Barcode     = '300'
         QPL:BarcodeText = '300'
         QPL:KopiAntall  =  3
      
         ADD(QPrintLabelData)
      
         Funksjon_LargeLabel()
      
    OF ?But_ListIngredients
      ThisWindow.Update
      ! Tester proxy'ens 'ListIngredients' funksjon.
      
         Function_Add_Command( 'ListIngredients', 'ListIngredients' )
         POST(EVENT:WriteCommand)
    OF ?But_DeliveredRead
      ThisWindow.Update
      ! Tester proxy'ens 'DeliveredRead' funksjon.
      
         Function_Add_Command( 'DeliveredRead', 'DeliveredRead 1 -1 0')
         POST(EVENT:WriteCommand)
    OF ?But_Unique
      ThisWindow.Update
      ! Tester proxy'ens 'Unique' funksjon.
      
         Function_Add_Command( 'Unique', 'Unique' )
         POST(EVENT:WriteCommand)
    OF ?ButtonConnect
      ThisWindow.Update
      IF ?ButtonConnect{PROP:Text} = 'Connect'       !If not connected,
        ?OCX{'HostAddress'} = CLIP(L:BIPAddr)        !  Set IP address of remote host to talk to
        ?OCX{'RemotePort'}  = CLIP(LOC:Port_Number)  !  Connect to a listening port of remote host
        ?OCX{'Action'}      = SOCKET_CONNECT         !  Try the connection
        L:Status = 'Attempting to Connect...'
      ELSE                                           !If already connected,
        ?OCX{'Action'} = SOCKET_CLOSE                !  Close the socket connection
        ?ButtonConnect{PROP:Text} = 'Connect'        !  Change button text back to 'Connect' from 'Disconnect'
        L:Status = 'Disconnected'                    !  Update display var
        ENABLE(?L:BIPAddr)                           !  Allow entry into IP Address field again
      END
      
      DISPLAY
    OF ?Button11
      ThisWindow.Update
      ! Tester proxy'ens 'IngDataRead' funksjon.
      
         Function_Add_Command( 'IngDataRead', 'IngDataRead 1 -1' )
         POST(EVENT:WriteCommand)
    OF ?But_DeliveredLinesRead
      ThisWindow.Update
      ! Tester proxy'ens 'DeliveredLinesRead' funksjon.
      
         Function_Add_Command( 'DeliveredLinesRead', 'DeliveredLinesRead 1 -1 -1 0')
         POST(EVENT:WriteCommand)
    OF ?But_ListWeights
      ThisWindow.Update
      ! Tester proxy'ens 'ListWeights' funksjon.
      
         Function_Add_Command( 'ListWeights', 'ListWeights')
         POST(EVENT:WriteCommand)
    OF ?But_BarcodeRead
      ThisWindow.Update
      ! Tester proxy'ens 'BarcodeRead' funksjon.
      
         Function_Add_Command( 'BarcodeRead', 'BarcodeRead' )
         POST(EVENT:WriteCommand)
    OF ?But_Tank
      ThisWindow.Update
      ! Tester proxy'ens 'Tank' funksjon.
      
         Function_Add_Command( 'Tank', 'Tank')
         POST(EVENT:WriteCommand)
    OF ?Button2
      ThisWindow.Update
      ! Sender hvilken som helst kommando til proxy.
      
         L:SendData = L:Command & CLIP(L:EntryText)  !Concatenate command & data into one string
         L:SendData[199:200] = '<13,10>'             !Terminate the string with CR/LF
         ?OCX{'SendLen'} = 200                       !Set max number of bytes to write to socket
         ?OCX{'SendData'} = L:SendData               !Send command/data to remote host
         L:Status = 'Sending Request'                !Update display var
    OF ?Button3
      ThisWindow.Update
      ! Kaller opp vindu som viser formatert liste fra siste proxy-kommando Read
      
         START(Display_ReadList, 50000, LOC:List, LOC:ListOrg)
      
    OF ?But_TankDataRead
      ThisWindow.Update
      ! Tester proxy'ens 'TankDataRead' funksjon.
      
         Function_Add_Command( 'TankDataRead', 'TankDataRead 1 -1' )
         POST(EVENT:WriteCommand)
    OF ?Button52
      ThisWindow.Update
      ! Setter standard verdier i Lager.INI
                                             
          PUTINI('Oppsett','IP'            ,'79.161.10.133','Lager.INI')        !Place setting in    lager.INI
          PUTINI('Oppsett','Port'          ,'30125'       ,'Lager.INI')         !Place setting in    lager.INI
          PUTINI('Oppsett','Leveranse'     ,'1'           ,'Lager.INI')         !Place setting in    lager.INI
          PUTINI('Oppsett','Paafylling'    ,'1'           ,'Lager.INI')         !Place setting in    lager.INI
          PUTINI('Oppsett','Administrasjon','1'           ,'Lager.INI')         !Place setting in    lager.INI
          PUTINI('Oppsett','System'        ,'1'           ,'Lager.INI')         !Place setting in    lager.INI
          PUTINI('Oppsett','Test'          ,'1'           ,'Lager.INI')         !Place setting in    lager.INI
          PUTINI('Oppsett','Vekt'          ,'Micro'       ,'Lager.INI')         !Place setting in    lager.INI
          PUTINI('Oppsett','Alarmperiode'  ,'30'          ,'Lager.INI')         !Place setting in    lager.INI
    OF ?Button50
      ThisWindow.Update
      ! Kaller opp funksjoner for refresh av lokale dataregister
      
         GLO:Save_Mode = 'Update'
      
         Function_Add_Command( 'ListIngredients', 'ListIngredients' )
         Function_Add_Command( 'IngDataRead', 'IngDataRead 1 -1' )
         Function_Add_Command( 'Tank', 'Tank')
         Function_Add_Command( 'TankDataRead', 'TankDataRead 1 -1' )
         Function_Add_Command( 'DeliveredRead', 'DeliveredRead 1 -1 0')
         Function_Add_Command( 'BarcodeRead', 'BarcodeRead' )
      
         Function_Add_Command( 'RefillCheck', 'RefillCheck' )
      
      !   Function_Add_Command( 'UsedLineHistory', 'UsedLineHistory')
      
         POST(EVENT:WriteCommand)
      
         LOC:Info_Str = 'Lokale register er oppdatert.'
         DISPLAY(?LOC:Info_Str)
      
         Self.Reset(1)
      
    OF ?Button47
      ThisWindow.Update
      ! Spør proxy etter data for lest barcode
      
         CASE CHOICE(?Sheet1)
      
         OF 3
             CLEAR(LOC:Paafyll_Fullfoert_Melding)
      
             IF LOC:Lest_Barcode = '' THEN
                MESSAGE('Les inn barkode først.')
             ELSE
      
                LOC:Lest_Barcode = LEFT(LOC:Lest_Barcode)
      
                IF LOC:Lest_Barcode[1:4] = 'Tank' THEN
      
                   TAN:barcode = LOC:Lest_Barcode
      
                   IF Access:TankData.Fetch(TAN:K_barcode) = Level:Benign THEN
      
                      SOU:tanknummer = TAN:id_tank
      
                      IF Access:sourcetank.Fetch(SOU:K_tanknummer) NOT= Level:Benign THEN
                         MESSAGE('Feil ved oppslag mot lokale tankdata.')
                      ELSE
                         LOC:Melding_Tank = ''
      
                         LOC:Valgt_Tank                 = TAN:id_tank
                         LOC:Valgt_Tank_Barkode         = TAN:barcode
                         LOC:Valgt_Tank_ingredient_ID   = SOU:id
                         LOC:Valgt_Tank_ingredient_Name = SOU:name
                         LOC:Valgt_Tank_ingredient_Info = CLIP(SOU:code) & ': ' & CLIP(SOU:name)
      
                         LOC:warning_Paafyll = TAN:warning
                         LOC:alarm_Paafyll   = TAN:alarm
                         LOC:maximum_Paafyll = TAN:maximum
                         LOC:volume_Paafyll  = TAN:volume
                         LOC:notes_Paafyll   = TAN:notes
      
      !                     IF GLO:Valgt_Ingredient_ID NOT= '' THEN
                              POST(EVENT:CheckRefillCodes)
      !                     END
                      END
                   END
                ELSE
                   GLO:Valgt_Levering_Barcode = LOC:Lest_Barcode
      
      
                   LOC:Command     = 'BarcodeReadCode'
                   LOC:Command_Str = 'DeliveredByBarcode ' & LEFT(CLIP(LOC:Lest_Barcode))
                   Function_Add_Command( LOC:Command, LOC:Command_Str)
                   POST(EVENT:WriteCommand)
      
                END
             END
      
             SELECT(?LOC:Lest_Barcode)
      
         ELSE
      
      
         END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  !Here is the mechanism that processes the OCX events that SocketWrench provides.
  !You don't have direct access to them since they are in the callback procedure, so
  !I post an event for each one back to here so that you can respond to each individual
  !event if you want to.  I defined the events in the SWRENCH.INC file to correspond
  !with the SocketWrench Control events in the callback procedure.

  CASE EVENT()

   OF EVENT:WriteCommand

   IF GLO:ActiveCommand NOT= '' THEN
!      MESSAGE('GLO:ActiveCommand NOT=')
   ELSE
      GET(QCommandStack,1)
      E# = ERRORCODE()
      IF E# THEN
         IF E# NOT= 30 THEN
            MESSAGE('QUEUE error: ' & ERROR() )
         END
      ELSE
!         MESSAGE('Command: ' & QCS:Command & '|CommandStr: ' & QCS:CommandStr )

         FREE(QDataLines)         ! Delete work queue
         LOC:List    = ''         ! Clear formatet display data
         LOC:ListOrg = ''         ! Clear raw data storage

         GLO:ActiveCommand = QCS:Command

         L:SendData = CLIP(QCS:CommandStr)           !Concatenate command & data in one string
         L:SendData[199:200] = '<13,10>'             !Terminate the string with CR/LF
         ?OCX{'SendLen'} = 200                       !Set max number of bytes to write to socket
         ?OCX{'SendData'} = L:SendData               !Send command/data to remote host
         L:Status = 'Sending Request'                !Update display var

         DELETE(QCommandStack)
         IF ERRORCODE() THEN
            MESSAGE('Feil ved sletting fra kommand-stack|Error: ' & ERROR() )

            FREE(QCommandStack)
            IF ERRORCODE() THEN
               HALT(1,'Command stack error')
            END
         END
      END
   END

  OF EVENT:CheckRefillCodes

     ING:id = GLO:Valgt_Ingredient_ID

     IF GLO:Valgt_Levering_Barcode NOT= '' THEN

        DNO:Barkode = GLO:Valgt_Levering_Barcode

        IF Access:DelNode.Fetch(DNO:K_Barkode) NOT= Level:Benign THEN
!           MESSAGE('Feil ved innhenting data fra lokalt leverings register.')
           CLEAR(LOC:Valgt_DelNode_Dato)
           CLEAR(LOC:Valgt_DelNode_Antall)
           CLEAR(LOC:Valgt_DelNode_Brukt)
           CLEAR(LOC:Valgt_DelNode_Lager)
           CLEAR(GLO:Valgt_Levering_Barcode)
        ELSE
           LOC:Valgt_DelNode_Dato   = DNO:Dato
           LOC:Valgt_DelNode_Antall = DNO:Antall
           LOC:Valgt_DelNode_Brukt  = DNO:Brukt
           LOC:Valgt_DelNode_Lager  = CLIP(LEFT(DNO:Lager)) & '  (' & CLIP(LEFT(FORMAT(DNO:Lager_kg,@N_8B))) & ' kg)'
        END
     END

     IF Access:ingredient.Fetch(ING:K_id) = Level:Benign THEN
        LOC:Melding_Ingrediens = ''

        LOC:Valgt_Ingredient_Info = CLIP(ING:code_name_str)
     ELSE
!        MESSAGE('Lesefeil fra lokalt ingredient register.')
     END

     IF ING:id = LOC:Valgt_Tank_ingredient_ID THEN
        LOC:Melding_Paafylling = 'OK påfylling'

        ?Panel_Farge{PROP:Fill} = 000FF00H                            !Green
        ENABLE(?Group_Pafyllings:Antall)

        IF LOC:Antall_Sekker NOT= 0 THEN
            ENABLE(?But_Kvitter)
        END

        Function_Add_Command( 'LampOn', 'Lamp ' & CLIP(GETINI('Oppsett','Vekt','Micro','Lager.INI')) & ' Green 1' )
        Function_Add_Command( 'LampOn', 'Lamp ' & CLIP(GETINI('Oppsett','Vekt','Micro','Lager.INI')) & ' Red 0' )
        POST(EVENT:WriteCommand)
     ELSE
        LOC:Melding_Paafylling = 'Feil tank eller ingrediens'
        ?Panel_Farge{PROP:Fill} = 00000FFH                            !Red
         DISABLE(?Group_Pafyllings:Antall)
         DISABLE(?But_Kvitter)

         Function_Add_Command( 'LampOn', 'Lamp ' & CLIP(GETINI('Oppsett','Vekt','Micro','Lager.INI')) & ' Red 1' )
         Function_Add_Command( 'LampOn', 'Lamp ' & CLIP(GETINI('Oppsett','Vekt','Micro','Lager.INI')) & ' Green 0' )
         POST(EVENT:WriteCommand)
     END

     GLO:Valgt_Ingredient_Navn    = ING:name
     LOC:Valgt_Ingredient_perItem = DEFORMAT(GLO:Valgt_Delivered_perItem)

     DISPLAY()


  OF EVENT:SelfReset
     Self.Reset(1)

  OF EVENT:SWAccept
    L:LastEvent = 'Accept'
  
  OF EVENT:SWBlocking
    L:LastEvent = 'Blocking'
  
  OF EVENT:SWCancel
    L:LastEvent = 'Cancel'
  
  OF EVENT:SWConnect                            !A connection has been established
    L:LastEvent = 'Connect'                     !
    IF ?OCX{'Connected'} = -1                   !Check property and update display var
      L:Status = 'Connected'
      LOC:Connect_Status = L:Status
      ?ButtonConnect{PROP:Text} = 'Disconnect'  !Change 'Connect' buttton to 'Disconnect'
      DISABLE(?L:BIPAddr)                       !Disable IP Address entry field
      GLO:ActiveCommand = ''
  ELSE
      L:Status = 'No Connection'                !Otherwise, no connection was made
      LOC:Connect_Status = L:Status
      ENABLE(?L:BIPAddr)                        !Enable IP Address field for another entry
      ?ButtonConnect{PROP:Text} = 'Connect'     !Change 'Disconnect' back to 'Connect'
    END
  
  OF EVENT:SWLastError                          !Any errors generated by SW are taken care of
!    BEEP(BEEP:SystemHand)                       !here
    L:LastEvent = 'Error'                       !Update display vars
    L:Status = 'Error'                          !Error # & Error Msg are in globar vars
  
    IF CLIP(G:LastOCXErrCode) = '24035'         !Socket would block this operation
!       MESSAGE('24035 Socket would block this operation')
    ELSE
      IF CLIP(G:LastOCXErrCode) = '24061'         !Connection was refused by remote
        MESSAGE('The program was unable to establish a connection with the server.|This could ' |
              & 'be caused if the server is already servicing a request.  You may wish to retry ' |
              & 'your request in a few moments.','Connection Refused',ICON:Hand)
      ELSE
        MESSAGE('The following TCP-IP error has occurred:|' & CLIP(G:LastOCXErrCode) & ' ' & CLIP(G:LastOCXErrMsg) |
              & '||The request has failed.','TCP/IP Error',ICON:Hand)
      END
   END


  OF EVENT:SWRead                                 !Data is available to read
    L:LastEvent = 'Read'                          !Update display var
    ?OCX{'RecvLen'} = '2100'                      !Set Max bytes to read
    LOC:LastRecived = ?OCX{'RecvData'}            !Put Rec'd data in local var

    LOC:ListOrg = CLIP(LOC:ListOrg) & CLIP(LOC:LastRecived)

    L# = LEN(CLIP(LOC:LastRecived))

    LFEED# = INSTRING('<10>',LOC:LastRecived,1,1)
    IF LFEED# THEN
       LOC:LastRecived[LFEED#]=' '
       LOC:List = CLIP(LOC:List) & CLIP(LOC:LastRecived) & '<13><10>'
    ELSE
       IF L# THEN
          LOC:List = CLIP(LOC:List) & CLIP(LOC:LastRecived)
       END
    END


! Larger Read-data til QUEUE i mottatt format.
   IF L# >0 THEN
      IF L# > 300 THEN
         MESSAGE('Recived line error - To large for queue line buffer.')
      ELSE
         QDL:LineDataStr = CLIP(LOC:LastRecived)
         ADD(QDataLines)

!         MESSAGE(QDL:LineDataStr)

         IF ERRORCODE() THEN
            MESSAGE('ADD error for QDataLines: ' & ERROR() )
         END

      END
   END

! Sjekker for @ som angir slutt på overført tekst og når det er flere kommandoer
! i QCommandStack køen startes utførelsen av neste kommando.

   ENDPOS# = INSTRING('@',LOC:LastRecived,1,1)

!   IF ENDPOS# THEN
!     MESSAGE('Read completed')
!     DISPLAY()
!   END

   IF ENDPOS# THEN

     LOC:List[INSTRING('@',LOC:List,1,1)] = ' '
     LOC:List2 = CLIP(LOC:List)

!     LOC:List_Display = CLIP(LOC:List)
 
!     MESSAGE('QDataLines =  ' & RECORDS(QDataLines) )

     Function_ReadCompleted(GLO:ActiveCommand,LOC:List)

     GET(QCommandStack,1)
      E# = ERRORCODE()
      IF E# THEN
         IF E# NOT= 30 THEN
            GLO:ActiveCommand = ''
            MESSAGE('QUEUE error: ' & ERROR() )
         ELSE
            GLO:ActiveCommand = ''
         END
      ELSE

         GLO:ActiveCommand = QCS:Command

         FREE(QDataLines)         ! Delete work queue
         LOC:List    = ''         ! Clear formatet display data
         LOC:ListOrg = ''         ! Clear raw data storage
       
         L:SendData = CLIP(QCS:CommandStr)           !Concatenate command & data in one string
         L:SendData[199:200] = '<13,10>'             !Terminate the string with CR/LF
         ?OCX{'SendLen'} = 200                       !Set max number of bytes to write to socket
         ?OCX{'SendData'} = L:SendData               !Send command/data to remote host
         L:Status = 'Sending Request'                !Update display var

         DISPLAY()

         DELETE(QCommandStack)
         IF ERRORCODE() THEN
            MESSAGE('Feil ved sletting fra kommand-stack|Error: ' & ERROR() )

            FREE(QCommandStack)
            IF ERRORCODE() THEN
               HALT(1,'Command stack error')
            END
         END
      END
   END

  OF EVENT:SWTimeout                            !Blocking operation timed out
    L:LastEvent = 'Timeout'                     !No blocking operations were used in this example
    MESSAGE('Request has timed out.')
  
  OF EVENT:SWTimer                              !SW control also has an internal timer avail
    L:LastEvent = 'Timer'                       !which you can porgram with the 'Interval' property
  
  OF EVENT:SWWrite                              !Data can be written to a socket
    L:LastEvent = 'Write'
  
  OF EVENT:SWDisconnect                         !Socket has been closed by remote host
    L:LastEvent = 'Disconnect'                  !Update display var
    ?OCX{'Action'} = SOCKET_DISCONNECT          !Issue local socket close action
    ?ButtonConnect{PROP:Text} = 'Connect'       !Change 'Disconnect' back to 'Connect'
    ENABLE(?L:BIPAddr)                          !Allow text entry into IP Address field
    L:Status = 'Disconnected'                   !Update display var
    LOC:Connect_Status = L:Status
    BEEP(BEEP:SystemExclamation)
    MESSAGE('The connection was disconnected by the remote host.','Request Status',ICON:Hand)
  
  OF EVENT:SWUnknown                            !Any other event that I haven't explicitly
    L:LastEvent = 'Unknown'                     !mapped an event to.  I don't know of any at
                                                !this time
  END ! case event
  
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    CASE FIELD()
    OF ?List_Levert
      ! Test
      
         ENABLE(?But_Skriv_Barkode)
      
    OF ?GLO:Liste_Paafyllingsvarsel
      ! Setter Entry-felt aktiv med en gang.
      
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:Timer
      ! TEST AV TIMER
      
         LOC:Current_Date = TODAY()
         LOC:Current_Time = CLOCK()
         DISPLAY(?LOC:Current_Date)
         DISPLAY(?LOC:Current_Time)
      
         IF LOC:Delay_Flag > 1 THEN
            LOC:Delay_Flag -= 1
         ELSE
            IF LOC:Delay_Flag = 1 THEN
               LOC:Delay_Flag = 0
               POST(EVENT:WriteCommand)
            END
         END
      
         IF LOC:Connect_Status = 'Disconnected' THEN
      
            ?OCX{'HostAddress'} = CLIP(GETINI('Oppsett','IP','79.161.10.133','Lager.INI'))    !  Set IP address of remote host to talk to
            ?OCX{'RemotePort'}  = CLIP(GETINI('Oppsett','Port','30125','Lager.INI'))         !  Connect to a listening port of remote host
            ?OCX{'Action'}      = SOCKET_CONNECT         !  Try the connection
            L:Status = 'Attempting to Connect...'
         END
      
         IF INSTRING('Alarm', GLO:Liste_Paafyllingsvarsel, 1, 1) THEN
            IF(?Panel_Varsel{PROP:Fill} NOT= 00000FFH) THEN
               ?Panel_Varsel{PROP:Fill} = 00000FFH                   ! Rød
               DISPLAY(?Panel_Varsel)
            END
         ELSE
            IF(?Panel_Varsel{PROP:Fill} NOT= 0C8D0D4H) THEN
               ?Panel_Varsel{PROP:Fill} = 0C8D0D4H                   ! Rød
               DISPLAY(?Panel_Varsel)
            END
         END
      
      ! Sørger for å oppdatere alarm-info
      
         IF LOC:Refresh_Teller NOT= 0 THEN
            LOC:Refresh_Teller -= 1
      
         ELSE
            LOC:Refresh_Teller = LOC:Alarmperiode - 1
      
            LOC:Info_Str = ''                                         ! Sletter temp infostring brukt til programinfo
      
            Function_Add_Command( 'RefillCheck', 'RefillCheck' )
            POST(EVENT:WriteCommand)
      
         END
      
      ! (?Sheet1)=3 forteller at flipp brukt av påfylling er aktiv
      
         IF CHOICE(?Sheet1)=3 THEN
            IF ?LOC:Lest_Barcode NOT= FOCUS() THEN
      
               CASE FOCUS()
      
               OF ?But_Merknad
               OF ?But_Nullstill
               OF ?But_Pluss_En
               OF ?But_Pluss_Fem
               OF ?But_Pluss_Ti
               OF ?But_Pluss_Femti
               OF ?But_Kvitter
               OF ?Button_Avbryt_Paafylling
      
               ELSE
                  SELECT(?LOC:Lest_Barcode)
               END
            END
         END
      
      ! Kjører oppdateringer med jevne mellom på andre register.
      
         LOC:UpdateTeller += 1
      !  LOC:UpdateTeller = (LOC:UpdateTeller + 1) % 360
      
         CASE LOC:UpdateTeller
      
         OF  600
            Function_Add_Command( 'ListIngredients', 'ListIngredients' )
            POST(EVENT:WriteCommand)
      
         OF 1200
            Function_Add_Command( 'IngDataRead', 'IngDataRead 1 -1' )
            POST(EVENT:WriteCommand)
      
         OF 1800
            Function_Add_Command( 'Tank', 'Tank')
            POST(EVENT:WriteCommand)
      
         OF 2400
            Function_Add_Command( 'TankDataRead', 'TankDataRead 1 -1' )
            POST(EVENT:WriteCommand)
      
         OF 3000
            Function_Add_Command( 'DeliveredRead', 'DeliveredRead 1 -1 0')
            POST(EVENT:WriteCommand)
      
         OF 3600
            Function_Add_Command( 'BarcodeRead', 'BarcodeRead' )
            POST(EVENT:WriteCommand)
            LOC:UpdateTeller = 1
      
         END
      
      
      
      
      
      
      
      
      
      
      
      
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!---------------------------------------------------
MainOCXEventHandler FUNCTION(*SHORT ref,SIGNED OLEControlFEQ,LONG OLEEvent)
  CODE
! SocketWrench Event Callback Handler
! This is the first place the SW events are known.  Matching event will are !posted that
! can be picked up by the Event-loop. !The user defined SW events are defined in SWRENCH.INC

  CASE OLEEvent             !OLEEvent contains the SW event ID
  OF 1
    POST(EVENT:SWAccept)

  OF 2
    POST(EVENT:SWBlocking)

  OF 3
    POST(EVENT:SWCancel)

  OF 4
    POST(EVENT:SWConnect)

  OF 5                                        !If an error has ocurred, save the error code and
    G:LastOCXErrCode = OCXGETPARAM(Ref,1)     !number into global vars so that I can act on them
    G:LastOCXErrMsg  = OCXGETPARAM(Ref,2)     !in my procedure
    POST(EVENT:SWLastError)

  OF 6
    POST(EVENT:SWRead)

  OF 7
    POST(EVENT:SWTimeout)

  OF 8
    POST(EVENT:SWTimer)

  OF 9
    POST(EVENT:SWWrite)

  OF 10
    POST(EVENT:SWDisconnect)

  ELSE
    POST(EVENT:SWUnknown)
  END
  RETURN(True)

BRW5.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?Sheet4)=2
    RETURN SELF.SetSort(1,Force)
  ELSE
    RETURN SELF.SetSort(2,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


BRW5.SetQueueRecord PROCEDURE

  CODE
  LOC:Ingrediens_id = IN2:id
  PARENT.SetQueueRecord
  SELF.Q.LOC:Ingrediens_id = LOC:Ingrediens_id        !Assign formula result to display queue


BRW2.ResetFromView PROCEDURE

LOC:Teller_Aktive_Leveringer:Cnt LONG
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:DelNode.SetQuickScan(1)
  SELF.Reset
  LOOP
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      RETURN
    END
    SELF.SetQueueRecord
    LOC:Teller_Aktive_Leveringer:Cnt += 1
  END
  LOC:Teller_Aktive_Leveringer = LOC:Teller_Aktive_Leveringer:Cnt
  PARENT.ResetFromView
  Relate:DelNode.SetQuickScan(0)
  SETCURSOR()


BRW2.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?Sheet3)=2
    RETURN SELF.SetSort(1,Force)
  ELSIF CHOICE(?Sheet3)=3
    RETURN SELF.SetSort(2,Force)
  ELSIF CHOICE(?Sheet3)=4
    RETURN SELF.SetSort(3,Force)
  ELSE
    RETURN SELF.SetSort(4,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue


BRW3.ResetFromView PROCEDURE

LOC:Totalt_Levering_Antall:Sum REAL
LOC:Total_Levering_Brukt:Sum REAL
LOC:Total_Levering_Lager:Sum REAL
LOC:Totalt_Levering_Antall_kg:Sum REAL
LOC:Total_Levering_Brukt_kg:Sum REAL
LOC:Total_Levering_Lager_kg:Sum REAL
  CODE
  SETCURSOR(Cursor:Wait)
  Relate:DelNode2.SetQuickScan(1)
  SELF.Reset
  LOOP
    CASE SELF.Next()
    OF Level:Notify
      BREAK
    OF Level:Fatal
      RETURN
    END
    SELF.SetQueueRecord
    LOC:Totalt_Levering_Antall:Sum += DN2:Antall
    LOC:Total_Levering_Brukt:Sum += DN2:Brukt
    LOC:Total_Levering_Lager:Sum += DN2:Lager
    LOC:Totalt_Levering_Antall_kg:Sum += DN2:Antall_kg
    LOC:Total_Levering_Brukt_kg:Sum += DN2:Brukt_kg
    LOC:Total_Levering_Lager_kg:Sum += DN2:Lager_kg
  END
  LOC:Totalt_Levering_Antall = LOC:Totalt_Levering_Antall:Sum
  LOC:Total_Levering_Brukt = LOC:Total_Levering_Brukt:Sum
  LOC:Total_Levering_Lager = LOC:Total_Levering_Lager:Sum
  LOC:Totalt_Levering_Antall_kg = LOC:Totalt_Levering_Antall_kg:Sum
  LOC:Total_Levering_Brukt_kg = LOC:Total_Levering_Brukt_kg:Sum
  LOC:Total_Levering_Lager_kg = LOC:Total_Levering_Lager_kg:Sum
  PARENT.ResetFromView
  Relate:DelNode2.SetQuickScan(0)
  SETCURSOR()


BRW3.ResetSort PROCEDURE(BYTE Force)

ReturnValue          BYTE,AUTO

  CODE
  IF CHOICE(?Sheet5)=2
    RETURN SELF.SetSort(1,Force)
  ELSE
    RETURN SELF.SetSort(2,Force)
  END
  ReturnValue = PARENT.ResetSort(Force)
  RETURN ReturnValue




   MEMBER('lager.clw')                                ! This is a MEMBER module

                     MAP
                       INCLUDE('LAGER012.INC'),ONCE        !Local module procedure declarations
                     END


Function_Add_Command PROCEDURE  (PAR:Command, PAR:CommandStr) ! Declare Procedure
  CODE
!Legger inn commando i QCommandStack

   QCS:Command    = PAR:Command
   QCS:CommandStr = PAR:CommandStr

   ADD(QCommandStack)
   IF ERRORCODE() THEN
      MESSAGE('Feil ved lagring av kommando til stack|Error: ' & ERROR() )
   END

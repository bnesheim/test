  MEMBER('lager.clw')

  MAP
    MODULE('LAGERBC0.CLW')
LAGERBC0:DctInit             PROCEDURE
LAGERBC0:DctKill             PROCEDURE
LAGERBC0:FilesInit           PROCEDURE
    END
  END

DctInit PROCEDURE
  CODE
  LAGERBC0:DctInit
  LAGERBC0:FilesInit


DctKill PROCEDURE
  CODE
  LAGERBC0:DctKill


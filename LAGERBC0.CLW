  MEMBER('lager.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
LAGERBC0:DctInit    PROCEDURE
LAGERBC0:DctKill    PROCEDURE
LAGERBC0:FilesInit  PROCEDURE
  END

Hide:Access:weight   CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:weight   CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Used     CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:Used     CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:WorkLine CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
PrimeFields            PROCEDURE(),PROC,DERIVED
                     END


Hide:Relate:WorkLine CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Tankdata CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:Tankdata CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:sourcetank CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:sourcetank CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:ingredient CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:ingredient CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:IngData  CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:IngData  CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:DelNode  CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:DelNode  CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Barcode  CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:Barcode  CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:ingredient2 CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:ingredient2 CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:DelNode2 CLASS(FileManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


Hide:Relate:DelNode2 CLASS(RelationManager)
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

LAGERBC0:DctInit PROCEDURE
  CODE
  Relate:weight &= Hide:Relate:weight
  Relate:Used &= Hide:Relate:Used
  Relate:WorkLine &= Hide:Relate:WorkLine
  Relate:Tankdata &= Hide:Relate:Tankdata
  Relate:sourcetank &= Hide:Relate:sourcetank
  Relate:ingredient &= Hide:Relate:ingredient
  Relate:IngData &= Hide:Relate:IngData
  Relate:DelNode &= Hide:Relate:DelNode
  Relate:Barcode &= Hide:Relate:Barcode
  Relate:ingredient2 &= Hide:Relate:ingredient2
  Relate:DelNode2 &= Hide:Relate:DelNode2

LAGERBC0:FilesInit PROCEDURE
  CODE
  Hide:Relate:weight.Init
  Hide:Relate:Used.Init
  Hide:Relate:WorkLine.Init
  Hide:Relate:Tankdata.Init
  Hide:Relate:sourcetank.Init
  Hide:Relate:ingredient.Init
  Hide:Relate:IngData.Init
  Hide:Relate:DelNode.Init
  Hide:Relate:Barcode.Init
  Hide:Relate:ingredient2.Init
  Hide:Relate:DelNode2.Init


LAGERBC0:DctKill PROCEDURE
  CODE
  Hide:Relate:weight.Kill
  Hide:Relate:Used.Kill
  Hide:Relate:WorkLine.Kill
  Hide:Relate:Tankdata.Kill
  Hide:Relate:sourcetank.Kill
  Hide:Relate:ingredient.Kill
  Hide:Relate:IngData.Kill
  Hide:Relate:DelNode.Kill
  Hide:Relate:Barcode.Kill
  Hide:Relate:ingredient2.Kill
  Hide:Relate:DelNode2.Kill


Hide:Access:weight.Init PROCEDURE
  CODE
  SELF.Init(weight,GlobalErrors)
  SELF.Buffer &= WEI:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(WEI:K_ID_Weight,'WEI:K_ID_Weight',1)
  SELF.AddKey(WEI:K_visualName,'WEI:K_visualName',0)
  Access:weight &= SELF


Hide:Relate:weight.Init PROCEDURE
  CODE
  Hide:Access:weight.Init
  PARENT.Init(Access:weight,1)


Hide:Access:weight.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:weight &= NULL


Hide:Relate:weight.Kill PROCEDURE

  CODE
  Hide:Access:weight.Kill
  PARENT.Kill
  Relate:weight &= NULL


Hide:Access:Used.Init PROCEDURE
  CODE
  SELF.Init(Used,GlobalErrors)
  SELF.Buffer &= USE:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(USE:K_ID_Used,'USE:K_ID_Used',1)
  SELF.AddKey(USE:K_id,'USE:K_id',0)
  SELF.AddKey(USE:K_dline_id,'USE:K_dline_id',0)
  SELF.AddKey(USE:K_Dato_Asc,'USE:K_Dato_Asc',0)
  SELF.AddKey(USE:K_Dato_Des,'USE:K_Dato_Des',0)
  SELF.AddKey(USE:K_date_time_str,'USE:K_date_time_str',0)
  Access:Used &= SELF


Hide:Relate:Used.Init PROCEDURE
  CODE
  Hide:Access:Used.Init
  PARENT.Init(Access:Used,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:DelNode,RI:None,RI:None,DNO:K_ID_DeliveredNode)
  SELF.AddRelationLink(USE:dline_id,DNO:ID_DeliveredNode)


Hide:Access:Used.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Used &= NULL


Hide:Relate:Used.Kill PROCEDURE

  CODE
  Hide:Access:Used.Kill
  PARENT.Kill
  Relate:Used &= NULL


Hide:Access:WorkLine.Init PROCEDURE
  CODE
  SELF.Init(WorkLine,GlobalErrors)
  SELF.Buffer &= WLI:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(WLI:K_ID_WorkLine,'WLI:K_ID_WorkLine',1)
  SELF.AddKey(WLI:K_Ingrediens_id,'WLI:K_Ingrediens_id',0)
  SELF.AddKey(WLI:K_Barkode,'WLI:K_Barkode',0)
  SELF.AddKey(WLI:K_Dato,'WLI:K_Dato',0)
  SELF.AddKey(WLI:K_Status,'WLI:K_Status',0)
  Access:WorkLine &= SELF


Hide:Relate:WorkLine.Init PROCEDURE
  CODE
  Hide:Access:WorkLine.Init
  PARENT.Init(Access:WorkLine,1)


Hide:Access:WorkLine.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:WorkLine &= NULL


Hide:Access:WorkLine.PrimeFields PROCEDURE

  CODE
  WLI:Antall_Labler = 4
  WLI:Utskrevet_Flag = 'Nei'
  PARENT.PrimeFields


Hide:Relate:WorkLine.Kill PROCEDURE

  CODE
  Hide:Access:WorkLine.Kill
  PARENT.Kill
  Relate:WorkLine &= NULL


Hide:Access:Tankdata.Init PROCEDURE
  CODE
  SELF.Init(Tankdata,GlobalErrors)
  SELF.Buffer &= TAN:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(TAN:K_ID_Tankdata,'TAN:K_ID_Tankdata',1)
  SELF.AddKey(TAN:K_id_tank,'TAN:K_id_tank',0)
  SELF.AddKey(TAN:K_barcode,'TAN:K_barcode',0)
  SELF.AddKey(TAN:k_weightname,'TAN:k_weightname',0)
  Access:Tankdata &= SELF


Hide:Relate:Tankdata.Init PROCEDURE
  CODE
  Hide:Access:Tankdata.Init
  PARENT.Init(Access:Tankdata,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:sourcetank)


Hide:Access:Tankdata.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Tankdata &= NULL


Hide:Relate:Tankdata.Kill PROCEDURE

  CODE
  Hide:Access:Tankdata.Kill
  PARENT.Kill
  Relate:Tankdata &= NULL


Hide:Access:sourcetank.Init PROCEDURE
  CODE
  SELF.Init(sourcetank,GlobalErrors)
  SELF.Buffer &= SOU:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(SOU:K_ID_sourcetank,'SOU:K_ID_sourcetank',1)
  SELF.AddKey(SOU:K_tanknummer,'SOU:K_tanknummer',0)
  SELF.AddKey(SOU:K_id,'SOU:K_id',0)
  Access:sourcetank &= SELF


Hide:Relate:sourcetank.Init PROCEDURE
  CODE
  Hide:Access:sourcetank.Init
  PARENT.Init(Access:sourcetank,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Tankdata,RI:None,RI:None,TAN:K_id_tank)
  SELF.AddRelationLink(SOU:tanknummer,TAN:id_tank)


Hide:Access:sourcetank.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:sourcetank &= NULL


Hide:Relate:sourcetank.Kill PROCEDURE

  CODE
  Hide:Access:sourcetank.Kill
  PARENT.Kill
  Relate:sourcetank &= NULL


Hide:Access:ingredient.Init PROCEDURE
  CODE
  SELF.Init(ingredient,GlobalErrors)
  SELF.Buffer &= ING:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(ING:K_ID_ingredient,'ING:K_ID_ingredient',1)
  SELF.AddKey(ING:K_id,'ING:K_id',0)
  SELF.AddKey(ING:K_code,'ING:K_code',0)
  SELF.AddKey(ING:K_name,'ING:K_name',0)
  Access:ingredient &= SELF


Hide:Relate:ingredient.Init PROCEDURE
  CODE
  Hide:Access:ingredient.Init
  PARENT.Init(Access:ingredient,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:DelNode2)
  SELF.AddRelation(Relate:DelNode)
  SELF.AddRelation(Relate:IngData,RI:None,RI:None,IND:K_ingredientId)
  SELF.AddRelationLink(ING:id,IND:ingredientId)


Hide:Access:ingredient.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ingredient &= NULL


Hide:Relate:ingredient.Kill PROCEDURE

  CODE
  Hide:Access:ingredient.Kill
  PARENT.Kill
  Relate:ingredient &= NULL


Hide:Access:IngData.Init PROCEDURE
  CODE
  SELF.Init(IngData,GlobalErrors)
  SELF.Buffer &= IND:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(IND:K_ID_IngData,'IND:K_ID_IngData',1)
  SELF.AddKey(IND:K_ingredientId,'IND:K_ingredientId',0)
  Access:IngData &= SELF


Hide:Relate:IngData.Init PROCEDURE
  CODE
  Hide:Access:IngData.Init
  PARENT.Init(Access:IngData,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:ingredient2)
  SELF.AddRelation(Relate:ingredient)


Hide:Access:IngData.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:IngData &= NULL


Hide:Relate:IngData.Kill PROCEDURE

  CODE
  Hide:Access:IngData.Kill
  PARENT.Kill
  Relate:IngData &= NULL


Hide:Access:DelNode.Init PROCEDURE
  CODE
  SELF.Init(DelNode,GlobalErrors)
  SELF.Buffer &= DNO:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(DNO:K_ID_DelNode,'DNO:K_ID_DelNode',1)
  SELF.AddKey(DNO:K_ID_DeliveredNode,'DNO:K_ID_DeliveredNode',0)
  SELF.AddKey(DNO:K_Dato,'DNO:K_Dato',0)
  SELF.AddKey(DNO:K_DatoStr_Asc,'DNO:K_DatoStr_Asc',0)
  SELF.AddKey(DNO:K_DatoStr_Des,'DNO:K_DatoStr_Des',0)
  SELF.AddKey(DNO:K_Kilde,'DNO:K_Kilde',0)
  SELF.AddKey(DNO:K_Referanse,'DNO:K_Referanse',0)
  SELF.AddKey(DNO:K_Status,'DNO:K_Status',0)
  SELF.AddKey(DNO:K_ingredient_id,'DNO:K_ingredient_id',0)
  SELF.AddKey(DNO:K_Barkode,'DNO:K_Barkode',0)
  Access:DelNode &= SELF


Hide:Relate:DelNode.Init PROCEDURE
  CODE
  Hide:Access:DelNode.Init
  PARENT.Init(Access:DelNode,1)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Used)
  SELF.AddRelation(Relate:ingredient,RI:None,RI:None,ING:K_id)
  SELF.AddRelationLink(DNO:ingredient_id,ING:id)


Hide:Access:DelNode.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:DelNode &= NULL


Hide:Relate:DelNode.Kill PROCEDURE

  CODE
  Hide:Access:DelNode.Kill
  PARENT.Kill
  Relate:DelNode &= NULL


Hide:Access:Barcode.Init PROCEDURE
  CODE
  SELF.Init(Barcode,GlobalErrors)
  SELF.Buffer &= BAR:Record
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(BAR:K_ID_Barcode,'BAR:K_ID_Barcode',1)
  SELF.AddKey(BAR:K_barcode,'BAR:K_barcode',0)
  SELF.AddKey(BAR:K_type,'BAR:K_type',0)
  Access:Barcode &= SELF


Hide:Relate:Barcode.Init PROCEDURE
  CODE
  Hide:Access:Barcode.Init
  PARENT.Init(Access:Barcode,1)


Hide:Access:Barcode.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Barcode &= NULL


Hide:Relate:Barcode.Kill PROCEDURE

  CODE
  Hide:Access:Barcode.Kill
  PARENT.Kill
  Relate:Barcode &= NULL


Hide:Access:ingredient2.Init PROCEDURE
  CODE
  SELF.Init(ingredient2,GlobalErrors)
  SELF.Buffer &= IN2:Record
  SELF.AliasedFile &= Access:ingredient               !This is a File Alias, so assign aliased file
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(IN2:K_ID_ingredient,'IN2:K_ID_ingredient',1)
  SELF.AddKey(IN2:K_id,'IN2:K_id',0)
  SELF.AddKey(IN2:K_code,'IN2:K_code',0)
  SELF.AddKey(IN2:K_name,'IN2:K_name',0)
  Access:ingredient2 &= SELF


Hide:Relate:ingredient2.Init PROCEDURE
  CODE
  Hide:Access:ingredient2.Init
  PARENT.Init(Access:ingredient2,1)
  SELF.SetAlias(Relate:ingredient)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:IngData,RI:None,RI:None,IND:K_ingredientId)
  SELF.AddRelationLink(IN2:id,IND:ingredientId)


Hide:Access:ingredient2.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:ingredient2 &= NULL


Hide:Relate:ingredient2.Kill PROCEDURE

  CODE
  Hide:Access:ingredient2.Kill
  PARENT.Kill
  Relate:ingredient2 &= NULL


Hide:Access:DelNode2.Init PROCEDURE
  CODE
  SELF.Init(DelNode2,GlobalErrors)
  SELF.Buffer &= DN2:Record
  SELF.AliasedFile &= Access:DelNode                  !This is a File Alias, so assign aliased file
  SELF.Create = 1
  SELF.LockRecover = 10
  SELF.AddKey(DN2:K_ID_DelNode,'DN2:K_ID_DelNode',1)
  SELF.AddKey(DN2:K_ID_DeliveredNode,'DN2:K_ID_DeliveredNode',0)
  SELF.AddKey(DN2:K_Dato,'DN2:K_Dato',0)
  SELF.AddKey(DN2:K_DatoStr_Asc,'DN2:K_DatoStr_Asc',0)
  SELF.AddKey(DN2:K_DatoStr_Des,'DN2:K_DatoStr_Des',0)
  SELF.AddKey(DN2:K_Kilde,'DN2:K_Kilde',0)
  SELF.AddKey(DN2:K_Referanse,'DN2:K_Referanse',0)
  SELF.AddKey(DN2:K_Status,'DN2:K_Status',0)
  SELF.AddKey(DN2:K_ingredient_id,'DN2:K_ingredient_id',0)
  SELF.AddKey(DN2:K_Barkode,'DN2:K_Barkode',0)
  Access:DelNode2 &= SELF


Hide:Relate:DelNode2.Init PROCEDURE
  CODE
  Hide:Access:DelNode2.Init
  PARENT.Init(Access:DelNode2,1)
  SELF.SetAlias(Relate:DelNode)
  DO AddRelations_1

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:ingredient,RI:None,RI:None,ING:K_id)
  SELF.AddRelationLink(DN2:ingredient_id,ING:id)


Hide:Access:DelNode2.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:DelNode2 &= NULL


Hide:Relate:DelNode2.Kill PROCEDURE

  CODE
  Hide:Access:DelNode2.Kill
  PARENT.Kill
  Relate:DelNode2 &= NULL


use [Medieval_Weapons_Shop]

go
create procedure setClientPhoneNumberToBigInt as
	alter table Client alter column Phone_number bigint

go
create procedure setClientPhoneNumberToInt as
	alter table Client alter column Phone_number int
	
go
create procedure addLogInPasswordToClient as
	alter table Client add Pwd varchar(100)

go
create procedure removeLogInPasswordFromClient as
	alter table Client drop column Pwd

go
create procedure addDefaultConstraintToClient as 
	alter table Client add constraint DefaultEmpty default(0) for Email
	 
go
create procedure removeDefaultConstraintFromClient as
	alter table Client drop constraint DefaultEmpty 
	
go
create procedure addPrimaryKeyToBeenPurchased as
	alter table Been_Purchased drop constraint PK__BeenPurchasedpk
	alter table Been_Purchased add constraint PK__BeenPurchasedpk primary key (Been_Purchasedid, Amount)

go 
create procedure removePrimaryKeyBeenPurchased as
	alter table Been_Purchased drop constraint PK__BeenPurchasedpk
	alter table Been_Purchased add constraint PK__BeenPurchasedpk primary key ( Been_Purchasedid)

go 
create procedure addCandidateKeyToClient as
	alter table Client add constraint Candidate unique (Client_name,Email)

go
create procedure dropCandidateKeyFromClient as
	alter table Client drop constraint Candidate 

go
create procedure removeForeignKeyFromBeenPurchased as
	alter table Been_Purchased drop constraint CostFK




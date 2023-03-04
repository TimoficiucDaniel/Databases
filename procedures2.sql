use [Medieval_Weapons_Shop]
go
create procedure addFKToBeenPurchased as
	alter table Been_Purchased add constraint CostFK foreign key (Cost) references Product (Cost)

go
create procedure newTable as
	create table tempTable(
	tempname varchar(100) not null,
	tempid int not null,
	tempdate date not null,
	primary key(tempid))

go 
create procedure dropTempTable as
	if OBJECT_ID ('dbo.tempTable','U') is not NULL
	drop table tempTable

create table versionTable(
	ver int
	)

insert into versionTable values (1)

create table proceduresTable(
	fromVersion int,
	toVersion int,
	primary key(fromVersion,toVersion),
	procedureName varchar(100))

insert into proceduresTable
	values (1,2,'setClientPhoneNumberToBigInt'),
			(2,1,'setClientPhoneNumberToInt'),
			(2,3,'addLogInPasswordToClient'),
			(3,2,'removeLogInPasswordFromClient'),
			(3,4,'addDefaultConstraintToClient'),
			(4,3,'removeDefaultConstraintFromClient'),
			(4,5,'addPrimaryKeyToBeenPurchased'),
			(5,4,'removePrimaryKeyBeenPurchased'),
			(5,6,'addCandidateKeyToClient'),
			(6,5,'dropCandidateKeyFromClient'),
			(6,7,'addFKToBeenPurchased'),
			(7,6,'removeForeignKeyFromBeenPurchased2'),
			(7,8,'newTable'),
			(8,7,'dropTempTable')

go
create procedure removeForeignKeyFromBeenPurchased2 as
	alter table Been_Purchased add idk int

go
create procedure goToVersion(@newVersion int) as
	declare @curr int
    declare @var varchar(max)
    select @curr=ver from versionTable

    if @newVersion > (select max(toVersion) from proceduresTable)
        raiserror ('Bad version', 10, 1)

    while @curr > @newVersion begin
        select @var=procedureName from proceduresTable where fromVersion=@curr and toVersion=@curr-1
        exec (@var)
        set @curr=@curr-1
    end

    while @curr < @newVersion begin
        select @var=procedureName from proceduresTable where fromVersion=@curr and toVersion=@curr+1
        exec (@var)
        set @curr=@curr+1
    end

    update versionTable set ver=@newVersion

execute goToVersion 1
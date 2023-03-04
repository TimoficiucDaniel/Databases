use [Medieval_Weapons_Shop];

go
create or alter procedure addClients
@n int as begin
declare @i int=0
while @i < @n
begin 
	insert into Client values ( concat(@i ,@i ) , concat('client ', @i),0,'')
	set @i = @i + 1
end
end

go 
create or alter procedure deleteClients
as begin
	delete from Client 
	where Client_name like 'client %'
end

go
create or alter procedure addPurchases
@n int as begin
declare @i int=0
while @i < @n
begin
	insert into Purchase values ( concat(@i, @i), '1111-11-11',concat(@i, @i), 1)
	set @i = @i + 1
end
end

go
create or alter procedure deletePurchases
as begin
	delete from Purchase 
	where Date_of_purchase = '1111-11-11'
end

go
create or alter procedure addToBeenPurchased
@n int
as begin
declare @purid int
declare @proid int 
declare @i int=0
declare @id int=100
declare curs cursor
	for select pur.Purchaseid, pro.Productid from (select Purchaseid from Purchase 
	where Date_of_purchase = '1111-11-11')pur cross join Product pro

open curs

while @i < @n
begin 
	fetch next from curs into @purid, @proid
	insert into Been_Purchased values (@id , @proid, @purid,-10*(@i+1),1)
	set @i = @i+1
	set @id = @id + 1
end
deallocate curs
end

go 
create or alter procedure deleteBeenPurchased
as begin
	delete from Been_Purchased where Amount < 0
end

go
create or alter view viewClients
as
	select Client_name from Client

go 
create or alter view viewPurchase
as 
	select Purchaseid , Date_of_purchase , Purchase.Clientid 
	from Purchase inner join Client on Purchase.Clientid = Client.Clientid

go
create or alter view viewBeenPurchased
as
	select Been_Purchased.Productid,Sum(Amount) as Sum
	from Been_Purchased inner join Product on Been_Purchased.Productid = Product.Productid
	group by Been_Purchased.Productid 


go
create or alter procedure selectView
(@name varchar(100))
as
begin
	declare @sql varchar(250) = 'select * from ' + @name
	exec(@sql)
end
go

insert into Tests(Name) values  ('addClients'),
								('deleteClients'),
								('addPurchases'),
								('deletePurchases'),
								('addToBeenPurchased'),
								('deleteBeenPurchased'),
								('selectView')
insert into Tables(Name) values ('Client'),
								('Purchase'),
								('Been_Purchased')
insert into Views(Name) values  ('viewClients'),
								('viewPurchase'),
								('viewBeenPurchased')

select * from Tests
select * from Tables
select * from Views

insert into TestViews(TestID,ViewID) values (7,1), (7,2), (7,3)

insert into TestTables(TestID,TableID,NoOfRows,Position)
values
	(6,3,100,1),
	(4,2,100,2),
	(2,1,100,3),
	(1,1,100,1),
	(3,2,100,2),
	(5,3,100,3)

select * from TestTables
select * from TestViews

go
create or alter procedure main
as begin
	insert into TestRuns values ('','2000','2000')
	declare @testrunid int
	set @testrunid = (select max(TestRunId) from TestRuns)

	print 'running test with id ' + convert(varchar, @testRunID)
	update TestRuns
	set Description = 'test' + convert(varchar, @testRunID)
	where TestRunID = @testRunID 

	declare @noOfRows int
	declare @tableID int
	declare @tableName varchar(100)
	declare @startAt datetime
	declare @endAt datetime
	declare @viewID int
	declare @viewName varchar(100)
	declare @name varchar(100)

	declare testDeleteCursor cursor
	for
	select TableID, Name, NoOfRows
	from Tests inner join TestTables on Tests.TestID = TestTables.TestID
	where Name like 'delete%' 
	order by Position 

	open testDeleteCursor
	
	fetch next
	from testDeleteCursor
	into @tableID, @name, @noOfRows

	set @startAt = getdate()

	update TestRuns
	set StartAt = @startAt
	where TestRunID = @testRunID and year(StartAt) = 2000


	while @@FETCH_STATUS = 0
	begin
		print 'running  ' + @name

		exec(@name) 

		fetch next
		from testDeleteCursor
		into @tableID,@name,  @noOfRows
	end

	close testDeleteCursor
	deallocate testDeleteCursor

	-- insert tests

	declare testInsertCursor cursor
	for
	select TableID, Name, NoOfRows
	from Tests inner join TestTables on Tests.TestID = TestTables.TestID
	where Name like 'add%' 
	order by Position 

	open testInsertCursor

	fetch next
	from testInsertCursor
	into @tableID, @name, @noOfRows

	while @@FETCH_STATUS = 0
	begin

		set @startAt = getdate()

		print 'running ' + @name

		exec @name @noOfRows
		
		set @endAt = getdate()

		insert into TestRunTables values (@testRunID, @tableID, @startAt, @endAt)

		fetch next
		from testInsertCursor
		into @tableID, @name, @noOfRows
	end

	close testInsertCursor
	deallocate testInsertCursor


	-- view tests

	declare testViewCursor cursor
	for 
	select ViewID
	from TestViews

	open testViewCursor

	fetch next
	from testViewCursor
	into @viewID

	while @@FETCH_STATUS = 0
	begin
		set @viewName = (select Name from Views where ViewID = @viewID)

		set @startAt = getdate()
		print 'view name ' + @viewName
		exec selectView @viewName
		set @endAt = getdate()

		insert into TestRunViews values (@testRunID, @viewID, @startAt, @endAt)

		fetch next
		from testViewCursor
		into @viewID
	end

	update TestRuns
	set EndAt = @endAt
	where TestRunID = @testRunID

	close testViewCursor
	deallocate testViewCursor
end
go

exec main

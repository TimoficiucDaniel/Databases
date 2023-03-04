use Medieval_Weapons_Shop;

insert into client
values
	(1,'Dani Timo',0711111111,'dani.timo@yahoo.com'),
	(2,'Iannis Taravinas',0722222222,'iannis.taravinas@yahoo.com'),
	(3,'Oana Topan',0733333333,'oana.topan@yahoo.com'),
	(4,'Andi Varga',0744444444,'andi.varga@yahoo.com'),
	(5,'Alex Stufi',0755555555,'alex.stufi@yahoo.com');

insert into Employee
values
	(1,'2019-10-28','Bogdan Baga',4000),
	(2,'2018-03-21','Rafa Radu',3999),
	(3,'2019-12-25','Nicolae Craciun',4100);

insert into purchase
values 
	(1,'2022-09-28',2,2),
	(2,'2021-04-14',1,1),
	(3,'2020-03-03',5,2),
	(4,'2021-12-25',4,3),
	(5,'2022-02-01',3,1);

insert into Producer
values 
	(1,'Fier si Otel Cluj SRL','Strada Otelului nr 46','fier.otel.cluj@gmail.ro',0220456789),
	(2,'Fieraria Articolelor Istorice','Strada Iugoslaviei nr 1','fieraria.ai@gmail.ro',0220123789);

insert into Sword
values
	(1,'Longsword','Damascus steel',100),
	(2,'Katana','steel',90),
	(3,'Claymore','Carbon steel',160),
	(4,'Shortsword','Cobalt alloy',60),
	(5,'Sabre','Tool steel',90);

insert into Bow
values
	(1,'Longbow',100,'Oak wood'),
	(2,'Recurve bow',60,'Birch wood');

insert into Miscelaneous
values
	(1,'Sword oil','Oil used to protect the sword from oxidation'),
	(2,'Arrow','Standard multipurpose arrow'),
	(3,'Quiver','Used to store arrows for transport');

insert into Shield
values
	(1,'Kite Shield','Hardwood with a steel core',20),
	(2,'Bulwark','Steel with leather straps',20),
	(3,'Round Shield','Hardwood',15),
	(4,'Buckler','Carbon steel',10);

insert into Product
values
	(1,200,1,1,NULL,NULL,NULL),
	(2,300,2,2,NULL,NULL,NULL),
	(3,100,1,4,NULL,NULL,NULL),
	(4,250,1,NULL,NULL,NULL,2),
	(5,10,2,NULL,NULL,1,NULL),
	(6,150,2,NULL,2,NULL,NULL);

insert into Been_Purchased
values 
	(1,1,2,1),
	(2,3,2,1),
	(3,4,3,1),
	(4,5,4,1),
	(5,2,1,1),
	(6,6,5,1);

update Shield
	set Thickness = 18
	where Thickness between 17 and 21;

update Product
	set Cost = 210 
	where Producerid = 1 AND Shieldid is NULL; 

update Miscelaneous
	set Misc_type='Training arrow', Misc_description = 'Standard training arrow'
	where Miscelaneousid=2;

delete from Sword
	where Sword_type like 'c%' or Sword_length >=150;

delete from Shield
	where Shield_type in ('Buckler','Pavise Shield','Heater Shield');

insert into Sword
values
	(6,'Greatsword','Stainless steel',140),
	(7,'Gladius','Carbon steel',70);

insert into Shield
values
	(5,'Buckler','Carbon steel',15);

insert into Bow
values
	(3,'Compound bow',150,'Carbon steel');


use Medieval_Weapons_Shop;
CREATE TABLE Client(
Clientid int not null,
Client_name nvarchar(50) not null,
Phone_number int,
Email nvarchar(50),
PRIMARY KEY(Clientid));

create table Employee(
Employeeid int not null,
Date_of_hire date not null,
Employee_name nvarchar(50) not null,
Salary int not null,
primary key(Employeeid));

CREATE TABLE Purchase(
Purchaseid int not null,
Date_of_purchase date not null,
Clientid int not null,
Employeeid int not null,
PRIMARY KEY(Purchaseid),
FOREIGN KEY(Clientid)
		REFERENCES Client(Clientid)
		ON DELETE CASCADE,
FOREIGN KEY(Employeeid)
		REFERENCES Employee(Employeeid)
		ON DELETE CASCADE);

create table Bow(
Bowid int not null,
Bow_type nvarchar(50) not null,
Shooting_distance int not null,
Material nvarchar(50) not null,
Primary key(Bowid));

create table Sword(
Swordid int not null,
Sword_type nvarchar(50) not null,
Sword_alloy nvarchar(50) not null,
Sword_length int not null,
primary key(Swordid));

create table Shield(
Shieldid int not null,
Shield_type nvarchar(50) not null,
Material nvarchar(50) not null,
Thickness int not null,
primary key(Shieldid));

create table Producer(
Producerid int not null,
Producer_name nvarchar(50) not null,
Producer_address nvarchar(50) not null,
Producer_email nvarchar(50) not null,
Phone_number int not null,
primary key(Producerid));

create table Miscelaneous(
Miscelaneousid int not null,
Misc_type nvarchar(50) not null,
Misc_description nvarchar(500) not null,
primary key(Miscelaneousid));

create table Product(
Productid int not null,
Cost int not null,
Producerid int,
Swordid int,
Bowid int,
Miscelaneousid int,
Shieldid int,
primary key(Productid),
foreign key(Producerid)
	references Producer(Producerid)
	on delete cascade,
foreign key(Swordid)
	references Sword(Swordid)
	on delete cascade,
foreign key(Bowid)
	references Bow(Bowid)
	on delete cascade,
foreign key(Miscelaneousid)
	references Miscelaneous(Miscelaneousid)
	on delete cascade,
foreign key(Shieldid)
	references Shield(Shieldid)
	on delete cascade);

CREATE TABLE Been_Purchased(
Been_Purchasedid int not null,
Productid int not null,
Purchaseid int not null,
Amount int not null,
PRIMARY KEY(Been_Purchasedid),
FOREIGN KEY(Productid)
		REFERENCES Product(Productid)
		ON DELETE CASCADE,
FOREIGN KEY(Purchaseid)
		REFERENCES Purchase(Purchaseid)
		ON DELETE CASCADE);



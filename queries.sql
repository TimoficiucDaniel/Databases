use Medieval_Weapons_Shop
--a 2 queries with the union operation; use UNION [ALL] and OR;

Select Client_name as People from Client 
where Client_name like 'a%' or Client_name like 'd%'
Union
Select Employee_name from Employee
Order by People;

Select Client_name as People from Client 
Union
Select Employee_name from Employee
Order by People;

--b  2 queries with the intersection operation; use INTERSECT and IN;

Select Swordid from Product
Intersect
Select Swordid from Sword;

Select Swordid from Product
where Swordid in (select Swordid from Sword);

--c 2 queries with the difference operation; use EXCEPT and NOT IN;

--Select Swordid from Product
--where Swordid not like 'null';

Select * from Sword
where Swordid NOT in (Select Swordid from Product
						where Swordid not like 'NULL')
						order by Sword_type ,Sword_length asc;

Select Swordid from Sword
Except
Select Swordid from Product;

--d	4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, 
--and FULL JOIN (one query per operator); one query will
--join at least 3 tables,while another one will join at least
--two many-to-many relationships;	

Select Sword_type from Sword
right join Product
on sword.Swordid = product.swordid
where sword.Swordid not like 'null';

Select Distinct Sword_type,Shield_type,Bow_type,Sword_alloy from ((Sword
inner join Shield
on shield.Material like sword.Sword_alloy)
inner join Bow 
on bow.Material like shield.Material);

Select Date_of_purchase from Purchase 
left join Product
on cost >= 100;


Select Employee.Employee_name,Purchase.Purchaseid,
Purchase.Date_of_purchase from Employee
full join Purchase
on Employee.Employeeid = Purchase.Employeeid;

--e 2 queries with the IN operator and a subquery in 
--the WHERE clause; in at least one case, the subquery
--must include a subquery in its own WHERE clause;

Select top 2 Sword_type,Sword_alloy from Sword
where Swordid in (Select Swordid from Product where
Swordid not like 'null')
order by Sword_alloy desc;

Select Clientid from Client 
where Client_name like 'a%' or Client_name like '%n';

select Purchase.Purchaseid from
Purchase where Clientid in ( Select Clientid from Client 
where Client_name like 'a%' or Client_name like '%n');

Select Cost from Product
where Productid in (Select Productid from Been_Purchased 
where Purchaseid in (select Purchaseid from
Purchase where Clientid in ( Select Clientid from Client 
where Client_name like 'a%' or Client_name like '%n')));

--f 2 queries with the EXISTS operator and a subquery in the WHERE clause;

Select Bow_type from Bow
where exists (select Bowid from Product
where Bowid not like 'null');

Select Employee.Employee_name from Employee
where exists( Select Purchase.Purchaseid from Purchase
where Date_of_purchase >= '2022-02-02');

--g 2 queries with a subquery in the FROM clause;

Select P.Producerid, P.Productid,P.Cost ,avgcost.averageCost from 
( select avg(cost) as averageCost from
Product) as avgcost,Product as P where avgcost.averageCost < P.Cost;

Select P.Producerid, P.Productid,P.Cost ,averageid from 
( select avg(Productid) as averageid from
Product) as avgid,Product as P where averageid < P.Productid;

--h 4 queries with the GROUP BY clause, 3 of which also
--contain the HAVING clause; 2 of the latter will also 
--have a subquery in the HAVING clause; use the aggregation
--operators: COUNT, SUM, AVG, MIN, MAX;


Select Distinct Pr.Producerid,Pr.Productid,Pr.Cost from Product 
as Pr
group by Pr.cost,Pr.Producerid,Pr.Productid
having Pr.cost > (select avg(cost) from product);


SELECT TABLE_NAME,
       CONSTRAINT_TYPE,CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME like 'Client';
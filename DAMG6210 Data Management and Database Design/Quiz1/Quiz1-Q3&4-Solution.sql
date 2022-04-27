
-- Last Digit of NUID 0, 8 or 9

-- Question 3 (4 points)

with temp1 as
(select sd.ProductID, year(OrderDate) Year, sum(UnitPrice * OrderQty) YearSales
 from Sales.SalesOrderHeader sh
 join Sales.SalesOrderDetail sd
      on sh.SalesOrderID = sd.SalesOrderID
 group by sd.ProductID, year(OrderDate)),

 temp2 as
(select sd.ProductID, year(OrderDate) Year, count(distinct sh.SalesOrderID) OC
 from Sales.SalesOrderHeader sh
 join Sales.SalesOrderDetail sd
      on sh.SalesOrderID = sd.SalesOrderID
 where TotalDue < 50000
 group by sd.ProductID, year(OrderDate)
 having count(distinct sh.SalesOrderID) < 5 
 )

 select t1.ProductID, t1.Year, t1.YearSales, oc
 from temp1 t1
 join temp2 t2
 on t1.ProductID = t2.ProductID and t1.Year = t2.Year
 order by t1.ProductID, t1.Year;


-- Question 4 (3 points)

with t1 as (
select SalesPersonID, 
       count(distinct StateProvinceID) sc,
	   sum(TotalDue) Sale,
	   rank() over (order by sum(TotalDue) desc) BR
from Sales.SalesOrderHeader sh
join Person.Address a
on sh.ShipToAddressID = a.AddressID
where SalesPersonID is not null
group by sh.SalesPersonID)

select SalesPersonID, SC, Sale, LastName, FirstName
from t1
join Person.Person p
on t1.SalesPersonID = p.BusinessEntityID
where BR <= 3 and SC >10
order by SalesPersonID;


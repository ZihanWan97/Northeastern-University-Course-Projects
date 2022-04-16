
-- Lab 3s Solutions

-- 3-1

SELECT SalesPersonID, p.LastName, p.FirstName,
       COUNT(o.SalesOrderid) [Total Orders],
	   CASE
		  WHEN COUNT(o.SalesOrderID) BETWEEN 1 AND 120
			 THEN 'Do more!'
		  WHEN COUNT(o.SalesOrderID) BETWEEN 121 AND 320
			 THEN 'Fine!'
		  ELSE 'Excellent!'
	   END AS Performance
FROM Sales.SalesOrderHeader o
JOIN Person.Person p
   ON o.SalesPersonID = p.BusinessEntityID
GROUP BY o.SalesPersonID, p.LastName, p.FirstName
ORDER BY p.LastName, p.FirstName;


-- 3-2

SELECT o.TerritoryID, s.Name, o.SalesPersonID,
  COUNT(o.SalesOrderid) [Total Orders],
  RANK() OVER (PARTITION BY o.TerritoryID ORDER BY COUNT(o.SalesOrderid) DESC) [Rank]
FROM Sales.SalesOrderHeader o
JOIN Sales.SalesTerritory s
   ON o.TerritoryID = s.TerritoryID
WHERE SalesPersonID IS NOT NULL
GROUP BY o.TerritoryID, s.Name, o.SalesPersonID
ORDER BY o.TerritoryID;


-- Lab 3-3

with temp as (
select City, sd.ProductID, sum(OrderQty) TotalSales,
       rank() over (partition by City order by sum(OrderQty) desc) Ranking
from Sales.SalesOrderHeader sh
join Sales.SalesOrderDetail sd
on sh.SalesOrderID = sd.SalesOrderID
join Person.Address a
on sh.ShipToAddressID = a.AddressID
group by a.City, sd.ProductID)

select * from temp where Ranking = 1 and TotalSales > 100
order by City;


-- Lab 3-4

select * from 
(select cast(a.OrderDate as DATE) AS OrderDate,
        b.ProductID, 
        sum(b.OrderQty) as total,
	    rank() OVER (PARTITION BY a.OrderDate ORDER BY sum(b.OrderQty) DESC) AS rank 
 from [Sales].[SalesOrderHeader] a
 join [Sales].[SalesOrderDetail] b
 on a.SalesOrderID =  b.SalesOrderID
 group by a.OrderDate, b.ProductID
) temp
where rank = 1
order by OrderDate;


-- Lab 3-5 

select CustomerID--, count(od.ProductID), count(distinct od.ProductID)
from [Sales].[SalesOrderHeader] sh
join [Sales].[SalesOrderDetail] od
     on sh.SalesOrderID = od.SalesOrderID
group by sh.CustomerID
having count(od.ProductID) = count(distinct od.ProductID)
       and count(distinct od.ProductID) > 10
order by count(distinct od.ProductID) desc;




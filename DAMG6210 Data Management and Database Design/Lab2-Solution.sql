
-- Lab 2 Solutions

-- 2-1

select SalesPersonID, SalesOrderID, cast(OrderDate as date) 'Order Date',
       round(TotalDue, 2) 'Total Due'
from Sales.SalesOrderHeader
where SalesPersonID in (276, 277) and TotalDue > 100000
order by SalesPersonID, OrderDate;


--2-2

Select TerritoryID as 'Territory ID', 
       count(SalesOrderId) as 'Total Orders',
	   cast(round(sum(TotalDue), 0) as int) as 'Total Sales'
From Sales.SalesOrderHeader
Group By TerritoryID
having count(SalesOrderId) > 3500 
Order by TerritoryID;


--2-3

Select ProductID as 'Product ID', 
       Name as 'Product Name',
       ListPrice as 'List Price', 
	   cast(SellStartDate as date) 'Sell Start Date'
From Production.Product
Where ListPrice > (Select max(ListPrice) From Production.Product)-1000
ORDER BY ListPrice desc;


--2-4

Select p.ProductID as 'Product ID',
       p.Name as 'Product Name',
       sum(sod.OrderQty) as 'total sold quantity'
From Production.Product p 
join Sales.SalesOrderDetail sod
on p.ProductID = sod.ProductID
where Color = 'Black'
Group By p.ProductID, p.Name
Having sum(sod.OrderQty) > 3000
Order by sum(sod.OrderQty) desc;


--2-5

SELECT cast(OrderDate as date) Date,
       sum(OrderQty) TotalProductQuantitySold
FROM Sales.SalesOrderHeader so
JOIN Sales.SalesOrderDetail sd
ON so.SalesOrderID = sd.SalesOrderID
WHERE OrderDate NOT IN
(SELECT OrderDate
 FROM Sales.SalesOrderHeader sh
 JOIN Sales.SalesOrderDetail sd
      ON sh.SalesOrderID = sd.SalesOrderID
 JOIN Production.Product p
      ON p.ProductID = sd.ProductID
 WHERE p.Color = 'Red')
GROUP BY OrderDate
ORDER BY TotalProductQuantitySold desc;


--2-6 

with temp as
(select CustomerID, year(OrderDate) year, sum(TotalDue) AnnualPurchase
from Sales.SalesOrderHeader
group by CustomerID, year(OrderDate))

select t.CustomerID, p.LastName, p.FirstName, 
       cast(sum(AnnualPurchase) as int) Total, 
	   cast(max(AnnualPurchase) as int) HighestYear
from temp t
join Sales.Customer c
on t.CustomerID = c.CustomerID
join Person.Person p
on c.PersonID = p.BusinessEntityID
group by t.CustomerID, p.LastName, p.FirstName
having sum(AnnualPurchase) > 500000
order by Total desc;



--3-1
SELECT SalesPersonID, p.LastName, p.FirstName, COUNT(o.SalesOrderid) [Total Orders],
	   CASE 
	   		WHEN COUNT(o.SalesOrderid) BETWEEN 1 AND 120 THEN 'Do more!'
	   		WHEN COUNT(o.SalesOrderid) BETWEEN 121 AND 320 THEN 'Fine!'
	   		ELSE 'Excellent!'
	   END AS Performance
FROM Sales.SalesOrderHeader o JOIN Person.Person p ON o.SalesPersonID = p.BusinessEntityID
GROUP BY o.SalesPersonID, p.LastName, p.FirstName
ORDER BY p.LastName, p.FirstName;

--3-2
SELECT o.TerritoryID, s.Name, o.SalesPersonID, COUNT(o.SalesOrderid) [Total Orders], 
	   RANK() OVER (PARTITION BY o.TerritoryID ORDER BY COUNT(o.SalesOrderid) DESC) AS [rank] 
FROM Sales.SalesOrderHeader o 
JOIN Sales.SalesTerritory s ON o.TerritoryID = s.TerritoryID
WHERE SalesPersonID IS NOT NULL GROUP BY o.TerritoryID, s.Name, o.SalesPersonID
ORDER BY o.TerritoryID;

--3-3
SELECT City,ProductID,TotalSoldQty 
FROM 
	(SELECT City, ProductID, SUM(OrderQty) AS [TotalSoldQty], RANK() OVER (PARTITION BY City ORDER BY SUM(OrderQty) DESC) AS [Rank]
	FROM Sales.SalesOrderDetail sod
	INNER JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
	INNER JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID 
	GROUP BY City,ProductID 
	HAVING SUM(OrderQty)>100) temp
WHERE [Rank] = 1
ORDER BY City;

--3-4
SELECT CAST(OrderDate AS DATE),ProductID, TotalSoldQty 
FROM 
	(SELECT OrderDate, ProductID, SUM(OrderQty) AS [TotalSoldQty], 
	RANK() OVER (PARTITION BY OrderDate ORDER BY SUM(OrderQty) DESC) AS [Rank]
	FROM Sales.SalesOrderHeader soh 
	INNER JOIN Sales.SalesOrderDetail sod  ON soh.SalesOrderID = sod.SalesOrderID 
	GROUP BY OrderDate,ProductID) temp
WHERE [Rank] = 1
ORDER BY OrderDate;

--3-5
SELECT CustomerID
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
WHERE CustomerID NOT IN(SELECT CustomerID
						FROM Sales.SalesOrderHeader soh 
						INNER JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID 
						GROUP BY CustomerID, ProductID
						HAVING COUNT(*) > 1)
GROUP BY CustomerID
HAVING COUNT(*) > 10
ORDER BY COUNT(*) DESC

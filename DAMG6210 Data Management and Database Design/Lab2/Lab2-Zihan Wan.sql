--2-1
SELECT SalesPersonID , SalesOrderID, CAST(OrderDate AS DATE) AS SalesOrderDate, CAST(ROUND(TotalDue,2) AS DECIMAL(10,2)) AS SalesTotalDue
FROM Sales.SalesOrderHeader 
WHERE SalesPersonID in (276,277) AND TotalDue > 100000
ORDER BY SalesPersonID, SalesOrderDate

--2-2
SELECT TerritoryID, COUNT(SalesOrderID) AS TotalNoOfOrders, CAST(SUM(TotalDue) AS INT) AS TotalSalesAmount 
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID
HAVING COUNT(SalesOrderID) > 3500
ORDER BY TerritoryID 

--2-3
SELECT ProductID, Name, ListPrice, CAST(SellStartDate AS DATE) AS StartDate
FROM Production.Product
WHERE ListPrice > (SELECT MAX(ListPrice)-1000 FROM Production.Product) 
ORDER BY ListPrice DESC 

--2-4
SELECT p.ProductID, Name, SUM(sod.OrderQty) AS TotalSoldQty
FROM Production.Product p 
LEFT JOIN Sales.SalesOrderDetail sod 
ON p.ProductID = sod.ProductID
WHERE p.Color = 'Black'
GROUP BY p.ProductID, Name
HAVING SUM(sod.OrderQty) > 3000
ORDER BY SUM(sod.OrderQty) DESC

--2-5
SELECT CAST(OrderDate AS DATE) AS Date, SUM(sod.OrderQty) AS TotalSoldQty_Date 
FROM Sales.SalesOrderDetail sod
LEFT JOIN Sales.SalesOrderHeader soh
ON sod.SalesOrderID = soh.SalesOrderID
WHERE OrderDate NOT IN 
(SELECT OrderDate FROM Sales.SalesOrderHeader WHERE SalesOrderID IN 
(SELECT SalesOrderID FROM Sales.SalesOrderDetail WHERE ProductID IN 
(SELECT ProductID FROM Production.Product WHERE Color = 'Red')))
GROUP BY OrderDate 
ORDER BY SUM(sod.OrderQty) DESC

--2-6
SELECT soh.CustomerID, p.LastName, p.FirstName, SUM(TotalDue) AS OverallPurchase, Annual_Highest.HighestAnnualPurchase 
FROM Sales.Customer c 
INNER JOIN Sales.SalesOrderHeader soh 
ON c.CustomerID = soh.CustomerID
INNER JOIN Person.Person p 
ON c.PersonID = p.BusinessEntityID
INNER JOIN
(SELECT Annual.CustomerID AS CustomerID,MAX(Annual.Purchase) AS HighestAnnualPurchase
FROM (SELECT CustomerID AS CustomerID,SUM(TotalDue) as Purchase
	  FROM Sales.SalesOrderHeader soh
      GROUP BY CustomerID, YEAR(DueDate)) AS Annual
GROUP BY Annual.CustomerID) AS Annual_Highest
ON soh.CustomerID = Annual_Highest.CustomerID
GROUP BY soh.CustomerID, p.LastName, p.FirstName,Annual_Highest.HighestAnnualPurchase
HAVING SUM(TotalDue) > 500000
ORDER BY SUM(TotalDue) DESC

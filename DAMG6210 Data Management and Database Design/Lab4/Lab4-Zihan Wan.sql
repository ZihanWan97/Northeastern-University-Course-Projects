--Part A
CREATE DATABASE wzh;
GO
USE wzh;
CREATE TABLE dbo.TargetCustomers
(
	TargetID varchar(5) NOT NULL PRIMARY KEY,
	FirstName varchar(40) NOT NULL,
	LastName varchar(40) NOT NULL,
	Address varchar(100) NOT NULL,
	City varchar(40) NOT NULL,
	State varchar(40) NOT NULL,
	ZipCode varchar(20) NOT NULL
);
CREATE TABLE MailingLists
(
	MailingListID int IDENTITY NOT NULL PRIMARY KEY,
	MailingList varchar(100) NOT NULL
);
CREATE TABLE TargetMailingLists
(
	TargetID varchar(5) NOT NULL REFERENCES dbo.TargetCustomers(TargetID),
	MailingListID int NOT NULL REFERENCES dbo.MailingLists(MailingListID),
	PRIMARY KEY(TargetID, MailingListID)
);



USE AdventureWorks2008R2;


--Part B
--B-1
SELECT DISTINCT h.CustomerID,
	   STUFF((SELECT ', ' + RTRIM(ISNULL(CAST(SalesPersonID AS varchar),''))
	   FROM Sales.SalesOrderHeader 
	   WHERE CustomerID = c.CustomerID 
	   GROUP BY CustomerID,SalesPersonID 
	   ORDER BY SalesPersonID 
	   FOR XML PATH('')),1,2,'') AS [SalesPerson ID]
FROM Sales.SalesOrderHeader h
JOIN Sales.Customer c ON h.CustomerID = c.CustomerID 
ORDER BY CustomerID DESC;

--B-2
WITH temp AS
(SELECT YEAR(OrderDate) AS [Year],
	   ProductID,
	   RANK() OVER(PARTITION BY YEAR(OrderDate) ORDER BY SUM(OrderQty) DESC) AS [Ranking],SUM(OrderQty) AS [Qty]
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID 
GROUP BY YEAR(OrderDate),ProductID)

SELECT temp.Year,
	   CAST(ROUND(CAST(SUM(QTY) AS decimal)/CAST(Total.TotalQty AS decimal),11,1)*100 AS decimal(13,11)) AS [% of Total Sale],
	   String_AGG(CAST(ProductID AS varchar),', ') AS [Top5Products]
FROM temp
JOIN (SELECT YEAR(OrderDate) AS [Year],SUM(OrderQty) AS [TotalQty]
	  FROM Sales.SalesOrderDetail sod
      JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID 
      GROUP BY YEAR(OrderDate)) AS Total ON temp.Year = Total.Year
WHERE Ranking <= 5
GROUP BY temp.Year,Total.TotalQty
ORDER BY temp.Year;


--Part C
WITH Parts(AssemblyID, ComponentID, PerAssemblyQty, EndDate, ComponentLevel) 
AS (
SELECT b.ProductAssemblyID, b.ComponentID, b.PerAssemblyQty, b.EndDate, 0 AS ComponentLevel
FROM Production.BillOfMaterials AS b 
WHERE b.ProductAssemblyID = 992 AND b.EndDate IS NULL
UNION ALL
SELECT bom.ProductAssemblyID, bom.ComponentID, p.PerAssemblyQty, bom.EndDate, ComponentLevel + 1
FROM Production.BillOfMaterials AS bom 
INNER JOIN Parts AS p ON bom.ProductAssemblyID = p.ComponentID AND bom.EndDate IS NULL
),
Price AS(SELECT AssemblyID, ComponentID, Name, PerAssemblyQty, ComponentLevel,pr.ListPrice 
FROM Parts AS p 
INNER JOIN Production.Product AS pr ON p.ComponentID = pr.ProductID
)

SELECT 
(SELECT ListPrice FROM Price WHERE ComponentID = 815)
-(SELECT SUM(ListPrice) FROM Price GROUP BY AssemblyID HAVING AssemblyID = 815) 
AS [CostReduction]

--Lab4 Part a Solutions
create table dbo.TargetCustomers
(
    TargetID int identity not null primary key, --it is okay to use varchar instead of int
    FirstName nvarchar(40) not null,
    LastName nvarchar(40) not null,
    Address nvarchar(200) not null,
    City nvarchar(40) not null,
    State nvarchar(40) not null,
    ZipCode nvarchar(40) not null
);

create table dbo.MailingLists
(
    MailingListID int identity not null primary key,
    MailingList nvarchar(200) not null,
);

create table dbo.TargetMailingLists
(
    TargetID int not null references dbo.TargetCustomers(TargetID),
    MailingListID int not null references dbo.MailingLists(MailingListID)
    constraint PKItem primary key clustered (TargetID, MailingListID)
);
-- Lab 4 Part b and c Solutions

-- Part B

-- B-1

Use AdventureWorks2008R2;
SELECT distinct c.CustomerID,
COALESCE( STUFF((SELECT  distinct ', '+RTRIM(CAST(SalesPersonID as char))  
       FROM Sales.SalesOrderHeader 
       WHERE CustomerID = c.customerid
       FOR XML PATH('')) , 1, 2, '') , '')  AS SalesPersons
FROM Sales.Customer c
left join Sales.SalesOrderHeader oh on c.customerID = oh.CustomerID
order by c.CustomerID desc;


-- B-2

WITH Temp1 AS

   (select year(OrderDate) Year, ProductID, sum(OrderQty) ttl,
    rank() over (partition by year(OrderDate) order by sum(OrderQty) desc) as TopProduct
    from Sales.SalesOrderHeader sh
	join Sales.SalesOrderDetail sd
	on sh.SalesOrderID = sd.SalesOrderID
    group by year(OrderDate), ProductID) ,

Temp2 AS

   (select year(OrderDate) Year, sum(OrderQty) ttl
    from Sales.SalesOrderHeader sh
	join Sales.SalesOrderDetail sd
	on sh.SalesOrderID = sd.SalesOrderID
    group by year(OrderDate))

select t1.Year, cast(sum(t1.ttl) as decimal) / t2.ttl * 100 [% of Total Sale],

STUFF((SELECT  ', '+RTRIM(CAST(ProductID as char))  
       FROM temp1 
       WHERE Year = t1.Year and TopProduct <=5
       FOR XML PATH('')) , 1, 2, '') AS Top5Products

from temp1 t1
join temp2 t2
on t1.Year=t2.Year
where t1.TopProduct <= 5
group by t1.Year, t2.ttl;





-- Part C

IF OBJECT_ID('tempdb..#TempTable') IS NOT NULL
DROP TABLE #TempTable;

WITH Parts(AssemblyID, ComponentID, PerAssemblyQty, EndDate, ComponentLevel) AS
(
    -- Top-level compoments
	SELECT b.ProductAssemblyID, b.ComponentID, b.PerAssemblyQty,
        b.EndDate, 0 AS ComponentLevel
    FROM Production.BillOfMaterials AS b
    WHERE b.ProductAssemblyID = 992
          AND b.EndDate IS NULL

    UNION ALL

	-- All other sub-compoments
    SELECT bom.ProductAssemblyID, bom.ComponentID, p.PerAssemblyQty,
        bom.EndDate, ComponentLevel + 1
    FROM Production.BillOfMaterials AS bom 
        INNER JOIN Parts AS p
        ON bom.ProductAssemblyID = p.ComponentID
        AND bom.EndDate IS NULL
)
SELECT AssemblyID, ComponentID, Name, ListPrice, PerAssemblyQty, 
       ListPrice * PerAssemblyQty SubTotal, ComponentLevel

into #TempTable

FROM Parts AS p
    INNER JOIN Production.Product AS pr
    ON p.ComponentID = pr.ProductID
ORDER BY ComponentLevel, AssemblyID, ComponentID;


SELECT
	(SELECT ListPrice
	FROM #TempTable
	WHERE ComponentLevel = 0 and ComponentID = 815)
	-
	(SELECT SUM(ListPrice)
	FROM #TempTable
	WHERE ComponentLevel = 1 and AssemblyID = 815) AS 'Price Difference';



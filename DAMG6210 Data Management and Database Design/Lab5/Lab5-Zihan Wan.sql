USE wzh;


--5-1
CREATE FUNCTION dbo.GetTotalSale
(@Year int, @Month int) 
RETURNS INT
AS 
BEGIN 
	DECLARE @TotalSale INT;
	SELECT @TotalSale = ISNULL(SUM(s.TotalDue),0)
	FROM AdventureWorks2008R2.Sales.SalesOrderHeader s
	WHERE YEAR(OrderDate) = @Year AND MONTH(OrderDate) = @Month
	RETURN @TotalSale;
END
-- Execute the new function
SELECT dbo.GetTotalSale(2006,4);






--5-2
CREATE TABLE DateRange
(DateID INT IDENTITY, 
DateValue DATE, 
Month INT, 
DayOfWeek INT);


CREATE PROCEDURE GetDateRange
	 @StartDate date, 
	 @NumberOfDays int
AS 
BEGIN
	DECLARE @DateList TABLE (DateID INT, DateValue DATE, MONTH INT, DayOfWeek INT) 
	DECLARE @Counter int = 0;
	WHILE (@Counter < @NumberOfDays) 
	BEGIN 
		INSERT INTO @DateList 
			VALUES(@Counter + 1,
				   DATEADD(DAY, @Counter, @StartDate), 
				   DATEPART(MONTH,DATEADD(DAY, @Counter, @StartDate)), 
                   DATEPART(WEEKDAY,DATEADD(DAY, @Counter, @StartDate)));
		SET @Counter += 1;
	END
	SELECT * FROM @DateList
END 

DECLARE @StartDate date; 
DECLARE  @NumberOfDays int;
SET  @StartDate = '1997-06-14';
SET  @NumberOfDays = 173;
EXEC GetDateRange @StartDate, @NumberOfDays;





--5-3
CREATE TABLE Customer 
(CustomerID VARCHAR(20) PRIMARY KEY, 
CustomerLName VARCHAR(30), 
CustomerFName VARCHAR(30),
CustomerStatus VARCHAR(10));

CREATE TABLE SaleOrder 
(OrderID INT IDENTITY PRIMARY KEY,
CustomerID VARCHAR(20) REFERENCES Customer(CustomerID), 
OrderDate DATE,
OrderAmountBeforeTax INT);

CREATE TABLE SaleOrderDetail 
(OrderID INT REFERENCES SaleOrder(OrderID), 
ProductID INT, 
Quantity INT, 
UnitPrice INT,
PRIMARY KEY (OrderID, ProductID));


CREATE TRIGGER CustomerStatusPreferred
ON SaleOrder
AFTER INSERT,UPDATE,DELETE
AS
BEGIN
	DECLARE @CustomerID varchar(20);
    DECLARE @Total INT;

    SELECT @CustomerID = ISNULL(i.CustomerID, d.CustomerID)
	FROM INSERTED i
	FULL OUTER JOIN DELETED d ON D.CustomerID = d.CustomerID;

	SELECT @Total = SUM(OrderAmountBeforeTax) 
	FROM SaleOrder 
	WHERE CustomerID = @CustomerID;

	IF @Total > 5000
	BEGIN
		UPDATE Customer 
		SET CustomerStatus = 'Preferred'
		WHERE CustomerID = @CustomerID
	END
	ELSE
	BEGIN 
		UPDATE Customer 
		SET CustomerStatus = NULL
		WHERE CustomerID = @CustomerID
	END
END


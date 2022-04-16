
-- Lab 5 Solutions

--Q1

create function ufSalesByMonthYear
(@month int, @year int)
returns money
As
Begin 
	Declare @sale money;
	select @sale = isnull( sum(TotalDue) , 0)
	   from sales.SalesOrderHeader
	   where month(orderDate) = @month AND year(OrderDate) = @year
	return @sale;
End
	

-- Q2

CREATE TABLE DateRange
(DateID INT IDENTITY,
 DateValue DATE,
 Month INT,
 DayOfWeek INT);

create procedure dbo.uspFillDateRange
@startDate date,
@daysAfter int
AS BEGIN
	Declare @counter int = 0;
	declare @tempdate date;
	while (@counter < @daysAfter)
	Begin 
	    set @tempdate = DATEADD(dd, @counter, @startDate);
		Insert into dbo.DateRange (DateValue, month, DayOfWeek)
			values( @tempdate, month(@tempdate), DATEPART(dw, @tempdate));
			set @counter += 1;
	End
	Return;
End
Go


--Q3

Create trigger trUpdateCustomerStatus
on dbo.saleOrder
after INSERT, UPDATE, DELETE
As begin
	declare @total money = 0;
	declare @custid varchar(20);
	declare @status varchar(10);

	select @custid = isnull (i.CustomerID, d.CustomerID)
	   from inserted i full join deleted d 
	   on i.CustomerID = d.CustomerID;

	select @total = sum(OrderAmountBeforeTax)
	   from saleOrder
   	   where CustomerID = @custid;

	if @total > 5000
		set @status = 'preferred'
	else
		set @status = 'regular';

	update Customer
		set CustomerStatus = @status
		where CustomerID = @custid 
end


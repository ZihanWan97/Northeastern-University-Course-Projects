
-- 2, 4, 8

-- Question 1 (4 points)

with temp
as
 (select datepart(yy, OrderDate) Year,
         TerritoryID,
         cast(sum(TotalDue) as int) as TotalSales
  from Sales.SalesOrderHeader
  where year(OrderDate) in (2006, 2007, 2008) and TerritoryID between 1 and 5
  group by TerritoryID,  datepart(yy, OrderDate)
  having sum(TotalDue) > 3000000)

select Year, 'Total Sales' as 'Territory',
       case when [1] is null then '' else cast([1] as varchar(15)) end '1', 
       case when [2] is null then '' else cast([2] as varchar(15)) end '2',
	   case when [3] is null then '' else cast([3] as varchar(15)) end '3',
	   case when [4] is null then '' else cast([4] as varchar(15)) end '4',
	   case when [5] is null then '' else cast([5] as varchar(15)) end '5'
from
( select year, TerritoryID, totalsales from temp) vertical
pivot
(max(TotalSales) for TerritoryID in ([1], [2], [3], [4], [5])) horizontal;


-- Question 2 (5 points)

with temp as
(select CustomerID, TotalDue,
        dense_rank() over (partition by CustomerID order by TotalDue desc) Ranking
 from Sales.SalesOrderHeader),

ttl as
(select CustomerID, sum(TotalDue) Total,
        rank() over (order by sum(TotalDue) desc) RankingT
 from Sales.SalesOrderHeader
 group by CustomerID),

cmp as
 (select CustomerID, sum(TotalDue) Top3Total
  from temp
  where Ranking <= 3
  group by CustomerID)

select  t.CustomerID, cast(Total as int) TotalPurchase,
	STUFF((SELECT ', ' + cast(round(TotalDue, 2) as varchar(12)) 
		   FROM temp 
		   WHERE CustomerID = t.CustomerID and Ranking <=3
		   ORDER BY TotalDue desc
		   FOR XML PATH('')) , 1, 2, '') AS 'Top 3 Order Values' ,
	Top3Total/Total * 100 Percentage
from ttl t
join cmp
on cmp.CustomerID = t.CustomerID
where RankingT <= 3
order by t.CustomerID;


-- Question 3 (6 points)

create function ufCheckRule
(@drid int, @d date)
 returns smallint
 as
 begin
    declare @flag smallint, @a smallint, @rc smallint;

	select @rc = count(DoctorID) 
	from Appointment
	where DoctorID = @drid and AppointmentDate = @d;

	select @a = count(DateAvailable) 
	from DoctorAvailability 
	where DoctorID = @drid and DateAvailable = @d;

    if @rc > 25 or @a = 0
    set @flag = 1
    else set @flag = 0

	return @flag
 end

ALTER TABLE Appointment ADD CONSTRAINT AppRule 
CHECK (dbo.ufCheckRule(DoctorID, AppointmentDate) = 0);


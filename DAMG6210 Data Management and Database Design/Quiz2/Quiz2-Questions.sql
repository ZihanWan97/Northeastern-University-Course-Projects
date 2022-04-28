-- 3rd Last Digit of NUID 2, 4, or 8

-- Your Name:
-- Your NUID:

-- Question 1 (4 points)

/* Rewrite the following query to present the same data in a horizontal format,
   as listed below, using the SQL PIVOT command. 
   Please use AdventureWorks2008R2 for this question. */

select datepart(yy, OrderDate) Year,
       TerritoryID,
       cast(sum(TotalDue) as int) as TotalSales
from Sales.SalesOrderHeader
where year(OrderDate) in (2006, 2007, 2008) and TerritoryID between 1 and 5
group by TerritoryID,  datepart(yy, OrderDate)
having sum(TotalDue) > 3000000;

/*
Year	Territory	1		2		3		4		5
2006	Total Sales	4855977					8489321	3179192
2007	Total Sales	6447527	3232129	3389909	9960675	
2008	Total Sales	4396271					5810707	
*/




-- Question 2 (5 points)

/*
Using AdventureWorks2008R2, write a query to retrieve 
the customers and their order info.

Return the customer id, a customer's total purchase, 
the top 3 order values of a customer, and the total of
the top 3 order values of a customer as a percentage of
the customer's total purchase. 

The top 3 order values are the 3 highest order values. 
Use TotalDue in SalesOrderHeader as the order value. 
Please keep in mind it's the order value and several orders 
may have the same value. 

Return only the top 3 customers. The top 3 customers
have the 3 highest total purchase values. If there is a tie,
the tie needs to be retrieved.

Sort the returned data by CustomerID. Return the data in
the format specified below.
*/

/*
CustomerID	TotalPurchase	Top 3 Order Values					Percentage
	29715	961676			126992.22, 110338.50, 108152.52		35.92
	29722	954022			109340.82, 101001.82, 100723.86		32.60
	29818	989184			124249.49, 120955.89, 105415.70		35.44
*/




-- Question 3 (6 points)

/*
There is a business rule that a doctor will not see more than
25 patients per day for the dates the doctor works. A doctor doesn't
work everyday. The dates a doctor works are listed in the
DoctorAvailability table.

Given the following 4 tables, please write a SINGLE Table-Level
CHECK constraint which is based on a SINGLE function to implement 
the business rule.
*/
CREATE TABLE Doctor
(DoctorID INT PRIMARY KEY,
 LastName VARCHAR(50),
 FirsName VARCHAR(50),
 Email VARCHAR(30),
 Phone VARCHAR(20));

CREATE TABLE Patient
(PatientID INT PRIMARY KEY,
 LastName VARCHAR(50),
 FirsName VARCHAR(50),
 Email VARCHAR(30),
 Phone VARCHAR(20));

CREATE TABLE DoctorAvailability
(DoctorID INT REFERENCES Doctor(DoctorID),
 DateAvailable DATE
 PRIMARY KEY (DoctorID, DateAvailable));

CREATE TABLE Appointment
(PatientID INT REFERENCES Patient(PAtientID),
 DoctorID INT REFERENCES Doctor(DoctorID),
 AppointmentDate DATE,
 AppointmentTime time
 PRIMARY KEY (PatientID, DoctorID, AppointmentDAte));






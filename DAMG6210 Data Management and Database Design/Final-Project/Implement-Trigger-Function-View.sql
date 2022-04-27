--USE Team81;
USE Team8Test;
/*
* This file is used to create tables.
* PersonalInformation.Age is Computed Columns based on a function.
* PersonalInformation.SSN is Column Data Encryption.
* At the end of this file is Table-level CHECK Constraints based on a function.
*/

/*
*  The 1st part is used to create tables.
*/

-- dbo.Address definition

-- Drop table

-- DROP TABLE dbo.Address;

CREATE TABLE dbo.Address (
	address_id int IDENTITY(1,1) NOT NULL,
	address_line1 varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	address_line2 varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	zip varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	city varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	state varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Address__CAA247C8DEEEFAF0 PRIMARY KEY (address_id)
);


-- dbo.ContractType definition

-- Drop table

-- DROP TABLE dbo.ContractType;

CREATE TABLE dbo.ContractType (
	id int IDENTITY(1,1) NOT NULL,
	[type] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT ContractType_PK PRIMARY KEY (id)
);


-- dbo.CustomerType definition

-- Drop table

-- DROP TABLE dbo.CustomerType;

CREATE TABLE dbo.CustomerType (
	id int IDENTITY(1,1) NOT NULL,
	[type] varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Customer__3213E83FE08B9EDC PRIMARY KEY (id)
);


-- dbo.Department definition

-- Drop table

-- DROP TABLE dbo.Department;

CREATE TABLE dbo.Department (
	id int IDENTITY(1,1) NOT NULL,
	name varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Departme__3213E83F84A5D0E0 PRIMARY KEY (id)
);


-- dbo.Floorplan definition

-- Drop table

-- DROP TABLE dbo.Floorplan;

CREATE TABLE dbo.Floorplan (
	id int IDENTITY(1,1) NOT NULL,
	bedroom_count int NOT NULL,
	bathroom_count int NOT NULL,
	livingroom_count int NOT NULL,
	CONSTRAINT PK__Floorpla__3213E83F36F925F1 PRIMARY KEY (id)
);


-- dbo.FunctionType definition

-- Drop table

-- DROP TABLE dbo.FunctionType;

CREATE TABLE dbo.FunctionType (
	id int IDENTITY(1,1) NOT NULL,
	[type] varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	description varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Function__3213E83F7B742CF5 PRIMARY KEY (id)
);
ALTER TABLE dbo.FunctionType WITH NOCHECK ADD CONSTRAINT CK__FunctionTy__type__5224328E CHECK ([type]='heating repair' OR [type]='alarm repair' OR [type]='water' OR [type]='electrical' OR [type]='roof repair' OR [type]='pest control' OR [type]='cleaning' OR [type]='plumbing' OR [type]='security' OR [type]='appliance repair ');


-- dbo.[Group] definition

-- Drop table

-- DROP TABLE dbo.[Group];

CREATE TABLE dbo.[Group] (
	id int IDENTITY(1,1) NOT NULL,
	[size] int NOT NULL,
	CONSTRAINT PK__Group__3213E83F0616041F PRIMARY KEY (id)
);


-- dbo.Building definition

-- Drop table

-- DROP TABLE dbo.Building;

CREATE TABLE dbo.Building (
	id int IDENTITY(1,1) NOT NULL,
	group_id int NOT NULL,
	construction_time date NOT NULL,
	utility int NOT NULL,
	address_id int NOT NULL,
	total_parking int NOT NULL,
	CONSTRAINT PK__Building__3213E83F7D79082C PRIMARY KEY (id),
	CONSTRAINT FK__Building__addres__47A6A41B FOREIGN KEY (address_id) REFERENCES dbo.Address(address_id),
	CONSTRAINT FK__Building__group___2F10007B FOREIGN KEY (group_id) REFERENCES dbo.[Group](id)
);
ALTER TABLE dbo.Building WITH NOCHECK ADD CONSTRAINT CK__Building__utilit__2B3F6F97 CHECK ([utility]=(1) OR [utility]=(0));


-- dbo.Parking definition

-- Drop table

-- DROP TABLE dbo.Parking;

CREATE TABLE dbo.Parking (
	id int IDENTITY(1,1) NOT NULL,
	availability int NOT NULL,
	building_id int NOT NULL,
	vehicle_plate_number varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	location varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK__Parking__3213E83F1E4D5D77 PRIMARY KEY (id),
	CONSTRAINT FK__Parking__buildin__2C3393D0 FOREIGN KEY (building_id) REFERENCES dbo.Building(id)
);
ALTER TABLE dbo.Parking WITH NOCHECK ADD CONSTRAINT CK__Parking__availab__286302EC CHECK ([availability]=(1) OR [availability]=(0));


-- dbo.PersonalInformation definition

-- Drop table

-- DROP TABLE dbo.PersonalInformation;

CREATE TABLE dbo.PersonalInformation (
	id int IDENTITY(1,1) NOT NULL,
	first_name varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Last_name varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	gender varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	DOB date NOT NULL,
	Age AS (datediff(hour,[DOB],getdate())/(8766)),
	phone varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	email varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	address_id int NULL,
	SSN varbinary(250) NULL,
	CONSTRAINT PK__Personal__3213E83FB03E7FD7 PRIMARY KEY (id),
	CONSTRAINT FK__PersonalI__addre__3C69FB99 FOREIGN KEY (address_id) REFERENCES dbo.Address(address_id)
);


-- dbo.Room definition

-- Drop table

-- DROP TABLE dbo.Room;

CREATE TABLE dbo.Room (
	id int IDENTITY(1,1) NOT NULL,
	floorplan_id int NULL,
	building_id int NULL,
	furnished int NULL,
	laundry int NULL,
	floor int NULL,
	room_number int NULL,
	orientation varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	avaliable int DEFAULT 1 NULL,
	available_date date NULL,
	minimum_tenancy int NOT NULL,
	maximum_tenancy int NOT NULL,
	rent money NOT NULL,
	CONSTRAINT PK__Room__3213E83FAF7DD379 PRIMARY KEY (id),
	CONSTRAINT FK__Room__building_i__49C3F6B7 FOREIGN KEY (building_id) REFERENCES dbo.Building(id),
	CONSTRAINT FK__Room__floorplan___48CFD27E FOREIGN KEY (floorplan_id) REFERENCES dbo.Floorplan(id)
);
ALTER TABLE dbo.Room WITH NOCHECK ADD CONSTRAINT CK__Room__furnished__4BAC3F29 CHECK ([furnished]=(1) OR [furnished]=(0));
ALTER TABLE dbo.Room WITH NOCHECK ADD CONSTRAINT CK__Room__laundry__4CA06362 CHECK ([laundry]=(1) OR [laundry]=(0));
ALTER TABLE dbo.Room WITH NOCHECK ADD CONSTRAINT CK__Room__orientatio__4D94879B CHECK ([orientation]='SOUTH' OR [orientation]='NORTH' OR [orientation]='WEST' OR [orientation]='EAST');


-- dbo.ServiceCompanies definition

-- Drop table

-- DROP TABLE dbo.ServiceCompanies;

CREATE TABLE dbo.ServiceCompanies (
	id int IDENTITY(1,1) NOT NULL,
	name varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	function_id int NULL,
	average_fee money NULL,
	evaluation float NULL,
	CONSTRAINT PK__ServiceC__3213E83FD57644BB PRIMARY KEY (id),
	CONSTRAINT FK__ServiceCo__funct__4316F928 FOREIGN KEY (function_id) REFERENCES dbo.FunctionType(id)
);


-- dbo.Staff definition

-- Drop table

-- DROP TABLE dbo.Staff;

CREATE TABLE dbo.Staff (
	id int IDENTITY(1,1) NOT NULL,
	group_id int NOT NULL,
	department_id int NOT NULL,
	info_id int NOT NULL,
	salary decimal(18,0) NOT NULL,
	CONSTRAINT PK__Staff__3213E83FB1F7222F PRIMARY KEY (id),
	CONSTRAINT FK__Staff__departmen__35BCFE0A FOREIGN KEY (department_id) REFERENCES dbo.Department(id),
	CONSTRAINT FK__Staff__group_id__34C8D9D1 FOREIGN KEY (group_id) REFERENCES dbo.[Group](id),
	CONSTRAINT FK__Staff__info_id__3D5E1FD2 FOREIGN KEY (info_id) REFERENCES dbo.PersonalInformation(id)
);


-- dbo.Customer definition

-- Drop table

-- DROP TABLE dbo.Customer;

CREATE TABLE dbo.Customer (
	id int IDENTITY(1,1) NOT NULL,
	info_id int NULL,
	[type] int NULL,
	CONSTRAINT PK__Customer__3213E83F8D965927 PRIMARY KEY (id),
	CONSTRAINT FK__Customer__info_i__5441852A FOREIGN KEY (info_id) REFERENCES dbo.PersonalInformation(id),
	CONSTRAINT FK__Customer__type__5535A963 FOREIGN KEY ([type]) REFERENCES dbo.CustomerType(id)
);


-- dbo.MaintenanceHistory definition

-- Drop table

-- DROP TABLE dbo.MaintenanceHistory;

CREATE TABLE dbo.MaintenanceHistory (
	id int IDENTITY(1,1) NOT NULL,
	service_company_id int NULL,
	maintaining_detail varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	start_date date NOT NULL,
	end_date date NULL,
	fee money NOT NULL,
	score int NOT NULL,
	room_id int NULL,
	CONSTRAINT PK__Maintena__3213E83FA1FD1F8A PRIMARY KEY (id),
	CONSTRAINT FK__Maintenan__room___4E53A1AA FOREIGN KEY (room_id) REFERENCES dbo.Room(id),
	CONSTRAINT FK__Maintenan__servi__45F365D3 FOREIGN KEY (service_company_id) REFERENCES dbo.ServiceCompanies(id)
);


-- dbo.VisitingHistory definition

-- Drop table

-- DROP TABLE dbo.VisitingHistory;

CREATE TABLE dbo.VisitingHistory (
	id int IDENTITY(1,1) NOT NULL,
	room_id int NOT NULL,
	custom_id int NOT NULL,
	[date] date NOT NULL,
	CONSTRAINT VisitingHistory_PK PRIMARY KEY (id),
	CONSTRAINT VisitingHistory_FK FOREIGN KEY (room_id) REFERENCES dbo.Room(id),
	CONSTRAINT VisitingHistory_FK_1 FOREIGN KEY (custom_id) REFERENCES dbo.Customer(id)
);


-- dbo.Application definition

-- Drop table

-- DROP TABLE dbo.Application;

CREATE TABLE dbo.Application (
	id int IDENTITY(1,1) NOT NULL,
	room_id int NOT NULL,
	customer_id int NOT NULL,
	move_in_date date NOT NULL,
	expected_tenancy int NOT NULL,
	income_monthly money NOT NULL,
	occupation varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	application_date date NOT NULL,
	isValid int DEFAULT 0 NULL,
	CONSTRAINT Application_PK PRIMARY KEY (id),
	CONSTRAINT Application_FK FOREIGN KEY (room_id) REFERENCES dbo.Room(id),
	CONSTRAINT Application_FK_1 FOREIGN KEY (customer_id) REFERENCES dbo.Customer(id)
);


-- dbo.Contract definition

-- Drop table

-- DROP TABLE dbo.Contract;

CREATE TABLE dbo.Contract (
	id int IDENTITY(1,1) NOT NULL,
	room_id int NOT NULL,
	customer_id int NULL,
	start_date date NULL,
	end_date date NULL,
	rent money NULL,
	validity varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	service_fee money NULL,
	type_id int NULL,
	management_fee AS ([service_fee]*(0.1)),
	CONSTRAINT Contract_PK PRIMARY KEY (id),
	CONSTRAINT Contract_FK FOREIGN KEY (room_id) REFERENCES dbo.Room(id),
	CONSTRAINT Contract_FK_1 FOREIGN KEY (customer_id) REFERENCES dbo.Customer(id),
	CONSTRAINT Contract_FK_2 FOREIGN KEY (type_id) REFERENCES dbo.ContractType(id)
);
ALTER TABLE dbo.Contract WITH NOCHECK ADD CONSTRAINT AvailabilityEvaluation CHECK ([dbo].[CheckAvailability]([end_date])>=(0));


/*
* This is Table-level CHECK Constraints based on a function.
*/
CREATE FUNCTION CheckAvailability (@Sdate date)
RETURNS int
AS
BEGIN 
	DECLARE @BlankDays INT = 0;
	SELECT @BlankDays = DATEDIFF(DAY, available_date, end_date)
	FROM Contract c
	JOIN Room r
	ON r.id = c.room_id 
	RETURN @BlankDays
END

ALTER TABLE Contract 
ADD CONSTRAINT AvailabilityEvaluation CHECK (dbo.CheckAvailability(end_date)>=0);


--encryption key 
CREATE MASTER KEY ENCRYPTION 
BY PASSWORD = 'Team8Authority' 
   
CREATE CERTIFICATE EncryptPersonalInfo 
WITH SUBJECT = 'Team8Authority' 
  
CREATE SYMMETRIC KEY SSNEncryptionKey 
WITH ALGORITHM = AES_256 ENCRYPTION 
BY CERTIFICATE EncryptPersonalInfo 



/*
*  The 2nd part is used to add trigger.
*/
-- add a trigger on Application
CREATE TRIGGER [dbo].[updateAppkicationStatus] 
ON [dbo].[Application] 
AFTER INSERT,UPDATE
AS BEGIN 

	DECLARE @id int; 
	DECLARE @move_in_date date; 
	DECLARE @expected_tenancy int; 
	DECLARE @income_monthly money; 
	DECLARE @occupation varchar(100); 
	DECLARE @minimum_tenancy int; 
	DECLARE @maximum_tenancy int; 
	DECLARE @avaliable_date date; 
	DECLARE @age int; 
	DECLARE @rent money; 


	SELECT @minimum_tenancy=r.minimum_tenancy,@maximum_tenancy=r.maximum_tenancy,@avaliable_date=r.available_date,@occupation=i.occupation,@income_monthly=i.income_monthly,@id=i.id,@age=p.Age,@expected_tenancy=i.expected_tenancy,@move_in_date=i.move_in_date,@rent=r.rent

	FROM dbo.Room r 
	FULL JOIN inserted i 
	ON i.room_id=r.id 
	FULL JOIN dbo.Customer c 
	ON i.customer_id=c.id 
	FULL JOIN dbo.PersonalInformation p 
	ON c.info_id=p.id 

	IF @expected_tenancy<=@maximum_tenancy AND @expected_tenancy>=@minimum_tenancy AND @move_in_date>=@avaliable_date 
	AND (@occupation='student' OR @income_monthly>=1.5*@rent) AND @age>=18
		UPDATE dbo.Application SET isValid=1 WHERE id=@id 

END ;


-- add a trigger on Contract
CREATE TRIGGER [dbo].[changeAvailableDate] 
ON [dbo].[Contract] 
AFTER INSERT,UPDATE 
AS BEGIN 
	DECLARE @room_id int; 
	DECLARE @end_date date;
	DECLARE @start_date date;
	DECLARE @contract_type int;
	DECLARE @customer_id int;
	DECLARE @available_date date;

	SELECT @room_id=ISNULL(i.room_id,d.room_id),@end_date=ISNULL(i.end_date,d.end_date),@start_date=ISNULL(i.start_date,d.start_date),
	@contract_type=ISNULL(i.type_id,d.type_id),@customer_id=ISNULL(i.customer_id,d.customer_id),@available_date=r.available_date

	FROM inserted i
	FULL JOIN deleted d
	ON i.room_id=d.room_id
	FULL JOIN dbo.Room r
	ON i.room_id=r.id

	IF(@contract_type=1)
	BEGIN
		IF EXISTS(SELECT room_id FROM INSERTED)
		BEGIN
			UPDATE dbo.Customer SET type=1 WHERE id=@customer_id
			IF(@available_date<DATEADD(day,1,@end_date))
				BEGIN
				UPDATE dbo.Room SET available_date=DATEADD(day,1,@end_date) WHERE id=@room_id
				END
		END
		ELSE
			UPDATE dbo.Room SET available_date=DATEADD(day,-1,@start_date) WHERE id=@room_id
	END
END;


--add a trigger on MaintenanceHistory
CREATE TRIGGER update_average_fee
ON MaintenanceHistory
AFTER INSERT, UPDATE, DELETE
AS BEGIN
	UPDATE ServiceCompanies 
	SET average_fee = (
		SELECT AVG(mh.fee)
		FROM MaintenanceHistory mh 
		WHERE ServiceCompanies.id = mh.service_company_id )
END;


--add a trigger on MaintenanceHistory
CREATE TRIGGER update_evaluation
ON MaintenanceHistory
AFTER INSERT, UPDATE, DELETE
AS BEGIN
	UPDATE ServiceCompanies 
	SET evaluation = (
		SELECT CAST(AVG(CONVERT(FLOAT, score)) AS DECIMAL(18,2)) 
		FROM MaintenanceHistory mh 
		WHERE ServiceCompanies.id = mh.service_company_id )
END;


--DROP TRIGGER addPerson;
--add a trigger on PersonalInformation
CREATE TRIGGER dbo.addPerson
ON dbo.PersonalInformation
INSTEAD OF INSERT 
AS BEGIN 
	DECLARE @first_name varchar(40), 
	@last_name varchar(40),   
	@gender varchar(40),   
	@DOB DATE,  
	@SSN varbinary,
	@phone varchar(40),   
	@email varchar(40),
	@address_id int  

	SELECT @first_name=i.first_name,@last_name=i.Last_name,@gender=i.gender,@DOB=i.DOB,@SSN=i.SSN,@phone=i.phone,@email=i.email,@address_id=i.address_id
	FROM inserted i;

	OPEN SYMMETRIC KEY SSNEncryptionKey  
	DECRYPTION BY CERTIFICATE EncryptPersonalInfo;  

	INSERT INTO dbo.PersonalInformation(first_name,last_name,gender,DOB,SSN,phone,email,address_id)  
	VALUES (@first_name,@last_name,@gender,@DOB,EncryptByKey(Key_GUID('SSNEncryptionKey')  
    , @ssn,1, HashBytes('SHA1', CONVERT(varbinary(250),@phone))),@phone,@email,@address_id);  
END;




/*
*  The 3rd part is used to add data.
*/

/*
 * Step 1 : insert data into Address
 */
INSERT INTO dbo.Address(address_line1, address_line2, zip, city, state)
VALUES 
	('244 Hanover St', null, '02113', 'Boston', 'MA'), 	--build 1 address apt
	('190 Pleasant St', null, '02148', 'Malden', 'MA'), --build 2 address apt
	('623 Carpenter Way', null, '02149', 'Boston', 'MA'), 		-- st
	('550 Park Ave', null, '02149', 'Boston', 'MA'),	 		-- st
	('27529 Mayer Trail', null, '02110', 'Boston', 'MA'),		-- st 
	('99896 Maywood Court', null, '02116', 'Boston', 'MA'),		-- st 
	('13 Dayton Crossing', null, '02108', 'Boston', 'MA'),		-- st 
	('9th ave ne', null, '02149', 'Malden', 'MA'), 				-- st 
	('06412 American Ash Trail', null, '02116', 'Malden', 'MA'), -- st 
	('5422 Scofield Parkway', null, '02116', 'Malden', 'MA'), 	-- st 
	('244 Hanover St', 'Apt.101', '02113', 'Boston', 'MA'), --r1 
	('244 Hanover St', 'Apt.102', '02113', 'Boston', 'MA'),
	('244 Hanover St', 'Apt.103', '02113', 'Boston', 'MA'),
	('244 Hanover St', 'Apt.104', '02113', 'Boston', 'MA'),
	('244 Hanover St', 'Apt.201', '02113', 'Boston', 'MA'),
	('244 Hanover St', 'Apt.202', '02113', 'Boston', 'MA'),
	('244 Hanover St', 'Apt.301', '02113', 'Boston', 'MA'),
	('244 Hanover St', 'Apt.302', '02113', 'Boston', 'MA'),
	('244 Hanover St', 'Apt.401', '02113', 'Boston', 'MA'),
	('244 Hanover St', 'Apt.402', '02113', 'Boston', 'MA'),
	('190 Pleasant St', 'Apt.101', '02148', 'Malden', 'MA'), --r2 
	('190 Pleasant St', 'Apt.102', '02148', 'Malden', 'MA'),
	('190 Pleasant St', 'Apt.103', '02148', 'Malden', 'MA'),
	('190 Pleasant St', 'Apt.104', '02148', 'Malden', 'MA'),
	('190 Pleasant St', 'Apt.201', '02148', 'Malden', 'MA'),
	('190 Pleasant St', 'Apt.202', '02148', 'Malden', 'MA'),
	('190 Pleasant St', 'Apt.301', '02148', 'Malden', 'MA'),
	('190 Pleasant St', 'Apt.302', '02148', 'Malden', 'MA'),
	('190 Pleasant St', 'Apt.401', '02148', 'Malden', 'MA'),
	('190 Pleasant St', 'Apt.402', '02148', 'Malden', 'MA'),
	('59 Clarendon St', null, '02116', 'Boston', 'MA'),   --build 3 address  -house
	('296 Columbus Ave', null, '02116', 'Boston', 'MA'),  --build 4 address  -house
	('43 Webster St', null, '02149', 'Everett', 'MA'),	  --build 5 address  -house
	('6 Ashland St', null, '02155', 'Medford', 'MA');	  --build 6 address  -house
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9 Canary Place', null, '02668', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('31 Ryan Crossing', null, '02462', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('07 Brickson Park Point', null, '02667', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('81 Sage Drive', null, '02673', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1 Bultman Parkway', null, '02670', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('75 Ilene Avenue', null, '02493', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9911 Pearson Avenue', null, '02790', 'Cambridge', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('41353 Westend Drive', null, '02670', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6 Leroy Court', null, '02668', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9678 Pepper Wood Pass', null, '02671', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4 Sunfield Road', null, '02191', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8 Heath Junction', null, '02663', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('76227 Forest Parkway', null, '02663', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('18 Fieldstone Avenue', null, '02576', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0 Clyde Gallagher Street', null, '02189', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('717 Clyde Gallagher Road', null, '02663', 'Revere', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('16 Pleasure Point', null, '02132', 'Chelsea', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('17 American Ash Court', null, '02481', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8684 Waxwing Avenue', null, '02576', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1306 Namekagon Park', null, '02672', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8883 Springview Parkway', null, '02670', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('83137 Fairfield Park', null, '02061', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('18 Fremont Drive', null, '02791', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('46 Lakewood Parkway', null, '02791', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('46 Mallard Circle', null, '02462', 'Revere', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4 Pleasure Center', null, '02670', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5 Eggendart Terrace', null, '02189', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('85608 Park Meadow Point', null, '02672', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4 Fair Oaks Way', null, '02191', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1 Talmadge Pass', null, '02132', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('572 Di Loreto Alley', null, '02132', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6 Vahlen Lane', null, '02189', 'Revere', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('10805 Hallows Avenue', null, '02132', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('18676 Express Terrace', null, '02061', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0613 Kings Plaza', null, '02791', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('234 Pierstorff Alley', null, '02671', 'Cambridge', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6 Erie Street', null, '02465', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5592 Everett Crossing', null, '02481', 'Revere', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2 Namekagon Street', null, '02190', 'Chelsea', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1497 Grover Street', null, '02575', 'Chelsea', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('68214 Wayridge Drive', null, '02379', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('57 Oakridge Road', null, '02668', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2 Londonderry Point', null, '02190', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('38 Atwood Circle', null, '02465', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3 Haas Junction', null, '02667', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('321 Maryland Junction', null, '02672', 'Cambridge', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('7 1st Plaza', null, '02667', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0889 Mallard Hill', null, '02667', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('49607 Spaight Avenue', null, '02191', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('854 Prairieview Road', null, '02132', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3917 Sauthoff Drive', null, '02671', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4093 New Castle Street', null, '02576', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('54831 Quincy Place', null, '02061', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('91369 Burrows Way', null, '02493', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6996 Bultman Drive', null, '02191', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4 Becker Point', null, '02575', 'Cambridge', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('833 Harbort Pass', null, '02669', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2296 Little Fleur Alley', null, '02090', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('48 David Lane', null, '02462', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('7839 Corry Plaza', null, '02669', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('00 Summerview Center', null, '02671', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('655 Melvin Pass', null, '02576', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('73 Troy Terrace', null, '02465', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('42 Milwaukee Street', null, '02791', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9 Fairfield Circle', null, '02191', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('7700 Laurel Avenue', null, '02670', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0 Larry Lane', null, '02465', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('162 Springview Trail', null, '02462', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('16 Debra Park', null, '02190', 'Revere', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('917 Garrison Road', null, '02672', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3 Upham Junction', null, '02673', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9 Walton Circle', null, '02673', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0585 Carey Court', null, '02190', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2 Gulseth Hill', null, '02670', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('810 Darwin Street', null, '02790', 'Revere', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('60 Sutherland Place', null, '02576', 'Revere', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('785 Emmet Parkway', null, '02190', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0 Thierer Street', null, '02670', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('57 Hallows Place', null, '02575', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('316 Drewry Parkway', null, '02791', 'Revere', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('744 Hoard Court', null, '02663', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('737 Paget Point', null, '02482', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2564 Sachs Road', null, '02061', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('11 Holy Cross Drive', null, '02190', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4 Starling Circle', null, '02575', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('978 Charing Cross Center', null, '02190', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('793 Knutson Junction', null, '02188', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('342 Sherman Street', null, '02090', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('27 Rowland Crossing', null, '02575', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('7 Hintze Way', null, '02061', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1634 Mendota Park', null, '02189', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('157 Manitowish Alley', null, '02465', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('93 Dahle Road', null, '02791', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('207 Commercial Street', null, '02575', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5 Springview Lane', null, '02671', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('51363 Annamark Way', null, '02482', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3 Colorado Trail', null, '02668', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5 Montana Drive', null, '02481', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2 Hallows Plaza', null, '02575', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('52 Armistice Parkway', null, '02669', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0155 Warbler Drive', null, '02791', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2083 Orin Center', null, '02090', 'Chelsea', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('124 Pepper Wood Park', null, '02671', 'Revere', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4 Stone Corner Parkway', null, '02575', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('79 Victoria Trail', null, '02668', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('7 Rigney Parkway', null, '02791', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3140 Schlimgen Parkway', null, '02465', 'Chelsea', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('66 Rutledge Circle', null, '02189', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('03 Toban Court', null, '02132', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5890 Derek Plaza', null, '02576', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('55 Mayer Hill', null, '02465', 'Chelsea', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1184 Ryan Court', null, '02575', 'Chelsea', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('912 Loftsgordon Plaza', null, '02673', 'Chelsea', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('32058 Redwing Alley', null, '02379', 'Chelsea', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('75 Welch Point', null, '02061', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5714 Merry Park', null, '02132', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('45 Weeping Birch Way', null, '02189', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('562 Northfield Court', null, '02673', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('60694 Roxbury Court', null, '02791', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('82 Armistice Drive', null, '02668', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5913 Mcguire Terrace', null, '02670', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6 Schlimgen Alley', null, '02379', 'Revere', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('95 Del Mar Road', null, '02668', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('64644 Northfield Alley', null, '02482', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5393 Grim Circle', null, '02673', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('52079 Londonderry Road', '7 Ronald Regan Parkway', '02462', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('933 Basil Alley', null, '02672', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9309 Homewood Pass', null, '02575', 'Chelsea', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('208 Morningstar Way', null, '02061', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0 Green Crossing', null, '02189', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('7 Fairfield Road', null, '02663', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('07383 Prentice Road', null, '02671', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('24954 Pearson Crossing', null, '02379', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('87 Green Hill', null, '02379', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('85 Waubesa Road', null, '02379', 'Cambridge', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('993 Butternut Point', null, '02190', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6684 Union Plaza', null, '02670', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8 Namekagon Way', null, '02671', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0129 Delladonna Road', null, '02465', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('25 Merry Center', null, '02671', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('95396 Ruskin Crossing', null, '02663', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('633 Waxwing Street', null, '02790', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('13091 Golf Pass', null, '02090', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('37 Melvin Hill', null, '02667', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1 Kedzie Plaza', null, '02189', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('20 Springview Circle', null, '02663', 'Quincy', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('90277 Larry Circle', null, '02575', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('53 Petterle Court', null, '02668', 'Cambridge', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('19002 Sherman Center', null, '02379', 'Chelsea', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('615 Victoria Crossing', null, '02790', 'Cambridge', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4349 Haas Avenue', null, '02132', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('21 Kennedy Street', null, '02576', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('93405 Moulton Hill', null, '02191', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('37806 Hayes Crossing', null, '02482', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('80 Anthes Lane', null, '02482', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('509 Messerschmidt Avenue', null, '02668', 'Cambridge', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1657 Elgar Court', null, '02190', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('71058 Spaight Trail', null, '02669', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0 Carioca Road', null, '02379', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('7700 Rigney Circle', null, '02669', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('7 Sachtjen Circle', null, '02481', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('655 Macpherson Pass', null, '02188', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9953 Heath Trail', null, '02462', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('042 Armistice Road', null, '02379', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1 Fairview Park', null, '02790', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3 Farmco Drive', null, '02132', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6 Hazelcrest Terrace', null, '02190', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('62 Del Sol Crossing', null, '02061', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('51 Elka Point', null, '02061', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('25551 West Pass', null, '02482', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8 Darwin Lane', null, '02575', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('30 Mandrake Place', null, '02090', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('36737 Lindbergh Court', null, '02667', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2938 Lakewood Gardens Avenue', null, '02669', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('660 Weeping Birch Street', null, '02493', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6 Hooker Lane', null, '02668', 'Cambridge', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8 Ohio Court', null, '02462', 'Revere', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('68352 Eastlawn Junction', null, '02790', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('810 Hoepker Place', null, '02663', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('213 Derek Street', null, '02673', 'Cambridge', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3 Elka Way', null, '02670', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2840 Glacier Hill Point', null, '02132', 'Brighton', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('95165 Dahle Crossing', null, '02575', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('63835 Sage Plaza', null, '02189', 'Cambridge', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('53 Buena Vista Avenue', null, '02061', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('00 Jenna Crossing', null, '02482', 'Chelsea', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('456 Monument Trail', null, '02669', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8 Anniversary Circle', null, '02481', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('71 Hollow Ridge Parkway', null, '02465', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('50 Granby Alley', null, '02671', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0096 Tennessee Court', null, '02671', 'Chelsea', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('75 Pepper Wood Lane', null, '02379', 'Allston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('86348 Hayes Trail', null, '02670', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1021 Nancy Road', null, '02669', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2 Vermont Way', null, '02465', 'Malden', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8 Merrick Avenue', null, '02188', 'Somerville', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('37107 Merchant Pass', null, '02189', 'Everett', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('47 Chive Parkway', null, '02791', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('81781 Jenifer Alley', null, '02673', 'Brookline', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('7 Heffernan Alley', null, '02481', 'Boston', 'MA');

--personal address
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('038 Troy Junction', null, '02669', 'Jamaica', 'NY');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0 Carberry Circle', 'Apt 8', '02482', 'Austin', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3 Express Place', 'Apt 8', '02575', 'Monroe', 'LA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9 Lakeland Circle', 'Apt 1', '02672', 'Pittsburgh', 'PA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6860 Crest Line Center', 'Apt 1', '02191', 'San Diego', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('915 Express Alley', 'Apt 7', '02672', 'Augusta', 'GA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1 Daystar Court', 'Apt 3', '02673', 'Minneapolis', 'MN');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1455 Artisan Terrace', 'Apt 2', '02791', 'Waterbury', 'CT');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5148 West Center', 'Apt 8', '02668', 'El Paso', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('7 Melvin Center', 'Apt 7', '02481', 'Clearwater', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6567 Waywood Street', 'Apt 6', '02188', 'Louisville', 'KY');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5 Derek Terrace', 'Apt 9', '02090', 'Elizabeth', 'NJ');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('276 Buhler Place', 'Apt 6', '02482', 'Aurora', 'IL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('44128 Declaration Trail', 'Apt 9', '02188', 'Santa Monica', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('85 Columbus Court', 'Apt 8', '02482', 'Pittsburgh', 'PA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('65 Ridgeview Center', 'Apt 6', '02667', 'Louisville', 'KY');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9 Independence Alley', null, '02188', 'Odessa', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('98989 Del Mar Lane', 'Apt 5', '02132', 'Indianapolis', 'IN');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('397 Moulton Hill', 'Apt 5', '02575', 'Tucson', 'AZ');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('25 Hudson Plaza', 'Apt 6', '02188', 'Miami', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1 Springview Terrace', 'Apt 2', '02673', 'Columbus', 'OH');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8551 Prairie Rose Circle', 'Apt 2', '02669', 'Atlanta', 'GA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('624 Monterey Road', 'Apt 4', '02575', 'Honolulu', 'HI');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('038 Clove Center', null, '02672', 'Oklahoma City', 'OK');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('60835 Sutteridge Street', 'Apt 8', '02482', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4 Esch Terrace', 'Apt 7', '02132', 'Bronx', 'NY');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('79 Heffernan Drive', null, '02671', 'Houston', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('83 Commercial Plaza', 'Apt 8', '02575', 'Des Moines', 'IA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6 Packers Way', 'Apt 4', '02061', 'Seattle', 'WA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('55 Bowman Place', 'Apt 7', '02465', 'Chicago', 'IL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('03018 Clarendon Park', 'Apt 6', '02575', 'Jacksonville', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('02118 Anderson Trail', 'Apt 6', '02188', 'Lakeland', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5705 Bartelt Court', 'Apt 9', '02465', 'Saint Petersburg', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5 Sheridan Circle', 'Apt 6', '02668', 'Houston', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('311 Hallows Road', 'Apt 7', '02576', 'Cleveland', 'OH');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('13498 Cottonwood Trail', null, '02668', 'Richmond', 'VA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9 Surrey Avenue', 'Apt 8', '02670', 'Miami', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('28 Westridge Road', null, '02790', 'Trenton', 'NJ');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8696 Holmberg Avenue', 'Apt 6', '02462', 'Birmingham', 'AL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('72 Loomis Street', 'Apt 3', '02465', 'Trenton', 'NJ');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('37 Westend Crossing', null, '02791', 'Rockville', 'MD');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('95577 Fremont Parkway', 'Apt 6', '02189', 'Montgomery', 'AL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('98 Buena Vista Way', 'Apt 4', '02667', 'Norman', 'OK');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('80 Judy Pass', 'Apt 3', '02671', 'Indianapolis', 'IN');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('7 Schiller Avenue', 'Apt 9', '02481', 'Cedar Rapids', 'IA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4229 Shelley Plaza', 'Apt 5', '02493', 'Columbia', 'MO');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('45145 David Place', 'Apt 6', '02061', 'Providence', 'RI');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('60 Leroy Terrace', 'Apt 9', '02465', 'Honolulu', 'HI');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2 Cherokee Street', 'Apt 7', '02667', 'Washington', 'DC');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1961 School Circle', 'Apt 8', '02790', 'Silver Spring', 'MD');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('80 Del Sol Avenue', 'Apt 9', '02663', 'Minneapolis', 'MN');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('06247 Hanover Point', null, '02132', 'Amarillo', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('62385 Kennedy Street', 'Apt 2', '02672', 'Lafayette', 'LA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('959 Nancy Pass', 'Apt 7', '02188', 'Phoenix', 'AZ');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8 Meadow Ridge Trail', null, '02669', 'Greensboro', 'NC');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8 5th Lane', 'Apt 1', '02493', 'Des Moines', 'IA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('83670 Memorial Trail', 'Apt 4', '02481', 'Reno', 'NV');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4492 Melvin Terrace', 'Apt 8', '02462', 'Philadelphia', 'PA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('756 American Trail', 'Apt 6', '02462', 'Las Cruces', 'NM');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5242 Green Way', null, '02482', 'Washington', 'DC');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('021 Melrose Point', 'Apt 8', '02791', 'Alexandria', 'VA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0 Novick Park', 'Apt 7', '02462', 'Anchorage', 'AK');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6794 Gerald Center', 'Apt 9', '02670', 'Spokane', 'WA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0 Schlimgen Alley', 'Apt 4', '02668', 'San Bernardino', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('11 Loftsgordon Place', 'Apt 9', '02465', 'Atlanta', 'GA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('298 Green Drive', 'Apt 9', '02576', 'Colorado Springs', 'CO');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('95319 Mockingbird Trail', 'Apt 4', '02673', 'Vancouver', 'WA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('904 Hovde Park', 'Apt 2', '02189', 'Cleveland', 'OH');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9840 Clyde Gallagher Way', 'Apt 1', '02090', 'Tacoma', 'WA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('52821 Graedel Plaza', 'Apt 9', '02576', 'Sarasota', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9096 Golden Leaf Crossing', 'Apt 6', '02673', 'Denver', 'CO');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2 Cordelia Parkway', 'Apt 5', '02190', 'Austin', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3 Pankratz Junction', 'Apt 2', '02670', 'Pittsburgh', 'PA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('985 Spohn Place', 'Apt 6', '02791', 'Washington', 'DC');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('550 Sauthoff Parkway', 'Apt 1', '02575', 'Salt Lake City', 'UT');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8 Gateway Road', 'Apt 1', '02673', 'Silver Spring', 'MD');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0247 American Drive', 'Apt 7', '02671', 'Roanoke', 'VA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('04665 International Center', 'Apt 2', '02189', 'Hartford', 'CT');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('93 Graceland Circle', 'Apt 9', '02189', 'Norfolk', 'VA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('72 Badeau Way', null, '02791', 'Mansfield', 'OH');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0265 Karstens Hill', 'Apt 6', '02668', 'Warren', 'OH');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1 Spaight Place', 'Apt 5', '02189', 'Fresno', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3 Graedel Avenue', 'Apt 6', '02188', 'Philadelphia', 'PA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4492 Montana Road', 'Apt 6', '02672', 'Chicago', 'IL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2237 Rutledge Park', 'Apt 9', '02663', 'Detroit', 'MI');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('45 Mcguire Hill', 'Apt 8', '02672', 'Independence', 'MO');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8353 Algoma Terrace', 'Apt 3', '02465', 'Tallahassee', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('958 Londonderry Drive', 'Apt 4', '02671', 'Pensacola', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('34 Sugar Street', null, '02190', 'Anaheim', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3 Westport Trail', 'Apt 2', '02482', 'Fort Collins', 'CO');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6 Lakewood Junction', 'Apt 2', '02669', 'Los Angeles', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4 American Ash Road', 'Apt 9', '02061', 'Topeka', 'KS');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2 Mccormick Trail', 'Apt 6', '02671', 'Odessa', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('72 Bartillon Lane', 'Apt 1', '02673', 'Chicago', 'IL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('216 Summer Ridge Avenue', 'Apt 5', '02671', 'Peoria', 'IL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0 Union Alley', null, '02673', 'Springfield', 'IL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('64867 Cambridge Drive', 'Apt 6', '02090', 'Philadelphia', 'PA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('27 1st Place', 'Apt 2', '02667', 'Littleton', 'CO');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('198 Summer Ridge Park', 'Apt 5', '02090', 'Kansas City', 'MO');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('30082 Springs Hill', 'Apt 2', '02132', 'Charlotte', 'NC');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('44 Ridgeway Lane', 'Apt 4', '02671', 'Pittsburgh', 'PA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3173 Burrows Street', 'Apt 2', '02667', 'Indianapolis', 'IN');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('95 Hoepker Terrace', 'Apt 2', '02465', 'Pompano Beach', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0 Park Meadow Junction', 'Apt 4', '02673', 'Sacramento', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('36 Stoughton Center', 'Apt 9', '02673', 'Phoenix', 'AZ');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('15 Division Parkway', 'Apt 7', '02191', 'Duluth', 'MN');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('481 Onsgard Trail', 'Apt 6', '02790', 'Milwaukee', 'WI');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('41 Annamark Court', 'Apt 3', '02465', 'Jackson', 'MS');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('70226 Mitchell Trail', 'Apt 9', '02576', 'Buffalo', 'NY');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('78467 Moulton Trail', 'Apt 8', '02671', 'Indianapolis', 'IN');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('24 Merrick Crossing', 'Apt 3', '02191', 'New Orleans', 'LA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('93302 Corry Terrace', null, '02190', 'Los Angeles', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('73 Londonderry Way', 'Apt 7', '02791', 'Dallas', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('031 Veith Court', 'Apt 8', '02493', 'Modesto', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5 Carberry Trail', 'Apt 3', '02493', 'Jackson', 'MS');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4895 Washington Terrace', 'Apt 2', '02191', 'Jamaica', 'NY');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('314 Maryland Alley', 'Apt 2', '02575', 'Chicago', 'IL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9 Messerschmidt Place', 'Apt 3', '02061', 'Canton', 'OH');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5089 Melvin Drive', 'Apt 2', '02189', 'Phoenix', 'AZ');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('98 Main Alley', 'Apt 1', '02465', 'Phoenix', 'AZ');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5 Golden Leaf Lane', 'Apt 5', '02790', 'San Jose', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('685 Old Shore Center', 'Apt 4', '02790', 'Dallas', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('81 3rd Court', 'Apt 2', '02379', 'Detroit', 'MI');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5949 Basil Place', 'Apt 5', '02132', 'El Paso', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9576 Park Meadow Avenue', 'Apt 2', '02465', 'San Rafael', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2 Bashford Parkway', 'Apt 2', '02191', 'Rockford', 'IL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('33 Grasskamp Crossing', 'Apt 9', '02482', 'Waco', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('256 Maple Wood Avenue', 'Apt 5', '02668', 'Colorado Springs', 'CO');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('7 Blue Bill Park Way', 'Apt 5', '02188', 'Pittsburgh', 'PA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0347 Blaine Terrace', 'Apt 4', '02061', 'Ogden', 'UT');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5169 Farragut Alley', 'Apt 2', '02061', 'Oakland', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('31 Mockingbird Plaza', 'Apt 7', '02191', 'Omaha', 'NE');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4549 Corry Avenue', 'Apt 4', '02669', 'Alexandria', 'LA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('24650 Coleman Point', 'Apt 8', '02673', 'Tulsa', 'OK');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('556 Barby Road', null, '02061', 'Minneapolis', 'MN');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1 Northfield Terrace', 'Apt 7', '02575', 'Missoula', 'MT');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('62 Hayes Way', 'Apt 5', '02576', 'Sarasota', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4632 Loomis Trail', 'Apt 7', '02191', 'Washington', 'DC');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9993 Hoard Avenue', null, '02670', 'Champaign', 'IL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('25206 Milwaukee Trail', 'Apt 5', '02671', 'Newark', 'NJ');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8560 Blaine Drive', 'Apt 3', '02481', 'Lubbock', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4 Park Meadow Point', 'Apt 7', '02672', 'Long Beach', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('834 Maywood Park', 'Apt 1', '02671', 'Tallahassee', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('44626 Jana Plaza', 'Apt 5', '02132', 'Young America', 'MN');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('19 Hagan Court', 'Apt 9', '02493', 'Philadelphia', 'PA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8522 Londonderry Street', 'Apt 1', '02673', 'Elizabeth', 'NJ');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('770 Manitowish Park', 'Apt 5', '02132', 'Pittsburgh', 'PA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('11877 New Castle Circle', 'Apt 6', '02132', 'Youngstown', 'OH');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('561 Hoard Crossing', 'Apt 9', '02669', 'Olympia', 'WA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8649 Merchant Lane', null, '02462', 'Seattle', 'WA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('02381 Autumn Leaf Junction', null, '02191', 'Columbus', 'OH');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('268 Nobel Place', 'Apt 9', '02667', 'Duluth', 'GA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('82 High Crossing Street', 'Apt 8', '02669', 'Cincinnati', 'OH');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('98243 Tennyson Parkway', 'Apt 8', '02482', 'San Diego', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('50024 Crownhardt Lane', 'Apt 3', '02462', 'San Jose', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('06 Michigan Park', 'Apt 5', '02132', 'Milwaukee', 'WI');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('17 Susan Avenue', 'Apt 2', '02188', 'Charlotte', 'NC');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('9141 Packers Place', 'Apt 5', '02189', 'Jersey City', 'NJ');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4 Meadow Vale Point', 'Apt 4', '02493', 'Orlando', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1758 Grim Center', 'Apt 9', '02673', 'Katy', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4 Grasskamp Lane', 'Apt 6', '02090', 'Columbus', 'OH');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('76 Redwing Court', 'Apt 9', '02670', 'Scottsdale', 'AZ');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('51811 Brown Place', 'Apt 1', '02190', 'Springfield', 'IL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4615 1st Plaza', 'Apt 6', '02191', 'Bismarck', 'ND');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5 Mccormick Avenue', 'Apt 7', '02576', 'Greensboro', 'NC');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8 1st Avenue', 'Apt 6', '02791', 'Boise', 'ID');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('22967 Tomscot Junction', 'Apt 9', '02090', 'Pensacola', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('52 Warner Lane', 'Apt 4', '02090', 'Frankfort', 'KY');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('55327 Lillian Lane', 'Apt 3', '02481', 'Naples', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('28302 Sunnyside Circle', 'Apt 1', '02670', 'Syracuse', 'NY');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6157 Drewry Point', 'Apt 5', '02671', 'Indianapolis', 'IN');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('89364 Loomis Trail', 'Apt 1', '02493', 'Bismarck', 'ND');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('74307 Valley Edge Hill', 'Apt 7', '02190', 'Missoula', 'MT');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('22 Luster Center', 'Apt 6', '02379', 'Baton Rouge', 'LA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('92 Lakewood Crossing', 'Apt 8', '02575', 'Saint Paul', 'MN');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('952 Autumn Leaf Hill', 'Apt 9', '02576', 'Fort Myers', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('494 Dwight Lane', 'Apt 4', '02790', 'Evansville', 'IN');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8846 Farragut Alley', 'Apt 3', '02673', 'Boston', 'MA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('59 Debs Center', 'Apt 1', '02668', 'Chesapeake', 'VA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('35116 Walton Trail', 'Apt 3', '02575', 'Salt Lake City', 'UT');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('562 Duke Point', 'Apt 9', '02790', 'Portland', 'OR');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('7 Hintze Way', 'Apt 5', '02481', 'Washington', 'DC');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3708 Sullivan Lane', 'Apt 6', '02670', 'Lake Worth', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6781 Mallory Point', 'Apt 9', '02493', 'Charleston', 'WV');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6458 Tomscot Park', 'Apt 5', '02672', 'Detroit', 'MI');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('4 Summit Alley', 'Apt 1', '02465', 'Houston', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('2 Ridgeway Street', 'Apt 5', '02668', 'Denver', 'CO');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('8 Meadow Valley Road', 'Apt 2', '02663', 'Boise', 'ID');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('6156 Sycamore Way', 'Apt 6', '02575', 'Fresno', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('0 5th Trail', 'Apt 3', '02663', 'Seattle', 'WA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('319 Sachs Circle', 'Apt 2', '02672', 'Houston', 'TX');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3 Twin Pines Parkway', null, '02481', 'San Francisco', 'CA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('15585 Waubesa Way', 'Apt 1', '02673', 'Hartford', 'CT');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('202 Prentice Avenue', 'Apt 2', '02132', 'New York City', 'NY');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('3979 Summit Road', 'Apt 8', '02132', 'Boca Raton', 'FL');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('1957 Debra Drive', null, '02790', 'Fairfax', 'VA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('94 Killdeer Terrace', null, '02670', 'Wilmington', 'DE');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('5 Rigney Trail', 'Apt 9', '02790', 'Augusta', 'GA');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('20861 Fairfield Park', 'Apt 4', '02481', 'Schenectady', 'NY');
insert into dbo.address (address_line1, address_line2, zip, city, state) values ('63 Gina Circle', 'Apt 5', '02462', 'Annapolis', 'MD');


/*
 * Step 2 : insert data into Group
 */
INSERT INTO [dbo].[Group](size) VALUES
(2),
(3),
(3),
(6),
(6),
(6),
(6),
(6),
(6),
(6),
(8),
(8),
(8),
(8),
(8),
(8),
(8),
(8),
(8),
(10),
(10),
(10),
(10),
(10),
(10),
(10),
(10),
(10),
(10);





/*
 * Step 3: insert data into Building
 */
INSERT INTO dbo.Building (group_id, construction_time, utility, address_id, total_parking)
VALUES 
	(2, '2008-08-12', '1', 1, 10),
	(3, '2012-12-28', '1', 2, 10),
	(2, '2005-10-01', '1', 31, 2),
	(2, '2001-02-05', '1', 32, 2),
	(3, '1999-03-21', '1', 33, 0),
	(3, '2002-09-01', '1', 34, 1);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (21, '1986-04-17', 1, 168, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (16, '1995-06-24', 1, 163, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (22, '1992-09-24', 1, 130, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (29, '2008-04-25', 0, 201, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (27, '2009-11-26', 0, 193, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (21, '1988-10-25', 0, 175, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (5, '1969-12-24', 0, 95, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (3, '1984-10-03', 0, 146, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (8, '1971-04-19', 0, 156, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (8, '2013-08-21', 0, 182, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (17, '1971-11-17', 1, 170, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (2, '2020-04-28', 1, 140, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (1, '1969-12-23', 0, 143, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (11, '1980-09-12', 1, 15, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (29, '2006-12-07', 0, 103, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (28, '1969-02-09', 0, 141, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (9, '2004-10-30', 1, 60, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (11, '2006-08-20', 0, 164, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (24, '1972-01-20', 0, 101, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (7, '2008-06-08', 0, 222, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (21, '2005-07-05', 1, 191, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (12, '1990-07-19', 0, 220, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (2, '1995-03-23', 1, 194, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (29, '2002-03-15', 1, 97, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (28, '1984-09-28', 0, 29, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (26, '2014-08-02', 1, 209, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (11, '1977-11-18', 1, 7, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (5, '2018-04-10', 0, 132, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (7, '2004-02-13', 0, 164, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (11, '1983-06-18', 1, 171, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (14, '1985-06-22', 0, 202, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (7, '2003-06-30', 1, 26, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (28, '2019-06-05', 0, 42, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (29, '1999-07-21', 0, 67, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (7, '1987-02-09', 1, 194, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (12, '1977-11-27', 1, 99, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (11, '1979-02-06', 1, 155, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (11, '2008-12-25', 1, 11, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (1, '1999-08-30', 1, 182, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (26, '1979-06-07', 0, 56, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (24, '1991-04-06', 0, 64, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (28, '2001-03-10', 1, 191, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (17, '2020-10-29', 1, 53, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (23, '1981-03-12', 1, 131, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (21, '1990-01-01', 1, 211, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (4, '1972-03-20', 0, 120, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (17, '1995-10-15', 1, 203, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (25, '1999-05-02', 1, 182, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (25, '1968-10-02', 1, 29, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (13, '1984-02-16', 0, 32, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (23, '2011-05-24', 0, 192, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (25, '2011-07-16', 1, 93, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (5, '2012-06-02', 1, 202, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (20, '1983-06-23', 0, 88, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (21, '2001-09-24', 0, 208, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (7, '2010-05-01', 0, 212, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (17, '1971-09-07', 0, 71, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (9, '1988-06-05', 1, 144, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (11, '1982-02-22', 1, 166, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (28, '1992-02-12', 0, 126, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (22, '1967-02-21', 0, 116, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (4, '1977-03-30', 0, 63, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (20, '2012-03-29', 1, 220, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (3, '1994-09-08', 0, 181, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (21, '2013-03-26', 0, 146, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (5, '1993-08-23', 0, 66, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (21, '1986-06-07', 1, 17, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (14, '2018-08-14', 1, 103, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (12, '2003-08-17', 0, 55, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (16, '1986-09-07', 1, 212, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (29, '1979-09-28', 1, 110, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (4, '1981-04-17', 1, 106, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (10, '1991-11-01', 0, 131, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (23, '1978-12-30', 0, 141, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (19, '1998-02-18', 0, 223, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (10, '1981-02-03', 1, 163, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (6, '1975-04-18', 0, 161, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (21, '2007-07-22', 0, 223, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (3, '2016-01-18', 0, 195, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (17, '2010-12-08', 1, 101, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (21, '1974-08-18', 0, 202, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (3, '2006-03-27', 0, 30, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (16, '2015-10-22', 1, 51, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (22, '2002-03-04', 0, 123, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (17, '1977-06-10', 1, 187, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (14, '1999-01-11', 0, 193, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (2, '2003-10-25', 1, 214, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (26, '2001-06-24', 0, 65, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (4, '2009-03-19', 0, 128, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (10, '1984-05-08', 0, 173, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (19, '1987-10-11', 0, 52, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (5, '2014-10-20', 0, 133, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (8, '1982-08-22', 0, 49, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (16, '1979-12-21', 0, 153, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (4, '1972-05-25', 0, 74, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (6, '1982-08-19', 1, 144, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (24, '2003-11-10', 1, 74, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (15, '1971-02-18', 0, 96, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (10, '2008-05-30', 1, 52, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (5, '1981-11-17', 1, 125, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (12, '1993-06-09', 1, 188, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (23, '2010-04-21', 0, 55, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (20, '1992-03-13', 0, 12, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (16, '1968-12-25', 0, 108, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (6, '2018-03-04', 1, 185, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (27, '1998-04-10', 1, 42, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (10, '1985-08-25', 1, 118, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (2, '1979-10-03', 0, 191, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (20, '2010-04-20', 1, 64, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (17, '1981-04-13', 0, 102, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (15, '1969-05-28', 1, 80, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (3, '1976-09-13', 1, 78, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (1, '2018-05-07', 1, 102, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (2, '2015-04-10', 1, 201, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (13, '1980-01-12', 1, 102, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (23, '1969-11-22', 1, 185, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (21, '2000-03-22', 0, 20, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (17, '1980-04-12', 0, 113, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (7, '1978-05-08', 0, 100, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (24, '2007-01-27', 1, 219, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (24, '1994-07-15', 0, 152, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (9, '2003-07-01', 0, 64, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (23, '1992-07-18', 0, 211, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (19, '2006-11-26', 1, 143, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (21, '2008-01-11', 0, 26, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (12, '1969-07-30', 0, 195, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (20, '2004-09-24', 0, 26, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (12, '1990-10-13', 1, 75, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (22, '1987-05-16', 0, 23, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (5, '1988-05-14', 1, 192, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (23, '2002-07-22', 0, 41, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (7, '1997-12-15', 1, 50, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (7, '1967-03-27', 0, 70, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (7, '2013-10-19', 0, 66, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (9, '1978-09-13', 0, 186, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (16, '1981-12-24', 0, 225, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (5, '1975-05-30', 1, 180, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (29, '1974-04-16', 1, 143, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (19, '2015-01-29', 0, 114, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (18, '1972-07-28', 0, 22, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (28, '2000-04-24', 1, 73, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (9, '1984-08-26', 1, 180, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (28, '2014-07-11', 1, 139, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (12, '1988-04-29', 1, 9, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (28, '2009-07-02', 1, 160, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (7, '1976-10-20', 1, 55, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (10, '1968-11-05', 1, 87, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (18, '1993-02-13', 0, 224, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (16, '1988-08-20', 0, 197, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (18, '2016-01-28', 1, 160, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (28, '1974-11-16', 0, 183, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (21, '1986-11-22', 0, 62, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (19, '2012-06-10', 0, 21, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (29, '1999-06-26', 1, 126, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (23, '1986-08-23', 1, 79, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (18, '2002-04-30', 0, 79, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (25, '1973-05-10', 0, 8, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (13, '1973-05-29', 1, 96, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (7, '1992-01-01', 0, 113, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (18, '2005-10-27', 1, 34, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (2, '1993-03-07', 1, 66, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (26, '1976-05-23', 1, 114, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (3, '1972-11-11', 0, 12, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (8, '1976-01-27', 0, 37, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (24, '1989-04-11', 0, 14, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (5, '1978-05-18', 1, 170, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (11, '2003-05-26', 0, 141, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (12, '1970-12-04', 1, 140, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (11, '1999-12-07', 0, 43, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (18, '2010-05-14', 0, 103, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (3, '1999-06-01', 1, 37, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (24, '1970-08-19', 0, 127, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (4, '1975-06-01', 0, 106, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (5, '2003-05-28', 0, 17, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (18, '2009-09-18', 1, 104, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (14, '1989-04-18', 1, 203, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (1, '1995-02-08', 0, 33, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (2, '1978-06-19', 0, 90, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (25, '1980-05-03', 1, 93, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (16, '2018-01-28', 1, 179, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (11, '1987-02-26', 1, 218, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (19, '2014-09-28', 1, 221, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (6, '1977-05-02', 0, 14, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (12, '2014-04-04', 0, 142, 9);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (27, '1997-08-03', 1, 60, 2);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (9, '1995-11-21', 1, 159, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (25, '2014-10-15', 0, 83, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (17, '1977-06-09', 0, 124, 6);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (22, '2014-12-06', 0, 167, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (7, '2019-01-22', 1, 22, 10);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (25, '1980-03-04', 0, 213, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (12, '1987-02-02', 0, 133, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (24, '1973-03-22', 0, 73, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (28, '1978-05-12', 0, 38, 4);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (17, '2017-06-09', 1, 190, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (5, '2000-08-05', 0, 136, 8);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (25, '1987-07-24', 1, 151, 5);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (10, '2003-10-16', 1, 144, 7);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (23, '2012-09-27', 0, 65, 3);
insert into dbo.building (group_id, construction_time, utility, address_id, total_parking) values (23, '1998-02-16', 1, 198, 6);




/*
 * Step 4: insert data into Parking
 */
INSERT INTO dbo.Parking (availability, building_id, vehicle_plate_number, location)
VALUES 
	(0, 1, '021 BG2', 'P1'),
	(0, 1, '1SPE 60', 'P1'),
	(0, 1, '460 9CW', 'P2'),
	(1, 1, null, 'P1'),
	(1, 1, null, 'P1'),
	(1, 1, null, 'P1'),
	(1, 1, null, 'P2'),
	(1, 1, null, 'P2'),
	(1, 1, null, 'P2'),
	(1, 1, null, 'P2'),
	(1, 1, null, 'P2'),
	(0, 2, 'CSY 0123', 'L1'),
	(0, 2, 'QQA 0834', 'L1'),
	(0, 2, 'AAA 4433', 'L1'),
	(1, 2, null, 'L1'),
	(1, 2, null, 'L1'),
	(1, 2, null, 'L2'),
	(1, 2, null, 'L2'),
	(1, 2, null, 'L2'),
	(1, 2, null, 'L2'),
	(1, 2, null, 'L1'),
	(1, 3, null, 'garage'),
	(1, 3, null, 'garage'),
	(1, 4, null, 'garage'),
	(1, 4, null, 'garage'),
	(1, 6, null, 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 205, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 134, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 88, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 80, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 79, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 140, null, 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 11, null, 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 202, null, 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 187, null, 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 131, null, 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 176, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 188, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 150, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 164, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 202, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 57, null, 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 91, null, 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 38, null, 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 134, null, 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 172, null, 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 63, 'ABC 1234', 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 77, 'ABC 1234', 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 68, 'ABC 1234', 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 50, 'ABC 1234', 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 81, 'ABC 1234', 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 202, null, 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 14, null, 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 96, null, 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 98, null, 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 131, null, 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 199, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 125, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 40, 'ABC 1234', 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 170, 'ABC 1234', 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 45, 'ABC 1234', 'street parking');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 111, null, 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 114, null, 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 199, null, 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 97, null, 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 175, null, 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 176, null, 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 191, null, 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (1, 75, null, 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 206, 'ABC 4321', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 142, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 23, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 14, 'ABC 1234', 'garage');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 158, 'ABC 1234', 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 75, 'ABC 1234', 'L1');
insert into dbo.Parking (availability, building_id, vehicle_plate_number, location) values (0, 173, 'ABC 1234', 'L1');


/*
 * Step 5: insert data into FloorPlan
 */
INSERT INTO dbo.Floorplan ( bedroom_count, bathroom_count, livingroom_count)
VALUES
	(1, 1, 1),
	(2, 1, 1),
	(2, 2, 1),
	(3, 2, 1),
	(3, 3, 1),
	(4, 2, 1),
	(4, 4, 1);
INSERT INTO dbo.Floorplan ( bedroom_count, bathroom_count, livingroom_count)
VALUES
	(6, 4, 1),
	(8, 4, 2),
	(10, 5, 3);




/*
 * Step 6: insert data into Room 
 */
INSERT INTO dbo.Room(floorplan_id, building_id, rent, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy)
VALUES 
	(1, 1, 1100, 1, 1, 1, 101, 'EAST', 1, '2022-12-20', 9, 24),--b1 
	(1, 1, 1100, 0, 1, 1, 102, 'WEST', 1, '2022-12-20', 9, 24),
	(1, 1, 1100, 0, 1, 1, 103, 'WEST', 1, '2022-12-20', 9, 24),
	(1, 1, 1100, 0, 1, 1, 104, 'WEST', 1, '2022-12-20', 9, 24),
	(1, 1, 1100, 0, 1, 1, 105, 'WEST', 1, '2021-12-21', 9, 24),
	(1, 1, 1100, 0, 1, 1, 106, 'WEST', 1, '2021-12-21', 9, 24),
	(1, 1, 1100, 0, 1, 1, 107, 'WEST', 1, '2021-12-21', 9, 24),
	(1, 1, 1100, 0, 1, 1, 108, 'WEST', 1, '2021-12-21', 9, 24),
	(2, 1, 2100, 1, 1, 2, 201, 'EAST', 1, '2022-08-01', 9, 24),
	(2, 1, 2100, 1, 1, 2, 202, 'EAST', 1, '2022-09-01', 9, 24),
	(2, 1, 2100, 1, 1, 2, 203, 'WEST', 1, '2021-12-21', 9, 24),--
	(2, 1, 2100, 1, 1, 2, 204, 'EAST', 1, '2021-12-21', 9, 24),--
	(4, 1, 3200, 1, 1, 3, 301, 'EAST', 1, '2022-12-20', 9, 24),
	(4, 1, 3200, 1, 1, 3, 302, 'EAST', 1, '2022-12-20', 9, 24),
	(4, 1, 3200, 1, 1, 3, 303, 'EAST', 1, '2021-12-21', 9, 24),
	(4, 1, 3200, 1, 1, 3, 304, 'EAST', 1, '2021-12-21', 9, 24),
	(6, 1, 4200, 1, 1, 4, 401, 'NORTH', 1, '2022-12-20', 9, 24),
	(6, 1, 4200, 1, 1, 4, 402, 'NORTH', 1, '2023-01-01', 9, 24),
	(6, 1, 4200, 1, 1, 4, 403, 'EAST', 1, '2021-12-21', 9, 24),
	(6, 1, 4200, 1, 1, 4, 404, 'EAST', 1, '2021-12-21', 9, 24),
	(1, 2, 1100, 1, 1, 1, 101, 'EAST', 1, '2022-12-20', 11, 18),--b2
	(1, 2, 1100, 0, 1, 1, 102, 'WEST', 1, '2022-12-20', 11, 18),
	(1, 2, 1100, 0, 1, 1, 103, 'WEST', 1, '2022-12-20', 11, 18),
	(1, 2, 1100, 0, 1, 1, 104, 'WEST', 1, '2022-12-20', 11, 18),
	(1, 2, 1100, 0, 1, 1, 105, 'WEST', 1, '2021-12-21', 11, 18),
	(1, 2, 1100, 0, 1, 1, 106, 'WEST', 1, '2021-12-21', 11, 18),
	(1, 2, 1100, 0, 1, 1, 107, 'WEST', 1, '2021-12-21', 11, 18),
	(1, 2, 1100, 0, 1, 1, 108, 'WEST', 1, '2021-12-21', 11, 18),
	(3, 2, 2200, 1, 1, 2, 201, 'EAST', 1, '2022-08-01', 11, 18),
	(3, 2, 2200, 1, 1, 2, 202, 'EAST', 1, '2022-09-01', 11, 18),
	(3, 2, 2200, 1, 1, 2, 203, 'WEST', 1, '2021-12-21', 11, 18),
	(3, 2, 2200, 1, 1, 2, 204, 'EAST', 1, '2021-12-21', 11, 18),
	(5, 2, 3300, 1, 1, 3, 301, 'EAST', 1, '2022-12-20', 11, 18),
	(5, 2, 3300, 1, 1, 3, 302, 'EAST', 1, '2022-12-20', 11, 18),
	(5, 2, 3300, 1, 1, 3, 303, 'EAST', 1, '2021-12-21', 11, 18),
	(5, 2, 3300, 1, 1, 3, 304, 'EAST', 1, '2021-12-21', 11, 18),
	(7, 2, 4400, 1, 1, 4, 401, 'NORTH', 1, '2022-12-20', 11, 18),
	(7, 2, 4400, 1, 1, 4, 402, 'NORTH', 1, '2023-01-01', 11, 18),
	(7, 2, 4400, 1, 1, 4, 403, 'EAST', 1, '2021-12-21', 11, 18),
	(7, 2, 4400, 1, 1, 4, 404, 'EAST', 1, '2021-12-21', 11, 18),
	(6, 3, 4300, 1, 1, 1, 999, 'NORTH', 1, '2022-12-20', 12, 24),
	(6, 4, 4400, 1, 1, 1, 999, 'NORTH', 1, '2023-01-01', 12, 24),
	(6, 5, 4500, 1, 1, 1, 999, 'EAST', 1, '2022-12-20', 12, 24),
	(6, 6, 4600, 1, 1, 1, 999, 'EAST', 1, '2022-12-20', 12, 24);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 28, 0, 0, 8, 5, 'SOUTH', 1, '2023-11-18', 3, 9, 6200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 74, 1, 1, 19, 12, 'EAST', 1, '2021-09-22', 6, 9, 4600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 147, 1, 0, 14, 8, 'NORTH', 1, '2023-06-16', 3, 9, 6900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 99, 1, 1, 9, 8, 'NORTH', 1, '2022-01-09', 3, 9, 3400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 174, 0, 1, 16, 3, 'SOUTH', 1, '2020-07-21', 3, 12, 4600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 119, 1, 1, 11, 2, 'WEST', 1, '2020-12-31', 3, 12, 4900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 174, 1, 0, 9, 12, 'EAST', 1, '2020-05-22', 3, 12, 5200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 66, 0, 0, 8, 13, 'NORTH', 1, '2022-02-27', 3, 12, 5900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 36, 1, 1, 18, 5, 'WEST', 1, '2023-06-23', 6, 9, 4900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 67, 0, 0, 12, 3, 'NORTH', 1, '2022-03-13', 3, 12, 4300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 191, 1, 0, 12, 6, 'WEST', 1, '2020-09-19', 3, 12, 2800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 9, 1, 0, 16, 11, 'SOUTH', 1, '2022-11-18', 3, 12, 2200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 76, 1, 1, 3, 8, 'NORTH', 1, '2022-07-01', 3, 12, 5400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 37, 0, 0, 6, 8, 'WEST', 1, '2023-11-05', 6, 12, 1800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 60, 0, 1, 12, 1, 'WEST', 1, '2020-12-19', 3, 12, 6000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 117, 1, 1, 13, 14, 'EAST', 1, '2021-06-22', 3, 12, 2100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 147, 0, 0, 15, 7, 'NORTH', 1, '2021-07-28', 3, 12, 6200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 50, 1, 0, 3, 6, 'NORTH', 1, '2023-11-17', 3, 12, 5300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 115, 1, 0, 7, 15, 'SOUTH', 1, '2023-04-30', 3, 12, 2500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 37, 1, 0, 11, 14, 'SOUTH', 1, '2020-05-11', 3, 9, 2400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 132, 0, 1, 14, 4, 'NORTH', 1, '2020-03-27', 6, 12, 5900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 88, 0, 0, 1, 9, 'EAST', 1, '2020-06-02', 3, 12, 1500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 179, 1, 0, 14, 6, 'EAST', 1, '2022-08-25', 3, 12, 6400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 52, 1, 1, 20, 12, 'EAST', 1, '2020-11-06', 3, 12, 7200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 68, 1, 1, 20, 3, 'SOUTH', 1, '2021-05-17', 6, 12, 5200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 193, 1, 0, 7, 13, 'WEST', 1, '2021-02-21', 3, 12, 3100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 200, 1, 0, 16, 1, 'SOUTH', 1, '2020-10-21', 3, 12, 3300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 188, 1, 1, 4, 15, 'WEST', 1, '2023-01-23', 3, 9, 2700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 28, 0, 1, 2, 4, 'WEST', 1, '2021-08-23', 3, 9, 6000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 74, 0, 0, 11, 6, 'WEST', 1, '2021-07-11', 3, 12, 3800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 158, 0, 0, 20, 11, 'WEST', 1, '2023-11-20', 6, 12, 2800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 177, 1, 1, 6, 15, 'SOUTH', 1, '2023-10-02', 3, 12, 4600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 188, 0, 0, 13, 1, 'SOUTH', 1, '2023-09-17', 3, 12, 2400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 7, 0, 0, 2, 9, 'EAST', 1, '2020-02-23', 3, 9, 7800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 4, 1, 0, 15, 9, 'EAST', 1, '2021-03-31', 3, 12, 4600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 164, 1, 1, 14, 1, 'WEST', 1, '2020-04-30', 6, 12, 7700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 41, 0, 0, 12, 4, 'WEST', 1, '2022-03-21', 3, 9, 3400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 201, 0, 1, 9, 8, 'SOUTH', 1, '2022-07-17', 6, 12, 3800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 58, 1, 1, 4, 15, 'SOUTH', 1, '2022-11-06', 3, 12, 2500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 73, 1, 0, 19, 11, 'SOUTH', 1, '2022-05-10', 3, 12, 5500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 11, 1, 1, 1, 10, 'EAST', 1, '2020-12-05', 3, 12, 1500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 192, 0, 1, 13, 11, 'SOUTH', 1, '2022-05-23', 6, 12, 4300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 13, 1, 1, 18, 9, 'NORTH', 1, '2020-01-27', 3, 12, 4700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 104, 0, 1, 5, 11, 'NORTH', 1, '2022-11-21', 3, 9, 5000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 9, 0, 1, 5, 2, 'EAST', 1, '2020-06-20', 3, 9, 6700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 27, 0, 0, 11, 11, 'WEST', 1, '2022-02-06', 3, 12, 5600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 128, 1, 1, 12, 8, 'EAST', 1, '2023-07-20', 3, 12, 5100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 81, 1, 0, 18, 14, 'EAST', 1, '2021-08-28', 6, 12, 3900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 188, 1, 1, 18, 11, 'NORTH', 1, '2021-03-29', 6, 9, 1600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 202, 1, 1, 4, 13, 'WEST', 1, '2023-03-16', 3, 12, 1700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 128, 1, 0, 1, 7, 'SOUTH', 1, '2023-03-18', 3, 12, 5200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 195, 1, 0, 9, 14, 'WEST', 1, '2020-03-27', 3, 9, 6600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 159, 0, 0, 12, 13, 'NORTH', 1, '2021-07-11', 3, 12, 2500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 25, 0, 1, 10, 5, 'SOUTH', 1, '2021-01-18', 3, 12, 5200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 20, 1, 1, 2, 11, 'EAST', 1, '2021-03-16', 3, 12, 2600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 182, 0, 1, 3, 1, 'SOUTH', 1, '2021-07-30', 3, 9, 6300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 128, 1, 1, 1, 13, 'EAST', 1, '2021-06-27', 3, 9, 7400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 178, 1, 0, 3, 11, 'SOUTH', 1, '2022-07-06', 3, 12, 3400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 116, 0, 1, 14, 12, 'WEST', 1, '2020-01-10', 3, 12, 3500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 164, 1, 1, 2, 14, 'WEST', 1, '2021-09-01', 3, 12, 2600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 9, 0, 1, 20, 13, 'NORTH', 1, '2022-01-02', 6, 12, 2900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 157, 0, 1, 10, 5, 'NORTH', 1, '2022-11-02', 3, 12, 3200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 89, 1, 0, 17, 8, 'WEST', 1, '2022-08-03', 3, 12, 6300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 153, 0, 0, 13, 1, 'SOUTH', 1, '2021-10-16', 3, 12, 5000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 88, 1, 0, 6, 7, 'SOUTH', 1, '2022-12-01', 3, 9, 6400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 147, 1, 0, 6, 2, 'EAST', 1, '2020-03-17', 3, 12, 7400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 138, 1, 0, 17, 14, 'WEST', 1, '2020-04-14', 3, 12, 4700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 49, 1, 1, 2, 2, 'NORTH', 1, '2020-12-13', 3, 12, 2100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 157, 1, 0, 13, 5, 'NORTH', 1, '2022-12-11', 6, 9, 5500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 9, 1, 1, 18, 3, 'NORTH', 1, '2020-06-30', 3, 12, 3800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 93, 1, 1, 9, 14, 'NORTH', 1, '2020-04-22', 3, 12, 2700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 202, 0, 0, 11, 4, 'EAST', 1, '2022-12-21', 3, 12, 4500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 9, 0, 1, 20, 8, 'NORTH', 1, '2020-12-18', 6, 12, 2600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 11, 0, 0, 2, 4, 'WEST', 1, '2022-02-18', 6, 12, 5200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 137, 1, 0, 18, 2, 'NORTH', 1, '2021-12-22', 3, 9, 6600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 34, 1, 0, 2, 2, 'EAST', 1, '2023-04-28', 3, 12, 4400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 150, 1, 1, 15, 7, 'WEST', 1, '2023-03-22', 3, 12, 5400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 88, 0, 0, 1, 15, 'EAST', 1, '2021-03-03', 3, 12, 3000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 16, 0, 1, 2, 11, 'EAST', 1, '2020-02-18', 3, 9, 5600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 129, 0, 0, 14, 14, 'WEST', 1, '2022-06-30', 3, 12, 5300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 30, 0, 0, 19, 12, 'EAST', 1, '2023-06-24', 6, 12, 1800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 120, 1, 1, 11, 7, 'NORTH', 1, '2022-03-25', 3, 12, 4500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 181, 0, 0, 13, 13, 'EAST', 1, '2022-06-13', 3, 12, 6500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 98, 0, 0, 6, 2, 'EAST', 1, '2020-12-02', 3, 9, 6200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 172, 1, 0, 1, 7, 'SOUTH', 1, '2021-02-12', 6, 12, 4000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 117, 0, 0, 17, 11, 'NORTH', 1, '2021-10-21', 6, 9, 5600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 188, 0, 0, 10, 13, 'NORTH', 1, '2022-01-04', 3, 12, 3200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 106, 0, 0, 9, 11, 'SOUTH', 1, '2020-02-22', 3, 12, 4000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 157, 1, 0, 18, 10, 'NORTH', 1, '2021-03-17', 3, 9, 2400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 130, 0, 1, 6, 2, 'NORTH', 1, '2020-04-19', 3, 12, 6700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 74, 0, 1, 12, 3, 'NORTH', 1, '2022-04-28', 6, 12, 2600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 181, 0, 1, 14, 11, 'SOUTH', 1, '2020-01-28', 6, 9, 2900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 193, 0, 1, 6, 12, 'SOUTH', 1, '2021-11-10', 6, 12, 4500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 20, 0, 1, 2, 14, 'NORTH', 1, '2020-11-19', 3, 12, 4900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 77, 0, 0, 6, 1, 'EAST', 1, '2021-09-14', 3, 9, 5800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 69, 0, 0, 14, 14, 'WEST', 1, '2022-06-03', 3, 12, 7100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 16, 1, 1, 14, 10, 'WEST', 1, '2023-12-17', 6, 12, 4900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 168, 0, 1, 2, 6, 'WEST', 1, '2023-09-17', 3, 12, 6900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 177, 1, 1, 4, 11, 'SOUTH', 1, '2020-07-19', 3, 12, 4800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 55, 0, 0, 14, 12, 'NORTH', 1, '2023-04-24', 3, 12, 3100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 104, 1, 0, 11, 15, 'WEST', 1, '2023-06-26', 3, 12, 3000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 139, 0, 0, 13, 14, 'WEST', 1, '2022-08-11', 3, 12, 6600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 200, 0, 1, 9, 15, 'NORTH', 1, '2023-09-16', 6, 12, 4400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 148, 1, 1, 18, 9, 'EAST', 1, '2023-05-08', 3, 12, 6200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 54, 1, 1, 19, 3, 'NORTH', 1, '2021-01-30', 3, 12, 6400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 146, 1, 0, 14, 11, 'EAST', 1, '2023-08-05', 6, 12, 2500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 206, 0, 0, 20, 15, 'SOUTH', 1, '2021-04-17', 3, 12, 2600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 53, 0, 1, 10, 15, 'EAST', 1, '2022-05-18', 3, 12, 6400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 32, 0, 1, 11, 1, 'EAST', 1, '2021-10-04', 3, 9, 3700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 30, 1, 1, 5, 8, 'EAST', 1, '2021-11-14', 3, 12, 7500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 114, 1, 0, 8, 9, 'NORTH', 1, '2022-07-27', 3, 12, 2100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 196, 0, 1, 9, 6, 'EAST', 1, '2020-07-25', 3, 12, 2800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 124, 1, 0, 15, 13, 'EAST', 1, '2020-09-17', 3, 12, 5900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 80, 0, 1, 8, 15, 'SOUTH', 1, '2020-12-23', 6, 12, 3200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 50, 1, 1, 5, 15, 'EAST', 1, '2022-12-10', 6, 12, 4100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 204, 0, 0, 7, 6, 'WEST', 1, '2020-10-31', 3, 12, 6000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 75, 0, 0, 7, 13, 'EAST', 1, '2021-09-08', 3, 12, 5100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 146, 1, 1, 5, 5, 'NORTH', 1, '2023-10-18', 6, 12, 4900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 139, 1, 0, 13, 6, 'SOUTH', 1, '2020-05-16', 3, 12, 4200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 144, 1, 1, 7, 7, 'EAST', 1, '2023-03-12', 3, 9, 7600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 151, 1, 0, 4, 2, 'SOUTH', 1, '2020-08-15', 3, 12, 2000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 80, 1, 0, 9, 1, 'WEST', 1, '2021-05-22', 3, 12, 4400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 170, 0, 1, 12, 11, 'NORTH', 1, '2022-07-02', 6, 12, 4400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 128, 0, 0, 7, 1, 'NORTH', 1, '2022-08-23', 3, 9, 3900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 195, 0, 1, 19, 10, 'NORTH', 1, '2023-08-03', 3, 9, 3400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 80, 1, 0, 7, 9, 'EAST', 1, '2022-07-24', 3, 9, 4300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 28, 1, 0, 2, 2, 'EAST', 1, '2023-08-22', 3, 12, 3100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 31, 0, 0, 6, 10, 'EAST', 1, '2022-11-01', 3, 12, 3700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 57, 0, 1, 3, 5, 'WEST', 1, '2020-06-15', 6, 9, 3700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 194, 1, 0, 20, 15, 'NORTH', 1, '2021-03-20', 3, 12, 4300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 184, 1, 1, 17, 1, 'SOUTH', 1, '2021-04-22', 3, 9, 4400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 46, 0, 1, 2, 11, 'EAST', 1, '2021-10-22', 3, 12, 5200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 206, 0, 1, 3, 2, 'NORTH', 1, '2023-07-25', 6, 12, 3000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 146, 0, 0, 20, 15, 'SOUTH', 1, '2021-11-29', 6, 12, 5000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 98, 1, 1, 19, 9, 'WEST', 1, '2021-11-27', 3, 12, 2800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 141, 0, 1, 1, 6, 'NORTH', 1, '2021-09-05', 3, 9, 4600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 140, 1, 0, 4, 13, 'EAST', 1, '2022-10-05', 3, 12, 4300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 181, 0, 1, 17, 9, 'WEST', 1, '2021-06-07', 3, 12, 4600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 91, 1, 0, 19, 3, 'WEST', 1, '2022-05-16', 3, 12, 4100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 132, 0, 0, 5, 2, 'EAST', 1, '2023-01-25', 3, 9, 2700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 175, 1, 1, 20, 11, 'WEST', 1, '2022-03-26', 3, 12, 1600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 147, 0, 1, 20, 14, 'WEST', 1, '2023-08-03', 6, 12, 2800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 34, 0, 1, 18, 10, 'NORTH', 1, '2021-09-14', 3, 12, 3300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 184, 0, 1, 11, 10, 'WEST', 1, '2022-04-22', 3, 12, 5000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 150, 0, 1, 9, 1, 'SOUTH', 1, '2021-07-22', 6, 9, 3200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 166, 0, 0, 10, 1, 'NORTH', 1, '2023-10-18', 3, 9, 4400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 144, 1, 0, 3, 4, 'WEST', 1, '2020-06-04', 3, 12, 1900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 10, 0, 0, 1, 13, 'SOUTH', 1, '2023-08-05', 3, 12, 4800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 27, 1, 1, 18, 8, 'WEST', 1, '2022-10-06', 3, 9, 6600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 116, 1, 0, 19, 8, 'EAST', 1, '2021-11-15', 3, 12, 3100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 172, 1, 1, 20, 5, 'SOUTH', 1, '2022-04-14', 3, 12, 2700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 122, 1, 1, 19, 8, 'WEST', 1, '2021-01-19', 3, 12, 2900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 148, 0, 0, 15, 15, 'WEST', 1, '2022-07-25', 3, 9, 2400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 182, 0, 1, 17, 10, 'WEST', 1, '2022-06-05', 3, 12, 5100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 149, 1, 0, 6, 10, 'SOUTH', 1, '2022-06-03', 6, 12, 4300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 7, 0, 1, 1, 10, 'SOUTH', 1, '2021-10-30', 3, 12, 7000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 171, 1, 1, 8, 4, 'EAST', 1, '2023-07-05', 3, 12, 6600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 57, 0, 1, 2, 6, 'WEST', 1, '2022-04-22', 6, 12, 3000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 50, 0, 1, 5, 9, 'EAST', 1, '2021-03-12', 3, 12, 5600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 65, 0, 1, 8, 9, 'SOUTH', 1, '2020-10-05', 3, 9, 5100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 34, 0, 1, 15, 12, 'SOUTH', 1, '2023-01-25', 6, 9, 7900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 178, 0, 0, 9, 11, 'SOUTH', 1, '2020-12-24', 3, 12, 4600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 154, 1, 0, 9, 3, 'NORTH', 1, '2022-06-24', 3, 9, 6300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 118, 1, 0, 18, 12, 'SOUTH', 1, '2022-11-15', 3, 9, 5400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 103, 0, 0, 15, 7, 'EAST', 1, '2023-07-01', 3, 12, 7300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 171, 0, 1, 12, 10, 'WEST', 1, '2022-02-19', 6, 12, 4200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 123, 0, 1, 13, 6, 'WEST', 1, '2021-11-06', 3, 9, 2100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 86, 0, 1, 15, 14, 'SOUTH', 1, '2021-03-02', 3, 12, 5200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 156, 0, 0, 18, 8, 'EAST', 1, '2022-09-15', 6, 9, 4300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 161, 0, 0, 10, 15, 'WEST', 1, '2023-04-29', 6, 12, 4800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 67, 1, 1, 16, 6, 'SOUTH', 1, '2022-01-14', 3, 12, 1900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 45, 0, 0, 2, 5, 'NORTH', 1, '2021-04-30', 3, 12, 3100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 84, 1, 0, 17, 9, 'WEST', 1, '2021-12-23', 3, 12, 4600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 159, 0, 0, 4, 10, 'EAST', 1, '2020-03-29', 3, 12, 4400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 70, 0, 1, 15, 3, 'WEST', 1, '2020-03-21', 3, 12, 6200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 185, 1, 0, 2, 14, 'EAST', 1, '2020-01-25', 3, 12, 4300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 14, 1, 0, 9, 9, 'NORTH', 1, '2021-02-25', 3, 12, 1600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 62, 0, 1, 3, 13, 'WEST', 1, '2021-12-27', 3, 12, 4800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (7, 123, 1, 1, 18, 9, 'SOUTH', 1, '2020-09-10', 3, 12, 4100);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 46, 1, 0, 9, 11, 'WEST', 1, '2023-12-12', 3, 12, 2600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 140, 1, 0, 6, 5, 'WEST', 1, '2020-01-31', 3, 12, 1800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 62, 1, 1, 11, 13, 'EAST', 1, '2022-06-11', 3, 12, 3600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 174, 0, 1, 2, 13, 'EAST', 1, '2021-06-05', 3, 12, 5600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 109, 0, 1, 9, 12, 'SOUTH', 1, '2023-04-25', 3, 12, 2900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 28, 1, 1, 17, 2, 'SOUTH', 1, '2021-12-17', 3, 12, 3800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 144, 1, 1, 16, 12, 'SOUTH', 1, '2023-10-05', 6, 12, 6600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 39, 0, 1, 1, 15, 'EAST', 1, '2021-01-27', 3, 9, 6400);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 180, 1, 0, 15, 10, 'SOUTH', 1, '2021-05-08', 3, 12, 2800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 93, 0, 0, 13, 5, 'EAST', 1, '2020-05-06', 3, 12, 5300);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 14, 1, 1, 2, 14, 'SOUTH', 1, '2020-08-07', 6, 12, 4600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (5, 58, 0, 0, 11, 13, 'SOUTH', 1, '2020-06-26', 3, 9, 5500);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (2, 91, 0, 1, 8, 2, 'NORTH', 1, '2021-12-21', 3, 9, 1900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 185, 0, 1, 11, 1, 'EAST', 1, '2020-12-07', 3, 12, 4700);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 47, 0, 1, 19, 10, 'SOUTH', 1, '2022-04-21', 3, 9, 4900);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 17, 1, 1, 20, 15, 'EAST', 1, '2021-08-22', 3, 9, 4000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 71, 0, 1, 2, 10, 'WEST', 1, '2022-12-08', 3, 12, 5800);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (1, 81, 0, 1, 15, 9, 'WEST', 1, '2023-08-03', 3, 12, 3000);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (6, 196, 1, 1, 10, 8, 'NORTH', 1, '2020-05-18', 3, 12, 5600);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (3, 47, 1, 1, 16, 10, 'SOUTH', 1, '2021-11-13', 3, 12, 5200);
insert into dbo.room (floorplan_id, building_id, furnished, laundry, floor, room_number, orientation, avaliable, available_date, minimum_tenancy, maximum_tenancy, rent) values (4, 49, 0, 0, 9, 12, 'EAST', 1, '2023-10-20', 3, 12, 3400);
--reset available_date
UPDATE [dbo].[Room] SET available_date='2020-05-31' WHERE id>0;



/*
 * Step 7: insert data into Department
 */
 INSERT INTO dbo.Department(name)
VALUES
	('Administrative'), --1
	('HR'), --1
	('Property_Management'),--2
	('Sale'), --2
	('Finance'); --2
INSERT INTO dbo.Department(name)
VALUES
	('Marketing'),
	('Operation'),
	('Research and Development'),
	('Purchasing'),
	('General Management');





/*
 * Step 8: insert data into PersonalInformation
 */
DBCC CHECKIDENT ('[dbo].[PersonalInformation]', RESEED, 100);

INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Dieter', 'Sorro', 'Male', '1990-04-02', convert(varbinary,'105-51-0151'), '704-250-6780', 'dsorro0@pagesperso-orange.fr', 3); --admin g1
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Wilmette', 'Larking', 'Female', '1991-01-02', convert(varbinary,'657-88-7026'), '403-372-3578', 'wlarking1@plala.or.jp', 4); -- HR g1
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Joela', 'Gaspar', 'Female', '1997-11-09', convert(varbinary,'825-22-0924'), '713-619-9122', 'jgaspar2@blogs.com', 5); -- manage g2
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Ddene', 'Emmet', 'Female', '1992-9-12', convert(varbinary,'634-31-2046'), '857-539-5495', 'demmet3@statcounter.com', 6); -- manage g3
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Glenna', 'Caney', 'Female', '2000-02-12', convert(varbinary,'816-55-8843'), '140-916-5513', 'gcaney4@amazon.co.jp', 7); -- sale g2
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Allie', 'Blance', 'Female', '1988-12-14', convert(varbinary,'614-46-7543'), '171-402-9359', 'ablance5@ft.com', 8); -- sale g3
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Joice', 'Heath', 'Female', '1998-04-13', convert(varbinary,'438-09-4138'), '264-593-4876', 'jheath6@comsenz.com', 9); -- fiannce g2
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Pansie', 'Dmitrienko', 'Female', '1990-12-18', convert(varbinary,'517-41-8766'), '577-716-7910', 'pdmitrienko7@cbc.ca', 10); --finance g3
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Franz', 'Fabry', 'Male', '1996-09-09', convert(varbinary,'782-18-2790'), '763-552-6149', 'ffabry0@shinystat.com', 11); -- r1 101
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Pieter', 'Nobriga', 'Male', '1994-01-03', convert(varbinary,'547-81-8479'), '663-454-3601', 'pnobriga1@rediff.com', 12); --r1 102
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Tandie', 'Yaknov', 'Female', '1990-09-08', convert(varbinary,'415-12-7361'), '939-427-8373', 'tyaknov2@webeden.co.uk', 13);--r1 103
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Katrine', 'Muggeridge', 'Female', '1993-04-13', convert(varbinary,'470-17-9526'), '619-819-6345', 'kmuggeridge3@surveymonkey.com', 14);--r1 104
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Riki', 'Puxley', 'Female', '1992-06-01', convert(varbinary,'337-17-2626'), '722-566-6828', 'rpuxley4@theatlantic.com', 15);--r1 201
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Donalt', 'Balmann', 'Male', '1997-04-06', convert(varbinary,'243-72-2286'), '582-538-6738', 'dbalmann5@toplist.cz', 15);--r1 201
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Karyl', 'Drinan', 'Female', '1994-02-01', convert(varbinary,'382-84-6939'), '741-564-5591', 'kdrinan6@buzzfeed.com', 16); --r1 202
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Lila', 'Dowyer', 'Female', '1999-01-09', convert(varbinary,'600-96-0727'), '908-191-0534', 'ldowyer7@engadget.com', 16); --r1 202
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Karl', 'Ketcher', 'Male', '1993-09-01', convert(varbinary,'222-07-8011'), '844-391-6335', 'kketcher8@about.me', 17); --r1 301
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Claybourne', 'Rundall', 'Male', '2000-03-26', convert(varbinary,'135-54-1470'), '827-203-7738', 'crundall9@phpbb.com', 17); --r1 301
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Fons', 'Fairbridge', 'Male', '1998-12-23', convert(varbinary,'448-65-9507'), '605-214-9731', 'ffairbridge8@ed.gov', 17); --r1 301
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Tymothy', 'Perrone', 'Male', '1997-09-08', convert(varbinary,'543-46-2962'), '740-892-6091', 'tperrone9@ocn.ne.jp', 18); --r1 302
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Regan', 'Mantrup', 'Male', '1996-12-09', convert(varbinary,'741-39-1751'), '635-728-4409', 'rmantrupa@tumblr.com', 18); --r1 302
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Kathie', 'McGragh', 'Female', '1995-08-01', convert(varbinary,'637-56-6765'), '803-313-1095', 'kmcgraghb@washingtonpost.com', 18);--r1 302
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Boycie', 'Aucourte', 'Male', '1993-02-19', convert(varbinary,'700-97-0886'), '387-572-2069', 'baucourtec@disqus.com', 19);--r1 401
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Carmelle', 'Sidwell', 'Female', '1995-07-06', convert(varbinary,'639-30-8158'), '836-476-2304', 'csidwelld@skyrock.com', 19);--r1 401
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Jefferey', 'Jerome', 'Male', '1994-12-01', convert(varbinary,'167-98-7957'), '128-447-5981', 'jjeromee@cnet.com', 19); --r1 401
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Salomone', 'Habden', 'Male', '1998-08-19', convert(varbinary,'129-94-0792'), '601-269-7528', 'shabdenk@earthlink.net', 19); --r1 401
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Hirsch', 'Salmoni', 'Male', '1989-12-09', convert(varbinary,'184-25-1698'), '594-603-4427', 'hsalmonil@slate.com', 20); --r1 402
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Grayce', 'Charley', 'Female', '1995-04-06', convert(varbinary,'784-29-8187'), '431-896-7366', 'gcharleym@so-net.ne.jp', 20); --r1 402
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Kassie', 'Whether', 'Female', '1998-09-09', convert(varbinary,'407-37-1573'), '691-926-4392', 'kwhethern@sohu.com', 20); --r1 402
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Rem', 'Tebbutt', 'Male', '1999-01-28', convert(varbinary,'313-90-9277'), '248-835-8370', 'rtebbutto@typepad.com', 20); --r1 402
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Hymie', 'Cattlow', 'Male', '2000-01-25', convert(varbinary,'362-96-3258'), '157-309-8962', 'hcattlowp@printfriendly.com', 21); --r2 101
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Mallissa', 'Rubberts', 'Female', '2001-01-09', convert(varbinary,'788-55-8783'), '246-192-0987', 'mrubbertsq@wsj.com', 22);  --r2 102
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Cliff', 'Clelland', 'Male', '2000-03-17', convert(varbinary,'561-36-4626'), '984-117-2502', 'cclellandr@yellowbook.com', 23);  --r2 103
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Etta', 'Guilliland', 'Female', '1994-09-08', convert(varbinary,'235-65-5435'), '871-197-2292', 'eguillilands@gravatar.com', 24);  --r2 104
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Sergio', 'McGuirk', 'Male', '1994-12-13', convert(varbinary,'886-73-3162'), '451-929-8816', 'smcguirkt@tiny.cc', 25); --r2 201
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Reed', 'Dibbert', 'Male', '1984-07-27', convert(varbinary,'503-52-0569'), '249-533-2101', 'rdibbert0@fastcompany.com', 25); --r2 201
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Tristam', 'Caen', 'Male', '1991-05-03', convert(varbinary,'785-38-4856'), '778-414-2197', 'tcaeng@washingtonpost.com', 26); --r2 202
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Raye', 'Arndtsen', 'Female', '1975-03-22', convert(varbinary,'222-72-9138'), '559-350-4875', 'rarndtsenh@bing.com', 26); --r2 202
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Donia', 'Bartelet', 'Female', '1993-07-20', convert(varbinary,'221-06-1630'), '779-173-8840', 'dbartelet1@stanford.edu', 27); --r2 301
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Lenette', 'Launder', 'Female', '1981-06-03', convert(varbinary,'278-51-2587'), '329-621-7746', 'llaunder2@shutterfly.com', 27); --r2 301
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Reggie', 'Mattheus', 'Male', '2001-04-22', convert(varbinary,'552-34-1169'), '262-409-3963', 'rmattheus3@etsy.com', 27); --r2 301
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Jeremias', 'Sherebrook', 'Male', '1991-09-11', convert(varbinary,'374-62-4983'), '396-309-5646', 'jsherebrook4@ucoz.com', 28); --r2 302
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Stefano', 'Timlett', 'Male', '1985-07-19', convert(varbinary,'624-01-1110'), '588-106-4670', 'stimlett5@marketwatch.com', 28); --r2 302
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Brade', 'Morgan', 'Male', '1993-03-29', convert(varbinary,'116-38-5363'), '284-846-1390', 'bmorgan6@arizona.edu', 28); --r2 302
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Sansone', 'Racine', 'Male', '1997-09-25', convert(varbinary,'354-25-4613'), '879-612-9158', 'sracine7@tumblr.com', 29); --r2 401
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Koralle', 'Gronno', 'Female', '1979-08-25', convert(varbinary,'267-84-8858'), '463-490-7442', 'kgronno8@biglobe.ne.jp', 29); --r2 401
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Henderson', 'Grigolon', 'Male', '1980-08-29', convert(varbinary,'579-47-8628'), '984-229-9715', 'hgrigolon9@creativecommons.org', 29); --r2 401
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Loleta', 'Annes', 'Female', '1985-07-08', convert(varbinary,'320-85-4409'), '896-921-8008', 'lannesa@gizmodo.com', 29); --r2 401
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Cash', 'Eyer', 'Male', '1999-01-29', convert(varbinary,'793-08-9535'), '771-122-8053', 'ceyerb@gov.uk', 30); --r2 402
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Loren', 'Bratt', 'Male', '1990-01-19', convert(varbinary,'145-11-1374'), '118-372-4486', 'lbrattc@alexa.com', 30); --r2 402
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Holly', 'Vasovic', 'Male', '1979-10-16', convert(varbinary,'851-09-0462'), '509-594-3520', 'hvasovicd@msu.edu', 30); --r2 402
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Iorgo', 'Ranscombe', 'Male', '1991-01-20', convert(varbinary,'766-04-2229'), '680-250-6083', 'iranscombee@taobao.com', 30); --r2 402
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Ashley', 'Beckmann', 'Female', '2001-03-04', convert(varbinary,'330-27-1859'), '924-301-3393', 'abeckmannn@bigcartel.com', null); --l3
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Gauthier', 'Cosstick', 'Male', '1994-10-02', convert(varbinary,'146-75-1256'), '642-194-5246', 'gcosstickf@sun.com', 31); --r3
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Tristam', 'Caen', 'Male', '1991-05-03', convert(varbinary,'785-38-4856'), '778-414-2197', 'tcaeng@washingtonpost.com', null); --l4
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Raye', 'Arndtsen', 'Female', '1975-03-22', convert(varbinary,'222-72-9138'), '559-350-4875', 'rarndtsenh@bing.com', 32); --r4
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Caryl', 'Simmans', 'Male', '1991-10-24', convert(varbinary,'878-73-1916'), '827-598-5293', 'csimmansi@google.co.jp', null); --l5
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Gauthier', 'Cosstick', 'Male', '1994-10-02', convert(varbinary,'146-75-1256'), '642-194-5246', 'gcosstickf@sun.com', 33); --r5
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Tristam', 'Caen', 'Male', '1991-05-03', convert(varbinary,'785-38-4856'), '778-414-2197', 'tcaeng@washingtonpost.com', null); --l6
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Gauthier', 'Cosstick', 'Male', '1994-10-02', convert(varbinary,'146-75-1256'), '642-194-5246', 'gcosstickf@sun.com', 34);--r6
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Ina', 'Blayney', 'Male', '2001-01-09', convert(varbinary,'818-15-1797'), '185-205-9433', 'iblayneyf@twitpic.com', null);--potential
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Guilbert', 'De Vaux', 'Male', '2001-09-01', convert(varbinary,'221-71-6742'), '745-996-2795', 'gdevauxg@phpbb.com', null);--potential
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Obadiah', 'Schottli', 'Male', '1999-09-09', convert(varbinary,'869-98-7112'), '681-343-3847', 'oschottlih@army.mil', null);--potential
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Corly', 'Zorzetti', 'Male', '1997-12-10', convert(varbinary,'195-83-7252'), '776-157-3581', 'czorzettii@sciencedirect.com', null);--potential
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Olenolin', 'Charte', 'Male', '1999-12-12', convert(varbinary,'807-97-6840'), '754-819-7949', 'ochartej@toplist.cz', null);--potential
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Inaad', 'Blayndey', 'Male', '2000-01-09', convert(varbinary,'817-15-1797'), '195-205-9433', 'iblyneyf@twitpic.com', null);--potential
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Guilb', 'De Va', 'Male', '2001-09-01', convert(varbinary,'221-01-6742'), '745-996-2795', 'gdevauxg@phpbb.com', null);--potential
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Obad', 'Schoi', 'FeMale', '1998-09-09', convert(varbinary,'889-98-7112'), '671-343-3847', 'oschottlih@army.mil', null);--potential
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Cor', 'Zetti', 'FeMale', '1997-12-10', convert(varbinary,'195-81-7252'), '775-157-3581', 'czorzettii@sciencedirect.com', null);--potential
INSERT INTO dbo.PersonalInformation(first_name, Last_name, gender, DOB, SSN, phone, email, address_id)
VALUES
	('Ole', 'Cha', 'FeMale', '1999-10-12', convert(varbinary,'801-97-6840'), '754-819-1234', 'ochart@toplist.cz', null);--potential

INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Forbes','Shuter','Male','1980-07-09','130-310-1527','fshuter0@ehow.com',237,convert(varbinary,'205-12-0273'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Anett','Vedikhov','Female','1998-10-10','786-358-7771','avedikhov1@oakley.com',416,convert(varbinary,'188-57-6419'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Joanie','Figgess','Female','1974-09-25','475-170-2716','jfiggess2@amazon.com',314,convert(varbinary,'314-73-5520'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Brnaby','Francescuccio','Polygender','1974-03-13','508-437-1794','bfrancescuccio3@yandex.ru',318,convert(varbinary,'823-49-5735'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Tami','Franiak','Female','2001-03-13','806-286-8095','tfraniak4@cdbaby.com',254,convert(varbinary,'603-89-3552'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Nara','Hackley','Female','1987-01-04','814-536-2956','nhackley5@reddit.com',431,convert(varbinary,'589-51-2309'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Gweneth','Swenson','Female','1983-05-04','349-696-1940','gswenson6@cornell.edu',308,convert(varbinary,'696-75-1816'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Melinde','Jamme','Female','1993-02-13','798-381-7914','mjamme7@twitpic.com',260,convert(varbinary,'584-24-0449'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Frasquito','Cumberlidge','Male','1978-01-15','583-435-0681','fcumberlidge8@soundcloud.com',431,convert(varbinary,'669-58-0326'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Hashim','Ector','Male','2001-09-15','907-578-7803','hector9@ezinearticles.com',365,convert(varbinary,'515-58-6012'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Gerta','Whalley','Female','2002-05-03','226-412-5232','gwhalleya@oracle.com',297,convert(varbinary,'176-62-6130'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Abbe','Coddington','Male','1987-02-18','954-203-7314','acoddingtonb@mapquest.com',290,convert(varbinary,'311-03-9501'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Engracia','Eastwell','Female','2000-04-05','504-217-2355','eeastwellc@thetimes.co.uk',260,convert(varbinary,'478-24-4898'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Aylmar','Brauner','Male','1999-12-01','298-697-9080','abraunerd@prnewswire.com',427,convert(varbinary,'502-05-3042'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Madelin','Bendik','Female','2000-09-26','942-275-5092','mbendike@springer.com',417,convert(varbinary,'422-34-3882'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Rockey','Gavagan','Male','1990-06-09','803-413-0688','rgavaganf@w3.org',277,convert(varbinary,'330-64-6910'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Silvan','Simony','Male','1982-08-13','154-342-8553','ssimonyg@umn.edu',268,convert(varbinary,'579-53-2006'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Aubrette','Gosz','Female','1973-03-12','190-206-1246','agoszh@usda.gov',271,convert(varbinary,'219-25-1167'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Lucretia','Maloney','Genderqueer','1987-07-11','516-329-6147','lmaloneyi@vimeo.com',324,convert(varbinary,'355-25-0838'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Yvon','Coldridge','Male','1978-07-10','749-430-6745','ycoldridgej@odnoklassniki.ru',414,convert(varbinary,'587-55-9691'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Alysa','Sleney','Female','1983-01-30','764-723-6643','asleneyk@discuz.net',384,convert(varbinary,'257-75-8805'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Buckie','Heffy','Male','1979-01-24','662-750-9652','bheffyl@blinklist.com',388,convert(varbinary,'267-25-7518'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Morgana','Blakeslee','Female','1989-02-17','921-549-4042','mblakesleem@berkeley.edu',285,convert(varbinary,'661-60-2306'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Roxi','Beals','Female','1989-08-06','754-143-5314','rbealsn@ask.com',358,convert(varbinary,'635-84-8573'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Husein','Fuzzey','Male','1979-05-28','124-184-0342','hfuzzeyo@psu.edu',313,convert(varbinary,'330-17-3948'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Erwin','Gillman','Male','1974-04-29','441-498-8729','egillmanp@hugedomains.com',375,convert(varbinary,'588-09-9666'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Silvia','Yurevich','Female','1999-07-18','667-656-5966','syurevichq@va.gov',385,convert(varbinary,'453-08-5390'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Bria','Lemmen','Female','1997-06-27','865-566-1874','blemmenr@creativecommons.org',375,convert(varbinary,'320-79-5358'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Bette-ann','Ham','Female','1975-03-05','175-490-1974','bhams@google.pl',317,convert(varbinary,'745-74-7955'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Rolf','Eveleigh','Male','1997-07-11','971-996-9936','reveleight@webmd.com',244,convert(varbinary,'896-91-2325'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Emeline','Woolvin','Female','1989-05-27','233-454-9075','ewoolvinu@xinhuanet.com',360,convert(varbinary,'587-57-9507'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Dalton','Varne','Male','1993-03-01','449-101-1563','dvarnev@php.net',405,convert(varbinary,'596-86-5051'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Karim','McMichan','Male','1985-03-09','964-334-0579','kmcmichanw@blog.com',253,convert(varbinary,'819-38-5396'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Nani','Schutze','Female','1978-01-17','751-869-2456','nschutzex@printfriendly.com',420,convert(varbinary,'355-69-7594'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Land','Rabbitt','Agender','1977-09-27','642-917-2576','lrabbitty@boston.com',264,convert(varbinary,'789-19-8488'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Joshua','Ambroise','Non-binary','1985-08-21','695-920-9727','jambroisez@sfgate.com',324,convert(varbinary,'582-30-7488'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Perry','Kilborn','Polygender','1978-09-13','744-660-9147','pkilborn10@unblog.fr',236,convert(varbinary,'754-69-0722'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Bank','ONeal','Male','1993-05-31','615-963-8917','boneal11@addthis.com',356,convert(varbinary,'723-48-5276'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Herschel','Cardoso','Male','1974-01-17','393-653-3623','hcardoso12@cargocollective.com',373,convert(varbinary,'300-93-2271'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Josefina','Holtaway','Female','1973-10-01','528-515-8254','jholtaway13@latimes.com',372,convert(varbinary,'651-56-7192'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Worthington','Bonelle','Male','1975-01-13','988-407-6575','wbonelle14@lycos.com',381,convert(varbinary,'739-43-7068'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Micheal','Gedling','Male','1978-11-12','479-745-1507','mgedling15@umn.edu',302,convert(varbinary,'673-84-5389'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Derrick','Everwin','Male','1991-11-08','236-671-7718','deverwin16@cyberchimps.com',395,convert(varbinary,'142-93-8448'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Cory','Kenforth','Male','1998-06-11','170-919-3894','ckenforth17@goodreads.com',236,convert(varbinary,'239-30-9214'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Dyan','Petriello','Genderqueer','1990-09-17','208-569-2793','dpetriello18@google.fr',305,convert(varbinary,'400-55-7950'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Dasha','McAusland','Female','1990-09-07','246-517-3452','dmcausland19@twitter.com',249,convert(varbinary,'639-44-5793'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Rosella','Holtum','Female','1993-04-10','394-541-4782','rholtum1a@hatena.ne.jp',428,convert(varbinary,'387-57-2156'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Jessalyn','Ells','Female','2002-04-30','195-673-5854','jells1b@jimdo.com',431,convert(varbinary,'782-08-2795'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Berny','Gregs','Non-binary','1983-06-24','908-468-0012','bgregs1c@seattletimes.com',396,convert(varbinary,'806-84-1621'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Charisse','Stickney','Female','1989-01-08','527-202-3984','cstickney1d@i2i.jp',383,convert(varbinary,'296-89-9122'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Mellisent','Dyke','Female','1993-11-01','819-670-2180','mdyke1e@bloomberg.com',379,convert(varbinary,'833-80-7273'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Eleonora','Revie','Female','1984-06-23','866-147-8345','erevie1f@bing.com',407,convert(varbinary,'661-49-4206'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Sisely','Gilford','Female','1997-05-14','653-964-1895','sgilford1g@instagram.com',347,convert(varbinary,'824-40-8491'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Abbot','Sekulla','Male','1995-05-01','725-449-9930','asekulla1h@businesswire.com',369,convert(varbinary,'457-52-8157'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Quinlan','Doerffer','Male','1986-08-12','795-251-2888','qdoerffer1i@forbes.com',345,convert(varbinary,'166-05-8579'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Lauri','Tuffin','Female','1980-07-29','347-975-1387','ltuffin1j@intel.com',364,convert(varbinary,'819-07-9171'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Bartholomeus','Pawle','Male','1977-10-23','162-356-4153','bpawle1k@myspace.com',406,convert(varbinary,'149-72-0723'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Davidde','Morfett','Male','2002-05-22','571-256-0850','dmorfett1l@jiathis.com',317,convert(varbinary,'244-72-2886'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Wallache','Silbersak','Male','1977-04-07','188-770-6609','wsilbersak1m@unesco.org',375,convert(varbinary,'698-90-1963'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Ralf','Franchi','Male','1989-09-09','280-806-5825','rfranchi1n@cmu.edu',344,convert(varbinary,'392-78-8110'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Maurene','Charlin','Female','1975-10-28','284-842-2838','mcharlin1o@irs.gov',379,convert(varbinary,'149-95-8496'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Darrin','Mepham','Male','1998-08-22','917-539-6062','dmepham1p@yolasite.com',259,convert(varbinary,'223-70-2306'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Freddy','Leebetter','Female','1983-05-12','644-457-6393','fleebetter1q@about.me',341,convert(varbinary,'886-29-5958'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Salaidh','Greystock','Female','1985-03-13','609-164-6009','sgreystock1r@fema.gov',255,convert(varbinary,'499-41-1091'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Doro','Nesey','Female','1996-08-29','232-518-2135','dnesey1s@jalbum.net',322,convert(varbinary,'230-89-7664'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Lauralee','Kibard','Female','1994-04-06','862-984-5637','lkibard1t@sitemeter.com',246,convert(varbinary,'470-70-9722'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Sylvan','Woolsey','Male','1973-01-07','595-369-3327','swoolsey1u@tmall.com',287,convert(varbinary,'385-85-3737'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Gerladina','Quantrill','Polygender','1973-07-06','150-478-6424','gquantrill1v@hatena.ne.jp',365,convert(varbinary,'216-85-0255'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Persis','Boyall','Female','1985-08-03','737-778-2348','pboyall1w@ed.gov',405,convert(varbinary,'247-43-9030'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Jakob','Calven','Male','1978-12-21','812-808-0976','jcalven1x@hostgator.com',420,convert(varbinary,'502-16-1547'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Hubey','Alleyn','Male','2002-08-18','506-915-9747','halleyn1y@wordpress.org',329,convert(varbinary,'554-26-2555'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('George','Maccrie','Male','1992-06-24','418-990-5165','gmaccrie1z@hugedomains.com',262,convert(varbinary,'213-65-6119'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Maritsa','Sherington','Female','1993-03-06','940-159-1068','msherington20@cnbc.com',276,convert(varbinary,'137-95-9633'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Aldwin','Morrison','Male','1990-10-19','236-451-8704','amorrison21@marriott.com',258,convert(varbinary,'566-71-5226'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Myrna','Toxell','Female','1988-02-01','702-226-5812','mtoxell22@meetup.com',376,convert(varbinary,'670-85-2972'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Leonard','Sapp','Male','1995-05-27','803-812-9622','lsapp23@boston.com',382,convert(varbinary,'880-96-3500'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Gill','Greger','Male','1973-01-25','721-341-8686','ggreger24@google.fr',236,convert(varbinary,'609-87-6879'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Clarinda','Werendell','Female','1993-03-19','257-677-0076','cwerendell25@ed.gov',414,convert(varbinary,'713-57-4286'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Lucy','Putterill','Female','1974-03-09','524-548-9647','lputterill26@wp.com',434,convert(varbinary,'254-01-1050'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Emera','Marques','Female','1978-12-01','852-920-6164','emarques27@imgur.com',368,convert(varbinary,'745-69-7932'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Kenyon','Phillps','Male','1997-09-24','935-622-1030','kphillps28@google.nl',310,convert(varbinary,'480-59-1817'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Miner','Dowry','Male','2002-01-01','872-283-4934','mdowry29@bloglines.com',335,convert(varbinary,'154-12-6291'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Ailey','Casiero','Female','1980-09-14','583-685-6109','acasiero2a@hexun.com',237,convert(varbinary,'814-60-0594'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Tiphani','Trencher','Female','1991-09-21','460-588-6396','ttrencher2b@ameblo.jp',432,convert(varbinary,'421-06-4484'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Gustav','Mazillius','Male','2001-09-25','504-216-4803','gmazillius2c@cbc.ca',370,convert(varbinary,'530-89-6838'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Ulysses','Garfath','Male','1975-12-11','865-255-4856','ugarfath2d@forbes.com',302,convert(varbinary,'898-84-4667'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Erich','Sandeland','Male','1998-10-24','824-432-0235','esandeland2e@w3.org',327,convert(varbinary,'675-98-6305'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Land','Borleace','Male','1980-06-01','817-147-9564','lborleace2f@businessinsider.com',412,convert(varbinary,'609-61-5179'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Lonna','Joreau','Non-binary','2003-09-28','321-369-2804','ljoreau2g@answers.com',371,convert(varbinary,'304-62-8413'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Sula','Whittington','Female','1992-09-07','211-118-9328','swhittington2h@yale.edu',390,convert(varbinary,'174-97-6536'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Leeann','Mewburn','Female','1982-10-18','463-100-7767','lmewburn2i@csmonitor.com',343,convert(varbinary,'667-08-0297'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Agace','Colcomb','Female','2001-02-05','369-753-2182','acolcomb2j@is.gd',300,convert(varbinary,'124-65-0459'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Ursula','Fairchild','Female','1980-03-14','924-168-8126','ufairchild2k@rambler.ru',432,convert(varbinary,'181-85-3109'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Rorke','Truscott','Male','1992-04-14','753-789-3245','rtruscott2l@soundcloud.com',323,convert(varbinary,'114-97-3575'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Burt','Lesurf','Male','1988-08-15','213-405-5006','blesurf2m@nps.gov',330,convert(varbinary,'414-80-6741'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Barbara-anne','St Pierre','Bigender','1988-03-26','508-760-1266','bstpierre2n@blogs.com',410,convert(varbinary,'147-71-5139'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Ardisj','Halfhyde','Female','1979-01-11','323-751-7384','ahalfhyde2o@1und1.de',266,convert(varbinary,'353-68-0820'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Emyle','Claxton','Female','1992-02-21','939-479-7634','eclaxton2p@drupal.org',374,convert(varbinary,'500-40-1061'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Ikey','Burge','Male','1996-09-28','899-681-8991','iburge2q@illinois.edu',381,convert(varbinary,'730-39-8770'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Rhodia','Hearl','Female','1997-06-09','829-736-0906','rhearl2r@youtube.com',414,convert(varbinary,'293-60-1076'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Tiffy','Kapiloff','Female','1977-10-20','401-361-9899','tkapiloff2s@abc.net.au',335,convert(varbinary,'775-60-6992'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Florence','Antcliffe','Female','1974-02-07','865-872-6155','fantcliffe2t@blog.com',301,convert(varbinary,'412-35-6088'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Shannan','Featherstonhaugh','Male','2003-04-29','475-128-4029','sfeatherstonhaugh2u@yellowbook.com',299,convert(varbinary,'353-31-3286'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Daryle','Morewood','Male','1984-01-28','354-867-4929','dmorewood2v@livejournal.com',236,convert(varbinary,'486-36-3768'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Mavra','Jindra','Female','1999-07-25','842-346-6664','mjindra2w@ask.com',322,convert(varbinary,'231-63-3123'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Chandra','Burstow','Female','1999-01-03','490-784-6084','cburstow2x@infoseek.co.jp',262,convert(varbinary,'671-83-8039'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Hyacinthie','Scotts','Female','2002-10-19','786-230-8703','hscotts2y@slashdot.org',332,convert(varbinary,'600-82-1184'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Goldia','Rawsthorne','Female','1988-08-05','141-875-6067','grawsthorne2z@adobe.com',347,convert(varbinary,'361-33-2411'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Prudence','Welds','Genderfluid','1983-06-08','451-153-2935','pwelds30@digg.com',244,convert(varbinary,'672-97-5632'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Tessy','Fairfoot','Female','1988-09-22','770-283-1955','tfairfoot31@woothemes.com',256,convert(varbinary,'707-99-7826'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Thorpe','Nezey','Male','1998-04-30','908-185-0758','tnezey32@mail.ru',384,convert(varbinary,'439-80-9235'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Daisi','Croyser','Female','1983-06-24','717-618-1315','dcroyser33@chicagotribune.com',240,convert(varbinary,'873-45-7484'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Emlyn','Lavies','Agender','1975-04-04','775-986-0964','elavies34@weibo.com',267,convert(varbinary,'392-47-0303'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Hermione','Levett','Bigender','1999-05-20','110-962-2331','hlevett35@sourceforge.net',339,convert(varbinary,'667-81-5577'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Barret','Grandisson','Male','1975-06-13','846-690-3881','bgrandisson36@hatena.ne.jp',240,convert(varbinary,'328-83-2999'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Lazarus','Linford','Male','1986-02-24','254-861-4486','llinford37@globo.com',292,convert(varbinary,'835-25-1402'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Nicolais','Lyle','Male','2002-08-23','309-136-4018','nlyle38@theglobeandmail.com',263,convert(varbinary,'187-95-7873'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Cathe','Pipet','Non-binary','1976-04-30','491-105-8781','cpipet39@stanford.edu',239,convert(varbinary,'648-80-0026'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Worth','Hammerich','Male','1997-01-23','852-736-0017','whammerich3a@globo.com',248,convert(varbinary,'511-85-8537'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Lon','Clothier','Agender','2000-01-29','943-797-4812','lclothier3b@salon.com',387,convert(varbinary,'475-41-9377'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Quintana','Pinchin','Female','1973-02-02','611-957-6703','qpinchin3c@cloudflare.com',364,convert(varbinary,'766-59-2381'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Odette','Willoughey','Polygender','1980-07-17','208-141-3399','owilloughey3d@usatoday.com',366,convert(varbinary,'482-94-9702'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Cesare','Benning','Male','1984-03-20','686-923-2890','cbenning3e@aol.com',327,convert(varbinary,'529-63-1936'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Livvie','Shelf','Agender','1997-02-12','959-616-0224','lshelf3f@oracle.com',263,convert(varbinary,'772-14-3534'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Ermanno','Sproson','Male','1995-09-29','260-962-5417','esproson3g@google.ru',366,convert(varbinary,'622-55-9045'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Kincaid','Bresland','Male','1990-02-10','992-352-8586','kbresland3h@irs.gov',428,convert(varbinary,'767-15-7031'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Cly','Gencke','Male','1991-05-09','794-262-7433','cgencke3i@ebay.co.uk',270,convert(varbinary,'142-81-5224'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Jacenta','Venney','Polygender','1985-05-27','187-623-8227','jvenney3j@prlog.org',373,convert(varbinary,'474-85-7810'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Enrica','Groucock','Female','2003-02-15','680-266-9077','egroucock3k@un.org',354,convert(varbinary,'753-60-6216'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Elyse','Tasseler','Female','1985-05-26','325-559-0702','etasseler3l@noaa.gov',279,convert(varbinary,'893-12-4512'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Floyd','Halifax','Male','1979-08-09','586-728-4457','fhalifax3m@friendfeed.com',376,convert(varbinary,'105-57-6891'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Timofei','Helsdon','Male','1986-01-05','668-369-7138','thelsdon3n@deviantart.com',256,convert(varbinary,'773-25-3119'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Doreen','Ewen','Female','1995-09-28','621-776-3879','dewen3o@google.com.br',401,convert(varbinary,'652-02-7477'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Grover','Wolseley','Male','1986-08-10','936-781-5551','gwolseley3p@narod.ru',385,convert(varbinary,'404-68-8036'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Ignace','Rentcome','Male','1988-08-18','959-171-2269','irentcome3q@yahoo.co.jp',374,convert(varbinary,'117-31-5748'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Caresse','Tuddenham','Female','2000-09-26','317-109-4622','ctuddenham3r@odnoklassniki.ru',299,convert(varbinary,'331-34-9482'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Robby','Lutton','Male','1979-06-22','593-272-6387','rlutton3s@chronoengine.com',257,convert(varbinary,'304-84-0074'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Elisha','Pescott','Male','2000-03-18','471-774-4801','epescott3t@wikispaces.com',237,convert(varbinary,'310-67-2717'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Jayne','Vanyushin','Female','1990-10-03','640-857-1728','jvanyushin3u@gizmodo.com',282,convert(varbinary,'258-93-5691'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Salome','Klimecki','Female','2003-09-13','994-549-2663','sklimecki3v@cnbc.com',237,convert(varbinary,'265-18-5838'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Ardyth','French','Female','1973-07-20','357-564-4256','afrench3w@infoseek.co.jp',266,convert(varbinary,'206-99-4587'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Erika','Morcom','Female','2000-03-18','107-599-2590','emorcom3x@google.co.jp',321,convert(varbinary,'375-35-8772'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Lazarus','Deviney','Male','1985-03-13','945-575-1915','ldeviney3y@oaic.gov.au',354,convert(varbinary,'165-16-1743'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Cristian','Nickoles','Male','1987-06-16','203-907-1316','cnickoles3z@canalblog.com',429,convert(varbinary,'544-52-5031'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Nefen','Ketteridge','Male','1986-12-31','321-866-8277','nketteridge40@123-reg.co.uk',357,convert(varbinary,'539-98-2031'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Verge','Brayfield','Male','1974-07-16','903-448-2334','vbrayfield41@google.es',331,convert(varbinary,'249-54-0686'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Lester','Rogeon','Male','1976-03-27','386-910-3012','lrogeon42@microsoft.com',282,convert(varbinary,'753-21-6020'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Kristin','Bransden','Female','1982-12-24','480-427-7101','kbransden43@youku.com',314,convert(varbinary,'316-72-6679'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Mick','Einchcombe','Male','1982-07-17','658-194-4649','meinchcombe44@behance.net',240,convert(varbinary,'460-04-7187'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Ely','Brimmell','Male','1974-05-30','231-363-3838','ebrimmell45@odnoklassniki.ru',415,convert(varbinary,'477-57-6083'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Maurie','Ibbotson','Male','1995-09-20','303-529-2376','mibbotson46@friendfeed.com',395,convert(varbinary,'664-21-5690'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Bambi','MacLice','Female','1990-07-20','945-514-2402','bmaclice47@google.co.jp',395,convert(varbinary,'819-10-4850'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Ilka','Fewlass','Female','1987-12-22','563-206-6222','ifewlass48@jimdo.com',419,convert(varbinary,'142-25-3033'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Kirbie','Cleghorn','Female','1992-03-01','822-770-2616','kcleghorn49@mlb.com',310,convert(varbinary,'143-63-7023'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Janis','Zoephel','Female','1975-01-11','128-991-2618','jzoephel4a@ameblo.jp',300,convert(varbinary,'461-92-6613'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Adora','Dowdall','Female','1999-02-22','320-973-4510','adowdall4b@sfgate.com',355,convert(varbinary,'720-56-7501'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Eal','Jaray','Agender','1985-04-26','299-381-5132','ejaray4c@deliciousdays.com',346,convert(varbinary,'206-30-5854'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Vivia','Garlette','Female','1997-01-08','797-937-9361','vgarlette4d@gnu.org',308,convert(varbinary,'439-88-2076'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Germana','Dowda','Female','1974-07-26','198-493-4613','gdowda4e@yellowpages.com',251,convert(varbinary,'311-31-7137'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Meyer','Chyuerton','Male','1979-06-22','541-563-0499','mchyuerton4f@cafepress.com',371,convert(varbinary,'894-16-0687'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Eudora','Shevlane','Female','1989-02-16','736-221-4598','eshevlane4g@vimeo.com',236,convert(varbinary,'161-26-1063'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Tate','Keays','Female','1991-02-20','965-612-5476','tkeays4h@exblog.jp',308,convert(varbinary,'623-83-2055'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Bradly','Hanton','Male','1977-04-06','480-241-6896','bhanton4i@utexas.edu',380,convert(varbinary,'198-55-7136'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Candy','Warfield','Female','1999-10-02','243-639-0177','cwarfield4j@ask.com',327,convert(varbinary,'434-03-0215'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Toiboid','Jackways','Male','1987-01-28','179-141-5733','tjackways4k@nydailynews.com',279,convert(varbinary,'315-80-6964'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Daphne','Hyman','Female','1980-05-17','117-111-1890','dhyman4l@cocolog-nifty.com',245,convert(varbinary,'240-31-7076'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Kerwin','Skews','Male','1975-04-27','232-332-8646','kskews4m@vk.com',395,convert(varbinary,'888-44-7963'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Ezekiel','Capelen','Male','1998-10-29','445-902-1053','ecapelen4n@narod.ru',268,convert(varbinary,'245-43-3402'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Clemens','Brotherwood','Polygender','2000-12-25','789-469-3216','cbrotherwood4o@spotify.com',323,convert(varbinary,'509-61-9312'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Diana','Tatford','Female','1989-11-29','443-699-7321','dtatford4p@hud.gov',345,convert(varbinary,'673-61-1789'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Edi','Coast','Female','1987-01-03','240-535-6262','ecoast4q@alibaba.com',255,convert(varbinary,'369-71-0060'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Ulrick','Hylton','Male','1984-03-28','606-567-3978','uhylton4r@pagesperso-orange.fr',281,convert(varbinary,'775-08-7456'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Forrest','Trenbay','Male','1989-03-03','461-283-5762','ftrenbay4s@seattletimes.com',394,convert(varbinary,'276-53-5838'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Griselda','Forryan','Female','1990-11-03','651-733-4406','gforryan4t@purevolume.com',359,convert(varbinary,'836-80-6387'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Cathrine','Avo','Genderfluid','1976-06-18','570-635-8222','cavo4u@archive.org',396,convert(varbinary,'639-91-7608'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Christos','Arlidge','Male','1978-04-08','201-913-0483','carlidge4v@umich.edu',255,convert(varbinary,'260-22-2542'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Reeva','Tremellier','Female','1985-07-31','616-813-0466','rtremellier4w@cnbc.com',245,convert(varbinary,'538-11-1488'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Christy','Tolfrey','Male','1992-09-14','861-808-7530','ctolfrey4x@dot.gov',406,convert(varbinary,'682-66-0335'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Herta','Casham','Female','1978-06-28','665-824-3360','hcasham4y@sciencedirect.com',364,convert(varbinary,'655-43-1926'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Koenraad','Daunay','Male','1999-12-11','903-381-9069','kdaunay4z@hhs.gov',322,convert(varbinary,'460-87-4963'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Modestia','Scouller','Female','1996-04-11','874-854-0595','mscouller50@jalbum.net',309,convert(varbinary,'701-06-6700'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Abagail','Oxby','Female','1998-07-06','324-814-4929','aoxby51@ycombinator.com',420,convert(varbinary,'836-23-5745'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Elianora','Arent','Female','1992-03-18','942-774-1426','earent52@squidoo.com',427,convert(varbinary,'325-46-3941'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Dionisio','Ivushkin','Male','1980-09-01','512-896-8765','divushkin53@parallels.com',244,convert(varbinary,'269-55-2878'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Gayler','Filisov','Male','1999-08-11','878-137-4658','gfilisov54@blogtalkradio.com',346,convert(varbinary,'215-31-9121'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Lauralee','Higgan','Female','1973-04-10','560-162-0678','lhiggan55@ihg.com',402,convert(varbinary,'379-55-4195'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Philomena','Kinchington','Female','1990-10-11','265-470-6634','pkinchington56@github.com',259,convert(varbinary,'897-69-7892'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Domenic','Hourigan','Male','1987-01-23','407-237-5673','dhourigan57@fc2.com',386,convert(varbinary,'753-25-0143'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Amelie','Laydel','Female','1977-10-27','213-377-6469','alaydel58@xrea.com',263,convert(varbinary,'273-98-6521'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Penny','Perigo','Female','1975-09-14','586-402-7607','pperigo59@ftc.gov',291,convert(varbinary,'618-19-3244'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Minni','Spencers','Female','1982-12-27','955-989-0118','mspencers5a@dailymail.co.uk',413,convert(varbinary,'125-36-9147'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Slade','Pearcehouse','Male','1992-08-04','936-817-4036','spearcehouse5b@google.co.uk',412,convert(varbinary,'724-85-7890'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Derward','Schutter','Male','1995-06-30','981-535-1525','dschutter5c@theatlantic.com',423,convert(varbinary,'396-67-6385'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Josy','Elia','Female','1986-11-27','918-753-5062','jelia5d@eepurl.com',277,convert(varbinary,'765-20-9920'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Worden','Cragell','Bigender','2000-06-17','204-568-7305','wcragell5e@etsy.com',372,convert(varbinary,'663-90-7012'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Suzi','Burberye','Female','1977-12-03','605-509-1786','sburberye5f@clickbank.net',397,convert(varbinary,'564-53-9916'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Buddie','Mallan','Male','2000-12-20','628-100-0330','bmallan5g@bandcamp.com',340,convert(varbinary,'893-71-3807'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Davine','Boutflour','Female','1990-01-03','818-692-8050','dboutflour5h@webmd.com',367,convert(varbinary,'670-48-6164'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Alford','Freegard','Male','2003-07-17','641-127-1366','afreegard5i@tripod.com',351,convert(varbinary,'281-36-1406'));
INSERT INTO dbo.personalInformation (first_name,last_name,gender,DOB,phone,email,address_id,SSN) VALUES ('Elladine','Gaze','Female','1986-11-14','844-763-8135','egaze5j@hubpages.com',299,convert(varbinary,'369-67-0742'));

	
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Kalie', 'Bampkin', 'Female', '1976-04-18', convert(varbinary,'755-07-9370'), '679-611-8332', 'kbampkin0@toplist.cz', 293);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Gus', 'Durber', 'Female', '1979-04-27', convert(varbinary,'221-73-0250'), '792-767-2666', 'gdurber1@sun.com', 315);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Filide', 'Tomkowicz', 'Female', '1972-12-05', convert(varbinary,'739-11-6566'), '985-496-6781', 'ftomkowicz2@pinterest.com', 292);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Noreen', 'Junkin', 'Bigender', '1997-10-22', convert(varbinary,'172-42-4790'), '190-115-8264', 'njunkin3@google.co.jp', 234);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Gerhardt', 'Shankster', 'Genderqueer', '1974-01-20', convert(varbinary,'448-76-4176'), '326-949-1276', 'gshankster4@npr.org', 425);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Melisenda', 'Woan', 'Female', '1978-04-04', convert(varbinary,'304-11-1189'), '758-525-2387', 'mwoan5@free.fr', 376);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Cicely', 'Southorn', 'Female', '1983-05-10', convert(varbinary,'735-48-9325'), '721-101-5518', 'csouthorn6@vkontakte.ru', 359);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Bald', 'Gribbon', 'Male', '1997-10-01', convert(varbinary,'749-28-4092'), '694-690-7147', 'bgribbon7@abc.net.au', 292);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Umberto', 'Spoure', 'Male', '1996-06-16', convert(varbinary,'496-64-8678'), '535-802-0779', 'uspoure8@elegantthemes.com', 285);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Ryon', 'Elman', 'Genderqueer', '1987-02-06', convert(varbinary,'490-17-5503'), '161-310-8768', 'relman9@sohu.com', 262);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Davida', 'Lapping', 'Female', '1980-05-08', convert(varbinary,'764-72-5783'), '902-606-9664', 'dlappinga@google.com.br', 377);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Claudius', 'Bastone', 'Male', '1962-05-26', convert(varbinary,'427-92-5892'), '591-379-3275', 'cbastoneb@ihg.com', 265);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Ansel', 'Creaney', 'Male', '1964-09-08', convert(varbinary,'679-74-3606'), '182-500-9700', 'acreaneyc@prweb.com', 277);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Leupold', 'Ary', 'Male', '1967-03-18', convert(varbinary,'298-28-6005'), '501-996-7276', 'laryd@netlog.com', 266);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Silvan', 'MacCahee', 'Male', '1998-01-26', convert(varbinary,'579-17-0192'), '896-675-3585', 'smaccaheep@bloglovin.com', 429);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Hildagarde', 'Ankers', 'Female', '1982-05-04', convert(varbinary,'559-38-4156'), '327-145-1557', 'hankersq@reference.com', 351);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Kippy', 'Cleynman', 'Female', '1998-02-21', convert(varbinary,'747-85-6179'), '503-901-0027', 'kcleynmanr@java.com', 400);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Teddy', 'Illidge', 'Female', '1972-05-05', convert(varbinary,'896-96-2982'), '284-917-7435', 'tillidges@flickr.com', 308);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Palmer', 'Bailie', 'Male', '1963-07-08', convert(varbinary,'486-63-1198'), '279-529-8851', 'pbailiet@msn.com', 297);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Andromache', 'Ropars', 'Female', '1972-09-20', convert(varbinary,'796-06-5236'), '843-924-5491', 'aroparsu@elpais.com', 281);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Gertruda', 'MacIlwrick', 'Female', '1968-10-24', convert(varbinary,'520-85-4632'), '502-369-4416', 'gmacilwrickv@blog.com', 432);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Nessie', 'Weben', 'Polygender', '1985-10-04', convert(varbinary,'115-86-6334'), '955-223-9539', 'nwebenw@psu.edu', 340);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Wash', 'Rayer', 'Male', '1977-02-25', convert(varbinary,'274-48-9812'), '781-534-6607', 'wrayerx@tinyurl.com', 379);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Celie', 'Cazalet', 'Female', '1996-10-26', convert(varbinary,'667-14-6715'), '887-480-8614', 'ccazalety@skype.com', 419);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Perrine', 'Mayze', 'Female', '1978-02-26', convert(varbinary,'281-60-4453'), '246-376-6528', 'pmayzez@wufoo.com', 378);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Ransell', 'Ranyell', 'Genderqueer', '1996-07-02', convert(varbinary,'652-59-8398'), '890-534-5569', 'rranyell10@1688.com', 316);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Jone', 'Chorley', 'Male', '1989-01-08', convert(varbinary,'395-50-5502'), '305-136-0220', 'jchorley13@printfriendly.com', 352);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Nerty', 'Rany', 'Genderfluid', '1996-07-25', convert(varbinary,'107-97-1137'), '107-120-8996', 'nrany14@plala.or.jp', 261);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Correna', 'Jancic', 'Female', '1973-12-22', convert(varbinary,'883-34-4101'), '613-777-0219', 'cjancic15@hao123.com', 270);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Raquel', 'Wretham', 'Genderqueer', '1982-01-07', convert(varbinary,'804-66-9747'), '625-294-5798', 'rwretham16@japanpost.jp', 284);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Mariette', 'Saltmarshe', 'Female', '1982-07-18', convert(varbinary,'401-04-6525'), '421-662-5921', 'msaltmarshe17@thetimes.co.uk', 387);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Clayton', 'Butte', 'Male', '1992-06-28', convert(varbinary,'138-37-9216'), '703-904-8086', 'cbutte18@examiner.com', 294);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Marget', 'Conws', 'Female', '1983-03-21', convert(varbinary,'212-31-2223'), '640-343-9327', 'mconws19@canalblog.com', 363);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Berti', 'Penkman', 'Male', '1993-08-15', convert(varbinary,'699-15-3726'), '982-501-2361', 'bpenkman1a@illinois.edu', 313);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Mollie', 'Tickel', 'Female', '1985-08-14', convert(varbinary,'121-39-3349'), '770-953-7375', 'mtickel1b@mysql.com', 341);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Buffy', 'Stapleton', 'Female', '1976-12-21', convert(varbinary,'376-93-8848'), '873-606-1690', 'bstapleton1c@xinhuanet.com', 309);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Constantino', 'Dowbiggin', 'Male', '1973-02-28', convert(varbinary,'341-43-8070'), '637-351-4077', 'cdowbiggin1d@angelfire.com', 409);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Claudio', 'McManamon', 'Male', '1973-10-19', convert(varbinary,'554-36-7298'), '859-790-7597', 'cmcmanamon1e@about.me', 257);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Gabbie', 'Doorly', 'Female', '1971-05-11', convert(varbinary,'478-67-6889'), '352-399-7553', 'gdoorly1f@weibo.com', 356);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Thomasina', 'Mandre', 'Bigender', '1995-11-07', convert(varbinary,'249-23-8612'), '473-445-9103', 'tmandre1g@ning.com', 339);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Kathy', 'Ditter', 'Female', '1962-07-24', convert(varbinary,'720-17-8705'), '237-102-9760', 'kditter1h@microsoft.com', 389);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Maxy', 'Thurman', 'Genderqueer', '1962-10-10', convert(varbinary,'101-28-1269'), '984-290-3633', 'mthurman1i@pcworld.com', 295);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Brandyn', 'Driscoll', 'Male', '1981-02-12', convert(varbinary,'657-23-7714'), '581-129-8399', 'bdriscoll1j@zdnet.com', 274);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Truda', 'Willoughby', 'Female', '1970-07-28', convert(varbinary,'210-77-1918'), '446-826-3548', 'twilloughby1k@edublogs.org', 344);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Colin', 'Ilieve', 'Male', '1997-02-11', convert(varbinary,'376-30-9211'), '661-692-6477', 'cilieve1l@telegraph.co.uk', 351);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Gil', 'Speechley', 'Male', '1968-07-25', convert(varbinary,'757-87-6132'), '709-591-9730', 'gspeechley1m@cargocollective.com', 240);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Merrilee', 'Francey', 'Female', '1979-07-09', convert(varbinary,'414-86-7521'), '879-109-3115', 'mfrancey1n@hugedomains.com', 324);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Hilliary', 'Archanbault', 'Female', '1973-12-05', convert(varbinary,'155-88-2986'), '767-987-8039', 'harchanbault1o@meetup.com', 401);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Cliff', 'Asquez', 'Male', '1968-01-28', convert(varbinary,'650-58-8456'), '327-555-2837', 'casquez1p@netscape.com', 279);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Lian', 'Duhig', 'Female', '1967-01-14', convert(varbinary,'337-37-6394'), '703-193-8500', 'lduhig1q@e-recht24.de', 262);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Lorenzo', 'Runacres', 'Male', '1988-05-30', convert(varbinary,'272-74-0125'), '273-972-6556', 'lrunacres1r@sciencedirect.com', 435);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Perri', 'Brecknock', 'Female', '1983-12-06', convert(varbinary,'807-62-2359'), '220-107-2291', 'pbrecknock1s@army.mil', 275);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Bee', 'Peery', 'Female', '1960-06-16', convert(varbinary,'824-43-5566'), '926-989-5666', 'bpeery1t@creativecommons.org', 338);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Barbabra', 'Collens', 'Female', '1962-08-22', convert(varbinary,'802-26-5693'), '328-183-7773', 'bcollens1u@bravesites.com', 297);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Cornelius', 'Timmes', 'Male', '1969-08-16', convert(varbinary,'590-37-5559'), '905-723-0769', 'ctimmes1v@is.gd', 325);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Zacharia', 'Crombie', 'Male', '1972-07-09', convert(varbinary,'358-69-9440'), '472-106-0040', 'zcrombie1w@sohu.com', 355);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Clayborne', 'Keelinge', 'Male', '1984-02-02', convert(varbinary,'311-55-8363'), '743-819-5396', 'ckeelinge1x@opera.com', 253);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Reg', 'Rookesby', 'Male', '1996-01-20', convert(varbinary,'464-78-9348'), '224-954-5673', 'rrookesby1y@businessinsider.com', 248);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Tamarra', 'Jirak', 'Female', '1962-03-04', convert(varbinary,'644-13-9394'), '263-718-0585', 'tjirak1z@yahoo.co.jp', 312);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Anatola', 'Iacoboni', 'Female', '1992-09-10', convert(varbinary,'114-38-1228'), '519-477-4051', 'aiacoboni20@cornell.edu', 285);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Damian', 'Liddiard', 'Male', '1968-09-04', convert(varbinary,'503-55-9652'), '761-726-8797', 'dliddiard21@comcast.net', 305);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Alvie', 'Toffoloni', 'Male', '1962-04-14', convert(varbinary,'201-52-1724'), '121-235-3549', 'atoffoloni22@people.com.cn', 409);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Corey', 'Taplow', 'Female', '1979-03-25', convert(varbinary,'368-25-4110'), '330-505-3145', 'ctaplow23@cnbc.com', 412);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Heall', 'Girodin', 'Male', '1976-02-13', convert(varbinary,'834-98-1822'), '652-649-6124', 'hgirodin24@ucoz.com', 261);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Brewster', 'Swarbrigg', 'Male', '1969-02-07', convert(varbinary,'531-91-0113'), '522-550-7857', 'bswarbrigg25@imdb.com', 342);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Lois', 'Ambrogini', 'Female', '1980-12-10', convert(varbinary,'377-13-6266'), '462-408-8438', 'lambrogini26@bloglines.com', 351);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Dwain', 'Spooner', 'Male', '1991-05-19', convert(varbinary,'470-19-6068'), '389-916-7507', 'dspooner27@hugedomains.com', 269);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Aleen', 'Ayliffe', 'Female', '1976-08-22', convert(varbinary,'673-89-6543'), '454-383-9965', 'aayliffe28@nsw.gov.au', 432);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Walliw', 'Buntine', 'Female', '1962-06-08',convert(varbinary, '282-26-1901'), '141-458-3113', 'wbuntine29@usgs.gov', 327);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Bing', 'MacCaughan', 'Male', '1990-12-29', convert(varbinary,'711-72-4828'), '144-806-0247', 'bmaccaughan2a@sina.com.cn', 289);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Brockie', 'Nolli', 'Male', '1967-05-02', convert(varbinary,'604-40-2321'), '673-352-1899', 'bnolli2b@hc360.com', 270);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Marchall', 'Snedden', 'Bigender', '1978-01-03', convert(varbinary,'779-95-7955'), '998-818-1983', 'msnedden2c@nytimes.com', 286);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Marjy', 'Caveney', 'Non-binary', '1999-01-09',convert(varbinary, '716-81-9010'), '244-502-3704', 'mcaveney2d@dyndns.org', 389);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Cordula', 'Faragan', 'Bigender', '1991-04-17', convert(varbinary,'444-58-8760'), '513-980-8680', 'cfaragan2e@fotki.com', 261);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Sukey', 'Flowerdew', 'Female', '1980-08-05', convert(varbinary,'353-01-7211'), '277-556-8578', 'sflowerdew2f@redcross.org', 277);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Westley', 'Jesse', 'Male', '1970-07-25', convert(varbinary,'500-12-6131'), '457-385-6675', 'wjesse2g@etsy.com', 414);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Ferris', 'Chrystie', 'Male', '1961-04-30', convert(varbinary,'400-41-2600'), '763-561-2179', 'fchrystie2h@who.int', 353);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Arther', 'Dudin', 'Male', '1990-10-03', convert(varbinary,'313-31-9867'), '177-814-8439', 'adudin2i@jugem.jp', 387);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Helen', 'Philippault', 'Female', '1989-06-23', convert(varbinary,'869-28-6686'), '696-517-3189', 'hphilippault2j@ning.com', 291);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Hedi', 'Durand', 'Female', '1995-06-28', convert(varbinary,'356-10-4604'), '832-751-6364', 'hdurand2k@discovery.com', 416);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Lem', 'Spires', 'Male', '1970-03-01', convert(varbinary,'195-17-7930'), '753-723-6140', 'lspires2l@wsj.com', 374);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Llywellyn', 'Perrelle', 'Male', '1982-07-24', convert(varbinary,'456-08-7732'), '340-929-3748', 'lperrelle2m@blogtalkradio.com', 402);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Fabien', 'Alishoner', 'Male', '1978-08-18', convert(varbinary,'282-51-9997'), '600-797-4796', 'falishoner2n@soundcloud.com', 354);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Danell', 'Biagi', 'Female', '1978-01-26', convert(varbinary,'557-18-3309'), '648-872-0101', 'dbiagi2o@com.com', 252);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Leela', 'Bonefant', 'Female', '1972-01-22', convert(varbinary,'805-66-9758'), '435-431-1085', 'lbonefant2p@infoseek.co.jp', 309);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Frasquito', 'Bing', 'Male', '1994-10-08',convert(varbinary, '200-69-1845'), '859-253-4972', 'fbing2q@huffingtonpost.com', 392);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Rafaello', 'Brayson', 'Male', '1993-03-18', convert(varbinary,'280-24-3317'), '991-193-2411', 'rbrayson2r@fc2.com', 436);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Sammy', 'Crosham', 'Male', '1985-12-28', convert(varbinary,'295-44-4376'), '150-859-3182', 'scrosham0@deliciousdays.com', 256);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Alvis', 'Dismore', 'Male', '1977-09-24', convert(varbinary,'572-80-1473'), '974-692-8996', 'adismore1@51.la', 401);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Brunhilda', 'Levene', 'Female', '1996-10-24', convert(varbinary,'899-89-5683'), '578-566-3735', 'blevene2@adobe.com', 259);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Jeth', 'Dunhill', 'Male', '1982-04-07', convert(varbinary,'261-41-8681'), '493-753-9895', 'jdunhill3@blogger.com', 341);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Neile', 'Isakovic', 'Female', '1971-03-24', convert(varbinary,'828-05-4413'), '298-544-6594', 'nisakovic4@slashdot.org', 266);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Augustus', 'Kmicicki', 'Male', '1985-01-20', convert(varbinary,'360-17-6828'), '579-736-5543', 'akmicicki5@hao123.com', 260);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Gladys', 'Erskin', 'Female', '1978-03-27', convert(varbinary,'278-55-1124'), '136-973-3897', 'gerskin6@blogs.com', 315);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Philbert', 'Southeran', 'Male', '1992-02-05', convert(varbinary,'352-29-4464'), '959-986-8810', 'psoutheran7@nps.gov', 244);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Kendre', 'Scruton', 'Female', '1961-07-21', convert(varbinary,'185-73-0779'), '586-811-6810', 'kscruton8@blogs.com', 252);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Jarvis', 'Gerardi', 'Male', '1967-09-09', convert(varbinary,'494-66-8146'), '706-870-6401', 'jgerardi9@simplemachines.org', 339);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Staffard', 'McDell', 'Male', '1968-11-06', convert(varbinary,'393-32-7773'), '231-377-6015', 'smcdella@virginia.edu', 348);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Debbie', 'Jedrzejewski', 'Female', '1994-10-09', convert(varbinary,'337-29-1088'), '753-636-6517', 'djedrzejewskib@rediff.com', 284);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Babette', 'Geram', 'Female', '1980-10-01', convert(varbinary,'299-36-9655'), '524-664-1077', 'bgeramc@123-reg.co.uk', 366);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Keelby', 'Jessard', 'Male', '1997-08-11', convert(varbinary,'563-70-2795'), '225-559-7905', 'kjessardd@jalbum.net', 329);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Sabine', 'Killimister', 'Female', '2000-03-11', convert(varbinary,'514-44-8042'), '252-480-2346', 'skillimistere@epa.gov', 367);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Fabe', 'Lambrick', 'Male', '1984-08-16', convert(varbinary,'365-76-3288'), '807-555-7072', 'flambrickf@delicious.com', 270);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Obed', 'McQuirk', 'Male', '1992-11-11', convert(varbinary,'223-70-4061'), '641-734-3818', 'omcquirkg@ehow.com', 256);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Sergei', 'O''Crevy', 'Male', '1989-09-18', convert(varbinary,'436-58-7790'), '177-476-1419', 'socrevyh@sbwire.com', 278);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Wrennie', 'Yesenin', 'Female', '1984-08-18', convert(varbinary,'262-40-0122'), '161-727-8642', 'wyesenini@reference.com', 405);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Skippie', 'Lambot', 'Male', '1992-06-11', convert(varbinary,'612-90-6908'), '799-836-5808', 'slambotj@bloomberg.com', 263);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Celinda', 'Chuck', 'Female', '1986-05-30', convert(varbinary,'595-22-1720'), '280-990-3541', 'cchuckk@narod.ru', 380);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Kori', 'Broschke', 'Female', '1970-07-06', convert(varbinary,'154-53-2196'), '290-850-5137', 'kbroschkel@addtoany.com', 301);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Westley', 'Stains', 'Male', '1977-08-03', convert(varbinary,'840-13-1456'), '614-553-8221', 'wstainsm@4shared.com', 250);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Dwayne', 'Stormont', 'Male', '1985-03-07', convert(varbinary,'566-07-5721'), '715-365-7012', 'dstormontn@fda.gov', 294);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Roslyn', 'Sabate', 'Female', '1997-01-14', convert(varbinary,'724-82-9698'), '381-968-7912', 'rsabateo@canalblog.com', 272);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Nollie', 'Jolliffe', 'Male', '1977-01-27', convert(varbinary,'862-03-9292'), '881-587-4791', 'njolliffep@biglobe.ne.jp', 422);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Brunhilde', 'Arndt', 'Non-binary', '1962-12-31', convert(varbinary,'467-29-7964'), '148-255-5119', 'barndtq@google.com.au', 322);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Cathrin', 'McLagain', 'Female', '1985-08-12', convert(varbinary,'765-34-5550'), '640-834-3567', 'cmclagainr@tinypic.com', 374);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Loria', 'Pawellek', 'Female', '1966-11-04', convert(varbinary,'471-12-2934'), '274-837-0795', 'lpawelleks@soundcloud.com', 390);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Dusty', 'Mapstone', 'Female', '1987-11-20', convert(varbinary,'111-46-4189'), '674-261-5729', 'dmapstonet@cnet.com', 405);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Briny', 'Goricke', 'Female', '1972-09-20', convert(varbinary,'390-13-3618'), '819-433-8120', 'bgorickeu@amazon.com', 318);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Roana', 'Brager', 'Female', '1994-09-02', convert(varbinary,'346-15-9725'), '403-773-9914', 'rbragerv@sohu.com', 259);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Inna', 'Teare', 'Female', '1986-07-13', convert(varbinary,'658-81-2441'), '115-328-5853', 'itearew@ycombinator.com', 322);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Cele', 'Treadwell', 'Female', '1981-06-19', convert(varbinary,'871-91-6241'), '320-215-7621', 'ctreadwellx@istockphoto.com', 428);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Theo', 'Dyott', 'Bigender', '1984-01-28', convert(varbinary,'609-95-9790'), '747-156-0374', 'tdyotty@arstechnica.com', 415);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Sindee', 'Gronow', 'Female', '1999-06-29', convert(varbinary,'405-99-0216'), '561-703-4555', 'sgronowz@constantcontact.com', 252);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Leisha', 'Spadeck', 'Female', '1994-08-12', convert(varbinary,'691-67-7046'), '138-865-5261', 'lspadeck10@bloglovin.com', 421);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Kassey', 'Joplin', 'Female', '1992-07-06', convert(varbinary,'626-12-1828'), '660-954-9678', 'kjoplin11@csmonitor.com', 251);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Beverley', 'Worral', 'Female', '1987-09-10', convert(varbinary,'476-42-4171'), '317-478-8919', 'bworral12@blogtalkradio.com', 434);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Skipper', 'Forrestor', 'Male', '1963-02-21', convert(varbinary,'722-75-4057'), '129-118-7168', 'sforrestor13@live.com', 298);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Hyacinthe', 'Riepl', 'Female', '1999-05-06',convert(varbinary, '787-77-2143'), '212-193-1178', 'hriepl14@ucoz.com', 314);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Starla', 'Maiklem', 'Female', '1988-07-30', convert(varbinary,'502-64-9716'), '906-293-4915', 'smaiklem15@theguardian.com', 433);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Angel', 'Serrels', 'Male', '1972-06-17', convert(varbinary,'702-31-4034'), '973-534-7563', 'aserrels16@nasa.gov', 320);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Rad', 'Kyd', 'Male', '1963-10-15', convert(varbinary,'796-10-9458'), '868-431-7355', 'rkyd17@mozilla.com', 352);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Obie', 'Gooble', 'Male', '1965-02-07', convert(varbinary,'582-04-2764'), '416-613-5164', 'ogooble18@yahoo.co.jp', 274);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Godwin', 'Boshier', 'Male', '1962-07-11', convert(varbinary,'449-44-9136'), '714-150-2906', 'gboshier19@deliciousdays.com', 301);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Kylila', 'Scalia', 'Female', '1986-03-02', convert(varbinary,'524-42-2546'), '943-577-9065', 'kscalia1a@archive.org', 266);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Zahara', 'Druhan', 'Female', '1990-01-20', convert(varbinary,'202-33-6370'), '847-716-6611', 'zdruhan1b@fema.gov', 428);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Cory', 'Dalziell', 'Male', '1997-06-20', convert(varbinary,'450-11-2093'), '173-395-3353', 'cdalziell1c@uiuc.edu', 314);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Lucais', 'Rook', 'Male', '1993-04-21', convert(varbinary,'230-83-7260'), '433-692-3693', 'lrook1d@trellian.com', 345);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Elysha', 'Mabey', 'Genderqueer', '1971-10-27', convert(varbinary,'711-32-2815'), '804-162-3593', 'emabey1e@wunderground.com', 364);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Chadwick', 'Binns', 'Male', '1986-03-04', convert(varbinary,'766-59-0431'), '887-746-3833', 'cbinns1f@prnewswire.com', 342);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Pippo', 'Peer', 'Male', '1995-09-21', convert(varbinary,'474-49-9450'), '695-893-6104', 'ppeer1g@apache.org', 377);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Verge', 'Boschmann', 'Male', '1975-03-26', convert(varbinary,'491-96-2642'), '927-789-7696', 'vboschmann1h@flavors.me', 350);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Stevie', 'Hayller', 'Male', '1999-01-27', convert(varbinary,'622-50-3554'), '486-617-2062', 'shayller1i@printfriendly.com', 386);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Milzie', 'Crosfield', 'Female', '1963-03-03', convert(varbinary,'830-05-5520'), '720-521-4748', 'mcrosfield1j@stumbleupon.com', 368);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Simmonds', 'Vickors', 'Male', '1988-12-17', convert(varbinary,'128-17-6156'), '228-584-7875', 'svickors1k@bloomberg.com', 331);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Cordula', 'Kirman', 'Female', '1961-07-31', convert(varbinary,'470-57-4200'), '779-845-1962', 'ckirman1l@blogs.com', 381);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Stoddard', 'Gillivrie', 'Female', '1974-09-03', convert(varbinary,'168-68-8764'), '361-979-8710', 'sgillivrie1m@cnbc.com', 377);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Harrison', 'Gillespey', 'Male', '1994-07-20', convert(varbinary,'130-92-1877'), '288-535-6612', 'hgillespey1n@wired.com', 338);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Fanchette', 'Lyle', 'Female', '1990-10-05', convert(varbinary,'290-02-6235'), '695-828-2324', 'flyle1o@dot.gov', 433);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Lem', 'Toby', 'Genderfluid', '1964-08-23', convert(varbinary,'640-95-6301'), '183-354-9510', 'ltoby1p@wired.com', 379);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Rolf', 'Cuttell', 'Male', '1979-04-12', convert(varbinary,'498-99-4598'), '764-374-9115', 'rcuttell1q@discovery.com', 355);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Bjorn', 'Vannah', 'Male', '1983-02-14', convert(varbinary,'676-36-1044'), '735-271-5502', 'bvannah1r@google.fr', 312);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Halsey', 'Laneham', 'Male', '1986-06-25', convert(varbinary,'861-89-6663'), '145-126-1948', 'hlaneham1s@weibo.com', 310);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Trev', 'Dunridge', 'Male', '1965-04-27', convert(varbinary,'871-70-2727'), '211-513-7647', 'tdunridge1t@dagondesign.com', 345);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Ede', 'Hilland', 'Polygender', '1988-11-28', convert(varbinary,'847-64-1327'), '238-503-1379', 'ehilland1u@comsenz.com', 329);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Julie', 'Rime', 'Female', '1992-03-09', convert(varbinary,'439-37-7699'), '732-958-0125', 'jrime1v@bbb.org', 257);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Karel', 'Schollar', 'Female', '1963-09-06', convert(varbinary,'307-41-3712'), '971-403-0802', 'kschollar1w@salon.com', 275);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Quinlan', 'Newhouse', 'Male', '1991-10-25', convert(varbinary,'244-18-8912'), '707-806-5407', 'qnewhouse1x@miitbeian.gov.cn', 311);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Boyd', 'Hune', 'Male', '1963-10-11', convert(varbinary,'467-38-5303'), '301-645-6567', 'bhune1y@nsw.gov.au', 258);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Krishna', 'Marcam', 'Male', '1992-11-20', convert(varbinary,'312-93-6180'), '399-103-3620', 'kmarcam1z@apple.com', 299);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Bibbye', 'Patzelt', 'Female', '1969-02-06', convert(varbinary,'286-17-8821'), '904-385-2937', 'bpatzelt20@deviantart.com', 315);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Alanson', 'Wreford', 'Male', '1983-07-11', convert(varbinary,'241-48-8024'), '535-601-2207', 'awreford21@cnet.com', 338);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Bertina', 'Hattiff', 'Female', '1994-12-23', convert(varbinary,'810-70-1648'), '304-894-3229', 'bhattiff22@ameblo.jp', 264);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Leta', 'Pollen', 'Female', '1978-08-29', convert(varbinary,'134-83-4635'), '677-429-8600', 'lpollen23@sina.com.cn', 385);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Mollie', 'Tickel', 'Female', '1985-08-14', convert(varbinary,'121-39-3349'), '770-953-7375', 'mtickel1b@mysql.com', 334);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Buffy', 'Stapleton', 'Female', '1976-12-21', convert(varbinary,'376-93-8848'), '873-606-1690', 'bstapleton1c@xinhuanet.com', 334);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Constantino', 'Dowbiggin', 'Male', '1973-02-28', convert(varbinary,'341-43-8070'), '637-351-4077', 'cdowbiggin1d@angelfire.com', 429);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Claudio', 'McManamon', 'Male', '1973-10-19', convert(varbinary,'554-36-7298'), '859-790-7597', 'cmcmanamon1e@about.me', 227);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Gabbie', 'Doorly', 'Female', '1971-05-11', convert(varbinary,'478-67-6889'), '352-399-7553', 'gdoorly1f@weibo.com', 356);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Thomasina', 'Mandre', 'Bigender', '1995-11-07', convert(varbinary,'249-23-8612'), '473-445-9103', 'tmandre1g@ning.com', 359);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Kathy', 'Ditter', 'Female', '1962-07-24', convert(varbinary,'720-17-8705'), '237-102-9760', 'kditter1h@microsoft.com', 359);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Maxy', 'Thurman', 'Genderqueer', '1962-10-10', convert(varbinary,'101-28-1269'), '984-290-3633', 'mthurman1i@pcworld.com', 225);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Brandyn', 'Driscoll', 'Male', '1981-02-12', convert(varbinary,'657-23-7714'), '581-129-8399', 'bdriscoll1j@zdnet.com', 234);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Truda', 'Willoughby', 'Female', '1970-07-28', convert(varbinary,'210-77-1918'), '446-826-3548', 'twilloughby1k@edublogs.org', 354);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Colin', 'Ilieve', 'Male', '1997-02-11', convert(varbinary,'376-30-9211'), '661-692-6477', 'cilieve1l@telegraph.co.uk', 341);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Gil', 'Speechley', 'Male', '1968-07-25', convert(varbinary,'757-87-6132'), '709-591-9730', 'gspeechley1m@cargocollective.com', 241);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Merrilee', 'Francey', 'Female', '1979-07-09', convert(varbinary,'414-86-7521'), '879-109-3115', 'mfrancey1n@hugedomains.com', 314);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Hilliary', 'Archanbault', 'Female', '1973-12-05', convert(varbinary,'155-88-2986'), '767-987-8039', 'harchanbault1o@meetup.com', 402);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Cliff', 'Asquez', 'Male', '1968-01-28', convert(varbinary,'650-58-8456'), '327-555-2837', 'casquez1p@netscape.com', 277);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Lian', 'Duhig', 'Female', '1967-01-14', convert(varbinary,'337-37-6394'), '703-193-8500', 'lduhig1q@e-recht24.de', 282);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Westley', 'Jesse', 'Male', '1970-07-25', convert(varbinary,'500-12-6131'), '457-385-6675', 'wjesse2g@etsy.com', 416);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Ferris', 'Chrystie', 'Male', '1961-04-30', convert(varbinary,'400-41-2600'), '763-561-2179', 'fchrystie2h@who.int', 393);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Arther', 'Dudin', 'Male', '1990-10-03', convert(varbinary,'313-31-9867'), '177-814-8439', 'adudin2i@jugem.jp', 367);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Helen', 'Philippault', 'Female', '1989-06-23', convert(varbinary,'869-28-6686'), '696-517-3189', 'hphilippault2j@ning.com', 271);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Hedi', 'Durand', 'Female', '1995-06-28', convert(varbinary,'356-10-4604'), '832-751-6364', 'hdurand2k@discovery.com', 476);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Lem', 'Spires', 'Male', '1970-03-01', convert(varbinary,'195-17-7930'), '753-723-6140', 'lspires2l@wsj.com', 364);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Llywellyn', 'Perrelle', 'Male', '1982-07-24', convert(varbinary,'456-08-7732'), '340-929-3748', 'lperrelle2m@blogtalkradio.com', 472);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Fabien', 'Alishoner', 'Male', '1978-08-18', convert(varbinary,'282-51-9997'), '600-797-4796', 'falishoner2n@soundcloud.com', 374);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Danell', 'Biagi', 'Female', '1978-01-26', convert(varbinary,'557-18-3309'), '648-872-0101', 'dbiagi2o@com.com', 252);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Leela', 'Bonefant', 'Female', '1972-01-22', convert(varbinary,'805-66-9758'), '435-431-1085', 'lbonefant2p@infoseek.co.jp', 349);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Frasquito', 'Bing', 'Male', '1994-10-08',convert(varbinary, '200-69-1845'), '859-253-4972', 'fbing2q@huffingtonpost.com', 332);
insert into dbo.PersonalInformation (first_name, last_name, gender, DOB, SSN, phone, email, address_id) values ('Rafaello', 'Brayson', 'Male', '1993-03-18', convert(varbinary,'280-24-3317'), '991-193-2411', 'rbrayson2r@fc2.com', 416);




/*
 * Step 9: insert data into Staff
 */
INSERT INTO dbo.Staff(group_id, department_id, info_id, salary)
VALUES
	(1, 1, 101, 10900.00),
	(1, 2, 102, 4500.50),
	(2, 3, 103, 3500.00),
	(2, 4, 104, 3500.00),
	(2, 5, 105, 3500.00),
	(3, 3, 106, 4700.00),
	(3, 4, 107, 4500.50),
	(3, 5, 108, 3500.00);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (20, 6, 371, 3500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 6, 372, 3500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (5, 7, 373, 3500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (4, 7, 374, 3500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (17, 6, 375, 3500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (9, 9, 376, 3500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (13, 3, 377, 3500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (12, 3, 378, 3500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (20, 2, 379, 3500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (17, 8, 380, 3500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (7, 9, 381, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (11, 2, 382, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (11, 6, 383, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (21, 5, 384, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (14, 8, 385, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (11, 2, 386, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (19, 2, 387, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (23, 3, 388, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (6, 6, 389, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (29, 10, 390, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (18, 2, 391, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (13, 6, 392, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (4, 3, 393, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (4, 10, 394, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (18, 4, 395, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (25, 3, 396, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (18, 10, 397, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (27, 7, 398, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (29, 10, 399, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (12, 6, 400, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (13, 4, 401, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (15, 3, 402, 4500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (11, 7, 403, 4200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (17, 4, 404, 4200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (6, 10, 405, 4200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (24, 2, 406, 4200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (29, 3, 407, 4200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (10, 8, 408, 4200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (23, 5, 409, 4800);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (10, 10, 410, 4800);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 8, 411, 4800);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (27, 3, 412, 4800);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (19, 4, 413, 4800);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (26, 10, 414, 4800);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (6, 3, 415, 4800);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (17, 3, 416, 4800);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (17, 3, 417, 4800);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (22, 8, 418, 4800);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (6, 9, 419, 4800);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (6, 4, 420, 4800);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (22, 4, 421, 4800);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (22, 10, 422, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (10, 4, 423, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (11, 10, 424, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (12, 5, 425, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (20, 8, 426, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (29, 2, 427, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (22, 5, 428, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (4, 7, 429, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (15, 2, 430, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (24, 6, 431, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (19, 9, 432, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (16, 7, 433, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (28, 7, 434, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (11, 5, 435, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (17, 3, 436, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (29, 3, 437, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (27, 6, 438, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (24, 9, 439, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (25, 10, 440, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (19, 6, 441, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (12, 8, 442, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (19, 10, 443, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (27, 6, 444, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (28, 2, 445, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (11, 7, 446, 5200);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (10, 7, 447, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (21, 5, 448, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (16, 7, 449, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (17, 7, 450, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 7, 451, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (28, 7, 452, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (15, 6, 453, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (7, 3, 454, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (23, 9, 455, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (14, 5, 456, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 6, 457, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (11, 7, 458, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 5, 459, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (24, 2, 460, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (21, 9, 461, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (28, 9, 462, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (22, 5, 463, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (15, 3, 464, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (10, 7, 465, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (20, 7, 466, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (19, 8, 467, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (10, 3, 468, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (25, 3, 469, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 2, 470, 5100);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (17, 7, 471, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (28, 7, 472, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (15, 6, 473, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (7, 3, 474, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (23, 9, 475, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (14, 5, 476, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 6, 477, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (11, 7, 478, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 5, 479, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (24, 2, 480, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (21, 9, 481, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (28, 9, 482, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (22, 5, 483, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (15, 3, 484, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (10, 7, 485, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (20, 7, 486, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (19, 8, 487, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (10, 3, 488, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (25, 3, 489, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 2, 490, 5100);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 7, 491, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (28, 7, 492, 6300);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (15, 6, 493, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (7, 3, 494, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (23, 9, 495, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (14, 5, 496, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 6, 497, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (11, 7, 498, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 5, 499, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (24, 2, 500, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (21, 9, 501, 4000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (28, 9, 502, 5500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (22, 5, 503, 5600);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (15, 3, 504, 5700);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (10, 7, 505, 5500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (20, 7, 506, 5400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (19, 8, 507, 5500);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (10, 3, 508, 6000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (25, 3, 509, 5000);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 2, 510, 5100);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 7, 511, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 7, 512, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 7, 513, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 7, 514, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 7, 515, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 7, 516, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 7, 517, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 7, 518, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 7, 519, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 7, 520, 6400);
insert into dbo.Staff (group_id, department_id, info_id, salary) values (3, 7, 521, 6400);




/*
 * Step 10: insert data into CustomerType
 */
INSERT INTO dbo.CustomerType ([type]) VALUES
	 ('FirstTimeTenant'),
	 ('FirstTimeLandlord'),
	 ('FirstTimeVisitor'),
	 ('NonFirstTimeTenant'),
	 ('NonFirstTimeLandlord'),
	 ('NonFirstTimeVisitor'),
	 ('TenantByReferral'),
	 ('LandlordByReferral'),
	 ('VisitorByReferral'),
	 ('Others');

	


/*
 * Step 11 : insert data into Customer
 */
INSERT INTO dbo.Customer(info_id, [type])
VALUES
	(109, 1),--t 
	(110, 1),--t 
	(111, 1),--t 
	(112, 1),--t 
	(113, 1),--t 
	(114, 1),--t 
	(115, 1),--t 
	(116, 1),--t 
	(117, 1),--t
	(118, 1),--t 
	(119, 1),--t 
	(120, 1),--t 
	(121, 1),--t 
	(122, 1), --t 
	(123, 1), --t 
	(124, 1),--t 
	(125, 1),--t 
	(126, 1),--t 
	(127, 1),--t 
	(128, 1),--t 
	(129, 1),--t 
	(130, 1),--t
	(131, 1),--t 
	(132, 1),--t 
	(133, 1),--t 
	(134, 1),--t 
	(135, 1), --t 
	(136, 1), --t 
	(137, 1),--t 
	(138, 1),--t 
	(139, 1),--t 
	(140, 1),--t 
	(141, 1), --t 
	(142, 1),--t 
	(143, 1),--t 
	(144, 1),--t 
	(145, 1),--t 
	(146, 1), --t 
	(147, 1),--t 
	(148, 1),--t 
	(149, 1),--t 
	(150, 1),--t 
	(151, 1), --t 
	(152, 1), --t 
	(153, 2),--land 
	(154, 1), --t
	(155, 2),--land 
	(156, 1), --t 
	(157, 2),--land 
	(158, 1), --t
	(159, 2),--land  
	(160, 1), --t 
	(161, 3), --potential/visitor
	(162, 3),--potential
	(163, 3),--potential
	(164, 3),--potential
	(165, 3), --potential
	(166, 3), --potential
	(167, 3),--potential
	(168, 3),--potential
	(169, 3),--potential
	(170, 3); --potential

INSERT INTO [dbo].[Customer]  VALUES (172,3);
INSERT INTO [dbo].[Customer]  VALUES (173,3);
INSERT INTO [dbo].[Customer]  VALUES (174,3);
INSERT INTO [dbo].[Customer]  VALUES (175,3);
INSERT INTO [dbo].[Customer]  VALUES (176,3);
INSERT INTO [dbo].[Customer]  VALUES (177,3);
INSERT INTO [dbo].[Customer]  VALUES (178,3);
INSERT INTO [dbo].[Customer]  VALUES (179,3);
INSERT INTO [dbo].[Customer]  VALUES (180,3);
INSERT INTO [dbo].[Customer]  VALUES (181,3);
INSERT INTO [dbo].[Customer]  VALUES (182,3);
INSERT INTO [dbo].[Customer]  VALUES (183,3);
INSERT INTO [dbo].[Customer]  VALUES (184,3);
INSERT INTO [dbo].[Customer]  VALUES (185,3);
INSERT INTO [dbo].[Customer]  VALUES (186,3);
INSERT INTO [dbo].[Customer]  VALUES (187,3);
INSERT INTO [dbo].[Customer]  VALUES (188,3);
INSERT INTO [dbo].[Customer]  VALUES (189,3);
INSERT INTO [dbo].[Customer]  VALUES (190,3);
INSERT INTO [dbo].[Customer]  VALUES (191,3);
INSERT INTO [dbo].[Customer]  VALUES (192,3);
INSERT INTO [dbo].[Customer]  VALUES (193,3);
INSERT INTO [dbo].[Customer]  VALUES (194,3);
INSERT INTO [dbo].[Customer]  VALUES (195,3);
INSERT INTO [dbo].[Customer]  VALUES (196,3);
INSERT INTO [dbo].[Customer]  VALUES (197,3);
INSERT INTO [dbo].[Customer]  VALUES (198,3);
INSERT INTO [dbo].[Customer]  VALUES (199,3);
INSERT INTO [dbo].[Customer]  VALUES (200,3);
INSERT INTO [dbo].[Customer]  VALUES (201,3);
INSERT INTO [dbo].[Customer]  VALUES (202,3);
INSERT INTO [dbo].[Customer]  VALUES (203,3);
INSERT INTO [dbo].[Customer]  VALUES (204,3);
INSERT INTO [dbo].[Customer]  VALUES (205,3);
INSERT INTO [dbo].[Customer]  VALUES (206,3);
INSERT INTO [dbo].[Customer]  VALUES (207,3);
INSERT INTO [dbo].[Customer]  VALUES (208,3);
INSERT INTO [dbo].[Customer]  VALUES (209,3);
INSERT INTO [dbo].[Customer]  VALUES (210,3);
INSERT INTO [dbo].[Customer]  VALUES (211,3);
INSERT INTO [dbo].[Customer]  VALUES (212,3);
INSERT INTO [dbo].[Customer]  VALUES (213,3);
INSERT INTO [dbo].[Customer]  VALUES (214,3);
INSERT INTO [dbo].[Customer]  VALUES (215,3);
INSERT INTO [dbo].[Customer]  VALUES (216,3);
INSERT INTO [dbo].[Customer]  VALUES (217,3);
INSERT INTO [dbo].[Customer]  VALUES (218,3);
INSERT INTO [dbo].[Customer]  VALUES (219,3);
INSERT INTO [dbo].[Customer]  VALUES (220,3);
INSERT INTO [dbo].[Customer]  VALUES (221,3);
INSERT INTO [dbo].[Customer]  VALUES (222,3);
INSERT INTO [dbo].[Customer]  VALUES (223,3);
INSERT INTO [dbo].[Customer]  VALUES (224,3);
INSERT INTO [dbo].[Customer]  VALUES (225,3);
INSERT INTO [dbo].[Customer]  VALUES (226,3);
INSERT INTO [dbo].[Customer]  VALUES (227,3);
INSERT INTO [dbo].[Customer]  VALUES (228,3);
INSERT INTO [dbo].[Customer]  VALUES (229,3);
INSERT INTO [dbo].[Customer]  VALUES (230,3);
INSERT INTO [dbo].[Customer]  VALUES (231,3);
INSERT INTO [dbo].[Customer]  VALUES (232,3);
INSERT INTO [dbo].[Customer]  VALUES (233,3);
INSERT INTO [dbo].[Customer]  VALUES (234,3);
INSERT INTO [dbo].[Customer]  VALUES (235,3);
INSERT INTO [dbo].[Customer]  VALUES (236,3);
INSERT INTO [dbo].[Customer]  VALUES (237,3);
INSERT INTO [dbo].[Customer]  VALUES (238,3);
INSERT INTO [dbo].[Customer]  VALUES (239,3);
INSERT INTO [dbo].[Customer]  VALUES (240,3);
INSERT INTO [dbo].[Customer]  VALUES (241,3);
INSERT INTO [dbo].[Customer]  VALUES (242,3);
INSERT INTO [dbo].[Customer]  VALUES (243,3);
INSERT INTO [dbo].[Customer]  VALUES (244,3);
INSERT INTO [dbo].[Customer]  VALUES (245,3);
INSERT INTO [dbo].[Customer]  VALUES (246,3);
INSERT INTO [dbo].[Customer]  VALUES (247,3);
INSERT INTO [dbo].[Customer]  VALUES (248,3);
INSERT INTO [dbo].[Customer]  VALUES (249,3);
INSERT INTO [dbo].[Customer]  VALUES (250,3);
INSERT INTO [dbo].[Customer]  VALUES (251,3);
INSERT INTO [dbo].[Customer]  VALUES (252,3);
INSERT INTO [dbo].[Customer]  VALUES (253,3);
INSERT INTO [dbo].[Customer]  VALUES (254,3);
INSERT INTO [dbo].[Customer]  VALUES (255,3);
INSERT INTO [dbo].[Customer]  VALUES (256,3);
INSERT INTO [dbo].[Customer]  VALUES (257,3);
INSERT INTO [dbo].[Customer]  VALUES (258,3);
INSERT INTO [dbo].[Customer]  VALUES (259,3);
INSERT INTO [dbo].[Customer]  VALUES (260,3);
INSERT INTO [dbo].[Customer]  VALUES (261,3);
INSERT INTO [dbo].[Customer]  VALUES (262,3);
INSERT INTO [dbo].[Customer]  VALUES (263,3);
INSERT INTO [dbo].[Customer]  VALUES (264,3);
INSERT INTO [dbo].[Customer]  VALUES (265,3);
INSERT INTO [dbo].[Customer]  VALUES (266,3);
INSERT INTO [dbo].[Customer]  VALUES (267,3);
INSERT INTO [dbo].[Customer]  VALUES (268,3);
INSERT INTO [dbo].[Customer]  VALUES (269,3);
INSERT INTO [dbo].[Customer]  VALUES (270,3);
INSERT INTO [dbo].[Customer]  VALUES (271,3);
INSERT INTO [dbo].[Customer]  VALUES (272,3);
INSERT INTO [dbo].[Customer]  VALUES (273,3);
INSERT INTO [dbo].[Customer]  VALUES (274,3);
INSERT INTO [dbo].[Customer]  VALUES (275,3);
INSERT INTO [dbo].[Customer]  VALUES (276,3);
INSERT INTO [dbo].[Customer]  VALUES (277,3);
INSERT INTO [dbo].[Customer]  VALUES (278,3);
INSERT INTO [dbo].[Customer]  VALUES (279,3);
INSERT INTO [dbo].[Customer]  VALUES (280,3);
INSERT INTO [dbo].[Customer]  VALUES (281,3);
INSERT INTO [dbo].[Customer]  VALUES (282,3);
INSERT INTO [dbo].[Customer]  VALUES (283,3);
INSERT INTO [dbo].[Customer]  VALUES (284,3);
INSERT INTO [dbo].[Customer]  VALUES (285,3);
INSERT INTO [dbo].[Customer]  VALUES (286,3);
INSERT INTO [dbo].[Customer]  VALUES (287,3);
INSERT INTO [dbo].[Customer]  VALUES (288,3);
INSERT INTO [dbo].[Customer]  VALUES (289,3);
INSERT INTO [dbo].[Customer]  VALUES (290,3);
INSERT INTO [dbo].[Customer]  VALUES (291,3);
INSERT INTO [dbo].[Customer]  VALUES (292,3);
INSERT INTO [dbo].[Customer]  VALUES (293,3);
INSERT INTO [dbo].[Customer]  VALUES (294,3);
INSERT INTO [dbo].[Customer]  VALUES (295,3);
INSERT INTO [dbo].[Customer]  VALUES (296,3);
INSERT INTO [dbo].[Customer]  VALUES (297,3);
INSERT INTO [dbo].[Customer]  VALUES (298,3);
INSERT INTO [dbo].[Customer]  VALUES (299,3);
INSERT INTO [dbo].[Customer]  VALUES (300,3);
INSERT INTO [dbo].[Customer]  VALUES (301,3);
INSERT INTO [dbo].[Customer]  VALUES (302,3);
INSERT INTO [dbo].[Customer]  VALUES (303,3);
INSERT INTO [dbo].[Customer]  VALUES (304,3);
INSERT INTO [dbo].[Customer]  VALUES (305,3);
INSERT INTO [dbo].[Customer]  VALUES (306,3);
INSERT INTO [dbo].[Customer]  VALUES (307,3);
INSERT INTO [dbo].[Customer]  VALUES (308,3);
INSERT INTO [dbo].[Customer]  VALUES (309,3);
INSERT INTO [dbo].[Customer]  VALUES (310,3);
INSERT INTO [dbo].[Customer]  VALUES (311,3);
INSERT INTO [dbo].[Customer]  VALUES (312,3);
INSERT INTO [dbo].[Customer]  VALUES (313,3);
INSERT INTO [dbo].[Customer]  VALUES (314,3);
INSERT INTO [dbo].[Customer]  VALUES (315,3);
INSERT INTO [dbo].[Customer]  VALUES (316,3);
INSERT INTO [dbo].[Customer]  VALUES (317,3);
INSERT INTO [dbo].[Customer]  VALUES (318,3);
INSERT INTO [dbo].[Customer]  VALUES (319,3);
INSERT INTO [dbo].[Customer]  VALUES (320,3);
INSERT INTO [dbo].[Customer]  VALUES (321,3);
INSERT INTO [dbo].[Customer]  VALUES (322,3);
INSERT INTO [dbo].[Customer]  VALUES (323,3);
INSERT INTO [dbo].[Customer]  VALUES (324,3);
INSERT INTO [dbo].[Customer]  VALUES (325,3);
INSERT INTO [dbo].[Customer]  VALUES (326,3);
INSERT INTO [dbo].[Customer]  VALUES (327,3);
INSERT INTO [dbo].[Customer]  VALUES (328,3);
INSERT INTO [dbo].[Customer]  VALUES (329,3);
INSERT INTO [dbo].[Customer]  VALUES (330,3);
INSERT INTO [dbo].[Customer]  VALUES (331,3);
INSERT INTO [dbo].[Customer]  VALUES (332,3);
INSERT INTO [dbo].[Customer]  VALUES (333,3);
INSERT INTO [dbo].[Customer]  VALUES (334,3);
INSERT INTO [dbo].[Customer]  VALUES (335,3);
INSERT INTO [dbo].[Customer]  VALUES (336,3);
INSERT INTO [dbo].[Customer]  VALUES (337,3);
INSERT INTO [dbo].[Customer]  VALUES (338,3);
INSERT INTO [dbo].[Customer]  VALUES (339,3);
INSERT INTO [dbo].[Customer]  VALUES (340,3);
INSERT INTO [dbo].[Customer]  VALUES (341,3);
INSERT INTO [dbo].[Customer]  VALUES (342,3);
INSERT INTO [dbo].[Customer]  VALUES (343,3);
INSERT INTO [dbo].[Customer]  VALUES (344,3);
INSERT INTO [dbo].[Customer]  VALUES (345,3);
INSERT INTO [dbo].[Customer]  VALUES (346,3);
INSERT INTO [dbo].[Customer]  VALUES (347,3);
INSERT INTO [dbo].[Customer]  VALUES (348,3);
INSERT INTO [dbo].[Customer]  VALUES (349,3);
INSERT INTO [dbo].[Customer]  VALUES (350,3);
INSERT INTO [dbo].[Customer]  VALUES (351,3);
INSERT INTO [dbo].[Customer]  VALUES (352,3);
INSERT INTO [dbo].[Customer]  VALUES (353,3);
INSERT INTO [dbo].[Customer]  VALUES (354,3);
INSERT INTO [dbo].[Customer]  VALUES (355,3);
INSERT INTO [dbo].[Customer]  VALUES (356,3);
INSERT INTO [dbo].[Customer]  VALUES (357,3);
INSERT INTO [dbo].[Customer]  VALUES (358,3);
INSERT INTO [dbo].[Customer]  VALUES (359,3);
INSERT INTO [dbo].[Customer]  VALUES (360,3);
INSERT INTO [dbo].[Customer]  VALUES (361,3);
INSERT INTO [dbo].[Customer]  VALUES (362,3);
INSERT INTO [dbo].[Customer]  VALUES (363,3);
INSERT INTO [dbo].[Customer]  VALUES (364,3);
INSERT INTO [dbo].[Customer]  VALUES (365,3);
INSERT INTO [dbo].[Customer]  VALUES (366,3);
INSERT INTO [dbo].[Customer]  VALUES (367,3);
INSERT INTO [dbo].[Customer]  VALUES (368,3);
INSERT INTO [dbo].[Customer]  VALUES (369,3);
INSERT INTO [dbo].[Customer]  VALUES (370,3);
	
INSERT INTO dbo.Customer(info_id, [type])
VALUES
	(522, 2),
	(523, 2),
	(524, 2),
	(525, 2),
	(526, 2),
	(527, 2),
	(528, 2),
	(529, 2);
INSERT INTO dbo.Customer(info_id, [type])
VALUES
	(530, 2),
	(531, 2),
	(532, 2),
	(533, 2),
	(534, 2),
	(535, 2),
	(536, 2),
	(537, 2),
	(538, 2),
	(539, 2),
	(540, 2),
	(541, 2),
	(542, 2),
	(543, 2),
	(544, 2),
	(545, 2),
	(546, 2),
	(547, 2),
	(548, 2),
	(549, 2),
	(550, 2);
INSERT INTO dbo.Customer(info_id, [type])
VALUES
	(551, 2),
	(552, 2),
	(553, 2),
	(554, 2),
	(555, 2),
	(556, 2),
	(557, 2),
	(558, 2),
	(559, 2),
	(560, 2),
	(561, 2),
	--(562, 2),
	(563, 2),
	(564, 2),
	(565, 2),
	(566, 2),
	(567, 2),
	(568, 2),
	(569, 2),
	(570, 2),
	(571, 2);
	


/*
 * Step 12: insert data into ContractType
 */
INSERT INTO dbo.ContractType ([type]) VALUES
	 ('Customer-FirstTimeTenant'),
	 ('Business-FirstTimeLandlord'),
	 ('Business-ServiceCompany'),
	 ('Customer-RentersInsurance'),
	 ('Customer-PetAgreement'),
	 ('Customer-ParkingAgreement'),
	 ('Customer-PublicAmenitiesAgreement'),
	 ('Business-RentalAgency'),
	 ('Customer-NonFirstTimeTenant'),
	 ('Business-NonFirstTimeLandlord');



/*
 * Step 13: insert data into Application
 */
INSERT into dbo.Application(room_id, customer_id, move_in_date, expected_tenancy, income_monthly, occupation, application_date, isValid)
VALUES
	(1, 1, '2021-12-21', 12, 8700, 'Doctor', '2021-04-01', 1), --b1 
	(2, 2, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(3, 3, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(4, 4, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(9, 5, '2021-09-01', 11, 0, 'Student', '2021-04-01', 1),
	(9, 6, '2021-09-01', 11, 0, 'Student', '2021-04-01', 1),
	(10, 7, '2021-09-01', 12, 0, 'Student', '2021-04-01', 1),
	(10, 8, '2021-09-01', 12, 0, 'Student', '2021-04-01', 1),
	(13, 9, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(13, 10, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(13, 11, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(14, 12, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(14, 13, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(14, 14, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(17, 15, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(17, 16, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(17, 17, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(17, 18, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(18, 19, '2022-01-01', 12, 0, 'Student', '2021-07-01', 1),
	(18, 20, '2022-01-01', 12, 0, 'Student', '2021-07-01', 1),
	(18, 21, '2022-01-01', 12, 0, 'Student', '2021-07-01', 1),
	(18, 22, '2022-01-01', 12, 0, 'Student', '2021-07-01', 1),
	(21, 23, '2021-12-21', 12, 9800, 'Doctor', '2021-04-01', 1), --b2
	(22, 24, '2021-12-21', 12, 12000, 'Lawer', '2021-06-01', 1),
	(23, 25, '2021-12-21', 12, 11900, 'Lawer', '2021-04-20', 1),
	(24, 26, '2021-12-21', 12, 11500, 'Teacher', '2021-04-01', 1),
	(29, 27, '2021-09-01', 11, 0, 'Student', '2021-04-01', 1),
	(29, 28, '2021-09-01', 11, 0, 'Student', '2021-04-01', 1),
	(30, 29, '2021-09-01', 12, 0, 'Student', '2021-04-01', 1),
	(30, 30, '2021-09-01', 12, 0, 'Student', '2021-04-01', 1),
	(33, 31, '2021-12-21', 12, 0, 'Student', '2021-07-01', 1),
	(33, 32, '2021-12-21', 12, 0, 'Student', '2021-07-01', 1),
	(33, 33, '2021-12-21', 12, 0, 'Student', '2021-07-01', 1),
	(34, 34, '2021-12-21', 12, 0, 'Student', '2021-08-01', 1),
	(34, 35, '2021-12-21', 12, 0, 'Student', '2021-08-01', 1),
	(34, 36, '2021-12-21', 12, 0, 'Student', '2021-08-01', 1),
	(37, 37, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(37, 38, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(37, 39, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(37, 40, '2021-12-21', 12, 0, 'Student', '2021-04-01', 1),
	(38, 41, '2022-01-01', 12, 0, 'Student', '2021-07-01', 1),
	(38, 42, '2022-01-01', 12, 0, 'Student', '2021-07-01', 1),
	(38, 43, '2022-01-01', 12, 0, 'Student', '2021-07-01', 1),
	(38, 44, '2022-01-01', 12, 0, 'Student', '2021-07-01', 1),
	(41, 46, '2021-12-20', 12, 23000, 'Lawer', '2021-08-01', 1), --b3 
	(42, 48, '2021-12-20', 12, 0, 'Student', '2021-06-01', 1), --b4 
	(43, 50, '2021-12-20', 12, 26000, 'Dentist', '2021-04-01', 1), --b5 
	(44, 52, '2021-12-20', 12, 21000, 'Doctor', '2021-04-01', 1); --b6
--add some new applications
INSERT into dbo.Application(room_id, customer_id, move_in_date, expected_tenancy, income_monthly, occupation, application_date, isValid)
VALUES
	(5, 53, '2021-10-18', 5, 0, 'Student', '2021-05-01', 0),
	(6, 54, '2021-12-18', 5, 0, 'Student', '2021-05-01', 0),
	(7, 55, '2021-10-21', 3, 0, 'Worker', '2021-05-01', 0),
	(8, 56, '2021-11-10', 5, 0, 'Student', '2021-05-01', 0),
	(11, 57, '2022-08-01', 12, 0, 'Student', '2022-04-01', 1),
	(11, 58, '2022-08-01', 12, 0, 'Student', '2022-04-01', 1);
	
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (203, '2022-10-20', 11, 'Teacher', 75, 9893, '2020-10-17', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (206, '2021-10-13', 6, 'Physician', 176, 17641, '2021-09-13', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (193, '2021-07-29', 5, 'student', 29, 0, '2020-07-20', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (110, '2022-08-02', 4, 'Education', 132, 5266, '2021-06-19', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (222, '2022-05-19', 5, 'student', 218, 0, '2021-05-29', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (249, '2021-11-20', 8, 'HR', 87, 7347, '2021-07-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (158, '2022-04-30', 12, 'student', 83, 0, '2021-11-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (224, '2021-04-14', 4, 'Counselor', 191, 5257, '2021-04-04', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (253, '2021-05-19', 3, 'student', 115, 0, '2020-12-17', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (202, '2021-09-12', 11, 'SocialWorker', 81, 6887, '2021-09-02', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (124, '2023-09-12', 9, 'student', 22, 0, '2021-02-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (59, '2021-10-28', 6, 'Engineer', 90, 7564, '2020-12-23', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (203, '2020-12-05', 10, 'student', 186, 0, '2020-01-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (151, '2022-11-12', 10, 'Counselor', 224, 5853, '2020-09-18', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (130, '2021-11-25', 11, 'Education', 83, 7689, '2021-11-15', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (115, '2022-11-05', 11, 'Data', 191, 7807, '2020-11-10', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (161, '2022-06-07', 12, 'Financial', 115, 9858, '2022-01-10', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (138, '2020-07-17', 11, 'student', 11, 0, '2020-03-08', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (74, '2021-08-15', 12, 'student', 122, 0, '2021-08-05', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (124, '2022-04-20', 3, 'SocialWorker', 241, 5394, '2021-05-03', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (179, '2023-03-22', 12, 'student', 140, 0, '2021-08-21', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (187, '2022-01-27', 4, 'Counselor', 194, 5727, '2020-12-04', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (174, '2020-09-19', 3, 'student', 75, 0, '2020-09-09', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (123, '2020-11-16', 10, 'Teacher', 146, 9560, '2020-11-06', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (167, '2023-02-07', 10, 'Financial', 93, 10509, '2020-03-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (166, '2020-11-05', 11, 'Teacher', 206, 10351, '2020-10-26', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (261, '2020-12-26', 8, 'Financial', 32, 11534, '2020-12-16', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (257, '2023-03-03', 4, 'Counselor', 194, 6922, '2021-08-07', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (137, '2022-11-06', 10, 'Engineer', 240, 7661, '2020-09-04', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (169, '2022-09-09', 9, 'Education', 141, 8434, '2021-05-26', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (226, '2023-02-25', 8, 'Nurse', 209, 6129, '2021-04-02', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (136, '2023-08-01', 6, 'student', 21, 0, '2020-07-02', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (95, '2020-08-04', 9, 'student', 171, 0, '2020-07-25', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (142, '2021-12-18', 8, 'Computer', 164, 7536, '2021-06-28', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (98, '2021-07-11', 7, 'student', 236, 0, '2021-07-01', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (163, '2022-09-13', 8, 'Counselor', 64, 5242, '2020-03-02', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (74, '2021-01-18', 11, 'Legal', 64, 10530, '2020-12-25', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (217, '2020-06-15', 4, 'student', 116, 0, '2020-06-05', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (175, '2022-01-05', 4, 'Education', 19, 5537, '2021-01-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (150, '2023-08-16', 11, 'Engineer', 39, 10396, '2020-05-01', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (65, '2020-12-06', 9, 'student', 165, 0, '2020-01-31', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (118, '2023-06-18', 6, 'SocialWorker', 188, 3580, '2022-03-15', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (229, '2023-05-25', 12, 'Computer', 23, 10024, '2020-03-23', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (83, '2023-04-21', 8, 'SocialWorker', 244, 6668, '2021-10-24', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (139, '2023-07-23', 3, 'Counselor', 66, 4678, '2020-10-26', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (64, '2020-06-03', 12, 'student', 95, 0, '2020-05-24', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (241, '2021-06-16', 11, 'Financial', 209, 10616, '2020-09-02', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (221, '2022-09-15', 5, 'Data', 155, 10018, '2020-01-15', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (226, '2020-08-18', 8, 'student', 3, 0, '2020-08-08', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (206, '2022-11-12', 3, 'Physician', 175, 20050, '2022-03-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (213, '2021-12-31', 3, 'HR', 2, 6920, '2020-07-16', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (157, '2021-05-23', 11, 'Engineer', 146, 6369, '2020-08-29', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (220, '2021-01-18', 12, 'student', 192, 0, '2020-05-04', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (74, '2023-07-09', 6, 'Physician', 131, 18743, '2020-11-26', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (93, '2022-09-06', 5, 'Physician', 244, 18176, '2021-12-10', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (55, '2023-02-26', 9, 'HR', 230, 6828, '2021-11-25', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (256, '2022-11-11', 6, 'HR', 160, 7819, '2021-08-05', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (98, '2023-02-13', 10, 'student', 112, 0, '2021-05-18', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (201, '2023-06-01', 3, 'Counselor', 58, 5295, '2021-02-24', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (90, '2023-04-19', 10, 'Nurse', 22, 9532, '2020-01-17', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (166, '2022-11-23', 5, 'Education', 48, 8097, '2020-09-18', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (233, '2020-09-09', 6, 'Counselor', 34, 3129, '2020-08-30', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (219, '2023-04-26', 4, 'Teacher', 22, 9925, '2021-10-30', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (144, '2022-06-13', 10, 'HR', 225, 3947, '2021-02-27', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (68, '2023-01-02', 8, 'SocialWorker', 10, 6513, '2022-02-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (127, '2022-07-23', 11, 'Marketing', 135, 11742, '2020-10-02', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (215, '2020-09-29', 10, 'HR', 215, 5131, '2020-05-03', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (184, '2022-05-15', 5, 'Counselor', 172, 4255, '2021-06-01', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (146, '2022-12-07', 12, 'Nurse', 127, 7478, '2020-05-25', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (258, '2020-06-05', 7, 'Physician', 21, 17540, '2020-05-26', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (197, '2022-06-23', 12, 'Nurse', 135, 7301, '2021-12-17', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (82, '2022-11-01', 11, 'Education', 202, 5955, '2020-01-24', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (146, '2023-01-29', 7, 'student', 93, 0, '2021-01-14', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (101, '2021-08-17', 11, 'student', 4, 0, '2021-08-07', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (137, '2022-12-12', 5, 'Legal', 235, 12098, '2021-01-23', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (170, '2020-12-12', 10, 'Data', 215, 11422, '2020-12-02', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (73, '2022-06-20', 4, 'Financial', 224, 12534, '2021-05-09', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (257, '2020-06-07', 5, 'Marketing', 53, 12419, '2020-02-02', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (207, '2021-12-05', 12, 'student', 218, 0, '2020-03-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (154, '2021-07-28', 8, 'student', 117, 0, '2020-09-15', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (87, '2020-12-18', 3, 'student', 2, 0, '2020-12-08', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (162, '2023-08-24', 4, 'Engineer', 122, 10931, '2022-02-09', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (124, '2021-03-17', 8, 'student', 185, 0, '2020-04-04', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (119, '2021-01-03', 3, 'Teacher', 48, 10376, '2020-09-09', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (56, '2023-09-28', 11, 'Nurse', 213, 5139, '2020-12-08', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (215, '2023-06-20', 12, 'Computer', 83, 6074, '2021-07-30', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (91, '2022-05-18', 4, 'Legal', 216, 12166, '2021-01-16', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (101, '2023-02-09', 4, 'student', 142, 0, '2020-08-20', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (112, '2022-04-24', 4, 'Dentist', 70, 13809, '2021-01-06', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (159, '2022-03-06', 12, 'HR', 158, 4553, '2021-10-08', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (148, '2021-07-20', 12, 'Legal', 114, 13674, '2020-07-27', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (176, '2023-07-27', 5, 'Physician', 121, 23899, '2020-03-31', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (68, '2020-09-07', 6, 'Counselor', 82, 6363, '2020-08-28', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (136, '2020-11-28', 8, 'Engineer', 129, 10462, '2020-09-27', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (78, '2021-03-26', 8, 'SocialWorker', 41, 6790, '2021-03-16', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (146, '2022-10-14', 8, 'Physician', 4, 20141, '2020-03-11', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (135, '2021-07-29', 9, 'Financial', 102, 13085, '2021-07-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (154, '2020-08-08', 10, 'Marketing', 24, 14631, '2020-07-29', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (93, '2022-08-30', 9, 'student', 225, 0, '2021-06-10', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (231, '2022-06-19', 10, 'Physician', 6, 24751, '2020-08-11', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (249, '2020-07-17', 11, 'Dentist', 94, 16023, '2020-04-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (218, '2023-07-18', 9, 'Counselor', 124, 6698, '2021-10-04', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (129, '2022-05-12', 6, 'student', 184, 0, '2020-11-22', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (167, '2022-06-06', 8, 'student', 70, 0, '2020-10-18', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (99, '2021-01-17', 3, 'Physician', 207, 20913, '2021-01-07', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (136, '2021-09-19', 9, 'Engineer', 216, 10453, '2021-09-09', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (208, '2021-11-13', 4, 'Computer', 14, 10341, '2021-05-16', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (240, '2022-05-21', 9, 'Counselor', 186, 4937, '2020-05-27', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (174, '2023-01-19', 11, 'Marketing', 224, 12113, '2022-03-14', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (92, '2023-01-28', 7, 'student', 179, 0, '2021-04-26', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (129, '2023-02-26', 3, 'student', 122, 0, '2020-02-15', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (124, '2022-02-21', 11, 'Dentist', 158, 13427, '2021-05-16', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (259, '2021-10-13', 6, 'Dentist', 145, 15529, '2021-10-03', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (95, '2022-04-23', 3, 'student', 4, 0, '2022-02-05', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (103, '2022-08-29', 12, 'HR', 219, 4740, '2020-01-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (81, '2022-06-11', 4, 'HR', 181, 4595, '2020-08-25', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (240, '2021-09-30', 12, 'Computer', 162, 11480, '2021-04-11', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (235, '2021-07-27', 11, 'student', 211, 0, '2021-07-17', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (134, '2021-04-01', 3, 'SocialWorker', 189, 5983, '2021-03-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (229, '2022-12-18', 8, 'Computer', 163, 10675, '2022-01-28', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (158, '2020-06-21', 3, 'Data', 138, 12102, '2020-06-11', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (235, '2021-07-29', 3, 'SocialWorker', 241, 6557, '2021-07-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (232, '2023-08-28', 6, 'Teacher', 183, 7385, '2021-08-04', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (93, '2022-11-16', 8, 'Education', 193, 7854, '2020-10-23', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (118, '2022-11-11', 3, 'HR', 111, 7557, '2020-12-27', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (128, '2023-01-07', 6, 'Nurse', 103, 9826, '2021-09-17', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (150, '2021-05-27', 7, 'Teacher', 96, 7359, '2020-01-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (81, '2022-11-27', 8, 'Financial', 172, 14920, '2021-07-24', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (74, '2022-02-02', 3, 'Engineer', 23, 9040, '2020-11-20', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (233, '2020-07-17', 10, 'Engineer', 39, 8132, '2020-04-17', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (174, '2023-09-09', 6, 'student', 104, 0, '2022-01-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (53, '2020-10-10', 4, 'student', 162, 0, '2020-09-30', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (195, '2021-01-24', 8, 'Financial', 110, 14742, '2020-05-28', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (256, '2022-06-05', 7, 'Education', 97, 7090, '2020-08-13', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (202, '2021-01-03', 6, 'student', 8, 0, '2020-12-24', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (95, '2022-06-15', 11, 'Nurse', 139, 9241, '2020-05-19', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (203, '2021-06-11', 3, 'Education', 145, 5513, '2021-06-01', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (101, '2021-11-19', 12, 'student', 21, 0, '2020-09-27', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (240, '2022-06-15', 5, 'Nurse', 94, 9723, '2021-08-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (159, '2021-08-03', 12, 'student', 195, 0, '2021-07-24', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (53, '2021-10-23', 8, 'student', 23, 0, '2020-07-27', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (114, '2021-02-14', 6, 'student', 94, 0, '2021-02-04', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (227, '2023-02-16', 5, 'Physician', 94, 23091, '2020-12-06', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (69, '2023-03-07', 9, 'Engineer', 142, 10817, '2021-06-16', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (189, '2022-07-15', 7, 'Teacher', 107, 6610, '2022-02-22', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (261, '2023-01-18', 7, 'SocialWorker', 63, 7990, '2022-01-13', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (215, '2021-06-18', 6, 'Computer', 191, 7976, '2020-04-26', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (176, '2023-08-19', 11, 'student', 8, 0, '2020-05-08', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (109, '2022-07-02', 4, 'student', 5, 0, '2021-04-06', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (78, '2023-07-23', 6, 'student', 229, 0, '2020-06-02', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (249, '2022-03-04', 12, 'student', 9, 0, '2020-08-13', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (162, '2023-03-18', 7, 'student', 93, 0, '2022-03-29', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (228, '2022-08-30', 10, 'student', 202, 0, '2021-11-29', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (117, '2021-06-09', 11, 'Engineer', 81, 6911, '2020-08-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (157, '2022-08-07', 4, 'Teacher', 170, 8313, '2021-03-04', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (72, '2021-07-22', 11, 'student', 217, 0, '2020-10-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (239, '2022-09-08', 5, 'Engineer', 95, 7036, '2020-07-07', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (105, '2023-02-17', 4, 'student', 58, 0, '2022-04-12', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (223, '2022-02-01', 11, 'student', 217, 0, '2021-10-30', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (117, '2023-08-07', 7, 'student', 93, 0, '2022-02-18', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (55, '2021-09-29', 7, 'student', 28, 0, '2021-04-05', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (250, '2022-04-05', 4, 'student', 175, 0, '2022-03-13', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (193, '2021-07-15', 10, 'SocialWorker', 202, 7684, '2021-07-05', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (98, '2020-08-10', 6, 'Education', 35, 7467, '2020-07-31', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (123, '2020-10-31', 4, 'Education', 110, 5947, '2020-10-21', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (114, '2023-05-18', 11, 'Computer', 63, 9522, '2022-01-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (59, '2023-09-09', 4, 'student', 136, 0, '2020-05-31', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (121, '2021-01-18', 10, 'Nurse', 122, 9775, '2020-02-05', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (149, '2023-04-13', 11, 'Education', 109, 5615, '2020-07-09', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (155, '2021-10-19', 11, 'Counselor', 129, 3561, '2020-08-07', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (75, '2021-02-01', 9, 'Computer', 69, 5490, '2021-01-22', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (114, '2022-03-19', 12, 'Computer', 202, 10055, '2020-11-04', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (70, '2020-07-16', 4, 'Counselor', 226, 5785, '2020-06-03', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (128, '2022-04-19', 4, 'student', 168, 0, '2021-01-29', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (61, '2022-04-25', 7, 'student', 94, 0, '2021-02-16', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (65, '2022-08-15', 4, 'HR', 213, 7236, '2021-12-16', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (95, '2021-09-24', 6, 'Dentist', 178, 14026, '2020-08-07', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (214, '2022-02-26', 5, 'student', 206, 0, '2021-08-03', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (73, '2020-10-13', 11, 'Data', 22, 9728, '2020-07-02', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (135, '2023-08-04', 3, 'student', 221, 0, '2020-08-16', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (252, '2022-03-25', 7, 'Education', 117, 5787, '2021-09-16', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (200, '2023-08-24', 12, 'Education', 175, 6018, '2020-11-16', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (134, '2021-02-28', 3, 'Legal', 232, 11260, '2021-02-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (168, '2020-10-18', 6, 'student', 192, 0, '2020-10-08', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (176, '2023-08-25', 9, 'Nurse', 71, 6809, '2021-08-02', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (146, '2022-08-26', 9, 'student', 217, 0, '2021-02-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (60, '2022-11-10', 3, 'Engineer', 187, 7322, '2021-04-16', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (249, '2021-05-03', 9, 'student', 28, 0, '2020-05-29', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (176, '2021-06-21', 11, 'student', 142, 0, '2021-04-01', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (77, '2022-02-09', 3, 'HR', 95, 7744, '2021-07-16', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (88, '2022-12-03', 9, 'student', 179, 0, '2020-09-10', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (197, '2023-07-01', 7, 'Data', 232, 12471, '2022-04-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (255, '2020-08-04', 6, 'Nurse', 85, 7400, '2020-07-25', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (105, '2020-09-16', 10, 'Computer', 221, 7347, '2020-09-06', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (246, '2020-06-06', 11, 'student', 171, 0, '2020-05-27', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (245, '2021-06-30', 3, 'Teacher', 128, 6926, '2021-06-20', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (149, '2021-10-14', 8, 'student', 75, 0, '2021-10-04', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (140, '2023-05-21', 6, 'Education', 55, 8922, '2020-04-26', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (233, '2022-07-02', 6, 'student', 187, 0, '2020-08-11', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (172, '2021-04-10', 9, 'Dentist', 1, 14135, '2020-06-05', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (215, '2021-01-04', 11, 'student', 83, 0, '2020-12-25', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (194, '2023-03-31', 6, 'Engineer', 53, 8146, '2020-01-06', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (137, '2021-06-26', 9, 'Legal', 215, 12324, '2020-05-25', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (123, '2020-12-19', 3, 'Nurse', 230, 4863, '2020-03-10', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (164, '2022-07-28', 11, 'Nurse', 46, 7356, '2021-01-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (147, '2022-09-02', 9, 'Counselor', 63, 5474, '2021-01-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (176, '2021-06-11', 4, 'student', 206, 0, '2021-06-01', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (58, '2021-03-28', 5, 'SocialWorker', 203, 3446, '2020-05-28', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (100, '2021-07-23', 10, 'SocialWorker', 77, 4511, '2020-11-09', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (134, '2022-07-25', 10, 'student', 195, 0, '2020-11-05', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (120, '2022-11-03', 6, 'student', 12, 0, '2021-10-08', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (79, '2022-12-07', 10, 'student', 211, 0, '2020-06-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (260, '2021-06-21', 5, 'student', 94, 0, '2020-04-15', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (154, '2021-08-31', 3, 'HR', 184, 3341, '2021-05-05', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (87, '2023-06-10', 12, 'Data', 152, 12685, '2020-12-29', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (71, '2021-03-05', 9, 'student', 179, 0, '2021-02-23', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (212, '2020-06-09', 3, 'student', 202, 0, '2020-01-01', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (213, '2022-03-02', 11, 'HR', 60, 3977, '2021-06-08', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (54, '2020-07-24', 12, 'Data', 163, 9247, '2020-07-14', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (207, '2022-11-10', 11, 'Counselor', 84, 6602, '2020-08-13', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (142, '2023-06-01', 4, 'Legal', 208, 13477, '2021-03-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (167, '2021-12-09', 7, 'Counselor', 117, 4848, '2021-03-01', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (143, '2020-12-22', 6, 'Engineer', 205, 11548, '2020-12-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (56, '2021-02-02', 3, 'Nurse', 156, 8359, '2020-09-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (133, '2022-05-17', 3, 'student', 192, 0, '2020-05-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (260, '2020-12-26', 12, 'Teacher', 194, 8474, '2020-12-16', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (72, '2021-11-01', 4, 'Counselor', 10, 6383, '2020-06-14', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (126, '2023-08-30', 10, 'Financial', 22, 11613, '2021-10-03', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (134, '2023-09-02', 4, 'Teacher', 210, 8382, '2021-08-11', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (131, '2022-03-05', 10, 'Nurse', 181, 9755, '2020-03-11', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (82, '2023-02-11', 11, 'Dentist', 211, 14624, '2020-09-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (112, '2021-07-14', 11, 'Education', 5, 5755, '2020-05-01', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (260, '2022-01-30', 10, 'student', 228, 0, '2021-09-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (156, '2021-05-18', 5, 'Teacher', 111, 8900, '2020-08-25', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (106, '2022-05-04', 8, 'Legal', 108, 11521, '2020-02-26', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (137, '2021-12-26', 8, 'student', 77, 0, '2020-05-08', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (159, '2021-04-18', 9, 'Financial', 5, 11649, '2021-04-08', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (148, '2022-10-16', 3, 'student', 191, 0, '2020-05-11', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (160, '2021-05-22', 9, 'Nurse', 102, 5599, '2021-05-12', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (116, '2023-09-16', 7, 'student', 218, 0, '2020-08-22', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (195, '2023-08-16', 8, 'HR', 177, 3837, '2022-01-02', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (243, '2022-08-14', 7, 'Education', 194, 6267, '2021-02-26', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (98, '2023-05-24', 8, 'Physician', 196, 18325, '2021-05-23', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (75, '2020-06-08', 7, 'student', 85, 0, '2020-04-30', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (189, '2020-07-16', 5, 'SocialWorker', 23, 4025, '2020-07-06', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (167, '2022-10-02', 9, 'student', 216, 0, '2020-09-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (227, '2022-09-19', 12, 'Legal', 64, 9059, '2020-06-01', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (105, '2021-03-22', 11, 'Physician', 70, 23495, '2020-11-23', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (85, '2021-01-13', 7, 'Dentist', 70, 14620, '2021-01-03', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (68, '2021-10-07', 8, 'student', 165, 0, '2021-09-27', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (121, '2023-04-07', 6, 'Marketing', 34, 12841, '2021-02-15', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (259, '2021-04-27', 9, 'Legal', 145, 11101, '2021-04-17', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (123, '2022-11-14', 7, 'Data', 171, 11574, '2021-07-24', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (61, '2022-10-07', 10, 'student', 136, 0, '2021-06-03', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (240, '2022-08-03', 7, 'Engineer', 155, 7882, '2021-09-01', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (126, '2022-02-10', 11, 'Physician', 24, 17082, '2021-09-20', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (157, '2021-04-16', 12, 'Legal', 25, 11887, '2021-04-06', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (112, '2022-04-03', 6, 'student', 186, 0, '2021-02-21', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (177, '2021-08-27', 7, 'student', 217, 0, '2020-07-11', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (206, '2023-02-14', 5, 'SocialWorker', 152, 7594, '2020-05-01', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (99, '2022-04-12', 11, 'student', 95, 0, '2020-01-29', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (255, '2020-10-03', 6, 'student', 9, 0, '2020-09-23', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (123, '2021-05-19', 9, 'Physician', 125, 20215, '2020-12-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (64, '2020-07-22', 5, 'student', 140, 0, '2020-06-25', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (162, '2021-01-25', 4, 'Dentist', 225, 16979, '2020-04-11', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (171, '2021-11-09', 12, 'Counselor', 168, 6483, '2021-05-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (229, '2021-09-06', 10, 'Teacher', 141, 8394, '2020-10-29', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (181, '2022-03-26', 7, 'student', 162, 0, '2021-06-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (63, '2020-11-19', 4, 'student', 3, 0, '2020-11-09', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (95, '2023-07-13', 11, 'Nurse', 10, 8033, '2021-02-20', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (172, '2023-07-27', 8, 'Dentist', 71, 16813, '2021-11-28', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (88, '2022-07-05', 12, 'SocialWorker', 6, 4483, '2022-03-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (73, '2023-09-03', 11, 'student', 3, 0, '2021-05-15', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (144, '2023-04-05', 3, 'Dentist', 168, 12423, '2021-01-17', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (188, '2021-02-20', 9, 'HR', 175, 7424, '2021-02-10', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (145, '2020-08-13', 5, 'student', 215, 0, '2020-08-03', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (166, '2020-07-27', 9, 'Teacher', 21, 10374, '2020-07-17', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (206, '2023-05-04', 6, 'Marketing', 65, 12842, '2021-06-16', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (196, '2023-09-06', 12, 'student', 232, 0, '2021-05-13', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (255, '2023-07-02', 11, 'Teacher', 155, 6752, '2020-03-27', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (103, '2022-05-04', 9, 'Engineer', 48, 7818, '2022-03-20', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (77, '2022-08-14', 8, 'Nurse', 202, 6757, '2022-03-28', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (156, '2022-04-27', 9, 'student', 175, 0, '2020-04-08', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (147, '2021-09-05', 11, 'student', 168, 0, '2021-02-08', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (186, '2021-08-09', 6, 'Teacher', 189, 9756, '2021-07-30', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (56, '2020-09-30', 7, 'student', 192, 0, '2020-09-20', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (242, '2023-04-21', 5, 'Engineer', 124, 11754, '2020-10-20', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (208, '2021-06-11', 8, 'Teacher', 28, 10069, '2020-12-05', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (208, '2023-06-20', 10, 'Marketing', 171, 12266, '2020-03-07', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (184, '2020-10-28', 10, 'Financial', 121, 13512, '2020-10-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (63, '2020-08-05', 7, 'Teacher', 191, 8478, '2020-06-07', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (253, '2020-11-28', 6, 'student', 138, 0, '2020-11-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (74, '2023-04-11', 10, 'Financial', 162, 12055, '2021-11-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (206, '2023-08-26', 12, 'student', 241, 0, '2021-03-14', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (116, '2023-01-29', 9, 'Computer', 13, 7730, '2020-04-11', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (77, '2022-02-16', 5, 'student', 241, 0, '2020-12-31', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (216, '2023-05-26', 11, 'Counselor', 48, 4565, '2020-10-14', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (64, '2020-08-27', 6, 'Computer', 191, 8097, '2020-08-17', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (71, '2022-03-17', 4, 'Computer', 74, 6977, '2021-02-10', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (249, '2021-04-21', 3, 'Marketing', 191, 13463, '2020-07-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (173, '2023-05-29', 5, 'student', 216, 0, '2021-07-02', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (116, '2022-06-17', 3, 'Computer', 26, 11474, '2020-04-16', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (227, '2021-12-27', 11, 'student', 30, 0, '2020-02-06', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (186, '2023-03-24', 6, 'HR', 235, 3654, '2020-10-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (68, '2022-09-29', 5, 'student', 70, 0, '2021-07-15', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (191, '2022-10-27', 9, 'student', 5, 0, '2021-07-23', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (127, '2023-04-17', 4, 'Legal', 145, 7987, '2021-10-11', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (53, '2022-09-15', 12, 'student', 124, 0, '2022-01-26', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (128, '2022-09-21', 9, 'student', 22, 0, '2020-04-26', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (210, '2023-02-25', 4, 'Engineer', 26, 10117, '2021-04-26', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (108, '2020-09-22', 10, 'student', 141, 0, '2020-09-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (101, '2023-06-29', 12, 'Engineer', 243, 9689, '2021-08-02', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (136, '2022-01-23', 10, 'Computer', 196, 10005, '2020-02-01', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (247, '2021-08-29', 11, 'student', 7, 0, '2020-03-10', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (184, '2021-06-17', 4, 'Teacher', 144, 6348, '2021-02-24', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (188, '2023-03-16', 11, 'student', 26, 0, '2021-02-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (140, '2022-01-17', 7, 'SocialWorker', 202, 3141, '2021-08-05', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (69, '2021-11-30', 11, 'student', 136, 0, '2021-06-07', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (162, '2023-07-28', 7, 'Legal', 142, 10110, '2021-10-07', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (100, '2023-01-24', 4, 'Financial', 124, 10743, '2020-01-11', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (181, '2021-01-28', 10, 'student', 6, 0, '2021-01-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (155, '2020-08-18', 4, 'Counselor', 171, 3423, '2020-01-28', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (135, '2023-06-02', 7, 'student', 1, 0, '2021-03-23', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (250, '2020-12-23', 6, 'student', 185, 0, '2020-12-13', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (134, '2020-10-24', 3, 'student', 185, 0, '2020-10-14', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (229, '2021-04-29', 11, 'Physician', 87, 17991, '2020-05-09', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (184, '2021-02-20', 11, 'Nurse', 236, 8484, '2021-02-10', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (219, '2022-09-29', 4, 'Engineer', 224, 8677, '2022-04-17', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (243, '2023-08-22', 3, 'Engineer', 139, 11107, '2022-03-29', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (253, '2021-07-30', 5, 'student', 138, 0, '2020-09-09', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (126, '2021-01-12', 6, 'student', 116, 0, '2021-01-02', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (193, '2020-10-14', 4, 'Legal', 170, 10394, '2020-10-04', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (178, '2021-04-07', 9, 'Nurse', 177, 4898, '2020-02-06', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (203, '2023-09-26', 11, 'Teacher', 27, 8272, '2022-03-03', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (97, '2021-11-25', 8, 'student', 115, 0, '2020-11-24', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (120, '2023-08-08', 6, 'student', 6, 0, '2021-03-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (203, '2022-01-22', 8, 'student', 171, 0, '2021-04-22', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (165, '2022-12-03', 8, 'Counselor', 72, 3710, '2021-02-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (134, '2022-05-09', 12, 'SocialWorker', 232, 4619, '2020-08-03', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (59, '2021-10-10', 12, 'HR', 35, 6480, '2020-05-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (205, '2023-08-10', 7, 'student', 2, 0, '2021-10-29', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (90, '2020-10-16', 3, 'student', 136, 0, '2020-10-06', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (115, '2021-08-21', 12, 'Teacher', 70, 8834, '2020-09-08', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (219, '2023-03-13', 3, 'student', 116, 0, '2021-05-04', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (232, '2023-03-16', 4, 'student', 10, 0, '2021-10-23', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (168, '2020-11-30', 6, 'Data', 195, 10248, '2020-11-20', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (93, '2021-10-14', 6, 'Financial', 108, 12238, '2020-02-16', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (78, '2022-06-12', 4, 'Marketing', 113, 12702, '2020-03-01', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (227, '2020-11-06', 6, 'student', 162, 0, '2020-03-26', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (118, '2022-07-22', 4, 'student', 5, 0, '2021-11-29', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (132, '2023-03-27', 7, 'Nurse', 215, 8170, '2020-03-05', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (158, '2020-09-26', 8, 'student', 94, 0, '2020-01-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (148, '2020-11-09', 8, 'Nurse', 144, 5066, '2020-10-30', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (202, '2020-07-23', 6, 'Financial', 211, 11115, '2020-07-13', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (119, '2022-09-11', 8, 'student', 71, 0, '2020-05-06', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (191, '2023-08-23', 11, 'Data', 168, 7326, '2021-04-17', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (182, '2022-01-10', 5, 'Legal', 236, 11260, '2021-12-31', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (92, '2021-05-02', 11, 'student', 210, 0, '2021-04-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (217, '2021-02-26', 10, 'Dentist', 93, 16469, '2021-02-16', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (66, '2020-12-13', 4, 'student', 25, 0, '2020-12-03', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (256, '2023-04-09', 10, 'Dentist', 79, 13886, '2020-05-10', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (104, '2020-09-19', 3, 'Nurse', 198, 7900, '2020-09-09', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (143, '2021-05-05', 10, 'Education', 21, 8441, '2021-01-21', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (100, '2021-04-07', 4, 'Teacher', 58, 6828, '2021-03-28', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (67, '2020-06-10', 9, 'Engineer', 191, 7162, '2020-05-31', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (220, '2021-01-15', 7, 'Teacher', 2, 8435, '2021-01-05', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (250, '2021-09-08', 9, 'student', 11, 0, '2021-06-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (135, '2022-04-16', 12, 'student', 9, 0, '2021-05-03', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (158, '2023-05-17', 5, 'Marketing', 112, 11984, '2021-11-03', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (107, '2023-08-05', 10, 'Physician', 94, 19916, '2020-04-25', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (59, '2022-06-20', 9, 'Legal', 20, 7948, '2021-12-06', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (70, '2022-05-28', 11, 'student', 162, 0, '2020-02-29', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (189, '2023-07-27', 4, 'Marketing', 138, 13031, '2020-12-12', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (141, '2023-03-18', 7, 'Dentist', 21, 13636, '2021-07-22', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (94, '2022-01-23', 3, 'Nurse', 22, 5816, '2020-03-17', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (169, '2020-08-20', 5, 'Legal', 171, 11428, '2020-08-10', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (90, '2023-06-01', 11, 'Legal', 196, 11797, '2021-10-15', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (111, '2023-06-26', 7, 'student', 140, 0, '2020-02-07', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (124, '2022-03-25', 8, 'Data', 139, 11487, '2020-04-11', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (258, '2021-06-15', 6, 'Teacher', 96, 10467, '2021-02-03', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (131, '2023-01-21', 3, 'Computer', 25, 8595, '2020-11-17', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (95, '2022-04-20', 8, 'student', 66, 0, '2020-03-08', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (169, '2023-03-31', 11, 'Education', 236, 7815, '2020-03-15', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (210, '2023-08-06', 9, 'Education', 175, 6778, '2020-06-19', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (183, '2022-12-03', 12, 'Education', 101, 8005, '2021-11-25', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (180, '2020-07-12', 10, 'Data', 160, 8092, '2020-07-02', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (85, '2020-08-29', 10, 'student', 202, 0, '2020-08-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (245, '2021-10-21', 11, 'student', 53, 0, '2020-05-24', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (142, '2020-09-07', 3, 'student', 185, 0, '2020-08-28', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (178, '2023-05-11', 6, 'Teacher', 30, 7535, '2022-03-29', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (84, '2021-05-12', 12, 'Education', 104, 9148, '2020-08-29', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (203, '2021-11-08', 4, 'Financial', 21, 10195, '2021-06-28', 0);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (91, '2021-02-19', 5, 'Engineer', 10, 8742, '2020-12-14', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (154, '2022-05-08', 9, 'student', 3, 0, '2020-08-18', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (109, '2020-12-03', 10, 'Engineer', 2, 9229, '2020-09-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (187, '2021-05-31', 5, 'HR', 27, 4570, '2020-10-12', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (110, '2021-08-29', 7, 'student', 117, 0, '2021-08-19', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (84, '2022-01-16', 5, 'Teacher', 1, 7016, '2022-01-06', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (184, '2020-10-19', 9, 'Nurse', 217, 8119, '2020-10-09', 1);
insert into dbo.application (customer_id, move_in_date, expected_tenancy, occupation, room_id, income_monthly, application_date, isValid) values (214, '2022-10-22', 5, 'Teacher', 63, 10978, '2020-05-27', 0);

	

/*
 * Step 14: insert data into VistingHistory
 */
INSERT into dbo.VisitingHistory (room_id, custom_id, [date])
VALUES
	(1, 1, '2021-01-01'), --1 is 1b1b
	(1, 23, '2021-01-02'),
	(1, 25, '2021-01-06'),
	(1, 26, '2021-01-16'),
	(1, 27, '2021-01-16'),
	(1, 28, '2021-01-26'),
	(1, 37, '2021-02-02'),
	(1, 41, '2021-02-16'),
	(1, 42, '2021-02-16'),
	(1, 42, '2021-02-16'),
	(9, 5, '2021-02-18'), -- 9 is 2b1b
	(9, 6, '2021-02-18'),
	(9, 7, '2021-02-18'),
	(9, 8, '2021-02-18'),
	(9, 9, '2021-02-18'),
	(9, 10, '2021-02-19'),
	(9, 10, '2021-02-19'),
	(9, 12, '2021-02-19'),
	(9, 13, '2021-02-19'),
	(9, 14, '2021-02-19'),
	(9, 15, '2021-02-20'),
	(9, 16, '2021-02-20'),
	(9, 17, '2021-02-20'),
	(9, 18, '2021-02-20'),
	(29, 23, '2021-02-21'), --29 is 2b2b
	(29, 24, '2021-02-21'),
	(29, 25, '2021-02-21'),
	(29, 26, '2021-02-21'),
	(29, 27, '2021-02-21'),
	(29, 28, '2021-02-23'),
	(29, 29, '2021-02-23'),
	(29, 30, '2021-02-24'),
	(29, 31, '2021-02-24'),
	(29, 32, '2021-02-24'),
	(29, 23, '2021-02-21'), 
	(29, 34, '2021-02-21'),
	(29, 35, '2021-02-21'),
	(29, 36, '2021-02-21'),
	(29, 37, '2021-02-21'),
	(29, 38, '2021-02-23'),
	(29, 39, '2021-02-23'),
	(29, 40, '2021-02-24'),
	(29, 41, '2021-02-24'),
	(29, 42, '2021-02-24'),
	(29, 43, '2021-02-23'),
	(29, 44, '2021-02-23'),
	(29, 5, '2021-02-24'),
	(29, 6, '2021-02-24'),
	(29, 7, '2021-02-24'),
	(21, 1, '2021-02-25'), --21 is 1b1b
	(21, 3, '2021-02-23'),
	(21, 14, '2021-02-25'),
	(21, 21, '2021-03-25'),
	(33, 31, '2021-02-27'), --33 is 3b3b
	(33, 32, '2021-02-27'),
	(33, 33, '2021-02-27'),
	(33, 9, '2021-02-27'),
	(13, 9, '2021-03-02'), --13 is 3b2b
	(13, 10, '2021-03-02'),
	(13, 11, '2021-03-02'),
	(13, 12, '2021-03-02'),
	(13, 13, '2021-03-02'),
	(17, 15, '2021-03-04'), --17 is 4b2b
	(17, 16, '2021-03-04'),
	(17, 17, '2021-03-04'),
	(17, 18, '2021-03-04'),
	(17, 19, '2021-03-04'),
	(17, 20, '2021-03-06'),
	(17, 21, '2021-03-06'),
	(17, 22, '2021-03-06'),
	(17, 38, '2021-03-06'),
	(37, 37, '2021-02-08'), --37 is 4b4b
	(37, 38, '2021-03-14'),
	(37, 39, '2021-02-08'),
	(37, 40, '2021-03-14'),
	(37, 41, '2021-02-08'),
	(37, 42, '2021-03-14'),
	(37, 43, '2021-02-08'),
	(37, 44, '2021-03-14'),
	(37, 15, '2021-02-08'),
	(37, 16, '2021-03-14'),
	(37, 17, '2021-02-08'),
	(37, 18, '2021-03-14'),
	(37, 19, '2021-02-08'),
	(37, 20, '2021-03-14'),
	(37, 21, '2021-02-08');

insert into dbo.visitinghistory (room_id, custom_id, date) values (224, 71, '2020-11-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (64, 90, '2021-12-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (230, 164, '2021-01-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (57, 104, '2020-09-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (141, 158, '2020-09-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (44, 140, '2021-06-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (195, 171, '2021-03-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (208, 209, '2020-01-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (83, 140, '2020-02-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (164, 73, '2022-02-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (67, 166, '2021-08-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (152, 200, '2021-09-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (118, 165, '2020-08-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (180, 103, '2022-03-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (136, 228, '2021-01-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (110, 102, '2021-04-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (241, 156, '2020-04-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (195, 90, '2021-07-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (79, 122, '2021-09-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (10, 140, '2021-04-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (49, 217, '2021-06-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (43, 66, '2020-06-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (153, 208, '2022-04-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (106, 111, '2021-08-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (38, 144, '2020-06-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (43, 228, '2021-12-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (46, 161, '2021-10-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (65, 246, '2021-11-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (138, 67, '2020-01-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (157, 54, '2020-02-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (181, 64, '2021-02-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (91, 191, '2020-10-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (38, 72, '2020-03-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (37, 126, '2020-03-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (27, 84, '2021-02-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (60, 76, '2020-11-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (51, 124, '2020-03-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (243, 150, '2020-09-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (75, 137, '2020-10-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (119, 155, '2021-05-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (58, 80, '2021-05-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (127, 89, '2021-12-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (110, 245, '2021-01-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (66, 131, '2022-04-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (196, 105, '2021-08-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (53, 200, '2020-07-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (191, 217, '2020-10-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (183, 193, '2021-01-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (218, 149, '2020-08-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (6, 168, '2022-01-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (31, 225, '2021-12-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (58, 120, '2021-03-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (41, 222, '2021-01-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (38, 83, '2022-04-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (65, 109, '2021-10-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (97, 72, '2021-07-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (65, 244, '2021-11-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (136, 87, '2020-06-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (23, 93, '2020-06-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (79, 208, '2021-03-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (92, 177, '2022-01-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (8, 133, '2021-11-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (110, 142, '2020-03-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (72, 258, '2022-03-17');
insert into dbo.visitinghistory (room_id, custom_id, date) values (70, 102, '2021-06-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (42, 198, '2020-01-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (32, 187, '2022-04-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (97, 121, '2020-07-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (206, 111, '2021-02-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (21, 260, '2021-01-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (154, 147, '2021-04-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (194, 252, '2020-01-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (122, 186, '2021-06-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (82, 181, '2020-03-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (170, 152, '2021-09-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (191, 156, '2022-02-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (21, 237, '2021-11-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (155, 197, '2021-04-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (165, 94, '2020-08-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (121, 238, '2020-12-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (91, 192, '2021-07-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (33, 60, '2021-12-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (233, 123, '2021-12-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (188, 244, '2021-04-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (107, 208, '2021-11-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (135, 60, '2020-03-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (230, 163, '2020-12-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (9, 222, '2021-06-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (104, 56, '2020-09-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (100, 253, '2020-10-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (19, 201, '2020-11-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (78, 235, '2022-02-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (42, 226, '2020-11-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (105, 146, '2022-03-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (64, 144, '2020-03-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (141, 81, '2020-01-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (237, 85, '2021-11-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (93, 88, '2020-07-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (62, 78, '2022-01-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (102, 114, '2021-07-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (22, 244, '2021-01-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (153, 154, '2020-03-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (81, 205, '2020-02-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (164, 238, '2021-06-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (236, 116, '2021-09-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (221, 132, '2021-10-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (49, 64, '2020-11-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (32, 225, '2020-01-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (180, 260, '2020-09-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (154, 198, '2020-12-31');
insert into dbo.visitinghistory (room_id, custom_id, date) values (103, 114, '2020-06-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (66, 218, '2020-09-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (80, 249, '2022-01-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (228, 121, '2020-10-31');
insert into dbo.visitinghistory (room_id, custom_id, date) values (135, 90, '2020-05-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (206, 158, '2021-02-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (119, 244, '2021-08-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (197, 74, '2020-02-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (145, 64, '2021-05-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (208, 76, '2020-02-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (50, 195, '2021-08-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (167, 187, '2021-10-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (16, 169, '2020-09-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (71, 195, '2022-03-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (50, 249, '2020-04-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (198, 68, '2020-01-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (33, 209, '2021-07-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (205, 238, '2020-06-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (66, 250, '2020-05-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (242, 141, '2021-12-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (122, 99, '2022-03-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (39, 217, '2021-08-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (19, 81, '2021-08-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (102, 249, '2020-10-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (192, 182, '2021-04-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (84, 55, '2021-11-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (223, 56, '2021-09-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (235, 154, '2021-07-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (17, 162, '2020-12-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (192, 137, '2021-06-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (31, 164, '2021-04-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (18, 132, '2020-01-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (173, 119, '2022-01-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (12, 124, '2020-08-31');
insert into dbo.visitinghistory (room_id, custom_id, date) values (130, 239, '2022-02-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (223, 107, '2021-08-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (166, 176, '2020-09-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (117, 237, '2020-05-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (19, 115, '2021-10-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (143, 209, '2022-01-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (166, 121, '2020-04-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (106, 160, '2021-07-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (34, 167, '2020-12-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (27, 250, '2020-12-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (109, 204, '2020-08-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (211, 97, '2020-07-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (107, 234, '2020-12-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (236, 117, '2022-01-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (183, 139, '2021-02-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (227, 81, '2020-10-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (146, 67, '2021-04-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (150, 249, '2021-06-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (203, 243, '2022-02-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (101, 247, '2021-11-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (51, 91, '2021-09-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (39, 193, '2021-04-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (20, 180, '2020-01-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (231, 115, '2022-03-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (183, 69, '2021-08-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (157, 239, '2021-06-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (77, 252, '2020-09-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (196, 164, '2020-01-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (4, 154, '2021-11-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (129, 170, '2020-10-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (182, 193, '2020-04-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (119, 171, '2020-12-17');
insert into dbo.visitinghistory (room_id, custom_id, date) values (239, 254, '2021-03-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (134, 249, '2020-09-17');
insert into dbo.visitinghistory (room_id, custom_id, date) values (233, 218, '2021-10-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (103, 255, '2020-07-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (61, 178, '2021-05-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (37, 53, '2021-05-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (43, 227, '2022-03-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (34, 258, '2020-01-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (101, 227, '2021-06-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (83, 228, '2020-08-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (35, 115, '2020-06-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (75, 239, '2021-12-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (135, 145, '2021-06-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (209, 73, '2022-01-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (216, 194, '2020-12-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (132, 133, '2020-01-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (156, 228, '2021-01-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (73, 61, '2021-03-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (229, 162, '2020-04-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (223, 170, '2020-07-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (56, 133, '2021-05-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (147, 113, '2020-04-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (194, 85, '2021-06-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (198, 113, '2020-08-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (13, 156, '2021-09-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (236, 123, '2021-04-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (141, 148, '2020-06-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (91, 199, '2021-06-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (118, 227, '2022-04-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (98, 56, '2021-10-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (57, 247, '2020-03-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (1, 231, '2020-03-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (157, 66, '2020-05-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (224, 105, '2021-04-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (54, 91, '2020-12-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (244, 156, '2022-01-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (148, 218, '2022-04-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (52, 180, '2020-12-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (214, 143, '2021-04-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (45, 107, '2020-08-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (218, 68, '2020-03-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (8, 147, '2021-04-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (12, 90, '2021-09-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (102, 143, '2022-03-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (68, 184, '2022-03-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (137, 260, '2021-01-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (155, 188, '2020-06-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (215, 179, '2021-05-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (96, 256, '2021-07-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (4, 246, '2020-12-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (143, 109, '2022-01-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (105, 238, '2020-12-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (140, 149, '2022-04-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (56, 116, '2021-08-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (129, 234, '2020-10-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (142, 146, '2020-11-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (42, 224, '2022-01-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (27, 238, '2020-02-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (211, 178, '2021-06-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (187, 77, '2021-09-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (73, 218, '2020-03-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (21, 57, '2020-09-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (190, 173, '2020-09-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (243, 231, '2020-09-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (196, 180, '2021-03-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (77, 202, '2020-08-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (135, 88, '2020-11-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (239, 165, '2021-01-31');
insert into dbo.visitinghistory (room_id, custom_id, date) values (192, 217, '2021-12-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (113, 212, '2020-08-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (80, 194, '2021-04-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (31, 106, '2020-08-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (173, 65, '2020-11-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (61, 90, '2021-11-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (46, 91, '2020-02-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (152, 91, '2022-02-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (239, 231, '2020-03-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (186, 258, '2021-08-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (113, 104, '2021-03-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (227, 85, '2020-03-31');
insert into dbo.visitinghistory (room_id, custom_id, date) values (1, 239, '2021-08-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (220, 239, '2020-05-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (150, 141, '2020-05-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (24, 259, '2021-03-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (16, 64, '2021-12-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (53, 88, '2021-02-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (55, 253, '2021-05-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (10, 259, '2020-11-17');
insert into dbo.visitinghistory (room_id, custom_id, date) values (142, 250, '2020-08-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (47, 142, '2020-04-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (106, 207, '2021-03-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (58, 176, '2021-09-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (30, 87, '2020-10-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (98, 112, '2020-03-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (216, 225, '2020-05-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (169, 159, '2020-02-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (140, 118, '2020-03-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (19, 235, '2021-11-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (174, 183, '2021-12-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (190, 196, '2020-11-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (52, 124, '2022-03-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (57, 144, '2020-05-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (165, 84, '2020-01-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (164, 190, '2020-09-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (33, 254, '2020-11-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (230, 193, '2020-08-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (57, 231, '2020-01-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (127, 214, '2021-08-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (46, 158, '2021-11-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (225, 251, '2021-08-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (91, 117, '2021-04-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (218, 57, '2021-10-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (81, 112, '2021-07-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (24, 194, '2020-02-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (64, 259, '2021-02-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (1, 157, '2022-01-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (10, 123, '2021-06-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (171, 94, '2021-09-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (81, 102, '2020-07-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (224, 100, '2022-01-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (156, 99, '2022-03-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (54, 72, '2021-06-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (165, 147, '2022-04-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (17, 247, '2020-05-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (95, 146, '2021-04-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (36, 145, '2020-08-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (60, 156, '2020-10-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (40, 258, '2021-09-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (86, 64, '2021-08-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (1, 146, '2020-04-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (87, 99, '2021-01-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (62, 145, '2021-10-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (9, 106, '2021-03-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (223, 135, '2021-01-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (71, 115, '2021-11-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (176, 110, '2020-10-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (172, 259, '2020-10-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (177, 54, '2020-08-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (196, 251, '2021-09-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (104, 147, '2020-06-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (148, 134, '2021-04-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (165, 117, '2020-09-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (240, 70, '2021-04-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (19, 229, '2020-04-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (145, 242, '2020-03-17');
insert into dbo.visitinghistory (room_id, custom_id, date) values (17, 117, '2021-09-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (176, 254, '2021-07-31');
insert into dbo.visitinghistory (room_id, custom_id, date) values (141, 113, '2020-10-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (242, 191, '2020-05-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (220, 256, '2020-06-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (65, 199, '2020-02-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (155, 252, '2021-03-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (64, 185, '2021-01-31');
insert into dbo.visitinghistory (room_id, custom_id, date) values (44, 200, '2020-07-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (168, 88, '2020-12-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (195, 220, '2021-06-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (18, 117, '2020-07-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (143, 228, '2021-11-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (116, 136, '2021-10-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (36, 186, '2020-05-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (244, 120, '2021-06-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (78, 261, '2020-07-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (24, 220, '2021-02-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (39, 99, '2020-09-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (39, 93, '2020-11-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (238, 180, '2021-10-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (122, 59, '2021-08-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (46, 140, '2020-07-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (134, 130, '2020-08-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (195, 225, '2022-02-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (73, 80, '2021-12-17');
insert into dbo.visitinghistory (room_id, custom_id, date) values (135, 187, '2021-07-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (111, 91, '2020-02-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (49, 196, '2021-12-17');
insert into dbo.visitinghistory (room_id, custom_id, date) values (136, 257, '2022-02-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (146, 244, '2020-09-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (154, 174, '2020-10-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (84, 232, '2021-05-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (57, 140, '2020-03-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (16, 216, '2020-10-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (61, 218, '2020-04-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (195, 255, '2021-11-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (147, 187, '2022-03-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (22, 209, '2022-01-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (16, 202, '2020-03-31');
insert into dbo.visitinghistory (room_id, custom_id, date) values (106, 57, '2021-06-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (188, 157, '2020-03-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (52, 166, '2021-02-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (161, 129, '2021-04-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (209, 193, '2020-03-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (112, 139, '2020-10-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (78, 137, '2020-09-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (82, 105, '2020-12-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (147, 143, '2021-05-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (239, 74, '2020-05-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (20, 194, '2021-02-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (96, 220, '2020-11-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (243, 260, '2021-12-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (152, 212, '2021-03-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (4, 193, '2021-01-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (148, 88, '2021-09-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (53, 110, '2022-02-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (231, 192, '2020-03-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (69, 70, '2020-06-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (93, 149, '2021-11-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (3, 112, '2021-01-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (28, 162, '2020-07-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (54, 119, '2022-04-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (207, 119, '2021-05-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (54, 151, '2021-11-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (63, 257, '2022-03-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (190, 69, '2022-03-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (193, 170, '2020-06-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (122, 140, '2020-10-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (189, 177, '2021-06-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (198, 65, '2020-03-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (171, 220, '2021-02-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (50, 118, '2021-08-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (136, 201, '2020-05-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (190, 208, '2022-03-31');
insert into dbo.visitinghistory (room_id, custom_id, date) values (39, 108, '2020-01-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (90, 103, '2020-04-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (124, 189, '2022-03-17');
insert into dbo.visitinghistory (room_id, custom_id, date) values (160, 138, '2021-08-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (46, 230, '2021-02-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (51, 129, '2021-02-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (4, 118, '2020-10-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (7, 159, '2020-10-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (32, 127, '2020-02-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (214, 260, '2020-04-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (145, 204, '2020-04-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (112, 72, '2021-08-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (136, 53, '2021-12-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (128, 74, '2020-12-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (5, 143, '2020-06-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (132, 78, '2022-02-17');
insert into dbo.visitinghistory (room_id, custom_id, date) values (170, 151, '2020-06-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (195, 189, '2020-08-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (100, 233, '2021-06-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (92, 227, '2020-11-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (195, 179, '2020-04-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (137, 78, '2021-12-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (193, 133, '2020-06-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (108, 104, '2021-07-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (164, 219, '2020-11-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (208, 103, '2020-10-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (215, 69, '2021-04-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (159, 249, '2020-12-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (18, 83, '2020-08-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (129, 67, '2021-03-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (149, 96, '2020-04-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (196, 241, '2021-08-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (13, 211, '2021-06-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (75, 138, '2020-02-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (240, 175, '2020-02-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (13, 211, '2021-09-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (134, 253, '2022-04-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (3, 199, '2020-04-29');
insert into dbo.visitinghistory (room_id, custom_id, date) values (17, 254, '2020-01-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (228, 176, '2021-01-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (197, 116, '2021-04-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (201, 239, '2020-01-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (152, 183, '2021-04-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (160, 232, '2020-10-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (137, 248, '2020-03-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (34, 112, '2021-08-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (41, 85, '2021-07-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (229, 159, '2022-02-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (122, 178, '2022-02-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (28, 88, '2020-12-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (71, 189, '2021-04-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (166, 98, '2022-02-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (202, 84, '2020-08-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (37, 166, '2020-02-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (205, 260, '2021-12-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (2, 145, '2021-04-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (198, 92, '2020-06-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (207, 87, '2020-03-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (129, 105, '2020-04-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (119, 195, '2021-11-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (201, 107, '2022-01-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (155, 132, '2020-04-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (156, 62, '2021-08-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (64, 111, '2021-10-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (222, 124, '2021-12-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (83, 249, '2021-01-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (136, 97, '2021-12-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (28, 147, '2020-08-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (195, 216, '2020-07-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (32, 227, '2020-09-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (242, 157, '2020-08-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (165, 174, '2021-12-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (187, 203, '2020-04-17');
insert into dbo.visitinghistory (room_id, custom_id, date) values (123, 66, '2020-01-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (192, 163, '2022-03-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (72, 257, '2020-07-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (133, 84, '2021-01-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (126, 92, '2021-01-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (97, 95, '2020-09-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (167, 253, '2021-12-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (42, 62, '2020-11-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (16, 145, '2020-01-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (168, 244, '2021-12-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (232, 208, '2021-06-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (142, 71, '2021-02-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (10, 116, '2020-11-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (146, 176, '2021-01-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (25, 164, '2020-01-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (61, 133, '2021-06-17');
insert into dbo.visitinghistory (room_id, custom_id, date) values (56, 111, '2022-04-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (16, 244, '2020-09-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (87, 166, '2021-10-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (107, 67, '2020-03-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (113, 75, '2021-07-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (72, 130, '2021-05-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (177, 152, '2021-07-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (5, 175, '2021-07-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (34, 78, '2021-06-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (235, 79, '2020-02-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (21, 175, '2020-07-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (213, 79, '2020-03-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (55, 161, '2021-05-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (206, 197, '2021-06-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (210, 97, '2021-04-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (119, 63, '2020-05-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (49, 114, '2020-04-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (63, 153, '2020-03-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (71, 172, '2021-09-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (209, 144, '2021-02-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (141, 146, '2021-09-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (57, 209, '2022-04-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (102, 55, '2021-02-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (68, 256, '2021-08-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (162, 148, '2021-11-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (33, 164, '2021-10-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (204, 111, '2021-05-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (125, 144, '2020-04-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (106, 149, '2021-06-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (226, 240, '2022-01-17');
insert into dbo.visitinghistory (room_id, custom_id, date) values (198, 155, '2021-03-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (95, 54, '2020-01-22');
insert into dbo.visitinghistory (room_id, custom_id, date) values (7, 127, '2022-02-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (239, 237, '2021-06-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (114, 81, '2020-02-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (199, 81, '2021-02-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (217, 225, '2020-06-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (159, 226, '2022-02-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (1, 128, '2021-12-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (213, 81, '2020-06-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (143, 216, '2021-06-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (82, 213, '2022-02-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (30, 245, '2021-07-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (90, 196, '2021-03-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (87, 154, '2020-11-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (84, 173, '2020-10-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (155, 69, '2020-01-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (136, 94, '2021-07-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (94, 221, '2021-05-24');
insert into dbo.visitinghistory (room_id, custom_id, date) values (230, 87, '2020-07-31');
insert into dbo.visitinghistory (room_id, custom_id, date) values (228, 122, '2022-03-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (5, 92, '2020-04-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (23, 158, '2020-03-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (25, 124, '2021-06-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (61, 81, '2020-01-08');
insert into dbo.visitinghistory (room_id, custom_id, date) values (90, 87, '2022-04-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (89, 151, '2021-12-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (149, 128, '2021-10-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (100, 149, '2022-02-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (61, 110, '2022-02-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (46, 179, '2021-06-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (26, 72, '2022-01-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (71, 81, '2020-03-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (128, 211, '2020-06-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (45, 120, '2021-12-26');
insert into dbo.visitinghistory (room_id, custom_id, date) values (16, 250, '2022-02-01');
insert into dbo.visitinghistory (room_id, custom_id, date) values (228, 111, '2020-12-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (219, 80, '2021-01-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (146, 147, '2021-03-31');
insert into dbo.visitinghistory (room_id, custom_id, date) values (192, 60, '2021-05-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (93, 220, '2021-08-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (238, 181, '2020-10-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (165, 75, '2021-08-06');
insert into dbo.visitinghistory (room_id, custom_id, date) values (50, 155, '2021-03-18');
insert into dbo.visitinghistory (room_id, custom_id, date) values (191, 101, '2022-02-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (182, 129, '2021-09-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (221, 111, '2020-06-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (186, 206, '2020-12-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (162, 213, '2021-12-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (187, 168, '2021-02-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (9, 138, '2020-02-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (53, 123, '2022-01-31');
insert into dbo.visitinghistory (room_id, custom_id, date) values (38, 139, '2020-07-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (18, 141, '2020-09-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (13, 150, '2020-04-11');
insert into dbo.visitinghistory (room_id, custom_id, date) values (5, 89, '2021-08-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (23, 225, '2021-11-09');
insert into dbo.visitinghistory (room_id, custom_id, date) values (8, 109, '2021-12-02');
insert into dbo.visitinghistory (room_id, custom_id, date) values (80, 205, '2022-01-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (144, 113, '2020-08-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (145, 202, '2021-10-20');
insert into dbo.visitinghistory (room_id, custom_id, date) values (63, 243, '2020-03-16');
insert into dbo.visitinghistory (room_id, custom_id, date) values (42, 207, '2022-03-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (177, 109, '2021-03-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (241, 212, '2020-12-10');
insert into dbo.visitinghistory (room_id, custom_id, date) values (98, 148, '2022-01-23');
insert into dbo.visitinghistory (room_id, custom_id, date) values (138, 68, '2021-01-30');
insert into dbo.visitinghistory (room_id, custom_id, date) values (111, 59, '2020-01-05');
insert into dbo.visitinghistory (room_id, custom_id, date) values (217, 128, '2020-08-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (82, 139, '2021-03-19');
insert into dbo.visitinghistory (room_id, custom_id, date) values (98, 208, '2020-09-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (157, 228, '2022-01-04');
insert into dbo.visitinghistory (room_id, custom_id, date) values (168, 212, '2020-03-17');
insert into dbo.visitinghistory (room_id, custom_id, date) values (49, 125, '2021-06-15');
insert into dbo.visitinghistory (room_id, custom_id, date) values (46, 63, '2021-08-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (223, 86, '2022-02-21');
insert into dbo.visitinghistory (room_id, custom_id, date) values (23, 115, '2021-01-14');
insert into dbo.visitinghistory (room_id, custom_id, date) values (25, 220, '2021-07-27');
insert into dbo.visitinghistory (room_id, custom_id, date) values (17, 138, '2020-12-07');
insert into dbo.visitinghistory (room_id, custom_id, date) values (175, 83, '2021-06-12');
insert into dbo.visitinghistory (room_id, custom_id, date) values (191, 62, '2021-05-13');
insert into dbo.visitinghistory (room_id, custom_id, date) values (18, 246, '2020-11-28');
insert into dbo.visitinghistory (room_id, custom_id, date) values (119, 84, '2020-03-03');
insert into dbo.visitinghistory (room_id, custom_id, date) values (234, 110, '2020-02-25');
insert into dbo.visitinghistory (room_id, custom_id, date) values (118, 110, '2021-06-10');

	

/*
 * Step 15: insert data into Contract
 */
INSERT into dbo.Contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id)
values
	(1, 1, '2021-12-21', '2022-12-20', 1100, '1', 150, 1), --b1 
	(2, 2, '2021-12-21', '2022-12-20', 1100, '1', 150, 1),
	(3, 3, '2021-12-21', '2022-12-20', 1100, '1', 150, 1),
	(4, 4, '2021-12-21', '2022-12-20', 1100, '1', 150, 1),
	(9, 5, '2021-09-01', '2022-08-01', 1050, '1', 100, 1),
	(9, 6, '2021-09-01', '2022-08-01', 1050, '1', 100, 1),
	(10, 7, '2021-09-01', '2022-09-01', 1050, '1', 100, 1),
	(10, 8, '2021-09-01', '2022-09-01', 1050, '1', 100, 1),
	(13, 9, '2021-12-21', '2022-12-20', 1070, '1', 100, 1),
	(13, 10, '2021-12-21', '2022-12-20', 1070, '1', 100, 1),
	(13, 11, '2021-12-21', '2022-12-20', 1070, '1', 107, 1),
	(14, 12, '2021-12-21', '2022-12-20', 1070, '1', 107, 1),
	(14, 13, '2021-12-21', '2022-12-20', 1070, '1', 107, 1),
	(14, 14, '2021-12-21', '2022-12-20', 1070, '1', 100, 1),
	(17, 15, '2021-12-21', '2022-12-20', 1050, '1', 70, 1),
	(17, 16, '2021-12-21', '2022-12-20', 1050, '1', 70, 1),
	(17, 17, '2021-12-21', '2022-12-20', 1050, '1', 70, 1),
	(17, 18, '2021-12-21', '2022-12-20', 1050, '1', 70, 1),
	(18, 19, '2022-01-01', '2023-01-01', 1050, '1', 70, 1),
	(18, 20, '2022-01-01', '2023-01-01', 1050, '1', 70, 1),
	(18, 21, '2022-01-01', '2023-01-01', 1050, '1', 70, 1),
	(18, 22, '2022-01-01', '2023-01-01', 1050, '1', 70, 1),
	(21, 23, '2021-12-21', '2022-12-20', 1100, '1', 150, 1), --b2
	(22, 24, '2021-12-21', '2022-12-20', 1100, '1', 150, 1),
	(23, 25, '2021-12-21', '2022-12-20', 1100, '1', 150, 1),
	(24, 26, '2021-12-21', '2022-12-20', 1100, '1', 150, 1),
	(29, 27, '2021-09-01', '2022-08-01', 1050, '1', 100, 1),
	(29, 28, '2021-09-01', '2022-08-01', 1050, '1', 100, 1),
	(30, 29, '2021-09-01', '2022-09-01', 1050, '1', 100, 1),
	(30, 30, '2021-09-01', '2022-09-01', 1050, '1', 100, 1),
	(33, 31, '2021-12-21', '2022-12-20', 1070, '1', 100, 1),
	(33, 32, '2021-12-21', '2022-12-20', 1070, '1', 100, 1),
	(33, 33, '2021-12-21', '2022-12-20', 1070, '1', 100, 1),
	(34, 34, '2021-12-21', '2022-12-20', 1070, '1', 100, 1),
	(34, 35, '2021-12-21', '2022-12-20', 1070, '1', 100, 1),
	(34, 36, '2021-12-21', '2022-12-20', 1070, '1', 100, 1),
	(37, 37, '2021-12-21', '2022-12-20', 1050, '1', 70, 1),
	(37, 38, '2021-12-21', '2022-12-20', 1050, '1', 70, 1),
	(37, 39, '2021-12-21', '2022-12-20', 1050, '1', 70, 1),
	(37, 40, '2021-12-21', '2022-12-20', 1050, '1', 70, 1),
	(38, 41, '2022-01-01', '2023-01-01', 1050, '1', 70, 1),
	(38, 42, '2022-01-01', '2023-01-01', 1050, '1', 70, 1),
	(38, 43, '2022-01-01', '2023-01-01', 1050, '1', 70, 1),
	(38, 44, '2022-01-01', '2023-01-01', 1050, '1', 70, 1),
	(41, 46, '2021-12-20', '2022-12-20', 4300, '1', 200, 1), --b3 
	(42, 48, '2021-12-20', '2022-12-20', 4400, '1', 200, 1), --b4 
	(43, 50, '2021-12-20', '2022-12-20', 4500, '1', 200, 1), --b5 
	(44, 52, '2021-12-20', '2022-12-20', 4600, '1', 200, 1); --b6
	
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (57, 225, '2022-09-05', '2023-06-02', 5400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (174, 256, '2020-06-16', '2021-06-16', 4300, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (163, 203, '2022-12-05', '2023-12-05', 4200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (150, 182, '2023-05-19', '2023-11-15', 2500, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (158, 163, '2021-03-09', '2022-03-09', 3200, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (228, 194, '2021-04-09', '2021-07-08', 2900, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (134, 102, '2021-07-17', '2022-04-13', 6700, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (71, 157, '2021-10-24', '2022-04-22', 3300, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (46, 255, '2023-01-29', '2023-10-26', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (78, 124, '2021-09-25', '2022-06-22', 7800, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (103, 148, '2021-11-05', '2022-11-05', 3500, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (164, 92, '2023-07-30', '2024-04-25', 7600, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (212, 253, '2023-06-20', '2023-12-17', 5200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (176, 230, '2020-08-21', '2021-05-18', 5200, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (206, 77, '2022-02-17', '2023-02-17', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (7, 190, '2022-03-15', '2022-12-10', 1100, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (7, 77, '2020-12-06', '2021-09-02', 1100, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (149, 106, '2021-09-30', '2022-03-29', 6400, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (224, 140, '2022-03-03', '2023-03-03', 2600, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (139, 243, '2022-10-22', '2023-07-19', 5800, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (157, 59, '2023-01-25', '2023-10-22', 5900, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (117, 199, '2023-01-03', '2023-04-03', 2600, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (215, 186, '2020-10-26', '2021-10-26', 1900, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (77, 229, '2022-09-19', '2023-06-16', 2400, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (32, 70, '2020-12-06', '2021-12-06', 2200, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (241, 98, '2020-09-08', '2021-06-05', 3000, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (79, 151, '2022-04-21', '2022-10-18', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (168, 83, '2021-01-14', '2021-07-13', 3900, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (98, 215, '2020-07-12', '2021-01-08', 5200, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (27, 72, '2021-09-06', '2022-09-06', 1100, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (87, 196, '2020-09-06', '2021-03-05', 4700, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (61, 220, '2021-07-20', '2022-04-16', 6200, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (158, 188, '2023-08-20', '2024-02-16', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (204, 224, '2021-05-30', '2021-08-28', 5100, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (180, 93, '2021-03-10', '2022-03-10', 4600, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (120, 122, '2022-12-26', '2023-06-24', 4400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (73, 145, '2022-11-12', '2023-05-11', 6000, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (57, 173, '2021-03-11', '2021-09-07', 5400, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (217, 133, '2021-10-13', '2022-01-11', 4600, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (196, 151, '2021-07-28', '2021-10-26', 2900, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (199, 88, '2023-03-27', '2023-06-25', 4300, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (168, 190, '2022-11-05', '2023-11-05', 3900, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (186, 224, '2020-09-02', '2021-09-02', 2800, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (11, 89, '2021-03-05', '2021-11-30', 2100, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (26, 192, '2020-06-13', '2021-03-10', 1100, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (65, 73, '2021-11-20', '2022-02-18', 5900, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (76, 90, '2021-02-07', '2021-11-04', 4600, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (138, 107, '2020-11-22', '2021-05-21', 4900, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (55, 180, '2020-08-10', '2021-08-10', 2800, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (6, 189, '2021-11-01', '2022-07-29', 1100, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (40, 64, '2022-11-14', '2023-11-14', 4400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (83, 79, '2022-05-20', '2022-11-16', 2500, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (214, 118, '2023-07-08', '2023-10-06', 4800, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (25, 88, '2020-06-11', '2020-12-08', 1100, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (83, 183, '2020-09-25', '2021-09-25', 2500, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (161, 180, '2023-07-20', '2024-01-16', 5100, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (72, 151, '2021-02-24', '2021-08-23', 2700, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (11, 126, '2021-12-08', '2022-09-04', 2100, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (137, 253, '2022-01-14', '2022-10-11', 4500, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (123, 90, '2023-03-19', '2023-06-17', 5600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (195, 119, '2023-04-25', '2024-04-24', 2700, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (231, 217, '2021-05-30', '2021-08-28', 6400, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (64, 159, '2020-06-09', '2021-03-06', 2400, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (182, 108, '2023-08-19', '2024-02-15', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (8, 150, '2022-02-12', '2022-05-13', 1100, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (230, 139, '2022-02-16', '2022-08-15', 6600, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (133, 164, '2022-08-27', '2023-02-23', 2400, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (180, 259, '2021-10-17', '2022-01-15', 4600, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (80, 116, '2021-01-19', '2021-04-19', 7700, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (50, 89, '2020-09-01', '2021-09-01', 4900, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (122, 250, '2021-11-26', '2022-05-25', 3000, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (208, 204, '2021-07-23', '2022-01-19', 5400, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (189, 64, '2022-03-04', '2022-08-31', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (109, 235, '2021-07-18', '2022-04-14', 6400, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (226, 150, '2022-02-27', '2023-02-27', 3600, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (212, 247, '2021-05-30', '2021-08-28', 5200, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (62, 113, '2022-01-19', '2022-10-16', 5300, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (52, 214, '2022-06-14', '2023-06-14', 5900, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (194, 158, '2023-07-09', '2024-01-05', 3100, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (20, 69, '2021-10-28', '2022-10-28', 4200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (59, 170, '2023-01-20', '2023-04-20', 6000, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (189, 168, '2023-02-04', '2024-02-04', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (221, 250, '2021-12-20', '2022-03-20', 1600, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (87, 195, '2022-02-06', '2022-05-07', 4700, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (39, 254, '2020-11-29', '2021-02-27', 4400, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (228, 83, '2021-07-14', '2022-01-10', 2900, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (207, 158, '2021-02-03', '2021-10-31', 6300, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (3, 68, '2020-08-11', '2021-05-08', 1100, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (14, 204, '2021-11-13', '2022-02-11', 3200, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (122, 122, '2021-02-03', '2021-05-04', 3000, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (172, 64, '2022-10-13', '2023-01-11', 3700, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (137, 195, '2023-06-19', '2023-12-16', 4500, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (164, 98, '2022-04-16', '2023-04-16', 7600, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (86, 94, '2021-02-04', '2021-05-05', 4300, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (206, 107, '2021-05-28', '2022-05-28', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (104, 187, '2022-04-30', '2022-07-29', 2600, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (72, 106, '2021-10-12', '2022-04-10', 2700, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (1, 54, '2022-04-30', '2023-04-30', 1100, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (17, 130, '2023-02-06', '2023-08-05', 4200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (76, 241, '2022-07-10', '2023-04-06', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (56, 118, '2022-05-12', '2023-02-06', 2200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (236, 80, '2021-04-26', '2022-04-26', 1900, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (190, 109, '2020-12-21', '2021-03-21', 4400, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (38, 111, '2021-10-01', '2022-10-01', 4400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (130, 91, '2023-09-28', '2024-09-27', 5600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (190, 205, '2022-02-26', '2022-11-23', 4400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (130, 124, '2022-01-15', '2022-04-15', 5600, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (179, 259, '2021-08-15', '2021-11-13', 2800, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (69, 80, '2023-04-29', '2023-07-28', 5200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (19, 115, '2021-04-07', '2022-01-02', 4200, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (58, 144, '2021-11-03', '2022-11-03', 1800, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (148, 107, '2021-11-15', '2022-08-12', 6200, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (17, 59, '2021-06-15', '2021-09-13', 4200, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (55, 121, '2022-03-09', '2022-12-04', 2800, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (199, 193, '2020-11-26', '2021-05-25', 4300, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (221, 99, '2023-09-22', '2024-06-18', 1600, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (238, 195, '2021-06-20', '2022-03-17', 4900, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (18, 192, '2020-12-08', '2021-03-08', 4200, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (49, 65, '2021-10-28', '2022-07-25', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (97, 165, '2020-07-12', '2021-04-08', 2500, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (66, 161, '2022-03-06', '2022-06-04', 1500, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (234, 246, '2023-05-11', '2023-11-07', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (126, 258, '2020-08-10', '2021-08-10', 4500, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (77, 178, '2020-12-11', '2021-06-09', 2400, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (18, 154, '2021-06-20', '2022-03-17', 4200, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (178, 87, '2020-10-19', '2021-07-16', 5000, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (222, 224, '2021-02-06', '2021-08-05', 4800, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (2, 93, '2023-04-16', '2024-01-11', 1100, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (119, 212, '2023-02-18', '2023-11-15', 6600, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (92, 167, '2022-07-07', '2023-07-07', 3900, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (67, 241, '2021-10-21', '2022-01-19', 6400, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (221, 178, '2021-05-10', '2022-05-10', 1600, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (69, 174, '2023-05-11', '2023-08-09', 5200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (98, 173, '2022-03-23', '2023-03-23', 5200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (158, 72, '2023-04-24', '2023-10-21', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (87, 132, '2021-05-20', '2021-11-16', 4700, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (183, 115, '2023-04-14', '2024-04-13', 4100, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (97, 138, '2021-12-28', '2022-06-26', 2500, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (46, 127, '2022-07-08', '2023-01-04', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (200, 126, '2020-08-04', '2021-08-04', 7000, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (214, 244, '2023-06-03', '2024-06-02', 4800, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (31, 258, '2022-08-26', '2023-08-26', 2200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (51, 240, '2020-09-27', '2021-03-26', 5200, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (149, 132, '2021-08-17', '2022-05-14', 6400, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (38, 243, '2021-10-07', '2022-10-07', 4400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (205, 204, '2021-03-30', '2021-12-25', 7900, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (212, 88, '2023-09-18', '2023-12-17', 5200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (191, 53, '2021-12-12', '2022-09-08', 1900, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (200, 192, '2023-01-06', '2023-10-03', 7000, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (76, 181, '2020-11-07', '2021-02-05', 4600, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (190, 169, '2021-02-02', '2022-02-02', 4400, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (73, 54, '2021-10-03', '2022-01-01', 6000, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (76, 125, '2022-08-20', '2023-05-17', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (191, 246, '2022-05-29', '2023-05-29', 1900, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (113, 88, '2021-10-30', '2022-07-27', 5500, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (174, 53, '2023-05-11', '2024-05-10', 4300, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (243, 77, '2023-05-18', '2023-08-16', 5200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (106, 230, '2021-11-14', '2022-08-11', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (43, 89, '2022-06-26', '2023-03-23', 4500, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (107, 186, '2020-07-10', '2021-04-06', 6300, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (143, 145, '2023-09-15', '2024-03-13', 4800, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (153, 137, '2023-02-03', '2024-02-03', 3700, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (122, 245, '2020-06-10', '2020-12-07', 3000, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (69, 72, '2023-03-28', '2024-03-27', 5200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (238, 217, '2023-09-29', '2024-09-28', 4900, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (156, 190, '2020-12-28', '2021-09-24', 2800, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (175, 137, '2023-01-14', '2023-04-14', 4400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (164, 102, '2021-04-23', '2022-04-23', 7600, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (142, 160, '2023-04-15', '2024-01-10', 6900, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (13, 195, '2023-08-01', '2024-04-27', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (112, 135, '2021-08-14', '2022-08-14', 2100, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (131, 115, '2022-07-23', '2022-10-21', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (212, 232, '2021-06-11', '2021-12-08', 5200, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (242, 87, '2022-04-05', '2022-07-04', 5600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (183, 163, '2021-06-01', '2021-11-28', 4100, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (107, 172, '2023-03-10', '2023-12-05', 6300, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (25, 90, '2022-05-02', '2023-05-02', 1100, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (133, 132, '2022-12-26', '2023-06-24', 2400, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (41, 104, '2022-05-11', '2023-02-05', 4300, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (16, 146, '2021-04-02', '2021-12-28', 3200, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (151, 159, '2022-07-15', '2023-01-11', 2600, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (234, 149, '2022-03-14', '2022-06-12', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (206, 189, '2020-07-10', '2021-01-06', 4600, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (135, 102, '2023-01-24', '2024-01-24', 2600, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (239, 84, '2020-10-04', '2021-10-04', 4000, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (101, 207, '2021-10-09', '2022-07-06', 7400, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (112, 181, '2020-06-09', '2020-09-07', 2100, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (137, 139, '2023-04-25', '2024-01-20', 4500, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (122, 114, '2022-05-29', '2022-11-25', 3000, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (162, 171, '2021-06-22', '2022-06-22', 4900, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (210, 153, '2022-04-05', '2022-12-31', 4200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (70, 207, '2020-08-12', '2020-11-10', 3100, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (237, 83, '2021-09-28', '2022-06-25', 4700, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (227, 68, '2023-03-03', '2023-06-01', 5600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (136, 78, '2021-07-17', '2022-07-17', 2900, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (43, 129, '2023-05-16', '2023-11-12', 4500, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (238, 241, '2020-09-07', '2021-06-04', 4900, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (158, 230, '2023-04-25', '2023-07-24', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (225, 167, '2020-08-28', '2021-08-28', 1800, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (228, 168, '2023-06-09', '2023-09-07', 2900, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (207, 81, '2020-09-24', '2020-12-23', 6300, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (52, 107, '2021-08-03', '2021-11-01', 5900, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (180, 177, '2021-06-13', '2021-09-11', 4600, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (35, 100, '2023-09-24', '2024-09-23', 3300, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (106, 213, '2021-01-20', '2021-04-20', 3200, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (192, 80, '2021-11-23', '2022-02-21', 4800, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (130, 104, '2020-06-15', '2020-12-12', 5600, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (19, 83, '2020-06-03', '2021-02-28', 4200, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (131, 63, '2022-07-05', '2022-10-03', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (140, 167, '2020-09-10', '2021-06-07', 7100, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (136, 142, '2021-02-09', '2022-02-09', 2900, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (159, 210, '2021-10-01', '2021-12-30', 4100, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (70, 72, '2021-03-27', '2022-03-27', 3100, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (184, 110, '2021-09-27', '2022-03-26', 2700, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (230, 240, '2022-09-18', '2023-03-17', 6600, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (191, 157, '2020-06-20', '2021-06-20', 1900, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (157, 73, '2023-06-04', '2023-12-01', 5900, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (114, 89, '2022-06-15', '2022-09-13', 3800, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (105, 66, '2020-10-18', '2021-04-16', 2900, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (126, 116, '2021-09-23', '2022-03-22', 4500, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (52, 149, '2020-10-12', '2021-04-10', 5900, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (219, 239, '2020-07-20', '2021-07-20', 6200, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (53, 58, '2020-06-02', '2021-02-27', 4900, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (208, 258, '2023-07-23', '2024-07-22', 5400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (115, 214, '2022-04-26', '2022-10-23', 2700, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (200, 219, '2023-06-27', '2024-06-26', 7000, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (57, 111, '2021-02-16', '2021-05-17', 5400, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (105, 188, '2023-09-18', '2023-12-17', 2900, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (157, 138, '2020-07-20', '2020-10-18', 5900, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (62, 64, '2022-06-15', '2022-12-12', 5300, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (53, 173, '2022-07-07', '2022-10-05', 4900, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (30, 113, '2021-01-19', '2022-01-19', 2200, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (38, 253, '2022-11-19', '2023-02-17', 4400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (148, 134, '2022-06-22', '2023-06-22', 6200, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (125, 198, '2022-05-13', '2022-08-11', 1800, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (75, 99, '2022-06-10', '2023-03-07', 2800, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (223, 143, '2023-02-09', '2023-11-06', 4100, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (175, 111, '2023-03-04', '2024-03-03', 4400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (133, 66, '2022-06-11', '2023-06-11', 2400, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (239, 149, '2022-02-27', '2022-11-24', 4000, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (215, 151, '2022-07-02', '2023-03-29', 1900, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (131, 221, '2021-01-20', '2021-07-19', 3200, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (72, 139, '2021-07-12', '2022-07-12', 2700, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (180, 101, '2023-07-26', '2024-01-22', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (9, 171, '2021-02-24', '2021-05-25', 2100, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (135, 201, '2023-09-25', '2023-12-24', 2600, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (199, 205, '2020-06-17', '2021-06-17', 4300, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (242, 261, '2020-12-07', '2021-12-07', 5600, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (107, 224, '2022-10-03', '2023-01-01', 6300, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (170, 133, '2023-08-08', '2024-08-07', 4300, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (167, 149, '2021-03-02', '2021-05-31', 4400, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (144, 180, '2023-06-12', '2024-03-08', 3100, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (200, 112, '2023-04-27', '2023-07-26', 7000, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (217, 118, '2022-03-17', '2022-12-12', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (160, 131, '2023-03-30', '2023-09-26', 6000, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (129, 217, '2022-02-22', '2022-11-19', 4000, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (203, 130, '2023-06-24', '2024-06-23', 5600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (208, 183, '2023-09-02', '2024-02-29', 5400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (91, 151, '2023-09-02', '2024-05-29', 5100, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (102, 121, '2020-06-16', '2020-12-13', 3400, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (242, 99, '2022-03-21', '2023-03-21', 5600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (106, 176, '2022-09-27', '2022-12-26', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (77, 207, '2022-04-10', '2023-04-10', 2400, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (100, 144, '2023-06-14', '2023-09-12', 6300, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (4, 76, '2020-06-26', '2020-09-24', 1100, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (7, 59, '2021-08-02', '2022-01-29', 1100, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (133, 105, '2023-01-15', '2023-04-15', 2400, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (70, 178, '2021-03-15', '2021-09-11', 3100, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (151, 161, '2022-03-21', '2023-03-21', 2600, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (83, 60, '2020-10-03', '2021-10-03', 2500, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (19, 160, '2022-01-12', '2022-07-11', 4200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (145, 129, '2023-01-07', '2023-04-07', 3000, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (236, 64, '2020-06-12', '2021-03-09', 1900, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (210, 68, '2022-12-18', '2023-09-14', 4200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (214, 217, '2021-02-09', '2021-08-08', 4800, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (18, 60, '2023-08-31', '2024-02-27', 4200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (74, 63, '2021-06-17', '2021-12-14', 3800, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (232, 109, '2021-04-09', '2021-10-06', 2800, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (197, 243, '2021-08-21', '2022-05-18', 2400, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (167, 241, '2023-08-24', '2024-02-20', 4400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (155, 196, '2022-01-22', '2022-10-19', 2100, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (132, 152, '2022-07-02', '2022-12-29', 4000, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (202, 171, '2022-01-01', '2022-09-28', 3000, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (193, 202, '2023-03-07', '2023-12-02', 6600, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (189, 62, '2021-10-10', '2022-07-07', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (142, 108, '2021-05-21', '2021-08-19', 6900, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (170, 226, '2022-02-17', '2022-08-16', 4300, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (72, 121, '2021-12-06', '2022-09-02', 2700, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (64, 198, '2021-09-17', '2022-06-14', 2400, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (228, 226, '2021-08-30', '2021-11-28', 2900, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (17, 93, '2023-02-17', '2024-02-17', 4200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (138, 152, '2020-10-23', '2021-04-21', 4900, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (147, 236, '2022-07-23', '2023-04-19', 4400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (96, 93, '2020-11-07', '2021-05-06', 6600, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (79, 98, '2023-05-26', '2023-11-22', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (119, 104, '2021-08-25', '2022-08-25', 6600, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (202, 184, '2020-07-11', '2021-04-07', 3000, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (80, 165, '2021-12-22', '2022-09-18', 7700, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (206, 223, '2021-05-16', '2022-05-16', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (209, 174, '2021-11-21', '2022-11-21', 7300, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (221, 156, '2022-01-30', '2022-04-30', 1600, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (148, 205, '2023-05-22', '2023-11-18', 6200, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (193, 138, '2022-06-02', '2023-02-27', 6600, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (9, 216, '2021-12-05', '2022-09-01', 2100, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (221, 199, '2023-01-14', '2023-07-13', 1600, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (93, 161, '2022-12-27', '2023-03-27', 1600, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (30, 229, '2022-09-02', '2023-09-02', 2200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (108, 80, '2023-06-28', '2024-06-27', 5000, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (13, 137, '2023-05-05', '2024-01-30', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (55, 244, '2022-01-31', '2022-10-28', 2800, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (195, 226, '2021-07-28', '2022-04-24', 2700, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (184, 198, '2022-04-11', '2023-01-06', 2700, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (134, 153, '2021-05-12', '2022-02-06', 6700, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (191, 175, '2022-11-19', '2023-08-16', 1900, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (109, 94, '2021-06-13', '2021-12-10', 6400, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (224, 221, '2023-07-25', '2024-01-21', 2600, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (42, 244, '2021-02-27', '2021-11-24', 4400, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (38, 260, '2022-01-12', '2022-04-12', 4400, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (98, 189, '2023-09-05', '2024-06-01', 5200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (88, 240, '2021-01-28', '2021-07-27', 5000, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (130, 223, '2023-03-05', '2023-09-01', 5600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (169, 106, '2023-03-06', '2023-12-01', 3400, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (205, 104, '2023-04-04', '2023-10-01', 7900, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (205, 139, '2022-03-16', '2022-09-12', 7900, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (160, 222, '2021-01-28', '2021-04-28', 6000, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (135, 152, '2020-11-24', '2021-11-24', 2600, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (75, 114, '2021-04-05', '2021-07-04', 2800, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (190, 102, '2022-02-22', '2022-05-23', 4400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (217, 235, '2021-11-19', '2022-05-18', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (16, 221, '2021-12-05', '2022-12-05', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (125, 64, '2021-10-12', '2022-04-10', 1800, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (236, 108, '2020-08-28', '2021-05-25', 1900, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (107, 83, '2020-09-06', '2020-12-05', 6300, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (186, 89, '2022-04-03', '2023-04-03', 2800, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (1, 192, '2023-07-14', '2024-04-09', 1100, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (16, 80, '2022-12-20', '2023-09-16', 3200, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (180, 141, '2023-02-09', '2024-02-09', 4600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (207, 159, '2020-11-21', '2021-08-18', 6300, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (33, 252, '2023-07-08', '2024-04-03', 3300, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (37, 83, '2020-11-21', '2021-02-19', 4400, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (187, 122, '2022-04-08', '2022-07-07', 3300, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (242, 195, '2021-07-11', '2022-01-07', 5600, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (187, 236, '2022-05-19', '2022-08-17', 3300, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (203, 168, '2021-10-17', '2022-01-15', 5600, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (113, 115, '2021-03-19', '2021-12-14', 5500, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (164, 239, '2023-07-01', '2023-12-28', 7600, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (177, 163, '2020-07-24', '2021-04-20', 3000, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (80, 118, '2022-06-10', '2023-03-07', 7700, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (23, 225, '2022-08-06', '2022-11-04', 1100, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (100, 161, '2021-08-22', '2022-08-22', 6300, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (188, 132, '2020-07-13', '2020-10-11', 5000, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (104, 62, '2022-04-06', '2022-07-05', 2600, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (200, 107, '2022-07-23', '2023-07-23', 7000, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (117, 168, '2020-09-30', '2021-09-30', 2600, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (181, 116, '2023-06-17', '2023-09-15', 4300, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (162, 135, '2023-09-17', '2024-06-13', 4900, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (173, 235, '2022-12-03', '2023-12-03', 3700, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (60, 219, '2022-08-22', '2022-11-20', 2100, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (165, 162, '2022-12-20', '2023-12-20', 2000, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (227, 145, '2021-12-17', '2022-06-15', 5600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (215, 65, '2023-01-31', '2023-10-28', 1900, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (103, 176, '2020-12-07', '2021-12-07', 3500, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (74, 67, '2023-04-19', '2024-01-14', 3800, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (203, 117, '2022-05-06', '2022-11-02', 5600, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (142, 154, '2023-01-16', '2023-04-16', 6900, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (11, 210, '2022-06-04', '2022-12-01', 2100, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (79, 188, '2021-01-18', '2022-01-18', 4600, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (207, 132, '2021-05-06', '2021-11-02', 6300, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (174, 112, '2022-09-22', '2022-12-21', 4300, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (48, 62, '2021-04-04', '2021-12-30', 3400, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (62, 181, '2023-04-17', '2024-01-12', 5300, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (231, 67, '2021-04-05', '2021-07-04', 6400, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (139, 61, '2020-12-05', '2021-03-05', 5800, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (177, 154, '2022-10-23', '2023-04-21', 3000, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (235, 87, '2020-10-04', '2021-10-04', 5500, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (74, 218, '2022-05-30', '2022-11-26', 3800, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (117, 198, '2021-01-12', '2021-07-11', 2600, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (126, 192, '2023-03-16', '2023-12-11', 4500, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (215, 145, '2021-12-08', '2022-09-04', 1900, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (221, 165, '2022-12-22', '2023-09-18', 1600, 1, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (226, 144, '2022-02-11', '2022-05-12', 3600, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (187, 240, '2022-03-31', '2022-09-27', 3300, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (132, 233, '2022-03-08', '2023-03-08', 4000, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (7, 149, '2020-09-15', '2021-06-12', 1100, 0, 200, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (47, 237, '2021-05-22', '2021-08-20', 6900, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (207, 180, '2020-06-15', '2021-03-12', 6300, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (20, 217, '2020-07-27', '2020-10-25', 4200, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (47, 165, '2022-01-10', '2022-10-07', 6900, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (196, 244, '2020-09-15', '2021-03-14', 2900, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (120, 131, '2023-02-06', '2023-08-05', 4400, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (69, 198, '2022-03-22', '2022-09-18', 5200, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (152, 97, '2022-01-08', '2022-10-05', 6400, 1, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (233, 157, '2022-04-07', '2022-07-06', 5300, 1, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (110, 255, '2021-02-13', '2021-11-10', 7400, 0, 600, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (178, 202, '2021-07-03', '2022-03-30', 5000, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (77, 237, '2023-06-02', '2024-02-27', 2400, 1, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (136, 83, '2021-07-14', '2022-04-10', 2900, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (106, 109, '2021-08-16', '2022-02-12', 3200, 0, 300, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (240, 170, '2021-05-02', '2021-10-29', 5800, 0, 400, 1);
insert into dbo.contract (room_id, customer_id, start_date, end_date, rent, validity, service_fee, type_id) values (13, 73, '2021-06-01', '2022-02-26', 3200, 0, 300, 1);

	


/*
 * Step 16: insert data into FunctionType 
 */
INSERT INTO dbo.FunctionType([type], description)
VALUES
 ('appliance repair', 'tenant pay the material'),
 ('security', 'tenant pay for emergency call'),
 ('plumbing', 'tenant pay the material'),
 ('cleaning', 'office pay for floor cleaning'),
 ('pest control', 'according to area'),
 ('roof repair', null),
 ('electrical', null),
 ('water', null),
 ('alarm repair', 'management pay for battery'),
 ('heating repair', 'check or repair heating');




/*
 * Step 17: insert data into ServiceCompanies 
 */ 
INSERT INTO dbo.ServiceCompanies(name, function_id)
VALUES
 ('AAA Repair Company', 1),
 ('Super Security Company', 2),
 ('Plumbing Plumbing Org.', 3),
 ('Clean Master Company', 4),
 ('Pest Away Org.', 5),
 ('Roof Helper', 6),
 ('ELECT Company', 7),
 ('City Water Company', 8),
 ('Alarming Company', 9),
 ('Heating Company', 10);



/*
 * Step 18: insert data into MaintenanceHistory 
 */
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Replacement of pipes', '2021-05-16', null, 156, 10, 112);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2021-04-10', null, 184, 8, 6);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Repairing toilet', '2021-05-07', null, 161, 9, 110);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2020-06-12', null, 105, 10, 231);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2021-12-16', '2021-12-20', 170, 7, 77);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2020-06-26', null, 116, 10, 44);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2020-06-30', null, 43, 3, 62);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Unclogging pipes', '2021-04-23', null, 76, 7, 21);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Kitchen maintenance', '2020-08-08', null, 94, 6, 10);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity inspection', '2020-12-25', null, 177, 6, 145);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2021-09-21', '2021-10-01', 286, 9, 191);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2021-04-30', null, 101, 4, 26);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Kitchen cleaning', '2021-02-18', null, 424, 8, 29);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Kitchen cleaning', '2020-09-25', '2020-10-02', 206, 4, 45);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2022-01-24', '2022-01-31', 139, 8, 52);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Repairing closet', '2022-03-01', '2022-03-03', 358, 6, 233);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2020-12-12', '2020-12-20', 64, 7, 197);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2020-11-20', null, 232, 9, 131);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2020-07-25', null, 364, 6, 3);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2020-06-16', null, 104, 4, 69);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2020-07-25', null, 53, 8, 75);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2021-11-02', '2021-11-10', 100, 4, 141);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2021-05-03', null, 357, 10, 234);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2021-07-07', '2021-07-07', 44, 3, 217);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2021-01-03', null, 291, 6, 168);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2021-04-16', '2021-04-17', 200, 6, 18);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2021-11-08', '2021-11-11', 150, 7, 89);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Repairing closet', '2022-01-04', null, 362, 6, 191);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2020-07-31', null, 100, 10, 218);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2020-10-15', '2020-10-20', 50, 5, 228);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Repairing toilet', '2021-03-30', null, 418, 10, 122);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-01-19', null, 167, 9, 122);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity inspection', '2020-11-28', '2020-12-01', 353, 4, 185);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2021-05-27', null, 360, 7, 228);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2021-09-19', '2021-09-28', 69, 7, 188);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2020-12-26', null, 50, 9, 156);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity repair', '2021-04-09', null, 115, 10, 89);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2020-10-01', null, 178, 7, 55);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2021-05-12', '2021-05-21', 50, 4, 213);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Replacement of pipes', '2020-07-04', null, 315, 4, 72);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Yard cleaning', '2021-07-04', '2021-07-10', 265, 1, 48);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity inspection', '2021-03-08', null, 276, 8, 42);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2020-08-19', null, 271, 9, 108);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2021-02-16', '2021-02-25', 235, 5, 17);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2021-08-21', '2021-08-23', 100, 9, 36);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2021-02-03', null, 150, 10, 124);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Unclogging pipes', '2021-01-04', null, 281, 7, 47);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2020-08-19', '2020-08-28', 294, 4, 185);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Kitchen maintenance', '2021-02-19', null, 433, 8, 118);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2020-08-11', null, 260, 4, 27);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2022-01-15', '2022-01-17', 97, 3, 192);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2020-12-03', '2020-12-08', 225, 10, 8);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Replacement of pipes', '2021-09-22', '2021-09-23', 170, 7, 29);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2022-03-23', '2022-03-29', 42, 3, 88);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Yard cleaning', '2021-11-28', '2021-11-30', 803, 8, 233);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Repairing closet', '2021-11-27', '2021-11-29', 217, 10, 203);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2021-04-12', '2021-04-22', 357, 6, 89);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2022-01-11', '2022-01-21', 31, 3, 143);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-02-07', null, 70, 10, 202);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Yard cleaning', '2021-10-29', '2021-11-01', 551, 8, 231);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2022-01-13', '2022-01-13', 100, 8, 194);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Yard cleaning', '2022-03-06', '2022-03-08', 324, 8, 119);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2020-08-30', null, 100, 9, 24);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Repairing doors', '2020-06-03', null, 396, 5, 196);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2021-05-25', '2021-05-28', 141, 7, 222);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2021-02-11', null, 42, 4, 31);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Kitchen cleaning', '2022-03-11', '2022-03-11', 190, 6, 191);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2021-06-16', null, 200, 6, 35);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2021-08-29', '2021-09-01', 176, 9, 65);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2021-11-25', '2021-12-02', 62, 6, 182);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Kitchen cleaning', '2020-11-15', '2020-11-19', 658, 8, 155);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Kitchen maintenance', '2022-01-27', null, 391, 5, 21);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Kitchen cleaning', '2021-05-07', null, 797, 5, 65);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Kitchen maintenance', '2020-12-05', '2020-12-14', 141, 7, 191);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2020-07-13', null, 277, 8, 227);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2021-03-12', '2021-03-13', 200, 7, 2);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2021-01-03', null, 97, 6, 110);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-07-06', '2021-07-07', 114, 7, 133);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2021-12-07', '2021-12-10', 106, 4, 184);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2021-07-22', null, 200, 10, 191);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Interior Maintenance', '2021-08-19', null, 425, 10, 219);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Clean the whole house', '2020-09-24', null, 308, 2, 214);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity repair', '2020-08-13', null, 82, 10, 17);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Replacement of pipes', '2021-06-04', '2021-06-05', 131, 8, 120);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2021-09-02', '2021-09-07', 50, 9, 25);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2020-10-06', null, 45, 5, 171);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Interior Maintenance', '2021-02-17', null, 143, 7, 46);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Bathroom cleaning', '2021-01-27', null, 995, 1, 14);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2020-12-17', null, 365, 5, 198);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2020-09-09', null, 150, 7, 103);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2020-06-01', null, 50, 7, 133);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Unclogging pipes', '2021-12-18', '2021-12-28', 253, 8, 66);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2022-02-09', '2022-02-18', 93, 9, 173);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2021-10-01', null, 150, 10, 1);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity inspection', '2021-01-28', null, 140, 4, 35);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2021-10-04', '2021-10-06', 297, 4, 114);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2022-02-21', '2022-02-26', 73, 8, 92);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2021-01-13', '2021-01-22', 141, 5, 75);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2020-10-14', null, 62, 7, 115);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2021-05-27', null, 187, 9, 65);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2022-04-13', '2022-04-18', 50, 9, 229);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2020-06-21', null, 66, 7, 226);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Clean the whole house', '2020-06-11', null, 516, 3, 62);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2020-08-14', '2020-08-20', 43, 9, 137);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2021-05-19', null, 188, 10, 196);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2021-06-28', null, 172, 6, 48);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2021-04-29', '2021-05-07', 108, 9, 59);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2020-11-29', null, 62, 7, 21);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2021-02-18', null, 130, 8, 156);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2021-05-17', null, 177, 9, 141);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2020-06-27', null, 157, 9, 95);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2020-11-14', null, 65, 8, 229);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2021-07-01', '2021-07-10', 92, 8, 5);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-01-13', '2021-01-17', 70, 6, 137);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Yard cleaning', '2020-08-21', null, 809, 8, 244);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2020-06-19', null, 100, 4, 36);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2022-01-28', '2022-01-29', 188, 9, 233);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2021-03-06', null, 175, 4, 128);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2020-06-14', null, 69, 5, 21);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2021-05-01', '2021-05-06', 253, 6, 98);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Unclogging pipes', '2022-01-11', '2022-01-14', 390, 4, 103);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Kitchen maintenance', '2020-12-14', '2020-12-16', 32, 4, 155);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2020-08-01', null, 180, 7, 15);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity inspection', '2021-05-27', null, 318, 4, 127);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-04-10', null, 78, 10, 112);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2020-09-24', null, 115, 8, 95);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2020-11-29', null, 156, 5, 147);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2020-06-10', null, 106, 8, 198);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Unclogging pipes', '2020-09-20', null, 129, 8, 80);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2021-03-19', null, 291, 6, 35);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Repairing toilet', '2021-06-13', null, 455, 4, 137);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-11-02', '2021-11-05', 179, 8, 87);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2021-07-06', '2021-07-12', 49, 8, 237);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Replacement of pipes', '2021-09-20', '2021-09-25', 147, 6, 59);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2020-08-21', null, 50, 10, 183);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2020-12-31', '2021-01-03', 124, 7, 71);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Unclogging pipes', '2020-06-12', null, 181, 5, 33);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2020-06-13', null, 105, 10, 224);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity inspection', '2021-07-28', '2021-08-04', 355, 7, 74);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2021-09-24', '2021-09-24', 307, 9, 150);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Yard cleaning', '2021-11-28', '2021-11-30', 787, 4, 61);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Interior Maintenance', '2020-08-14', null, 453, 8, 43);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2020-07-17', null, 75, 5, 4);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Bathroom cleaning', '2020-07-23', null, 794, 4, 160);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2022-01-01', '2022-01-09', 113, 6, 47);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Kitchen maintenance', '2022-03-17', '2022-03-22', 380, 6, 128);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2021-05-27', null, 179, 6, 205);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2021-03-01', '2021-03-03', 122, 7, 205);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2022-02-17', null, 144, 4, 122);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2022-02-13', '2022-02-19', 350, 8, 88);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2020-12-14', '2020-12-16', 101, 7, 51);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-01-08', '2021-01-14', 193, 9, 236);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2021-08-08', '2021-08-13', 288, 9, 99);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2021-09-04', '2021-09-05', 58, 6, 128);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2021-11-28', null, 56, 8, 152);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-11-16', null, 90, 7, 32);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Kitchen maintenance', '2022-01-03', '2022-01-11', 198, 9, 52);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Repairing toilet', '2020-11-15', '2020-11-15', 420, 9, 21);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Unclogging pipes', '2021-05-18', null, 161, 7, 212);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Yard cleaning', '2021-06-06', '2021-06-12', 670, 6, 54);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Clean the whole house', '2020-09-12', null, 751, 1, 91);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2020-10-27', null, 100, 7, 231);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2020-07-23', null, 138, 10, 204);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity inspection', '2021-07-28', null, 78, 10, 182);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-09-09', '2021-09-17', 131, 10, 128);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity repair', '2021-09-25', null, 257, 10, 162);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity repair', '2021-06-21', '2021-06-23', 261, 6, 157);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity repair', '2021-03-19', '2021-03-21', 177, 8, 199);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2022-03-11', '2022-03-14', 130, 4, 97);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Unclogging pipes', '2020-08-13', null, 280, 7, 208);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Kitchen maintenance', '2020-12-26', '2020-12-30', 152, 10, 128);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Clean the whole house', '2021-07-29', '2021-07-30', 669, 5, 166);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity repair', '2021-11-04', '2021-11-09', 267, 6, 25);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2022-03-14', '2022-03-15', 155, 7, 114);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-03-23', '2021-03-26', 126, 7, 182);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (5, 'Pest killing', '2020-07-16', null, 197, 8, 140);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2020-07-04', null, 200, 8, 30);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-11-28', null, 72, 4, 204);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-10-09', null, 86, 10, 244);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2021-05-04', null, 150, 10, 107);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Repairing doors', '2021-08-10', null, 256, 4, 85);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-07-20', null, 170, 7, 244);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2020-06-17', null, 63, 8, 114);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2020-07-25', null, 160, 8, 195);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Repairing doors', '2020-09-12', null, 111, 9, 165);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-04-26', null, 186, 6, 124);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2020-11-09', null, 211, 10, 150);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Clean the whole house', '2020-12-23', '2020-12-27', 512, 3, 142);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2020-06-10', null, 50, 6, 218);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2020-12-05', null, 222, 5, 83);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2021-09-15', null, 103, 7, 234);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Yard cleaning', '2022-02-16', null, 672, 6, 37);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Repairing toilet', '2021-08-25', '2021-08-31', 102, 8, 12);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-03-15', '2021-03-18', 173, 7, 169);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Clean the whole house', '2020-06-10', null, 444, 2, 156);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2021-01-24', null, 160, 9, 41);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Interior Maintenance', '2020-08-04', null, 104, 8, 109);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2021-10-04', null, 189, 6, 72);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2020-11-17', null, 189, 8, 128);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Unclogging pipes', '2021-04-26', null, 373, 4, 152);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Clean the whole house', '2020-07-19', null, 180, 2, 32);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2022-03-14', '2022-03-23', 54, 3, 183);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2021-05-23', null, 205, 4, 64);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Kitchen cleaning', '2022-03-09', '2022-03-09', 136, 2, 128);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Electricity repair', '2021-01-20', null, 129, 5, 15);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (8, 'Water check', '2020-06-26', null, 198, 9, 90);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Repairing closet', '2021-02-08', null, 376, 7, 221);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2020-06-27', null, 146, 9, 6);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2021-03-07', null, 67, 10, 176);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Kitchen cleaning', '2020-10-09', null, 574, 6, 236);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (9, 'Alarm battery change', '2021-05-20', null, 200, 6, 3);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2021-06-14', '2021-06-21', 93, 4, 115);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (6, 'Repair the roof', '2021-01-19', null, 289, 5, 166);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (4, 'Kitchen cleaning', '2021-02-06', '2021-02-16', 103, 8, 224);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (3, 'Plumbing Repair', '2021-04-18', '2021-04-22', 284, 7, 224);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (1, 'Interior Maintenance', '2020-07-29', null, 316, 4, 37);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (2, 'security call', '2021-04-03', null, 70, 6, 205);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (7, 'Network repair', '2021-04-07', '2021-04-11', 247, 5, 59);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-04-19', '2021-04-27', 244, 9, 239);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2020-07-16', null, 171, 5, 141);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-03-15', null, 348, 4, 134);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-02-17', null, 274, 5, 236);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2022-01-17', '2022-01-22', 234, 10, 193);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-07-07', null, 258, 9, 153);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-06-25', null, 217, 4, 177);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-04-25', null, 100, 9, 189);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-02-13', '2021-02-22', 375, 9, 134);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2020-06-15', null, 129, 6, 187);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-10-13', '2021-10-17', 356, 6, 228);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-06-16', '2021-06-17', 83, 10, 168);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-11-04', '2021-11-09', 239, 9, 224);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-10-29', '2021-11-04', 167, 5, 50);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2022-01-13', '2022-01-20', 280, 10, 103);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-07-26', null, 135, 7, 207);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2020-12-02', '2020-12-02', 380, 4, 183);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2022-02-10', null, 134, 9, 14);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2020-11-17', '2020-11-23', 345, 10, 51);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-11-20', '2021-11-30', 223, 7, 114);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-08-17', null, 310, 4, 96);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-05-17', null, 252, 9, 5);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2022-01-25', '2022-01-29', 355, 7, 51);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2022-02-07', '2022-02-17', 380, 4, 204);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-02-20', '2021-02-26', 121, 9, 41);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2022-01-14', '2022-01-20', 226, 10, 212);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-10-07', '2021-10-13', 260, 5, 70);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2020-11-15', '2020-11-24', 207, 6, 32);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2021-04-17', null, 344, 6, 9);
insert into MaintenanceHistory (service_company_id, maintaining_detail, start_date, end_date, fee, score, room_id) values (10, 'Heating rapair', '2020-09-11', null, 220, 4, 111);



/*
*  The 4th part is used to add the views.
*/


-- dbo.applicationDistribution source
CREATE VIEW applicationDistribution
AS
SELECT a.room_id,
	   a2.city,
	   f.id as [Room_Type],
	   f.bedroom_count,
	   f.bathroom_count,
	   a.customer_id,
	   p.gender,
	   p.Age,
	   a.occupation, 
	   a.income_monthly
from Application a 
join Room r on r.id = a.room_id 
join Floorplan f on f.id = r.floorplan_id 
join Building b on b.id = r.building_id 
join Address a2 on a2.address_id = b.address_id
join Customer c on c.id = a.customer_id 
join PersonalInformation p on p.id = c.info_id;


-- dbo.application_vs_visit source
CREATE VIEW application_vs_visit
AS
select t2.*,t3.num_of_visits
from 
(select room_id,Room_Type,sum(app_id_not_null) as [num_of_applications]
from
(select r.id as [room_id],
	   CONCAT(f.bedroom_count,'B',bathroom_count,'B') as [Room_Type],
	   a.id as [application_id],
	   case
		   when a.id is null then 0
		   else 1 end as [app_id_not_null]
from Room r
left join Application a on a.room_id = r.id
left join Floorplan f on f.id = r.floorplan_id) as temp
group by temp.room_id,temp.Room_Type) as t2

join

(select room_id,sum(visit_id_not_null) as [num_of_visits]
from
(select r.id as [room_id],
	   v.id as [visit_id],
	   case
		   when v.id is null then 0
		   else 1 end as [visit_id_not_null]
from Room r 
left join VisitingHistory v on v.room_id = r.id ) as temp
group by temp.room_id) as t3 on t3.room_id = t2.room_id;


-- dbo.mostPopFloorPlan source
create view mostPopFloorPlan
as
SELECT r.floorplan_id, FORMAT(r.rent, 'c') as 'rent', f.bedroom_count, f.bathroom_count, count(r.floorplan_id) 'total_visit',
		rank() over(order by count(r.floorplan_id)DESC) as 'popular rank'
from dbo.VisitingHistory vh 
join dbo.Room r 
on vh.room_id = r.id 
join dbo.Floorplan f 
on r.floorplan_id = f.id
group by r.floorplan_id, r.rent, f.bedroom_count, f.bathroom_count;


-- dbo.performanceEvaluation source
create view performanceEvaluation
as
SELECT year(c.start_date) as [year],
	   c.id as [contract_id],
	   r.id as [room_id],
	   c.rent,
	   b.group_id as [group_id],
	   g.[size] as [group_size]
FROM Contract c
join Room r on r.id = c.room_id
join Building b on b.id = r.building_id
join [Group] g on g.id = b.group_id;


-- dbo.roomDistribution source
CREATE VIEW roomDistribution
AS
SELECT r.id as [room_id],r.building_id,a.address_id,a.city,a.state 
from Room r 
left join Building b on b.id = r.building_id
left join Address a on a.address_id =b.address_id 
where r.avaliable = 1;


-- dbo.serviceCompanyCompare source
CREATE VIEW serviceCompanyCompare
AS
SELECT sc.name as [service_company_name],ft.[type] as [service_type],count(sc.id) as [times_of_service],average_fee,evaluation
FROM ServiceCompanies sc
join FunctionType ft ON ft.id = sc.function_id
join MaintenanceHistory mh ON mh.service_company_id = sc.id
group by sc.name,ft.[type],average_fee,evaluation;






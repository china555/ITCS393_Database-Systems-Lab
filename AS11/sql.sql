/***************************************************************
 * ITCS393 Database Systems Lab (Year 2/2020)
 * Faculty of ICT, Mahidol University 
 * Updated on 6 April 2021
 */

------------------------------------------------------------
-- BEGIN: Stored Procedure
------------------------------------------------------------
USE PremierProducts   -- USE PremierProduct
GO

-- Q1 --
CREATE PROCEDURE sp_customer
    -- Add parameters for the stored procedure here
    @custNum NVARCHAR(3)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets 
    -- from interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT *
    FROM Customer
    WHERE CustomerNum = @custNum;
END
GO

-- Q2 --

-- Q3 --
DECLARE @RC int
DECLARE @custNum nvarchar(3)

-- TODO: Set parameter values here.
set @custNum = '608'

EXECUTE @RC = [dbo].[sp_customer] 
   @custNum
GO

-- Q4 --
ALTER PROCEDURE [dbo].[sp_customer]
    -- Add parameters for the stored procedure here
    @custNum NVARCHAR(3)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets 
    -- from interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT CustomerNum, CustomerName, Balance, CreditLine
    FROM Customer
    WHERE CustomerNum = @custNum;
END
GO

-- Q4.1 --
-- Execute again after ALTER 
EXEC sp_customer @custNum = '608'
GO

-- Q5 --
DROP PROCEDURE sp_customer
GO


-- Q6 --
SELECT *
FROM Customer
WHERE City = 'Grove' AND CreditLine >= 9000

SELECT *
FROM Customer
WHERE City = 'Fillmore' AND CreditLine >= 12000

-- Q7 --
-- Create the stored procedure in the specified schema
CREATE PROCEDURE dbo.sp_customer_city_limit
    @city NVARCHAR(100),
    @limit MONEY
-- add more stored procedure parameters here
AS
-- body of the stored procedure
SELECT *
FROM Customer
WHERE City = @city AND CreditLine >= @limit
GO

-- example to execute the stored procedure we just created

-- If the parameters are in the same order as declared in the stored proc, 
-- the parameter's name can be omitted
EXECUTE dbo.sp_customer_city_limit 'Grove', 9000
GO
-- Otherwise, the specific parameter names are required
EXECUTE dbo.sp_customer_city_limit @limit = 12000, @city = 'Fillmore'
GO

-- Q8 --
-- create stored proc to retrieve customers based on their credit line
-- type "high": credit line > 10000
-- type "mid": credit line between 7500 to 10000
-- type "low": credit line < 7500

CREATE PROCEDURE dbo.sp_customer_type
    @type NVARCHAR(5)
AS
-- body of the stored procedure
IF (@type = 'high')
        BEGIN
    SELECT *
    FROM Customer
    WHERE CreditLine >= 10000
END
    ELSE IF (@type = 'mid')
        BEGIN
    SELECT *
    FROM Customer
    WHERE CreditLine >= 7500 AND CreditLine < 10000
END
    ELSE
        BEGIN
    SELECT *
    FROM Customer
    WHERE CreditLine < 7500
END
GO


-- Q8.1 Executing --
EXECUTE dbo.sp_customer_type 'high'

-- Q8.2 Executing --
EXECUTE dbo.sp_customer_type 'mid'

-- Q8.3 Executing --
EXECUTE dbo.sp_customer_type 'low'
Go


-- Q9 --
-- Check input before inserting

CREATE PROCEDURE sp_insert
    @custNum INT,
    @custName VARCHAR(255)
AS
DECLARE @resultValue int
IF EXISTS (SELECT *
FROM Customer
WHERE CustomerNum = @custNum)  
        BEGIN
    SET  @resultValue = -5
END  
    ELSE  
        BEGIN
    INSERT INTO Customer
        (CustomerNum, CustomerName)
    VALUES
        (@custNum, @custName)
    SET @resultValue = 0
END

RETURN @resultValue


-- Q9.1 --
DECLARE  @return_status int
EXEC @return_status= sp_insert 125, 'Test New User'
SELECT @return_status
GO

-- Q9.2 --
DECLARE  @return_status int
EXEC @return_status= sp_insert 125, 'Test Duplicate User'
SELECT @return_status
GO

------------------------------------------------------------
-- END: Stored Procedure
------------------------------------------------------------

------------------------------------------------------------ start LAB 1 ------------------------------------------------------------
USE PremierProducts

CREATE PROCEDURE sp_customer_order
    @date datetime,
    @orderCount int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON;
    -- Insert statements for procedure here
    SELECT Orders.OrderNum, Orders.OrderDate, Orders.CustomerNum,
        COUNT(Orders.OrderNum) AS AmountOrder,
        CONVERT(DECIMAL(10,4),SUM(OrderLine.QuotedPrice)) AS SumPrice
    FROM Orders
        JOIN OrderLine ON OrderLine.OrderNum = Orders.OrderNum
    GROUP BY Orders.OrderNum, Orders.OrderDate, Orders.CustomerNum
    HAVING Orders.OrderDate = @date AND Orders.OrderNum >= @orderCount
END
GO
-- test exercise 1
exec sp_customer_order
@date = '2010-10-21', @orderCount = 1
------------------------------------------------------------- end LAB 1 -------------------------------------------------------------

----------------------------------------------------------- start HOMEWORK 1 -----------------------------------------------------------
-- before do HW1 --

SELECT *
FROM Orders
SELECT *
FROM OrderLine
Go
CREATE PROCEDURE sp_insert_order
    @amount			INT,
    -- amount of parts
    @part			NVARCHAR(10),
    -- part number
    @customerNum	INT
-- customer number
AS
BEGIN

    DECLARE @quotedPrice MONEY
    IF EXISTS (SELECT Part.Price
    FROM Part)  
        BEGIN
        SET  @quotedPrice = @amount * 
        (SELECT Part.Price
        FROM Part
        WHERE Part.PartNum = @part)
    END

    DECLARE @nextOrderNum INT
    IF EXISTS (SELECT OrderNum
    FROM Orders)  
        BEGIN
        SET  @nextOrderNum = (SELECT MAX(OrderNum)
        from Orders ) +1
END

    INSERT INTO Orders
        (OrderNum, OrderDate, CustomerNum)
    VALUES
        (@nextOrderNum, GETDATE() , @customerNum)

    INSERT INTO OrderLine
        (OrderNum, PartNum, NumOrdered, QuotedPrice)
    VALUES
        (@nextOrderNum, @part, @amount, @quotedPrice)

END

EXEC sp_insert_order @amount = 2, @part = 'DR93', @customerNum = '608'

-- after do HW1 --

SELECT *
FROM Orders
SELECT *
FROM OrderLine
------------------------------------------------------------ end HOMEWORK 1 ------------------------------------------------------------

------------------------------------------------------------
-- BEGIN: Database Trigger
------------------------------------------------------------
-- Q0: Prepare DB --
USE master
GO

DROP DATABASE TestTrigger
GO

CREATE DATABASE TestTrigger
GO

USE TestTrigger
GO

CREATE TABLE person
(
    pid varchar(4) PRIMARY KEY,
    full_name varchar(40) not null,
    budget decimal(18,2) not null,
    proj_id varchar(4)
);

CREATE TABLE project
(
    proj_id varchar(4) PRIMARY KEY,
    proj_name varchar(40) not null,
    total_budget decimal(18,2)not null
);


INSERT INTO person
    (pid, full_name, budget, proj_id)
VALUES
    ('001', 'Peter Copper', 20000, 1),
    ('002', 'Sarah MaCorr', 10000, 1),
    ('003', 'Henry Pipe', 25000, 1),
    ('004', 'Wilman Kala', 30000, 2),
    ('005', 'Matti Karttunen', 5000, 2),
    ('006', 'Luke Miller', 21000, 3),
    ('007', 'Margaret Johnson', 22000, 3),
    ('008', 'Bruce Randall', 32000, 3),
    ('009', 'Hina Siddiqui', 23000, 3),
    ('010', 'Joanne Mills', 25000, 4);

INSERT INTO project
    (proj_id, proj_name, total_budget)
VALUES
    ('1', 'Project 1', 55000),
    ('2', 'Project 2', 35000),
    ('3', 'Project 3', 98000),
    ('4', 'Project 4', 25000);

SELECT *
FROM person;

SELECT *
FROM project;
GO

---*******************************---
--- Q1: Before inserting/updating ---

CREATE TRIGGER minBudget
ON person
FOR INSERT, UPDATE 
AS
BEGIN
    SET NOCOUNT ON

    If ((SELECT MIN(budget)
    FROM INSERTED) < 10000)
    BEGIN
        PRINT 'The minimum budget is 10000. You need more Budget to INSERT';
        ROLLBACK
    END
END

-- Show all trigger --
SELECT *
FROM sys.triggers

-- Let's check the trigger
-- Step 1: try to insert a new record which doesn't meet the minimum budget
INSERT INTO person
    (pid, full_name, budget, proj_id)
VALUES
    ('011', 'Sarah Mogan', 5000, 4);

-- Step 2: try to insert again with valid input
INSERT INTO person
    (pid, full_name, budget, proj_id)
VALUES
    ('011', 'Sarah Mogan', 15000, 4);

-- Is there any problem in our data after inserting new person budget on a project?
-- YES!!! Inconsistency Data since the total budget in project table doesn't get updated!
SELECT *
FROM person
WHERE proj_id = 4
GO

SELECT *
FROM project
WHERE proj_id = 4
GO

SELECT SUM(budget) AS New_Total_Budget
FROM person
WHERE proj_id = 4
GO


---***************************************---
--- Q2: After inserting/updating/deleting ---
CREATE TRIGGER sumBudget
ON  person
AFTER INSERT,UPDATE,DELETE
AS 
BEGIN
    SET NOCOUNT ON;

    DECLARE @projID        VARCHAR(4);
    DECLARE @sumbudget  DECIMAL(18,2);

    SET @projID = (SELECT DISTINCT proj_id
    FROM INSERTED)

    IF @projID IS NULL
	BEGIN
        SET @projID = (SELECT DISTINCT proj_id
        FROM DELETED)
    END

    SET @sumbudget = (SELECT SUM(budget)
    FROM [person]
    WHERE proj_id = @projID )

    UPDATE project SET total_budget = @sumbudget 
	WHERE proj_id = @projID
;

END

-- Let's check the trigger
-- Step 1: remove Sarah  
DELETE person WHERE pid = '011';

-- now data are in the consistency state
SELECT *
FROM person
WHERE proj_id = 4;
SELECT *
FROM project
WHERE proj_id = 4;

-- Step 2: re-insert Sarah 
INSERT INTO person
    (pid, full_name, budget, proj_id)
VALUES
    ('011', 'Sarah Mogan', 15000, 4);

-- Trigger is executed, and data are still consistent.
SELECT *
FROM person
WHERE proj_id = 4;
SELECT *
FROM project
WHERE proj_id = 4;

-- Step 3: let's update the budget of pid 001 who works on proj_id 1
SELECT *
FROM person
WHERE pid = '001';     -- budget = 20000
SELECT *
FROM person
WHERE proj_id = 1;     -- 3 persons
SELECT *
FROM project
WHERE proj_id = 1;    -- total budget = 55000

UPDATE person 
SET budget = 10000
WHERE pid = '001'

-- Trigger is executed, and data are still consistent.
SELECT *
FROM person
WHERE proj_id = 1;     -- 3 persons
SELECT *
FROM project
WHERE proj_id = 1;    -- total budget = 45000
GO

---************************************************---
--- Q3: After deleting -> Cascading set NULL value ---
CREATE TRIGGER DelProject
ON project
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @proj_id int;
    SET @proj_id = (SELECT proj_id
    FROM DELETED)

    UPDATE Person
  SET proj_id = NULL
  WHERE proj_id = @proj_id;

END


-- Let's check the trigger
-- Step 1: remove proj_id 3  
DELETE project WHERE proj_id = 3;
SELECT *
FROM project;

-- what will happen to the data in person table?
SELECT *
FROM person;
GO

---************************************---
--- Q4: before dropping/altering table ---
CREATE TRIGGER BlockDDLTrigger
ON DATABASE 
FOR DROP_TABLE, ALTER_TABLE 
AS 
	PRINT 'You cannot drop or alter table now. You must disable the "BlockDDLTrigger" trigger first.'
ROLLBACK ;

-- Let's check the trigger
DROP TABLE person
GO

ALTER TABLE person ADD DOB DATETIME
GO



---*********************---
--- Q5: disable trigger ---
SELECT name, is_disabled
FROM sys.triggers
WHERE name = 'BlockDDLTrigger'
GO

-- disable trigger
DISABLE TRIGGER BlockDDLTrigger ON DATABASE

-- try to modify table again, should be able to modify
ALTER TABLE person ADD DOB DATETIME
GO

-- the new column DOB should be added in the person table
SELECT *
FROM person
GO

-- enable trigger
ENABLE TRIGGER  BlockDDLTrigger ON DATABASE

-- try to drop table again after enable trigger


------------------------------------------------------------
-- END: Database Trigger
------------------------------------------------------------

------------------------------------------------------------ start LAB 2 ------------------------------------------------------------
USE TestTrigger;
Go
CREATE TRIGGER cascade_insert
ON person
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @budget FLOAT
    DECLARE @project_id INT

    SET @budget = (SELECT budget
    from INSERTED)
    SET @project_ID = (SELECT proj_id
    from INSERTED)

    INSERT INTO project
    VALUES
        (@project_id, '(Unknown)', @budget)
END

INSERT INTO person
    (pid, full_name, budget, proj_id)
VALUES
    ('012', 'Harry Potter', 15000, 5);

SELECT *
FROM project

------------------------------------------------------------- end LAB 2 -------------------------------------------------------------

-- create table
CREATE TABLE LogFileAudit
(
    LogID VARCHAR(255) PRIMARY KEY,
    Action VARCHAR(255) NOT NULL,
    TableName VARCHAR(255) NOT NULL
);
Go
----------------------------------------------------------- start HOMEWORK 2 -----------------------------------------------------------
-- do after INSERT
CREATE TRIGGER addLogINS
ON person
AFTER INSERT 
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @logId VARCHAR(255)

    SET @logId = (SELECT LogID
    from LogFileAudit )
    IF @logId IS NULL
		SET @logId = 0
	ELSE
		SET @logId = (SELECT MAX(LogID)
    from LogFileAudit ) + 1

    INSERT INTO LogFileAudit
    VALUES
        (@logId, 'INSERT', 'person')
END  

-- test 
INSERT INTO person
VALUES
    ('089', 'Nattawipa Saetae', 270743.27, 7, GETDATE())

SELECT *
FROM LogFileAudit
-- end test

-- disable 'cascade_insert' before create 'addLogDEL' because it may have some conflict
DISABLE TRIGGER cascade_insert ON person 
ENABLE TRIGGER  cascade_insert ON person

-- do after DELETE
CREATE TRIGGER addLogDEL
ON project
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @logId VARCHAR(255)

    SET @logId = (SELECT MAX(LogID)
    from LogFileAudit ) + 1

    INSERT INTO LogFileAudit
    VALUES
        (@logId, 'DELETE', 'project')

END 

-- test 
DELETE FROM project WHERE proj_id = 7

SELECT *
FROM LogFileAudit
-- end test
------------------------------------------------------------ end HOMEWORK 2 ------------------------------------------------------------
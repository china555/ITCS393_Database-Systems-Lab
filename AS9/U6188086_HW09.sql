-- Kittikorn Keeratikriengkrai 6188086

-- Q1
CREATE TABLE Q1
(
	userId uniqueidentifier PRIMARY KEY,
	firstName NVARCHAR(20),
	lastName NVARCHAR(20)
);

-- Q2
INSERT INTO Q1
VALUES
	(NEWID(), 'Kittikorn', 'Keeratikriengkrai');

INSERT INTO Q1
VALUES
	(NEWID(), 'Nattawipa', 'Saetae');

-- Q3
SELECT CONCAT(Q1.firstName , ' ' , Q1.lastName) AS Name, LEN(CONCAT(Q1.firstName , ' ' , Q1.lastName)) AS Count_Characters
FROM Q1;

-- Q4
CREATE TABLE Q2
(
	Uname NVARCHAR(32),
	Upass NVARCHAR(64)
);

-- Q5
INSERT INTO Q2
VALUES
	(
		'U6188086', HASHBYTES('MDS','123456')
);

-- Q6
CREATE TABLE Q3
(
	userId uniqueidentifier PRIMARY KEY,
	Fname NVARCHAR(20),
	LoginDate date,
	LoginTime time,
	LogoutTime time
);

-- Q7
INSERT INTO Q3
	(userId, Fname, LoginDate, LoginTime)
VALUES
	(
		NEWID(), 'Kittikorn', GETDATE(), GETDATE()
);

-- Q8
UPDATE Q3 SET LogoutTime = GETDATE()  
WHERE Fname = 'Kittikorn'

-- Q9
SELECT Fname, CONVERT(varchar,LoginTime,108) AS LoginTime, CONVERT(varchar,LogoutTime,108) AS LogoutTime
FROM Q3

-- Q10
SELECT Fname,
	CONCAT ( DATENAME(DAY,LoginDate), '-',
				 DATENAME(MONTH,LoginDate), '-',
				 DATENAME(YEAR,LoginDate) ) AS LoginDate,
	DATEDIFF (MINUTE, LoginTime, LogoutTime) AS OnlineTime
FROM Q3
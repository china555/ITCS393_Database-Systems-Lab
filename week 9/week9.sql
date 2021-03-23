-- Q1
CREATE TABLE Q1
(
userId  uniqueidentifier PRIMARY KEY,
firstName NVARCHAR(20),
lastName NVARCHAR(20)
);

-- Q2
INSERT INTO Q1 VALUES (NEWID(),'Nattawipa','Saetae');
INSERT INTO Q1 VALUES (NEWID(),'Kittikorn','Keeratikriengkrai');

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
INSERT INTO Q2 VALUES ('U6188089', HASHBYTES('MDS','123456'));
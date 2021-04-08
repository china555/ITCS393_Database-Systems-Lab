CREATE VIEW vwTotalPaidBillofCustomer
AS
    SELECT c.CustomerNum, c.CustomerName, c.Zip AS Zip,
        r.FirstName as RepFName, r.LastName AS RepLName,
        SUM(ol.QuotedPrice*ol.NumOrdered) AS TotalPaid
    FROM Orders o
        JOIN Customer c ON c.CustomerNum = o.CustomerNum
        JOIN OrderLine ol ON ol.OrderNum = o.OrderNum
        JOIN Rep r ON r.RepNum = c.RepNum
    GROUP BY c.CustomerNum, c.CustomerName, c.Zip,r.FirstName, r.LastName
    HAVING SUM(ol.QuotedPrice*ol.NumOrdered) > 1000
Go

DROP VIEW vwTotalPaidBillofCustomer

SELECT *
FROM vwTotalPaidBillofCustomer
GO

ALTER VIEW vwTotalPaidBillofCustomer
AS
    SELECT c.CustomerNum, c.CustomerName, c.Zip AS Zip,
        r.FirstName as RepFName, r.LastName AS RepLName, COUNT(CustomerName) AS NumOrdered,
        SUM(ol.QuotedPrice*ol.NumOrdered) AS TotalPaid
    FROM Orders o
        JOIN Customer c ON c.CustomerNum = o.CustomerNum
        JOIN OrderLine ol ON ol.OrderNum = o.OrderNum
        JOIN Rep r ON r.RepNum = c.RepNum
    GROUP BY c.CustomerNum, c.CustomerName, c.Zip,r.FirstName, r.LastName
    HAVING SUM(ol.QuotedPrice*ol.NumOrdered) > 1000
Go

SELECT *
FROM vwTotalPaidBillofCustomer

select KeyID
into SmallDataKey
from DataStore_IDX
where KeyID < 500;

select KeyID
into LargeDataKey
from DataStore_IDX
where KeyID > 500000;

drop table DataStore

use PremierProduct11

select KeyID
from DataStore
where KeyID > 5000000;

select KeyID
from DataStore_IDX
where KeyID > 5000000;

select KeyID, AccountDesc, AccountType
from DataStore
where KeyID > 5000000;

select KeyID, AccountDesc, AccountType
from DataStore_IDX
where KeyID > 5000000;

-- 3. INNER JOIN with the SmallDataKey table on KeyID and shows SmallDataKey.KeyID and AccountDesc (from DataSotre or from DataStore_IDX)

-- DataStore
SELECT s.KeyID, d.AccountDesc
FROM DataStore d
    INNER JOIN SmallDataKey s ON d.KeyID = s.KeyID

-- DataStore_IDX
SELECT SmallDataKey.KeyID, AccountDesc
FROM DataStore_IDX
    INNER JOIN SmallDataKey ON DataStore_IDX.KeyID = SmallDataKey.KeyID

-- 4. INNER JOIN with the LargeDataKey table on KeyID and shows LargeDataKey.KeyID and AccountDesc (from DataSotre or from DataStore_IDX)

-- DataStore
SELECT LargeDataKey.KeyID, AccountDesc
FROM DataStore
    INNER JOIN LargeDataKey ON DataStore.KeyID = LargeDataKey.KeyID

-- DataStore_IDX
SELECT LargeDataKey.KeyID, AccountDesc
FROM DataStore_IDX
    INNER JOIN LargeDataKey ON DataStore_IDX.KeyID = LargeDataKey.KeyID

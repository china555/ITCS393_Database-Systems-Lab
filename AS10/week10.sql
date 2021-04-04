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
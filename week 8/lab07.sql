USE PremierProducts

SELECT *
FROM Part
WHERE Price >= (SELECT AVG(Price)FROM Part)

SELECT CustomerName
FROM Customer
WHERE CustomerNum IN (select CustomerNum
from Orders
WHERE OrderDate < '2010-10-22')

SELECT *
FROM Customer
WHERE CustomerNum in (select c.CustomerNum
from Customer c
join Rep r on r.RepNum = c.RepNum
WHERE r.FirstName = 'Valerie' and r.LastName = 'Kaiser')

Select c.CustomerName, c.Balance
from Customer c
Where c.Balance  > (select Balance
from Customer
WHERE CustomerName = 'Brookings Direct')


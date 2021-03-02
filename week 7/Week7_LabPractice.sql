use PremierProducts

--Q0
SELECT CustomerNum, CustomerName FROM Customer

--Q1
SELECT CustomerNum, CustomerName FROM Customer
UNION 
SELECT CustomerNum, CustomerName FROM Customer

--Q2
SELECT CustomerNum, CustomerName FROM Customer
UNION ALL
SELECT CustomerNum, CustomerName FROM Customer

--Q3
SELECT CustomerNum, CustomerName FROM Customer
UNION ALL
SELECT CustomerNum, CustomerName FROM Customer
ORDER BY CustomerNum


--Q4
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance BETWEEN 3000 AND 5500

--Q5
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance BETWEEN 3000 AND 5500
UNION ALL
SELECT CustomerNum, CustomerName FROM Customer

--Q6
SELECT CustomerNum, CustomerName FROM Customer
UNION ALL
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance BETWEEN 3000 AND 5500

--Q7
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance BETWEEN 3000 AND 5500
UNION
SELECT CustomerNum, CustomerName FROM Customer

--Q8
SELECT CustomerNum, CustomerName FROM Customer
UNION
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance BETWEEN 3000 AND 5500

--Q9
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance > 10000


--Q10
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance > 10000
UNION ALL
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance BETWEEN 3000 AND 5500


--Q11
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance > 10000
UNION
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance BETWEEN 3000 AND 5500

--Q12
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance > 5000


--Q13
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance > 5000
UNION ALL
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance BETWEEN 3000 AND 5500

--Q14
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance > 5000
UNION
SELECT CustomerNum, CustomerName FROM Customer
WHERE Balance BETWEEN 3000 AND 5500

--Q15
SELECT CustomerNum FROM Orders

--Q16
SELECT CustomerNum FROM Customer

--Q17
SELECT CustomerNum FROM Customer
EXCEPT
SELECT CustomerNum FROM Orders

--Q18
SELECT CustomerNum FROM Customer
INTERSECT
SELECT CustomerNum FROM Orders


--Q19
SELECT CustomerNum FROM Orders
EXCEPT
SELECT CustomerNum FROM Customer

--Q20
SELECT CustomerNum FROM Orders
INTERSECT
SELECT CustomerNum FROM Customer

--Q21
SELECT CustomerNum FROM Customer
UNION
SELECT CustomerNum, CustomerName FROM Customer


--Q22
SELECT CustomerNum FROM Orders
UNION
SELECT CustomerNum FROM Customer

--Q23
SELECT CustomerNum FROM Orders
EXCEPT
SELECT CustomerNum FROM Customer

--Q24
SELECT CustomerNum FROM Orders
INTERSECT
SELECT CustomerNum FROM Customer



--CROSS APPLY
--Q25
SELECT * FROM Customer
INNER JOIN Orders
ON Customer.CustomerNum = Orders.CustomerNum

--Q26
SELECT *
FROM Customer
CROSS APPLY
(
	SELECT *
	FROM Orders
	WHERE Customer.CustomerNum = Orders.CustomerNum
) AS T


--Q27
SELECT * FROM Customer
LEFT OUTER JOIN Orders
ON Customer.CustomerNum = Orders.CustomerNum

--Q28
SELECT *
FROM Customer
OUTER APPLY
(
	SELECT *
	FROM Orders
	WHERE Customer.CustomerNum = Orders.CustomerNum
) AS T


--Q28
SELECT CustomerName, T.TotalNumberOfOrders
FROM Customer
CROSS APPLY
(
	SELECT COUNT(*) AS TotalNumberOfOrders
	FROM Orders
	WHERE Customer.CustomerNum = Orders.CustomerNum
) AS T

--Q29
SELECT CustomerName, T.TotalNumberOfOrders
FROM Customer
OUTER APPLY
(
	SELECT COUNT(*) AS TotalNumberOfOrders
	FROM Orders
	WHERE Customer.CustomerNum = Orders.CustomerNum
) AS T

--Q30
SELECT CustomerName, T.SumPrice
FROM Customer
CROSS APPLY
(
	SELECT SUM(NumOrdered * QuotedPrice) AS SumPrice
	FROM Orders
	INNER JOIN OrderLine ON Orders.OrderNum = OrderLine.OrderNum
	WHERE Orders.CustomerNum = Customer.CustomerNum
	HAVING SUM(NumOrdered * QuotedPrice)  > 0
) AS T

--Q31
SELECT CustomerName, T.SumPrice
FROM Customer
OUTER APPLY
(
	SELECT SUM(NumOrdered * QuotedPrice) AS SumPrice
	FROM Orders
	INNER JOIN OrderLine ON Orders.OrderNum = OrderLine.OrderNum
	WHERE Orders.CustomerNum = Customer.CustomerNum
	HAVING SUM(NumOrdered * QuotedPrice)  > 0
) AS T
 
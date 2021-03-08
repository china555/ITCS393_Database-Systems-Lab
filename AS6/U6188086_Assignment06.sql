use ALEXAMARA

-- Q1 Write a query to show SlipID that does not request for service.
SELECT SlipID FROM MarinaSlip
EXCEPT
SELECT SlipID FROM ServiceRequest

-- Q2 Write a query to display Distinct Status using SET operation WHERE Status is not "Open".
SELECT DISTINCT Status
FROM ServiceRequest
EXCEPT
(
	SELECT Status
	FROM ServiceRequest
	WHERE Status = 'Open'
);

-- Q3 List all distinct City and State of Owner using SET operation in Descending Order.
SELECT City, State FROM Owner
UNION 
SELECT City, State FROM Owner
ORDER BY City DESC, State DESC
-- Q4 For each Owner and Marina, list all City using SET operation in Ascending Order -------------
SELECT City FROM Owner
UNION
SELECT City FROM Marina
ORDER BY City ASC
-- Q5 For each Owner, get additional column with SlipID and BoatType using APPLY operator
SELECT * FROM Owner
CROSS APPLY(
	SELECT SlipID
	FROM MarinaSlip
	WHERE MarinaSlip.OwnerNum = Owner.OwnerNum
) AS SlipID 
CROSS APPLY(
	SELECT BoatType
	FROM MarinaSlip
	WHERE MarinaSlip.OwnerNum = Owner.OwnerNum
) AS BoatType
-- Q6 For each Marina, get Name of Marina and Max rental fee
SELECT Name, M.Max_Rental_Fee FROM Marina
CROSS APPLY(
	SELECT MAX(MarinaSlip.RentalFee) AS Max_Rental_Fee
	FROM MarinaSlip
	WHERE MarinaSlip.MarinaNum = Marina.MarinaNum
) AS M
-- Q7 For every Slip, list the marina number, slip number, boat name, owner number, owner�s firstname, and owner�s last name.
SELECT MarinaNum, SlipNum, BoatName, O.OwnerNum, O.FirstName, O.LastName FROM MarinaSlip
CROSS APPLY(
	SELECT Owner.OwnerNum, Owner.FirstName, Owner.LastName
	FROM Owner
	WHERE Owner.OwnerNum = MarinaSlip.OwnerNum
) AS O

use adventureworks2014
/*  Student NameKittikorn Keeratikriengkrai ID6188086 */

/*  Q1 Write a query that returns BusinessEntityID, LastName ,
    NationalIDNumber, and JobTitle of all Person.
	[Table: Person, Employee]
 */
-- Your Solution is here!
SELECT p.BusinessEntityID, p.LastName, e.NationalIDNumber, e.JobTitle
FROM Person.Person p
	JOIN HumanResources.Employee e on e.BusinessEntityID = p.BusinessEntityID





/*	Q2 Write a query that returns FirstName, LastName and 
	CreditCardID of Person who have credit cards. 
	[Table: Person, PersonCreditCard]	
*/
-- Your Solution is here!
SELECT p.FirstName, p.LastName, pc.CreditCardID
FROM Person.Person p
	RIGHT JOIN Sales.PersonCreditCard pc on pc.BusinessEntityID = p.BusinessEntityID




/*	Q3 Write a query that returns Name, LogInID and DepartmentName 
	of Employee who were assigned the department and  loginID.
     [Table: Person, Employee, Department, EmployeeDepartmentHistory]
	*/
-- Your Solution is here!
SELECT p.FirstName, LoginID, hd.Name
FROM Person.Person p
	JOIN HumanResources.Employee he on he.BusinessEntityID = p.BusinessEntityID
	JOIN HumanResources.EmployeeDepartmentHistory eh on eh.BusinessEntityID = he.BusinessEntityID
	JOIN HumanResources.Department hd on hd.DepartmentID = eh.DepartmentID




/*	Q4 Write a query that returns one column called Result and 
	contains the last name of the employee with NationalIDNumber 112457891.
    [Table: Person, Employee]
*/
-- Your Solution is here!
SELECT CONCAT(LastName,NationalIDNumber )AS Result
FROM Person.Person p
	JOIN HumanResources.Employee he on he.BusinessEntityID = p.BusinessEntityID
Where NationalIDNumber = 112457891
 
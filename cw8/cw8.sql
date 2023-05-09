-- 1.

WITH TempEmployeeInfo 
AS
(
	SELECT Employee.BusinessEntityID AS BusinessEntityID , FirstName, MiddleName, LastName, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, PhoneNumber, EmailAddress, AddressLine1 AS Address, City, PostalCode, StateProvinceCode, CountryRegionCode, Name, Rate
	FROM HumanResources.Employee 
	INNER JOIN Person.Person ON Employee.BusinessEntityID = Person.BusinessEntityID 
	INNER JOIN Person.PersonPhone ON Person.BusinessEntityID = PersonPhone.BusinessEntityID 
	INNER JOIN Person.BusinessEntityAddress ON Person.BusinessEntityID = BusinessEntityAddress.BusinessEntityID
	INNER JOIN Person.Address ON BusinessEntityAddress.AddressID = Address.AddressID
	INNER JOIN Person.StateProvince ON Address.StateProvinceID = StateProvince.StateProvinceID
	INNER JOIN Person.EmailAddress ON Person.BusinessEntityID = EmailAddress.BusinessEntityID
	INNER JOIN HumanResources.EmployeePayHistory ON EmployeePayHistory.BusinessEntityID = Person.BusinessEntityID
)
SELECT BusinessEntityID , FirstName, MiddleName, LastName, JobTitle, BirthDate, MaritalStatus, Gender, HireDate, PhoneNumber, EmailAddress, Address, City, PostalCode, StateProvinceCode, CountryRegionCode, Name, Rate
FROM TempEmployeeInfo
ORDER BY BusinessEntityID ASC;

-- 2.

WITH TempCompanyRevenue
AS
(
	SELECT CompanyName, TotalDue AS Revenue, FirstName, LastName
	FROM SalesLT.Customer INNER JOIN SalesLT.SalesOrderHeader ON Customer.CustomerID = SalesOrderHeader.CustomerID
)
SELECT CONCAT(CompanyName, ' (' ,FirstName, ' ', LastName, ')') AS CompanyContact, Revenue
FROM TempCompanyRevenue
ORDER BY CompanyContact ASC;

-- 3.

WITH ProductCategorySalesValue
AS
(
	SELECT Product.ProductID AS ProductID, Product.ProductCategoryID AS ProductCategoryID , LineTotal, ProductCategory.Name AS Category
	FROM SalesLT.Product 
	INNER JOIN SalesLT.ProductCategory ON Product.ProductCategoryID = ProductCategory.ProductCategoryID 
	INNER JOIN SalesLT.SalesOrderDetail ON Product.ProductID = SalesOrderDetail.ProductID
	
)
SELECT Category, ROUND(SUM(LineTotal),2) AS SalesValue
FROM ProductCategorySalesValue
GROUP BY ProductCategoryID, Category;


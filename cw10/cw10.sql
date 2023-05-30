--1. Napisz zapytanie, które wykorzystuje transakcjê (zaczyna j¹), a nastêpnie
--aktualizuje cenê produktu o ProductID równym 680 w tabeli Production.Product
--o 10% i nastêpnie zatwierdza transakcjê.

BEGIN TRANSACTION;

UPDATE Production.Product SET ListPrice = ListPrice * 1.1
WHERE ProductID = 680;

COMMIT;

--2. Napisz zapytanie, które zaczyna transakcjê, usuwa produkt o ProductID równym
--707 z tabeli Production.Product, ale nastêpnie wycofuje transakcjê.

BEGIN TRANSACTION;

DELETE FROM Production.Product
WHERE ProductID = 707;

ROLLBACK;

SELECT ProductID FROM Production.Product
WHERE ProductID = 707;

--3. Napisz zapytanie, które zaczyna transakcjê, dodaje nowy produkt do tabeli
--Production.Product, a nastêpnie zatwierdza transakcjê.


BEGIN TRANSACTION;

SET IDENTITY_INSERT Production.Product ON;
INSERT INTO Production.Product 
(ProductID,Name,ProductNumber,MakeFlag,FinishedGoodsFlag,Color,SafetyStockLevel,ReorderPoint,StandardCost,ListPrice,Size,SizeUnitMeasureCode,WeightUnitMeasureCode,Weight,DaysToManufacture,ProductLine,Class,Style,ProductSubcategoryID,ProductModelID,SellStartDate,SellEndDate,DiscontinuedDate, rowguid) VALUES
(1000,'Road-796 Green, 57','BK-R06B-52',1,1,'Green',100,75,343.6496,539.99,52,'CM','LB',20.42,4,'R','L','U',2,31,'2013-05-30 00:00:00.000',NULL,NULL, NEWID());
SET IDENTITY_INSERT Production.Product OFF

COMMIT;


--4. Napisz zapytanie, które zaczyna transakcjê i aktualizuje StandardCost wszystkich
--produktów w tabeli Production.Product o 10%, je¿eli suma wszystkich
--StandardCost po aktualizacji nie przekracza 50000. W przeciwnym razie zapytanie
--powinno wycofaæ transakcjê.BEGIN TRANSACTION;UPDATE Production.Product SET StandardCost = StandardCost * 1.1IF  (SELECT SUM(StandardCost) FROM Production.Product) <= 50000
    COMMIT;
ELSE 
    ROLLBACK;--5. Napisz zapytanie SQL, które zaczyna transakcjê i próbuje dodaæ nowy produkt do
--tabeli Production.Product. Jeœli ProductNumber ju¿ istnieje w tabeli, zapytanie
--powinno wycofaæ transakcjê.BEGIN TRANSACTION;SET IDENTITY_INSERT Production.Product ON;
INSERT INTO Production.Product 
(ProductID,Name,ProductNumber,MakeFlag,FinishedGoodsFlag,Color,SafetyStockLevel,ReorderPoint,StandardCost,ListPrice,Size,SizeUnitMeasureCode,WeightUnitMeasureCode,Weight,DaysToManufacture,ProductLine,Class,Style,ProductSubcategoryID,ProductModelID,SellStartDate,SellEndDate,DiscontinuedDate, rowguid) VALUES
(1002,'Road-798 Green, 57','BK-R06B-52',1,1,'Green',100,75,343.6496,539.99,52,'CM','LB',20.42,4,'R','L','U',2,31,'2013-05-30 00:00:00.000',NULL,NULL, NEWID());
SET IDENTITY_INSERT Production.Product OFF;IF EXISTS (SELECT COUNT(ProductNumber) FROM Production.Product GROUP BY ProductNumber HAVING COUNT(ProductNumber) > 1)	ROLLBACK;ELSE	COMMIT;--6. Napisz zapytanie SQL, które zaczyna transakcjê i aktualizuje wartoœæ OrderQty
--dla ka¿dego zamówienia w tabeli Sales.SalesOrderDetail. Je¿eli którykolwiek z
--zamówieñ ma OrderQty równ¹ 0, zapytanie powinno wycofaæ transakcjê.BEGIN TRANSACTION;UPDATE Sales.SalesOrderDetail SET OrderQty = OrderQty + 1IF EXISTS (SELECT OrderQty FROM Sales.SalesOrderDetail WHERE OrderQty = 0)	ROLLBACK;ELSE	COMMIT;--7. Napisz zapytanie SQL, które zaczyna transakcjê i usuwa wszystkie produkty,
--których StandardCost jest wy¿szy ni¿ œredni koszt wszystkich produktów w tabeli
--Production.Product. Je¿eli liczba produktów do usuniêcia przekracza 10,
--zapytanie powinno wycofaæ transakcjê.BEGIN TRANSACTION;DECLARE @avg_cost MONEY;SELECT @avg_cost = AVG(StandardCost) FROM Production.ProductDELETE FROM Production.ProductWHERE StandardCost > @avg_costIF @@ROWCOUNT > 10	ROLLBACK;ELSE	COMMIT;	DECLARE @avg_cost MONEY;SELECT @avg_cost = AVG(StandardCost) FROM Production.ProductSELECT StandardCost FROM Production.ProductWHERE StandardCost > @avg_cost
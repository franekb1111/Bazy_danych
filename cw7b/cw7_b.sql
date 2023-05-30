-- 1. ciag fibonnaciego 

CREATE FUNCTION dbo.fibonaccifun (@n INT)
RETURNS INT
AS
BEGIN
	DECLARE @f0 INT;
	DECLARE @f1 INT;
	DECLARE @iter INT;
	DECLARE @temp INT;
	SET @iter = 2;
	SET @f0 = 0;
	SET @f1 = 1;
    IF @n = 0 OR @n = 1
		RETURN @n
	WHILE (@iter <= @n)
	BEGIN
		SET @temp = @f0 + @f1;
		SET @f0 = @f1;
		SET @f1 = @temp;
		SET @iter = @iter + 1;
	END
	RETURN @f1
END;


CREATE PROCEDURE dbo.fibprint (@i INT)
AS
BEGIN
    DECLARE @result_p INT;
    SET @result_p = dbo.fibonaccifun(@i);
    PRINT @result_p;
END;

EXEC dbo.fibprint @i = 11;

--2. Napisz trigger DML, który po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko 
--tak, aby by³o napisane du¿ymi literami. 

CREATE TRIGGER trigger_mod_surname
ON Person.Person
AFTER INSERT
AS
BEGIN
	UPDATE Person.Person SET LastName = UPPER(LastName);
END

INSERT INTO Person.BusinessEntity(rowguid) VALUES
(NEWID());


INSERT INTO Person.Person VALUES
(20805, 'IN', 0, NULL, 'Adam', NULL, 'Sánchez', NULL, 0, NULL, '<IndividualSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"><TotalPurchaseYTD>0</TotalPurchaseYTD></IndividualSurvey>', 'D44C30B4-84A5-4E06-BA5E-AF29992FBD802', '2023-05-30 13:00:37.827')



--3. 


CREATE TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
    IF UPDATE(TaxRate)
    BEGIN
        DECLARE @starypodatek FLOAT;
        DECLARE @nowypodatek FLOAT;

        SELECT @starypodatek = TaxRate FROM deleted;
        SELECT @nowypodatek = TaxRate FROM inserted;

        IF  @nowypodatek > @starypodatek * 1.3
        BEGIN
            RAISERROR(N'Zmiana podatku o wiecej ni¿ 30 procent nie jest dozwolona', 10, 2);
            ROLLBACK;
        END;
    END;
END;




UPDATE Sales.SalesTaxRate SET TaxRate = TaxRate * 1.5;



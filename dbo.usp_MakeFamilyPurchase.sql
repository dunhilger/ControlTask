CREATE OR ALTER PROCEDURE dbo.usp_MakeFamilyPurchase(@FamilySurName varchar(255))
AS
BEGIN
    IF NOT EXISTS (SELECT dbo.Family.SurName
				   FROM dbo.Family 
				   WHERE dbo.Family.SurName = @FamilySurName)
    BEGIN 
		RAISERROR('Ôàìèëèÿ %s íå íàéäåíà', 16, 1, @FamilySurName);
		RETURN;		
    END
    UPDATE dbo.Family
    SET dbo.Family.BudgetValue = dbo.Family.BudgetValue - 
		(SELECT (dbo.Basket.Quantity * dbo.Basket.[Value]) 
		 FROM dbo.Basket
			JOIN dbo.Family
				ON dbo.Basket.ID_Family = dbo.Family.ID
		 WHERE dbo.Family.SurName = @FamilySurName)
    WHERE dbo.Family.SurName = @FamilySurName;
END;
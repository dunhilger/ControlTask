CREATE OR ALTER FUNCTION udf_GetSKUPrice(@ID_SKU INT)
	RETURNS DECIMAL(18, 2)
	BEGIN
		DECLARE @Cost DECIMAL(18, 2);
		SELECT @Cost = SUM(dbo.Basket.[Value]) / SUM(dbo.Basket.Quantity)
		FROM dbo.Basket
		WHERE dbo.Basket.ID_SKU = @ID_SKU
	RETURN @Cost;
	END;
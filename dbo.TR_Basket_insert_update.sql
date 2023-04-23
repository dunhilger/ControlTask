CREATE OR ALTER TRIGGER TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT
AS
BEGIN
    UPDATE SRC
    SET SRC.DiscountValue = 
	CASE WHEN DEST.CNT >= 2 
		 THEN SRC.Value * 0.05
         ELSE 0.0
    END
    FROM dbo.Basket AS SRC
		JOIN Inserted AS I 
			ON I.ID = SRC.ID
		JOIN (SELECT ID_SKU, COUNT(*) AS CNT
              FROM Inserted
              GROUP BY ID_SKU) AS DEST 
				ON SRC.ID_SKU = DEST.ID_SKU
END;
CREATE VIEW dbo.vw_SKUPrice AS
SELECT Sku.ID, Sku.Code, Sku.[Name], dbo.udf_GetSKUPrice(Sku.ID) AS Price
FROM dbo.SKU AS Sku;
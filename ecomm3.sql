USE ecomm;

UPDATE customer_churn 
SET WarehouseToHome = (SELECT * FROM (SELECT ROUND(AVG(WarehouseToHome)) FROM customer_churn) AS t) 
WHERE WarehouseToHome IS NULL;

UPDATE customer_churn 
SET HourSpendOnApp = (SELECT * FROM (SELECT ROUND(AVG(HourSpendOnApp)) FROM customer_churn) AS t) 
WHERE HourSpendOnApp IS NULL;

UPDATE customer_churn 
SET OrderAmountHikeFromlastYear = (SELECT * FROM (SELECT ROUND(AVG(OrderAmountHikeFromlastYear)) FROM customer_churn) AS t) 
WHERE OrderAmountHikeFromlastYear IS NULL;

UPDATE customer_churn 
SET DaySinceLastOrder = (SELECT * FROM (SELECT ROUND(AVG(DaySinceLastOrder)) FROM customer_churn) AS t) 
WHERE DaySinceLastOrder IS NULL;
USE ecomm;

SELECT 
    SUM(CASE WHEN WarehouseToHome IS NULL THEN 1 ELSE 0 END) AS Null_Warehouse,
    SUM(CASE WHEN HourSpendOnApp IS NULL THEN 1 ELSE 0 END) AS Null_HourSpend,
    SUM(CASE WHEN OrderAmountHikeFromlastYear IS NULL THEN 1 ELSE 0 END) AS Null_OrderHike,
    SUM(CASE WHEN DaySinceLastOrder IS NULL THEN 1 ELSE 0 END) AS Null_DaysOrder,
    SUM(CASE WHEN Tenure IS NULL THEN 1 ELSE 0 END) AS Null_Tenure
FROM customer_churn;
USE ecomm;

UPDATE customer_churn 
SET Tenure = (
    SELECT Tenure FROM (
        SELECT Tenure FROM customer_churn 
        WHERE Tenure IS NOT NULL 
        GROUP BY Tenure 
        ORDER BY COUNT(*) DESC LIMIT 1
    ) AS temp1
) 
WHERE Tenure IS NULL;

UPDATE customer_churn 
SET CouponUsed = (
    SELECT CouponUsed FROM (
        SELECT CouponUsed FROM customer_churn 
        WHERE CouponUsed IS NOT NULL 
        GROUP BY CouponUsed 
        ORDER BY COUNT(*) DESC LIMIT 1
    ) AS temp2
) 
WHERE CouponUsed IS NULL;

UPDATE customer_churn 
SET OrderCount = (
    SELECT OrderCount FROM (
        SELECT OrderCount FROM customer_churn 
        WHERE Tenure IS NOT NULL
        GROUP BY OrderCount 
        ORDER BY COUNT(*) DESC LIMIT 1
    ) AS temp3
) 
WHERE OrderCount IS NULL;

SELECT 
    SUM(CASE WHEN Tenure IS NULL THEN 1 ELSE 0 END) AS Null_Tenure,
    SUM(CASE WHEN CouponUsed IS NULL THEN 1 ELSE 0 END) AS Null_CouponUsed,
    SUM(CASE WHEN OrderCount IS NULL THEN 1 ELSE 0 END) AS Null_OrderCount
FROM customer_churn;


DELETE FROM customer_churn 
WHERE WarehouseToHome > 100;
SELECT MAX(WarehouseToHome) AS Max_Distance 
FROM customer_churn;


UPDATE customer_churn 
SET PreferredLoginDevice = 'Mobile Phone' 
WHERE PreferredLoginDevice = 'Phone';


UPDATE customer_churn 
SET PreferedOrderCat = 'Mobile Phone' 
WHERE PreferedOrderCat = 'Mobile';

SELECT CustomerID, PreferredLoginDevice, PreferedOrderCat 
FROM customer_churn;

UPDATE customer_churn
SET PreferredPaymentMode = 'Cash on Delivery'
WHERE PreferredPaymentMode = 'COD';


UPDATE customer_churn
SET PreferredPaymentMode = 'Credit Card'
WHERE PreferredPaymentMode = 'CC';

SELECT CustomerID, PreferredPaymentMode 
FROM customer_churn;


ALTER TABLE customer_churn 
RENAME COLUMN PreferedOrderCat TO PreferredOrderCat;


ALTER TABLE customer_churn 
RENAME COLUMN HourSpendOnApp TO HoursSpentOnApp;
DESCRIBE customer_churn;


ALTER TABLE customer_churn 
ADD COLUMN ComplaintReceived VARCHAR(10);


UPDATE customer_churn 
SET ComplaintReceived = CASE 
    WHEN Complain = 1 THEN 'Yes' 
    ELSE 'No' 
END;


SELECT CustomerID, Complain, ComplaintReceived 
FROM customer_churn;


ALTER TABLE customer_churn 
ADD COLUMN ChurnStatus VARCHAR(20);


UPDATE customer_churn 
SET ChurnStatus = CASE 
    WHEN Churn = 1 THEN 'Churned' 
    ELSE 'Active' 
END;


SELECT CustomerID, Churn, ChurnStatus 
FROM customer_churn;

ALTER TABLE customer_churn 
DROP COLUMN Churn,
DROP COLUMN Complain;

DESCRIBE customer_churn;

SELECT * FROM customer_churn;


SELECT Churn, COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY Churn;


SELECT Churn, COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY Churn;


SELECT 
    AVG(Tenure) AS Average_Tenure, 
    SUM(CashbackAmount) AS Total_Cashback
FROM customer_churn
WHERE Churn = 1;


SELECT 
    (SUM(CASE WHEN Complain = 1 AND Churn = 1 THEN 1 ELSE 0 END) * 100.0) / 
    (SELECT COUNT(*) FROM customer_churn WHERE Churn = 1) AS Complaint_Percentage
FROM customer_churn;


SELECT CityTier, COUNT(*) AS Churned_Count
FROM customer_churn
WHERE Churn = 1 AND PreferedOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY Churned_Count DESC
LIMIT 1;




DROP TABLE IF EXISTS customer_churn;

CREATE TABLE customer_churn (
    CustomerID INT PRIMARY KEY,
    Churn BIT,
    Tenure INT,
    PreferredLoginDevice VARCHAR(20),
    CityTier INT,
    WarehouseToHome INT,
    PreferredPaymentMode VARCHAR(20),
    Gender ENUM('Male', 'Female'),
    HourSpendOnApp INT,
    NumberOfDeviceRegistered INT,
    PreferedOrderCat VARCHAR(20),
    SatisfactionScore INT,
    MaritalStatus VARCHAR(10),
    NumberOfAddress INT,
    Complain BIT,
    OrderAmountHikeFromlastYear INT,
    CouponUsed INT,
    OrderCount INT,
    DaySinceLastOrder INT,
    CashbackAmount INT
);

SELECT Churn, COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY Churn;

SELECT 
    AVG(Tenure) AS Average_Tenure, 
    SUM(CashbackAmount) AS Total_Cashback
FROM customer_churn
WHERE Churn = 1;

SELECT 
    (SUM(CASE WHEN Complain = 1 AND Churn = 1 THEN 1 ELSE 0 END) * 100.0) / 
    (SELECT COUNT(*) FROM customer_churn WHERE Churn = 1) AS Complaint_Percentage
FROM customer_churn;

SELECT CityTier, COUNT(*) AS Churned_Count
FROM customer_churn
WHERE Churn = 1 AND PreferedOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY Churned_Count DESC
LIMIT 1;

SELECT PreferredPaymentMode, COUNT(*) AS Customer_Count
FROM customer_churn
WHERE Churn = 0
GROUP BY PreferredPaymentMode
ORDER BY Customer_Count DESC
LIMIT 1;

SELECT SUM(OrderAmountHikeFromlastYear) AS Total_Order_Amount_Hike
FROM customer_churn
WHERE MaritalStatus = 'Single' 
  AND PreferredLoginDevice = 'Mobile Phone';
  SELECT AVG(NumberOfDeviceRegistered) AS Avg_Devices_Registered
FROM customer_churn
WHERE PreferredPaymentMode = 'UPI';

SELECT CityTier, COUNT(*) AS Total_Customers
FROM customer_churn
GROUP BY CityTier
ORDER BY Total_Customers DESC
LIMIT 1;

SELECT CityTier, COUNT(*) AS Total_Customers
FROM customer_churn
GROUP BY CityTier
ORDER BY Total_Customers DESC
LIMIT 1;

SELECT PreferedOrderCat, COUNT(*) AS Customer_Count, MAX(HourSpendOnApp) AS Max_Hours_Spent
FROM customer_churn
GROUP BY PreferedOrderCat;

SELECT SUM(OrderCount) AS Total_Order_Count
FROM customer_churn
WHERE PreferredPaymentMode = 'Credit Card' 
  AND SatisfactionScore = (SELECT MAX(SatisfactionScore) FROM customer_churn);

SELECT AVG(SatisfactionScore) AS Avg_Satisfaction_Score
FROM customer_churn
WHERE Complain = 1;

SELECT PreferedOrderCat, COUNT(*) AS Customer_Count
FROM customer_churn
WHERE CouponUsed > 5
GROUP BY PreferedOrderCat;

SELECT PreferedOrderCat, AVG(CashbackAmount) AS Avg_Cashback
FROM customer_churn
GROUP BY PreferedOrderCat
ORDER BY Avg_Cashback DESC
LIMIT 3;

SELECT PreferredPaymentMode
FROM customer_churn
GROUP BY PreferredPaymentMode
HAVING AVG(Tenure) = 10 AND SUM(OrderCount) > 500;

SELECT 
    CASE 
        WHEN WarehouseToHome <= 5 THEN 'Very Close Distance'
        WHEN WarehouseToHome <= 10 THEN 'Close Distance'
        WHEN WarehouseToHome <= 15 THEN 'Moderate Distance'
        ELSE 'Far Distance'
    END AS Distance_Category,
    Churn,
    COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY Distance_Category, Churn
ORDER BY Distance_Category;

SELECT *
FROM customer_churn
WHERE MaritalStatus = 'Married' 
  AND CityTier = 1 
  AND OrderCount > (SELECT AVG(OrderCount) FROM customer_churn);


DROP TABLE IF EXISTS customer_returns;


CREATE TABLE customer_returns (
    ReturnID INT PRIMARY KEY,
    CustomerID INT,
    ReturnDate DATE,
    RefundAmount INT
);


INSERT INTO customer_returns (ReturnID, CustomerID, ReturnDate, RefundAmount) VALUES
(1001, 50022, '2023-01-01', 2130),
(1002, 50316, '2023-01-23', 2000),
(1003, 51099, '2023-02-14', 2290),
(1004, 52321, '2023-03-08', 2510),
(1005, 52928, '2023-03-20', 3000),
(1006, 53749, '2023-04-17', 1740),
(1007, 54206, '2023-04-21', 3250),
(1008, 54838, '2023-04-30', 1990);

describe customer_returns;

SELECT r.*, c.*
FROM customer_returns r
JOIN customer_churn c ON r.CustomerID = c.CustomerID
WHERE c.Churn = 1 AND c.Complain = 1;
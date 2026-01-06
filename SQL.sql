SELECT * FROM project_pv.amazon_sales_2025_inr;

-- Total Revenue (Gross Sales)
SELECT 
    SUM(Total_Sales_INR) AS Total_Revenue
FROM amazon_sales_2025_INR;

-- Net Revenue
SELECT 
    SUM(net_sales_INR) AS net_revenue
FROM Amazon_Sales_2025_INR;

-- Total Orders
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM Amazon_Sales_2025_INR;

-- Average Order Value (AOV)
SELECT 
    ROUND(SUM(Net_Sales_INR) / COUNT(DISTINCT order_id), 2) AS Avg_Order_Value
FROM Amazon_Sales_2025_INR;

-- Return Rate (%)
SELECT 
    ROUND((SUM(CASE WHEN Delivery_status = 'Returned' THEN 1 ELSE 0 END) 
         / COUNT(order_id)) * 100, 2) AS Return_Rate_Percentage
FROM Amazon_Sales_2025_INR;

-- Revenue Loss Due to Returns
SELECT 
    SUM(Total_Sales_INR - Net_Sales_INR) AS Revenue_Lost_Due_To_Returns
FROM Amazon_Sales_2025_INR
WHERE Delivery_Status = 'Returned';

-- Top Performing Product Categories (by Revenue)
SELECT Product_Category,
       SUM(Net_sales_INR) AS Category_Revenue
FROM Amazon_Sales_2025_INR
 GROUP BY Product_Category
 ORDER BY category_revenue DESC;
 
 -- Average Customer Rating
SELECT 
    ROUND(AVG(Review_Rating), 2) AS Avg_Customer_Rating
FROM Amazon_Sales_2025_INR;

-- Payment Method Distribution
SELECT Payment_method,
       COUNT(order_id) AS Total_Orders,
       ROUND(COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM Amazon_Sales_2025_INR), 2) AS Order_Percentage
FROM Amazon_Sales_2025_INR
GROUP BY Payment_Method;

-- Top States by Revenue
SELECT State,
       SUM(Net_Sales_INR) AS State_Revenue
FROM Amazon_Sales_2025_INR
GROUP BY State
ORDER BY State_Revenue DESC
LIMIT 5;

-- Monthly Revenue Trend
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS month,
    SUM(Net_Sales_INR) AS Monthly_Revenue
FROM Amazon_Sales_2025_INR
GROUP BY month
ORDER BY month;

-- High Return Categories
SELECT 
    Product_Category,
    COUNT(*) AS Total_Returns
FROM Amazon_Sales_2025_INR
WHERE Delivery_Status = 'Returned'
GROUP BY Product_Category
ORDER BY Total_Returns DESC;

-- Rating vs Returns Analysis
SELECT 
    ROUND(AVG(Review_Rating),2) AS Avg_Rating,
    COUNT(*) AS Return_Count
FROM Amazon_Sales_2025_INR
WHERE Delivery_Status = 'Returned';

-- Customer Contribution per Category (% Revenue)
SELECT Product_Category,
       ROUND(SUM(Net_Sales_INR) * 100.0 / (SELECT SUM(Net_Sales_INR) FROM Amazon_Sales_2025_INR), 2
       ) AS Revenue_Percentage
FROM Amazon_Sales_2025_INR
GROUP BY Product_Category;
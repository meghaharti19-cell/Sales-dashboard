Select * from blinkit_data
Select COUNT(*) from blinkit_data

--Data Clening
Update blinkit_data
SET Item_Fat_Content = 
CASE 
WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END

Select DISTINCT(Item_Fat_Content) from blinkit_data

--Total Sales and out put comes in millions with decimale 2
Select CAST(SUM(Total_Sales)/1000000 AS decimal(10,2)) AS Total_Sales_Millions from blinkit_data

--Average Sales: The average revenue per sale.
Select CAST(AVG(Total_Sales) AS decimal(10,0)) AS Avg_Sales from blinkit_data

--Number of Items: The total count of different items sold.
SELECT COUNT(*) AS No_Of_Iteam FROM blinkit_data

--Average Rating: The average customer rating for items sold
Select CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating from blinkit_data


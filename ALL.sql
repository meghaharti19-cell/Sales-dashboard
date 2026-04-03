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

SELECT Item_Fat_Content, 
	CAST(SUM(Total_Sales)/1000 AS decimal(10,2)) AS Total_Sales_By_Item_Fat_Content_In_Thousands,
	CAST(AVG(Total_Sales) AS decimal(10,0)) AS Avg_Sales,
	COUNT(*) AS No_Of_Iteam,
	CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_By_Item_Fat_Content_In_Thousands DESC;

SELECT Item_Type, 
	CAST(SUM(Total_Sales) AS decimal(10,2)) AS Total_Sales_By_Item_Type,
	CAST(AVG(Total_Sales) AS decimal(10,0)) AS Avg_Sales,
	COUNT(*) AS No_Of_Iteam,
	CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales_By_Item_Type DESC;

Select * from blinkit_data

--Fat Content by Outlet for Total Sales:
SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular
FROM 
(
    SELECT Outlet_Location_Type, Item_Fat_Content, 
           CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT 
(
    SUM(Total_Sales) 
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

--Outlet Establishment
SELECT  [Outlet_Establishment_Year], 
           CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		   CAST(AVG(Total_Sales) AS decimal(10,0)) AS Avg_Sales,
			COUNT(*) AS No_Of_Iteam,
			CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating
    FROM blinkit_data
    GROUP BY Outlet_Establishment_Year
	ORDER BY [Outlet_Establishment_Year];

	SELECT * FROM [dbo].[blinkit_data]

--Percentage of Sales by Outlet Size
SELECT Outlet_Size,
	CAST(SUM(Total_Sales) AS decimal (10,2)) AS Total_Sales,
	CAST((SUM(Total_Sales) *100 / SUM(SUM(Total_Sales)) OVER())AS DECIMAL(10,2)) AS Sales_Percentage
FROM [dbo].[blinkit_data]
GROUP BY Outlet_Size
ORDER BY Total_Sales;

--Sales by Outlet Location
SELECT Outlet_Location_Type, 
	CAST(SUM(Total_Sales) AS decimal(10,2)) AS Total_Sales,
	CAST(AVG(Total_Sales) AS decimal(10,0)) AS Avg_Sales,
	COUNT(*) AS No_Of_Iteam,
	CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating,
	CAST((SUM(Total_Sales) *100 / SUM(SUM(Total_Sales)) OVER())AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

--All Metrics by Outlet Type:
SELECT Outlet_Type, 
	CAST(SUM(Total_Sales) AS decimal(10,2)) AS Total_Sales,
	CAST(AVG(Total_Sales) AS decimal(10,0)) AS Avg_Sales,
	COUNT(*) AS No_Of_Iteam,
	CAST(AVG(Rating) AS decimal(10,2)) AS Avg_Rating,
	CAST((SUM(Total_Sales) *100 / SUM(SUM(Total_Sales)) OVER())AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Outlet_Type ;
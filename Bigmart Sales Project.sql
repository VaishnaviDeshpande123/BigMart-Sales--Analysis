
-- =========================================
-- BIGMART SALES ANALYSIS (SQL PROJECT)
-- =========================================

-- Objective:
-- Analyze BigMart sales data to identify key factors affecting sales,
-- product performance, and outlet-level trends.

-- =========================================
-- DATABASE SETUP
-- =========================================

-- CREATE A DATABASE 
CREATE DATABASE DB ;
-- SELECT DATABASE 
USE DB ;

-- =========================================
-- BASIC DATA UNDERSTANDING
-- =========================================

-- DISPLAY TABLE 
SELECT COUNT(*) FROM BIGMART ;

-- DESCRIBE TABLE 
DESCRIBE BIGMART ;  

-- =========================================
-- DATA CLEANING
-- =========================================

-- Check NULL values
SELECT * FROM BIGMART WHERE Item_Weight IS NULL;

-- Replace NULL values with average
UPDATE BIGMART
SET Item_Weight = (SELECT AVG(Item_Weight) FROM BIGMART)
WHERE Item_Weight IS NULL;

-- Standardize Item_Fat_Content
UPDATE BIGMART
SET Item_Fat_Content = 
CASE 
    WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
    WHEN Item_Fat_Content = 'reg' THEN 'Regular'
    ELSE Item_Fat_Content
END;

-- =========================================
-- DATA PREVIEW AFTER CLEANING
-- =========================================

-- PREVIEW DATASET 
SELECT * FROM BIGMART ;

-- =========================================
-- CATEGORICAL DATA ANALYSIS
-- =========================================

-- Item_Fat_Content
SELECT DISTINCT Item_Fat_Content FROM BIGMART  ;

-- Item_Type
SELECT DISTINCT Item_Type FROM BIGMART ;

--   Outlet_Size
SELECT DISTINCT Outlet_Size FROM BIGMART ; 

-- Outlet_Location_Type
SELECT DISTINCT Outlet_Location_Type FROM BIGMART ; 

-- Outlet_Type
SELECT DISTINCT Outlet_Type FROM BIGMART ;  

-- =========================================
-- TOP & LEAST SELLING PRODUCTS
-- =========================================

-- Top 5 selling products
SELECT Item_Identifier, Item_Outlet_Sales 
FROM BIGMART 
ORDER BY Item_Outlet_Sales DESC 
LIMIT 5;

-- Least 5 selling products
SELECT Item_Identifier, Item_Outlet_Sales 
FROM BIGMART 
ORDER BY Item_Outlet_Sales 
LIMIT 5;

-- =========================================
-- SALES ANALYSIS BY CATEGORY
-- =========================================

-- 8 . DISPLAY  TOTAL SALES OF 'DAIRY ' PRODUCTS .
SELECT SUM(Item_Outlet_Sales) FROM BIGMART WHERE Item_Type = "DAIRY" ; 


-- 9. DISPLAY TOTAL SALES OF EACH ITEM TYPE .
SELECT 
Item_Type,
 ROUND(SUM(Item_Outlet_Sales),1) AS "TOTAL SALES",
 ROUND(SUM(Item_Outlet_Sales)/ (SELECT SUM(Item_Outlet_Sales) FROM BIGMART) * 100 , 1)  AS "%SALES"
 FROM BIGMART 
 GROUP BY 1 ;


-- =========================================
-- OUTLET-WISE SALES ANALYSIS
-- =========================================

-- 10 . DISPLAY SALES OF DAIRY ITEMS FROM EACH OUTLET . 
SELECT Outlet_Identifier, ROUND(SUM(Item_Outlet_Sales),2)AS "SALES"
 FROM BIGMART WHERE Item_Type = "DAIRY" GROUP BY 1 ORDER BY 2 DESC ; 
 
 
 -- =========================================
-- LOCATION & FAT CONTENT ANALYSIS
-- ========================================= 

 -- 11. DISPLAY LOCATION TYPE WISE CHANGES IN SALES FOR ITEMS WITH FAT CONTENT .
 SELECT Outlet_Location_Type, Item_Fat_Content, ROUND(SUM(Item_Outlet_Sales),1) AS SALES 
 FROM BIGMART
 WHERE Item_Fat_Content = "LOW FAT" OR Item_Fat_Content = "REGULAR"
 GROUP BY 1, 2 ORDER BY 1, 2 ; 
 
 
 -- =========================================
-- OUTLET-SPECIFIC ANALYSIS (OUT049)
-- =========================================

 SELECT Outlet_Identifier,
 COUNT(Item_Identifier) AS "UNIQUE ITEMS",
 ROUND(AVG(Item_Weight),2) AS "AVERAGE ITEM WEIGHT" ,
 COUNT(Item_Fat_Content) AS "COUNT" ,
 ROUND(MAX(Item_Visibility),2) AS "MAX ITEM VISIBILTITY",
 COUNT(Item_Type) AS "ITEM TYPE",
 ROUND(AVG(Item_MRP),2) AS "SUM MRP",
Count( DISTINCT Outlet_Establishment_Year) AS "ESTABLISHMENT YEAR",
 COUNT(Outlet_Size) AS "SIZE COUNT",
 COUNT(Outlet_Location_Type) AS "LOCATION TYPE COUNT",
 COUNT(Outlet_Type) AS "TYPE COUNT",
 ROUND(SUM(Item_Outlet_Sales) ,2)AS "SALES COUNT",
 ROUND(MAX(Item_Outlet_Sales), 2) AS "MAXIMUM SALE",
 ROUND(AVG(Item_Outlet_Sales),2) AS "AVERAGE SALE"
 FROM BIGMART  WHERE Outlet_Identifier = "OUT049" 
 ;
 
 -- =========================================
-- PRODUCT TYPE ANALYSIS (DAIRY)
-- =========================================

 SELECT Item_Type,
 COUNT(Item_Identifier) AS "TOTAL_ITEMS",
 ROUND(AVG(Item_Weight),2) AS "AVERAGE ITEM WEIGHT",
 COUNT(Item_Fat_Content) AS "COUNT",
 ROUND(MAX(Item_Visibility),3) AS "MAXIMUM  ITEM VISIBILITY",
 COUNT(Item_Type) AS "COUNT ITEM TYPE",
 COUNT(Outlet_Identifier) AS "COUNT OUTLET",
 COUNT(DISTINCT Outlet_Establishment_Year) AS "ESTABLISHMENT YEAR",
 ROUND(MAX(Item_Outlet_Sales),2) AS "MAXIMUM SALES",
 ROUND(AVG(Item_Outlet_Sales),2) AS "AVERAGE SALES",
 ROUND(MIN(Item_Outlet_Sales),2) AS "MIMIMUM SALES"
 FROM BIGMART  WHERE Item_Type = "DAIRY";
 
-- =========================================
-- OVERALL SALES ANALYSIS
-- =========================================

SELECT Item_Outlet_Sales,
SUM(Item_Outlet_Sales) AS "TOTAL SALES",
AVG(Item_Outlet_Sales) AS "AVERAGE SALES",
MAX(Item_Outlet_Sales) AS "MAXIMUM SALES",
COUNT(Item_Type) AS "COUNT",
COUNT(Item_Identifier) AS "COUNT ITEMS",
COUNT(Outlet_Identifier) AS "COUNT OUTLET",
COUNT(DISTINCT Outlet_Establishment_Year) AS "ESTABLISHMENT YEAR"
FROM BIGMART GROUP BY 1 ORDER BY 2 DESC ;



-- =========================================
-- KEY INSIGHTS
-- =========================================

-- 1. MRP significantly impacts sales performance.
-- 2. Tier 3 outlets generate higher overall sales.
-- 3. Supermarket Type 1 outlets contribute the most revenue.
-- 4. Dairy products show consistent demand.

 -- -------------------------------------------------------------------------------------------
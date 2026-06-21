{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 Times-Roman;\f1\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;\red91\green98\blue116;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c43137\c46275\c52941;\cssrgb\c0\c0\c0;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs24 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 -- Day 3: Revenue & Churn Analytics Queries\cf0 \strokec3  \
\cf2 \strokec2 -- Datasets: Superstore Sales + Telco Churn\cf0 \strokec3  \
\cf2 \strokec2 -- Date: June 2026
\f1 \cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 \
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0 \
-- How many rows in Superstore Sales?\
SELECT COUNT(*) AS Total_Orders\
FROM train;\
\
-- How many rows in Telco Churn?\
SELECT COUNT(*) AS Total_Customers\
FROM "WA_Fn-UseC_-Telco-Customer-Churn";\
\
-- What is the total revenue?\
SELECT ROUND(SUM(Sales), 2) AS Total_Revenue\
FROM train;\
\
-- Which region makes the most revenue?\
SELECT \
  Region,\
  ROUND(SUM(Sales), 2) AS Total_Revenue\
FROM train\
GROUP BY Region\
ORDER BY Total_Revenue DESC;\
\
-- Which category makes the most revenue?\
SELECT \
  Category,\
  ROUND(SUM(Sales), 2) AS Total_Revenue\
FROM train\
GROUP BY Category\
ORDER BY Total_Revenue DESC;\
\
-- Top 10 best selling products\
SELECT \
  "Product Name",\
  ROUND(SUM(Sales), 2) AS Total_Revenue\
FROM train\
GROUP BY "Product Name"\
ORDER BY Total_Revenue DESC\
LIMIT 10;\
\
-- Revenue by year\
SELECT \
  SUBSTR("Order Date", 7, 4) AS Year,\
  ROUND(SUM(Sales), 2) AS Total_Revenue\
FROM train\
GROUP BY Year\
ORDER BY Year ASC;\
\
-- Overall churn rate\
SELECT \
  COUNT(*) AS Total_Customers,\
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Customers_Left,\
  ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate_Percent\
FROM "WA_Fn-UseC_-Telco-Customer-Churn";\
\
-- Churn rate by contract type\
SELECT \
  Contract,\
  COUNT(*) AS Total_Customers,\
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Customers_Left,\
  ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate_Percent\
FROM "WA_Fn-UseC_-Telco-Customer-Churn"\
GROUP BY Contract\
ORDER BY Churn_Rate_Percent DESC;\
\
-- Churn rate by tenure group\
SELECT \
  CASE \
    WHEN tenure <= 12 THEN '0-12 months'\
    WHEN tenure <= 24 THEN '13-24 months'\
    WHEN tenure <= 48 THEN '25-48 months'\
    ELSE '49+ months'\
  END AS Tenure_Group,\
  COUNT(*) AS Total_Customers,\
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Customers_Left,\
  ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate_Percent\
FROM "WA_Fn-UseC_-Telco-Customer-Churn"\
GROUP BY Tenure_Group\
ORDER BY Churn_Rate_Percent DESC;\
\
-- Revenue lost from churned customers\
SELECT \
  Churn,\
  COUNT(*) AS Customers,\
  ROUND(SUM(MonthlyCharges), 2) AS Total_Monthly_Revenue\
FROM "WA_Fn-UseC_-Telco-Customer-Churn"\
GROUP BY Churn;\
\
-- Churn rate by internet service type\
SELECT \
  InternetService,\
  COUNT(*) AS Total_Customers,\
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Customers_Left,\
  ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate_Percent\
FROM "WA_Fn-UseC_-Telco-Customer-Churn"\
GROUP BY InternetService\
ORDER BY Churn_Rate_Percent DESC;\
}
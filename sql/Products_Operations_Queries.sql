{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 Times-Roman;\f1\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;\red91\green98\blue116;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c43137\c46275\c52941;\cssrgb\c0\c0\c0;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs24 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 -- Day 4: Products & Operations Analytics Queries\cf0 \strokec3  \
\cf2 \strokec2 -- Datasets: Olist E-Commerce + DataCo Supply Chain\cf0 \strokec3  \
\cf2 \strokec2 -- Date: June 2026
\f1 \cf0 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 \
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0 \
-- Check all 3 tables imported correctly\
SELECT 'Orders' AS Table_Name, COUNT(*) AS Total_Rows FROM olist_orders_dataset\
UNION ALL\
SELECT 'Products', COUNT(*) FROM olist_products_dataset\
UNION ALL\
SELECT 'Supply Chain', COUNT(*) FROM DataCoSupplyChainDataset;\
\
-- Top 10 product categories by number of orders\
SELECT \
  product_category_name AS Category,\
  COUNT(*) AS Total_Orders\
FROM olist_products_dataset\
GROUP BY product_category_name\
ORDER BY Total_Orders DESC\
LIMIT 10;\
\
-- Order status breakdown\
SELECT \
  order_status AS Status,\
  COUNT(*) AS Total_Orders,\
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM olist_orders_dataset), 2) AS Percentage\
FROM olist_orders_dataset\
GROUP BY order_status\
ORDER BY Total_Orders DESC;\
\
-- Overall late delivery rate\
SELECT \
  "Delivery Status" AS Delivery_Status,\
  COUNT(*) AS Total_Orders,\
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM DataCoSupplyChainDataset), 2) AS Percentage\
FROM DataCoSupplyChainDataset\
GROUP BY "Delivery Status"\
ORDER BY Total_Orders DESC;\
\
-- Late delivery rate by region\
SELECT \
  "Order Region" AS Region,\
  COUNT(*) AS Total_Orders,\
  SUM(CASE WHEN "Delivery Status" = 'Late delivery' THEN 1 ELSE 0 END) AS Late_Orders,\
  ROUND(SUM(CASE WHEN "Delivery Status" = 'Late delivery' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Late_Delivery_Rate\
FROM DataCoSupplyChainDataset\
GROUP BY "Order Region"\
ORDER BY Late_Delivery_Rate DESC\
LIMIT 10;\
\
-- Average shipping delay\
SELECT \
  ROUND(AVG("Days for shipping (real)"), 2) AS Avg_Actual_Shipping_Days,\
  ROUND(AVG("Days for shipment (scheduled)"), 2) AS Avg_Scheduled_Shipping_Days,\
  ROUND(AVG("Days for shipping (real)") - AVG("Days for shipment (scheduled)"), 2) AS Avg_Delay_Days\
FROM DataCoSupplyChainDataset;\
\
-- Late delivery rate by shipping mode\
SELECT \
  "Shipping Mode" AS Shipping_Mode,\
  COUNT(*) AS Total_Orders,\
  SUM(CASE WHEN "Delivery Status" = 'Late delivery' THEN 1 ELSE 0 END) AS Late_Orders,\
  ROUND(SUM(CASE WHEN "Delivery Status" = 'Late delivery' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Late_Rate\
FROM DataCoSupplyChainDataset\
GROUP BY "Shipping Mode"\
ORDER BY Late_Rate DESC;\
\
-- Profit by product category\
SELECT \
  "Category Name" AS Category,\
  COUNT(*) AS Total_Orders,\
  ROUND(SUM("Order Profit Per Order"), 2) AS Total_Profit,\
  ROUND(AVG("Order Profit Per Order"), 2) AS Avg_Profit_Per_Order\
FROM DataCoSupplyChainDataset\
GROUP BY "Category Name"\
ORDER BY Total_Profit DESC\
LIMIT 10;\
\
-- Master Company Health Summary\
SELECT 'Total Orders' AS Metric, COUNT(*) AS Value\
FROM DataCoSupplyChainDataset\
UNION ALL\
SELECT 'Late Deliveries', SUM(CASE WHEN "Delivery Status" = 'Late delivery' THEN 1 ELSE 0 END)\
FROM DataCoSupplyChainDataset\
UNION ALL\
SELECT 'On Time Deliveries', SUM(CASE WHEN "Delivery Status" = 'Shipping on time' THEN 1 ELSE 0 END)\
FROM DataCoSupplyChainDataset\
UNION ALL\
SELECT 'Total Revenue', ROUND(SUM(Sales), 0)\
FROM DataCoSupplyChainDataset\
UNION ALL\
SELECT 'Total Profit', ROUND(SUM("Order Profit Per Order"), 0)\
FROM DataCoSupplyChainDataset;}
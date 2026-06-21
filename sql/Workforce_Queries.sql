{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- Day 2: Workforce Analytics Queries\
-- Dataset: IBM HR Attrition\
-- Date: June 2026\
\
-- Query 1: How many employees in total?\
SELECT COUNT(*) AS Total_Employees\
FROM "WA_Fn-UseC_-HR-Employee-Attrition";\
\
-- Query 2: How many employees left?\
SELECT COUNT(*) AS Employees_Who_Left\
FROM "WA_Fn-UseC_-HR-Employee-Attrition"\
WHERE Attrition = 'Yes';\
\
-- Query 3: What percentage left?\
SELECT ROUND(237 * 100.0 / 1470, 2) AS Attrition_Rate_Percent;\
\
-- Query 4: How many stayed?\
SELECT COUNT(*) AS Employees_Who_Stayed\
FROM "WA_Fn-UseC_-HR-Employee-Attrition"\
WHERE Attrition = 'No';\
\
-- Query 5: Which department has most attrition?\
SELECT Department, COUNT(*) AS Employees_Who_Left\
FROM "WA_Fn-UseC_-HR-Employee-Attrition"\
WHERE Attrition = 'Yes'\
GROUP BY Department\
ORDER BY Employees_Who_Left DESC;\
\
-- Query 6: Attrition rate per department\
SELECT Department, COUNT(*) AS Total_Employees,\
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Left,\
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate_Percent\
FROM "WA_Fn-UseC_-HR-Employee-Attrition"\
GROUP BY Department\
ORDER BY Attrition_Rate_Percent DESC;\
\
-- Query 7: Does salary affect attrition?\
SELECT Attrition, ROUND(AVG(MonthlyIncome), 2) AS Average_Monthly_Salary\
FROM "WA_Fn-UseC_-HR-Employee-Attrition"\
GROUP BY Attrition;\
\
-- Query 8: Does overtime affect attrition?\
SELECT OverTime, COUNT(*) AS Total_Employees,\
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Left,\
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate_Percent\
FROM "WA_Fn-UseC_-HR-Employee-Attrition"\
GROUP BY OverTime\
ORDER BY Attrition_Rate_Percent DESC;\
\
-- Query 9: Does job satisfaction affect attrition?\
SELECT JobSatisfaction, COUNT(*) AS Total_Employees,\
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Left,\
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate_Percent\
FROM "WA_Fn-UseC_-HR-Employee-Attrition"\
GROUP BY JobSatisfaction\
ORDER BY JobSatisfaction ASC;\
\
-- Query 10: Does tenure affect attrition?\
SELECT YearsAtCompany, COUNT(*) AS Total_Employees,\
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Left,\
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate_Percent\
FROM "WA_Fn-UseC_-HR-Employee-Attrition"\
GROUP BY YearsAtCompany\
ORDER BY Attrition_Rate_Percent DESC\
LIMIT 10;\
\
-- Query 11: Does performance rating affect attrition?\
SELECT PerformanceRating, COUNT(*) AS Total_Employees,\
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Left,\
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate_Percent\
FROM "WA_Fn-UseC_-HR-Employee-Attrition"\
GROUP BY PerformanceRating\
ORDER BY PerformanceRating ASC;}
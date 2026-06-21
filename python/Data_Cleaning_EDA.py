# Day 5 & 6: All Libraries
# Project: 360 BI SaaS Analysis

# Data manipulation
import pandas as pd
import numpy as np

# Data visualization
import matplotlib.pyplot as plt
import seaborn as sns

# Machine learning (Day 6)
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score, confusion_matrix, classification_report
from sklearn.preprocessing import LabelEncoder

# Settings
import warnings
warnings.filterwarnings('ignore')
pd.set_option('display.max_columns', None)

print("All libraries loaded successfully!")

# Step 2: Load all 5 datasets

# Dataset 1: Workforce
workforce = pd.read_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/WA_Fn-UseC_-HR-Employee-Attrition.csv')

# Dataset 2: Revenue & Sales
sales = pd.read_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/train.csv')

# Dataset 3: Customer Churn
churn = pd.read_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/WA_Fn-UseC_-Telco-Customer-Churn.csv')

# Dataset 4: Product Analytics
orders = pd.read_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/archive (6)/olist_orders_dataset.csv')
products = pd.read_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/archive (6)/olist_products_dataset.csv')

# Dataset 5: Operations
supply_chain = pd.read_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/archive (7)/DataCoSupplyChainDataset.csv', encoding='latin1')

print("All datasets loaded successfully!")


# Step 3: Check shape of all datasets
workforce.shape
sales.shape
churn.shape
orders.shape
products.shape
supply_chain.shape

# check for missing values
workforce.isnull().sum()
sales.isnull().sum()
churn.isnull().sum()
orders.isnull().sum()
products.isnull().sum()
supply_chain.isnull().sum()

# Missing Values Summary:
# Workforce: perfectly clean
# Sales: 11 missing postal codes (irrelevant)
# Churn: perfectly clean
# Orders: missing delivery dates for cancelled orders (normal)
# Products: 610 missing category names (will fill with 'unknown')
# Supply Chain: Product Description completely empty (will drop)


# Step 4: Data Cleaning

# Dataset 4: Fill missing product category names
products['product_category_name'].fillna('unknown', inplace=True)

# Dataset 5: Drop useless Product Description column
supply_chain.drop(columns=['Product Description'], inplace=True)

products['product_category_name'].isnull().sum()
supply_chain.shape
# Filled 610 missing product category names with 'unknown'
# Dropped fully empty Product Description column from supply chain dataset


# Step 5: Save cleaned datasets
# Saving all 6 cleaned datasets as new CSV files for use in Power BI and Tableau

workforce.to_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/cleaned_workforce.csv', index=False)
sales.to_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/cleaned_sales.csv', index=False)
churn.to_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/cleaned_churn.csv', index=False)
orders.to_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/cleaned_orders.csv', index=False)
products.to_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/cleaned_products.csv', index=False)
supply_chain.to_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/cleaned_supply_chain.csv', index=False)


# Step 6: EDA Charts

# Chart 1: Workforce - Attrition Count
sns.countplot(x='Attrition', data=workforce)
plt.title('Employee Attrition Count')
plt.show()
# Finding: 237 out of 1470 employees left — 16.12% attrition rate

# Chart 2: Workforce - Attrition by Department
sns.countplot(x='Department', hue='Attrition', data=workforce)
plt.title('Attrition by Department')
plt.show()
# Finding: R&D loses most employees in total (133) but Sales has highest attrition rate (20.63%)

# Chart 3: Workforce - Salary vs Attrition
sns.boxplot(x='Attrition', y='MonthlyIncome', data=workforce)
plt.title('Monthly Income vs Attrition')
plt.show()
# Finding: Employees who left earned ~$2000 less per month than those who stayed

# Chart 4: Workforce - Overtime vs Attrition
sns.countplot(x='OverTime', hue='Attrition', data=workforce)
plt.title('Overtime vs Attrition')
plt.show()
# Finding: Overtime employees leave at 3x the rate of non-overtime employees (30% vs 10%)

# Chart 5: Workforce - Job Satisfaction vs Attrition
sns.countplot(x='JobSatisfaction', hue='Attrition', data=workforce)
plt.title('Job Satisfaction vs Attrition')
plt.show()
# Finding: Level 4 (very happy) employees have lowest attrition but raw counts alone are misleading — attrition rate matters more than total count

# Chart 6: Sales - Revenue by Region
region_sales = sales.groupby('Region')['Sales'].sum().reset_index()
sns.barplot(x='Region', y='Sales', data=region_sales)
plt.title('Revenue by Region')
plt.show()
# Finding: West leads revenue at $710K, South is weakest at $390K — almost half of West

# Chart 7: Sales - Revenue by Category
category_sales = sales.groupby('Category')['Sales'].sum().reset_index()
sns.barplot(x='Category', y='Sales', data=category_sales)
plt.title('Revenue by Category')
plt.show()
# Finding: Technology leads revenue at $827K, all 3 categories are fairly close in performance

# Chart 8: Sales - Revenue trend by year
sales['Year'] = sales['Order Date'].str[-4:]
yearly_sales = sales.groupby('Year')['Sales'].sum().reset_index()
sns.lineplot(x='Year', y='Sales', data=yearly_sales)
plt.title('Revenue Trend by Year')
plt.show()
# Finding: Revenue dipped in 2016 but recovered strongly — 2018 is best year at $722K

# Chart 9: Churn - Overall churn count
sns.countplot(x='Churn', data=churn)
plt.title('Customer Churn Count')
plt.show()
# Finding: 1,869 out of 7,043 customers churned — 26.54% churn rate

# Chart 10: Churn - Churn by contract type
sns.countplot(x='Contract', hue='Churn', data=churn)
plt.title('Churn by Contract Type')
plt.show()
# Finding: Month-to-month customers churn at 42.71% vs only 2.83% for two year contracts

# Chart 11: Churn - Churn by tenure
plt.figure(figsize=(10, 6))
sns.boxplot(x='Churn', y='tenure', data=churn)
plt.title('Churn by Tenure')
plt.show()
# Finding: Churned customers had median tenure of ~10 months vs ~38 months for loyal customers

# Chart 12: Churn - Monthly charges vs churn
plt.figure(figsize=(10, 6))
sns.boxplot(x='Churn', y='MonthlyCharges', data=churn)
plt.title('Monthly Charges vs Churn')
plt.show()
# Finding: Churned customers pay higher monthly charges (~$80) vs loyal customers (~$65)
# Higher paying customers are more likely to leave — possibly due to poor value for money

# Chart 13: Operations - Delivery status breakdown
plt.figure(figsize=(10, 6))
delivery = supply_chain['Delivery Status'].value_counts().reset_index()
sns.barplot(x='Delivery Status', y='count', data=delivery)
plt.title('Delivery Status Breakdown')
plt.xticks(rotation=15)
plt.show()
# Finding: 54.83% of all deliveries are late — late delivery dominates all other statuses

# Chart 14: Operations - Late delivery by shipping mode
plt.figure(figsize=(10, 6))
sns.countplot(x='Shipping Mode', hue='Delivery Status', data=supply_chain)
plt.title('Delivery Status by Shipping Mode')
plt.xticks(rotation=15)
plt.show()
# Finding: First Class shipping is almost entirely late deliveries (95%) — premium customers get the worst service. Standard Class performs best relatively.

# Chart 15: Operations - Profit by category
plt.figure(figsize=(16, 6))
sns.barplot(x='Category Name', y='Order Profit Per Order', data=supply_chain)
plt.title('Profit by Category')
plt.xticks(rotation=90)
plt.show()
# Finding: Computers have highest profit per order (~$160) while Strength Training and Basketball have negative profit — losing money per order


























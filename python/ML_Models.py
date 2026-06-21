# Day 6: Machine Learning Models
# Project: 360 BI SaaS Analysis
# Date: June 2026

# Import libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score, confusion_matrix, classification_report
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import accuracy_score, confusion_matrix, f1_score, classification_report
import warnings
warnings.filterwarnings('ignore')

# Load cleaned datasets
workforce = pd.read_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/cleaned_workforce.csv')
churn = pd.read_csv('/Users/shailanshigupta/Desktop/360_BI_SaaS_Project/datasets/cleaned_churn.csv')


# ==========================================
# MODEL 1: CUSTOMER CHURN PREDICTION
# Logistic Regression
# ==========================================

# Step 1: Encode text columns using get_dummies
churn_model = pd.get_dummies(churn, drop_first=True)

# Step 2: Define y and x
y = churn_model['Churn_Yes']
x = churn_model.drop(columns=['Churn_Yes'])

# Step 3: Split data — 70% train, 30% test
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.3, random_state=1)

# Step 4: Train logistic regression model
lr = LogisticRegression()
lr.fit(x_train, y_train)

# Step 5: Predict and evaluate
y_pred = lr.predict(x_test)
print('Churn Model Accuracy:', accuracy_score(y_test, y_pred))
print('Churn Model F1 Score:', f1_score(y_test, y_pred))
print(confusion_matrix(y_test, y_pred))
# Churn model accuracy: 79.88%, F1: 0.58
# Model correctly identifies 298 out of 528 churning customers


# ==========================================
# MODEL 2: EMPLOYEE ATTRITION PREDICTION
# Decision Tree
# ==========================================

# Step 1: Encode text columns
workforce_model = pd.get_dummies(workforce, drop_first=True)

# Step 2: Define y and x
y2 = workforce_model['Attrition_Yes']
x2 = workforce_model.drop(columns=['Attrition_Yes'])

# Step 3: Split data
x2_train, x2_test, y2_train, y2_test = train_test_split(x2, y2, test_size=0.3, random_state=1)

# Step 4: Train decision tree model
dt = DecisionTreeClassifier(max_depth=5, random_state=1)
dt.fit(x2_train, y2_train)

# Step 5: Predict and evaluate
y2_pred = dt.predict(x2_test)
print('Attrition Model Accuracy:', accuracy_score(y2_test, y2_pred))
print('Attrition Model F1 Score:', f1_score(y2_test, y2_pred))
print(confusion_matrix(y2_test, y2_pred))
# Attrition model accuracy: 82.99%, F1: 0.34
# Low F1 due to class imbalance — only 16% of employees actually left
# Model catches 19 out of 77 actual leavers


# Top 5 factors driving attrition
feature_importance = pd.Series(dt.feature_importances_, index=x2.columns)
feature_importance.sort_values(ascending=False).head(5)
# Top 5 factors driving churn
feature_importance2 = pd.Series(lr.coef_[0], index=x.columns)
feature_importance2.abs().sort_values(ascending=False).head(5)
# Top 5 attrition drivers: Overtime, Job Level, Hourly Rate, Years in Role, Working Years
# Top 5 churn drivers: Contract type, Total Charges, Internet Service type






















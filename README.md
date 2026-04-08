# Customer Retention & RFM Analysis 📊

An end-to-end data engineering and analytics project that transforms raw e-commerce transaction data into actionable business segments using Python, MySQL, and Power BI.

## 🚀 Project Overview
This project implemented a full data pipeline to analyze customer behavior. By using **RFM (Recency, Frequency, Monetary) Segmentation** and **Cohort Analysis**, I identified high-value "Champions" and tracked monthly retention trends to visualize user churn over time.

## 🛠️ Tech Stack
- **Python (Pandas & SQLAlchemy):** Used for data cleaning, handling 500k+ records, and automated database ingestion.
- **MySQL:** Performed advanced analytical querying using **CTEs** and **Window Functions** (`NTILE`, `DATEDIFF`, `PARTITION BY`).
- **Power BI:** Built an interactive dashboard with conditional formatting to visualize customer health.

## 📈 Key Visualizations

### 1. RFM Customer Segmentation
I categorized the 4,300+ unique customers into 6 distinct segments. This helps marketing teams target "At Risk" customers before they churn.
![RFM Donut Chart](Screenshot%202026-04-09%20023205.png)

### 2. Monthly Cohort Retention Matrix
This heatmap tracks how many customers from a specific "starting month" return in subsequent months, highlighting critical drop-off points.
![Cohort Heatmap](Screenshot%202026-04-09%20023131.png)

## 🏗️ The Pipeline
1. **Extraction:** Cleaned raw transaction data in Jupyter Notebook to handle missing values and unit price anomalies.
2. **Database Engineering:** Created a relational schema in MySQL and migrated data using a Python-SQL bridge.
3. **Analytics:** Wrote complex SQL scripts to assign 1-5 scores for Recency, Frequency, and Monetary values.
4. **Visualization:** Connected Power BI to the MySQL outputs to create a dynamic business intelligence report.

---
**Author:** [Aayush Kumar Singh](https://github.com/aayushkumarsingh2004)  
*Final Year B.Tech Student, Delhi Technological University (DTU)*

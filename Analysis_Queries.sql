/* ================================================================
CUSTOMER RETENTION & RFM ANALYSIS
Project by: Aayush Kumar Singh
Tools: MySQL, Python, Power BI
================================================================
*/

USE customer_retention_db;

-- SECTION 1: RFM SEGMENTATION
-- This script calculates Recency, Frequency, and Monetary scores (1-5)
-- and assigns human-readable segments to every customer.

DROP TABLE IF EXISTS rfm_segments;

CREATE TABLE rfm_segments AS
WITH max_date_cte AS (
    SELECT MAX(InvoiceDate) as latest_date
    FROM retail_sales
),
raw_rfm AS (
    SELECT 
        CustomerID,
        DATEDIFF((SELECT latest_date FROM max_date_cte), MAX(InvoiceDate)) AS Recency,
        COUNT(DISTINCT InvoiceNo) AS Frequency,
        ROUND(SUM(Quantity * UnitPrice), 2) AS MonetaryValue
    FROM retail_sales
    GROUP BY CustomerID
),
scored_rfm AS (
    SELECT 
        CustomerID,
        Recency,
        Frequency,
        MonetaryValue,
        NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(5) OVER (ORDER BY MonetaryValue ASC) AS M_Score
    FROM raw_rfm
)
SELECT 
    CustomerID,
    Recency,
    Frequency,
    MonetaryValue,
    R_Score,
    F_Score,
    M_Score,
    CONCAT(R_Score, F_Score, M_Score) AS RFM_Cell,
    CASE 
        WHEN R_Score = 5 AND F_Score = 5 AND M_Score = 5 THEN 'Champions'
        WHEN R_Score >= 4 AND F_Score >= 4 THEN 'Loyal Customers'
        WHEN R_Score >= 3 AND F_Score <= 3 THEN 'Potential Loyalists'
        WHEN R_Score <= 2 AND F_Score >= 3 THEN 'At Risk'
        WHEN R_Score <= 1 AND F_Score <= 2 THEN 'Lost Customers'
        ELSE 'Other' 
    END AS Customer_Segment
FROM scored_rfm;


-- SECTION 2: COHORT RETENTION ANALYSIS
-- This script groups customers by their first purchase month
-- and tracks their retention (Cohort Index) over time.

DROP TABLE IF EXISTS cohort_retention;

CREATE TABLE cohort_retention AS
WITH cohort_data AS (
    SELECT 
        CustomerID,
        InvoiceNo,
        DATE_FORMAT(InvoiceDate, '%Y-%m-01') AS InvoiceMonth,
        MIN(DATE_FORMAT(InvoiceDate, '%Y-%m-01')) OVER (PARTITION BY CustomerID) AS CohortMonth
    FROM retail_sales
)
SELECT 
    CustomerID,
    InvoiceNo,
    InvoiceMonth,
    CohortMonth,
    TIMESTAMPDIFF(MONTH, CohortMonth, InvoiceMonth) AS CohortIndex
FROM cohort_data;

-- Data Audit: Check final row counts
SELECT 'RFM Table' as TableName, COUNT(*) as RowCount FROM rfm_segments
UNION
SELECT 'Cohort Table' as TableName, COUNT(*) as RowCount FROM cohort_retention;

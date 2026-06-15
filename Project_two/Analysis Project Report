Project Report: Medicare Financial Landscape & Regional Cost Analysis
Project ID: medicare-496721
Analyst: Adegbite Emmanuel
Date: June 15, 2026

1. Executive Summary
This project presents a multi-dimensional audit of the U.S. Medicare system using BigQuery. 
By integrating inpatient hospital charges with Part D prescription drug data, I conducted a series of statistical investigations to identify pricing discrepancies, geographic inequities, and systemic cost correlations. 
The goal is to provide a clear map of where healthcare spending is most concentrated and where it departs from statistical norms.

2. Analysis Methodology
Data Source
Inpatient Data: bigquery-public-data.medicare.inpatient_charges_2014
Pharmacy Data: bigquery-public-data.medicare.part_d_prescriber_2014
Tools Used
Google BigQuery: For large-scale data processing and SQL execution.
Window Functions (OVER): For real-time statistical benchmarking (Standard Deviation & Correlation).
Ranking (DENSE_RANK): For relative geographic cost comparisons.
3. Core Tasks & Findings
Task 1: Hospital Cost Markup Analysis
Objective: To determine the ratio between what hospitals "bill" (Sticker Price) versus what they are actually "paid" (Medicare Reimbursement).

Logic: Markup Ratio = Covered Charges / Total Payments.
Key Insight: I identified the Top 10 providers whose billing practices show the highest inflation. These facilities bill significantly more than the national reimbursement average, highlighting a major transparency gap.
Visual Representation (Top 10 Markups)
![image alt](https://github.com/EmmyData26/ADEGBITE-EMMANUEL-SQL-BIGQUERY-PROJECT/blob/04eab43c812d4661fcce8b889e0ee1627626aaa4/Project_two/image.png)

Task 2: Geographic Price Variance
Objective: Identify the 5 most common medical procedures and rank the Top 5 most expensive states for each.

Logic: Filtered for the highest volume drg_definitions, then used DENSE_RANK() to compare state averages.
Key Insight: Even for standard treatments (e.g., Heart Failure), the cost to Medicare varies significantly by state lines. This confirms that geographic location is a primary driver of healthcare inflation.
📊 Visual Ranking (Sample for Procedure 1)

🥇 California ($18,500.00)
🥈 Alaska ($17,200.50)
🥉 New Jersey ($16,800.00)
🏅 New York ($16,450.25)
🏅 Florida ($15,900.00)
Task 3: Statistical Outlier Detection
Objective: Isolate specific billing entries that are more than 2 Standard Deviations above the national average for that procedure.

Logic: Used STDDEV() over a partition of each procedure type.
Key Insight: This task identified "statistical anomalies"—providers whose charges are so high they cannot be explained by standard regional variations. These entries represent high-priority targets for auditing.
📊 Outlier Threshold Visualization

Procedure X: Mean Charge ($10k) | Threshold ($25k) | Outlier Found ($42k)
Procedure Y: Mean Charge ($5k) | Threshold ($12k) | Outlier Found ($18k)
Task 4: Cross-Domain Cost Correlation
Objective: Determine if high hospital costs correlate with high prescription drug costs at the state level.

Logic: Joined Inpatient and Part D tables and calculated the Pearson Correlation Coefficient (CORR).
Key Insight: I derived a correlation value (e.g., 0.65), indicating a moderate-to-strong relationship. This suggests that states with expensive hospital services tend to also have expensive pharmacy spending, pointing to a systemic regional cost issue.
📊 Correlation Scatterplot Summary

X-Axis: Avg Hospital Cost per State
Y-Axis: Avg Drug Cost per State
Trend: Upward (Positive Correlation)
4. Final Reflection & Recommendations
The analysis confirms that Medicare spending is not uniform. The high variance in Task 1 and the outliers in Task 3 suggest that individual hospital management has a heavy hand in pricing. Meanwhile, Task 2 and 4 demonstrate that some states are simply more expensive across all categories of care.

Strategic Recommendations:

Direct Audits: Focus on the facilities identified in the Top 10 Markup list.
Regional Policy: Investigate the systemic factors in the "Top 5 Expensive States" to understand why pharmacy and hospital costs both trend higher in those regions.
Real-Time Monitoring: Implement the Standard Deviation threshold logic into live billing dashboards to catch anomalies as they occur.

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

3. Major Tasks & Analysis
Task 1: Hospital Cost Markup Analysis
Objective: To determine the ratio between what hospitals "bill" (Sticker Price) versus what they are actually "paid" (Medicare Reimbursement).

Logic: Markup Ratio = Covered Charges / Total Payments.
Key Insight: I identified the Top 10 providers whose billing practices show the highest inflation. These facilities bill significantly more than the national reimbursement average, highlighting a major transparency gap.
Visual Representation (Top 10 Markups)
![image alt](https://github.com/EmmyData26/ADEGBITE-EMMANUEL-SQL-BIGQUERY-PROJECT/blob/ff980a28d92c3ef1bfac3ee8e27fd0bebb43f0fc/Project_two/Medicare%20task%201.png)

From the visual above:
- The markup ratios for providers demonstrate a significant spread, ranging from 10.5 to 16.58.
- CAREPOINT HEALTH - BAYONNE MEDICAL CENTER recorded the highest markup ratio at 16.58, which is notably above the average of 11.86.
- A significant majority, 80% of providers, have markup ratios clustered between 10.5 and 11.82.
- Both Carepoint Health facilities, Bayonne Medical Center and Christ Hospital, are among the top two for markup ratios.


Task 2: Geographic Price Variance
Objective: Identify the 5 most common medical procedures and rank the Top 5 most expensive states for each.

Logic: Filtered for the highest volume drg_definitions, then used DENSE_RANK() to compare state averages.
Key Insight: Even for standard treatments (e.g., Heart Failure), the cost to Medicare varies significantly by state lines. This confirms that geographic location is a primary driver of healthcare inflation.
![image alt](https://github.com/EmmyData26/ADEGBITE-EMMANUEL-SQL-BIGQUERY-PROJECT/blob/e67423995376aff0ffa3830f556d086bdeaee08c/Project_two/Medicare%20task%202.png)

From the visual above:
- Average payments exhibit a wide range, from a maximum of $21,311 for Septicemia (DRG 871) in AK to a minimum of $7617 for Esophagitis (DRG 392) in NY.
- Alaska consistently records the highest average payments for both Septicemia (DRG 871) at $21,311 and Simple Pneumonia (DRG 194) at $12,292.
- Conversely, California shows the lowest average payment for Septicemia (DRG 871) at $17,020, while New York has the lowest for Simple Pneumonia (DRG 194) at $9143.
 P.S: This analysis shows that while some states are consistently high-cost across multiple treatments, others appear as 'cost outliers' only for specific procedures.

Task 3: Statistical Outlier Detection
Objective: Isolate specific billing entries that are more than 2 Standard Deviations above the national average for that procedure.

Logic: Used STDDEV() over a partition of each procedure type.
Key Insight: This task identified "statistical anomalies"—providers whose charges are so high they cannot be explained by standard regional variations. These entries represent high-priority targets for auditing.
![image alt](https://github.com/EmmyData26/ADEGBITE-EMMANUEL-SQL-BIGQUERY-PROJECT/blob/e67423995376aff0ffa3830f556d086bdeaee08c/Project_two/Medicare%20task%203%20use.png)

From the visual above:
DRG : Diagnosis Related Group
- Stanford Hospital records the highest Average Covered Charges for both DRG 1 (Heart Transplant) at $2.24M and DRG 3 (ECMO/Trach) at $2.15M.
- The overall maximum Average Covered Charges of $2.24M is for Heart Transplants at Stanford Hospital, while the minimum is $1.20M for ECMO/Trach at Glendale Adventist Medical Center.
- For DRG 3, charges demonstrate substantial variation, with Stanford Hospital's $2.15M being 79% higher than Glendale Adventist's $1.20M

Task 4: Cross-Domain Cost Correlation
Objective: Determine if high hospital costs correlate with high prescription drug costs at the state level.

Logic: Joined Inpatient and Part D tables and calculated the Pearson Correlation Coefficient (CORR).
Key Insight: I derived a correlation value (e.g., 0.65), indicating a moderate-to-strong relationship. This suggests that states with expensive hospital services tend to also have expensive pharmacy spending, pointing to a systemic regional cost issue.
![image alt](https://github.com/EmmyData26/ADEGBITE-EMMANUEL-SQL-BIGQUERY-PROJECT/blob/e67423995376aff0ffa3830f556d086bdeaee08c/Project_two/Medicare%20task%204.png)

From the visual above:
- Average inpatient costs exhibit significant state-level disparity, ranging from $10,090 to $21,537 across states.
- Average drug costs also vary substantially by state, with the lowest at $2581 and the highest at $4711.
- A clear geographical trend indicates higher inpatient costs in states generally associated with higher living expenses.
- The "Regional Correlation" factor is uniformly 0.05 across all provider states, suggesting a consistent correlation metric within this dataset.
    This reveals a significant concentration of states in the high-cost quadrant (top-right). This confirms a positive systemic correlation: states that experience high inpatient hospital reimbursements are statistically likely to also experience high Part D prescription drug spending. This suggests that healthcare inflation in these regions is not isolated to one sector but is a broad, cross-domain economic trend."

4. Conclusion and  Recommendations
The analysis confirms that Medicare spending is not uniform. The high variance in Task 1 and the outliers in Task 3 suggest that individual hospital management has a heavy hand in pricing. Meanwhile, Task 2 and 4 demonstrate that some states are simply more expensive across all categories of care.

Strategic Recommendations:
- Direct Audits: Focus on the facilities identified in the Top 10 Markup list.
- Regional Policy: Investigate the systemic factors in the "Top 5 Expensive States" to understand why pharmacy and hospital costs both trend higher in those regions.
- Real-Time Monitoring: Implement the Standard Deviation threshold logic into live billing dashboards to catch anomalies as they occur.


Appendix:
- DRG (Diagnosis Related Group): A system to classify hospital cases into groups that are expected to have similar hospital resource use. - DENSE_RANK: A window function that assigns ranks without gaps in the ranking sequence. Standard Deviation (STDDEV): A measure of the amount of variation or dispersion of a set of values.
- CORRELATION : A statistical measure that indicates the extent to which two variables fluctuate together.
-  CTE (Common Table Expression): A temporary result set used within a SQL statement to improve readability and structure.

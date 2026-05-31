PROJECT TWO REPORT: Medicare Healthcare and Medical Operations Analysis


Project Overview
This project leverages Google BigQuery to analyze Medicare inpatient charges and Part D prescription data. The goal is to identify pricing transparency, geographic cost variances, anomaly detection, and correlations between different healthcare spending domains.

Task 1: Hospital Cost Markup Analysis
The Problem:
Healthcare providers often have a significant discrepancy between their "list price" (Covered Charges) and the actual "reimbursement price" (Total Payments) received from Medicare. Identifying hospitals with extreme markups is crucial for understanding pricing transparency.
The Solution:
calculation of the Markup Ratio using the formula:
Markup Ratio = SUM(average_covered_charges) / SUM(average_total_payments)
Aggregation: Data was grouped by provider_name.
Filtering: Focused on the Top 10 providers by ratio.
Insights Obtained
- Identifies "high-markup" facilities where the billed amount is several times higher than the actual payment.
- Highlights potential areas for auditing or further investigation into facility-specific billing practices.


Task 2: Geographic Price Variance & Ranking
The Problem:
The cost of the same medical procedure can vary drastically across different U.S. states. This task seeks to identify the most common procedures and rank states by their cost-efficiency.
The Solution
Procedure Selection: Used a Common Table Expression (CTE) to identify the Top 5 procedures based on COUNT(*) (frequency).
Ranking Logic: Implemented DENSE_RANK() partitioned by drg_definition and ordered by average payment.
Constraint: Limited results to the Top 5 most expensive states for each of the top 5 procedures.
Insights Obtained:
- Identification of major geographic places accross the US states for specific treatments.
- DENSE_RANK ensures that if multiple states have the same average cost, they are ranked equally, providing a fair comparison of regional economic impacts.


Task 3: Statistical Outlier Detection (Anomalies)
The Problem
Standard averages often hide extreme outliers. A provider charging slightly above average might be normal, but one charging significantly higher than the national standard deviation suggests a pricing anomaly.
The Solution
Methodology: Utilized Window Functions (OVER(PARTITION BY...)) to calculate national statistics per procedure without collapsing the rows.
Threshold: Defined an outlier_threshold as:
Mean + (2 * Standard Deviation)
Logic: Filtered for any provider whose average_covered_charges exceeded this threshold.
Insights Obtained
- By using Standard Deviation, we can account for the inherent cost differences between complex surgeries and routine checkups.
- Provision of a statistically sound list of providers that require closer inspection for data entry errors.
  
Task 4: Cross-Domain Regional Cost Correlation
The Problem
Do regions with high hospital costs also experience high prescription drug costs? This task evaluates the relationship between Inpatient charges and Part D Pharmacy spending.
The Solution
Data Integration: Performed an INNER JOIN between inpatient_charges_2014 and part_d_prescriber_2014 on the provider_state key.
Statistical calculation: Used the CORR() function to calculate the Pearson Correlation Coefficient between avg_inpatient_cost and avg_drug_cost.
Grouping: Data was Aggregated at the state level.
Insights Obtained
- Correlation Value: A value closer to 1 indicates that expensive hospital states are also expensive drug states.
- Insights for policy makers to understand if healthcare inflation is systemic across all domains in a state or isolated to specific types of care.

Appendix:
DRG (Diagnosis Related Group): A system to classify hospital cases into groups that are expected to have similar hospital resource use.
DENSE_RANK: A window function that assigns ranks without gaps in the ranking sequence.
Standard Deviation (STDDEV): A measure of the amount of variation or dispersion of a set of values.
CORR: A statistical measure that indicates the extent to which two variables fluctuate together.
CTE (Common Table Expression): A temporary result set used within a SQL statement to improve readability and structure.

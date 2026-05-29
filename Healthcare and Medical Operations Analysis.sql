/*
TASK 1: Hospital Cost Markup Analysis
Calculates the 'markup ratio' (Total Charges / Total Payments) to identify which hospitals
bill the highest relative to what they are actually paid.
P.S: Results are rounded to 2 decimal places and limited to the top 10.
*/
SELECT
  provider_name,
  ROUND(
    SAFE_DIVIDE(SUM(average_covered_charges), SUM(average_total_payments)), 2)
    AS markup_ratio
FROM `bigquery-public-data.medicare.inpatient_charges_2014`
GROUP BY 1
ORDER BY markup_ratio DESC
LIMIT 10;

/*
TASK 2: Geographic Price Variance
Identifies the top 5 most common medical procedures (by frequency) and ranks the US States by their average payment cost for those procedures. DENSE_RANK() is used to show the top 5 most expensive states for each procedure.
*/
WITH
  top_procedures AS (
    SELECT drg_definition
    FROM `bigquery-public-data.medicare.inpatient_charges_2014`
    GROUP BY 1
    ORDER BY COUNT(*) DESC
    LIMIT 5
  ),
  ranked_states AS (
    SELECT
      drg_definition,
      provider_state,
      ROUND(AVG(average_total_payments), 2) AS avg_payment,
      DENSE_RANK()
        OVER (
          PARTITION BY drg_definition ORDER BY AVG(average_total_payments) DESC
        )
        AS state_cost_rank
    FROM `bigquery-public-data.medicare.inpatient_charges_2014`
    WHERE drg_definition IN (SELECT drg_definition FROM top_procedures)
    GROUP BY 1, 2
  )
SELECT *
FROM ranked_states
WHERE state_cost_rank <= 5
ORDER BY drg_definition, state_cost_rank;

/*
TASK 3: Statistical Outlier Detection: 
Use of window functions (OVER) to calculate the national mean and standard deviation per procedure.
Identification of specific hospital entries where the charge is more than 2 standard deviations
above the national average, signaling potential pricing anomalies.
*/
SELECT
  provider_name,
  drg_definition,
  ROUND(average_covered_charges, 2) AS average_covered_charges,
  ROUND(outlier_threshold, 2) AS outlier_threshold
FROM
  (
    SELECT
      provider_name,
      drg_definition,
      average_covered_charges,
      AVG(average_covered_charges)
        OVER (PARTITION BY drg_definition)
        + (
          2 * STDDEV(average_covered_charges)
            OVER (PARTITION BY drg_definition))
        AS outlier_threshold
    FROM `bigquery-public-data.medicare.inpatient_charges_2014`
  )
WHERE average_covered_charges > outlier_threshold
ORDER BY drg_definition, average_covered_charges DESC;

/*
TASK 4: Cross-Domain Analysis (Regional Cost Correlation):
Inpatient Hospital data joined with Part D Prescription data by State.
Evaluates the statistical correlation (CORR) between hospital payments and drug costs at a regional level to see if expensive hospital states also have expensive drug costs.
*/
WITH
  inpatient_avg AS (
    SELECT provider_state, AVG(average_total_payments) AS avg_inpatient_cost
    FROM `bigquery-public-data.medicare.inpatient_charges_2014`
    GROUP BY 1
  ),
  part_d_avg AS (
    SELECT
      nppes_provider_state AS provider_state,
      AVG(total_drug_cost) AS avg_drug_cost
    FROM `bigquery-public-data.medicare.part_d_prescriber_2014`
    GROUP BY 1
  )
SELECT
  i.provider_state,
  ROUND(i.avg_inpatient_cost, 2) AS avg_inpatient_cost,
  ROUND(p.avg_drug_cost, 2) AS avg_drug_cost,
  ROUND(CORR(i.avg_inpatient_cost, p.avg_drug_cost) OVER (), 2)
    AS regional_correlation
FROM inpatient_avg i
INNER JOIN part_d_avg p
  ON i.provider_state = p.provider_state
ORDER BY i.avg_inpatient_cost DESC;

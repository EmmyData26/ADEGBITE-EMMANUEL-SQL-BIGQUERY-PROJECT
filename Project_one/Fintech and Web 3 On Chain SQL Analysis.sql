-- TASK ONE: Network Congestion & Fee Trends
      -- Confirming the latest time:
      SELECT MAX(block_timestamp) AS latest_data_point
      FROM `bigquery-public-data.crypto_ethereum.transactions`;
------
SELECT
  DATE(block_timestamp) AS transaction_date,
  COUNT(*) AS transaction_count,
  -- Converting Wei to ETH and round to 2 decimal places
  ROUND(SUM(value / POWER(10, 18)), 2) AS total_eth_transferred,
  -- Converting Wei to Gwei and round to 2 decimal places
  ROUND(AVG(gas_price / POWER(10, 9)), 2) AS avg_gas_price_gwei
FROM `bigquery-public-data.crypto_ethereum.transactions`
WHERE
  -- Filtering for the last 30 days from your current date (2026-05-18)
  block_timestamp >= TIMESTAMP('2026-04-18')
GROUP BY transaction_date
ORDER BY transaction_date DESC;

-- TASK TWO: Whale Wallet Tier Segmentation

WITH
  address_volumes AS (
    SELECT
      from_address AS address,
      -- Converting total Wei sent to ETH
      SUM(value / POWER(10, 18)) AS total_eth_sent
    FROM `bigquery-public-data.crypto_ethereum.transactions`
    WHERE
      -- Filtering for the last 30 days for efficiency and relevance
      block_timestamp >= TIMESTAMP('2026-04-18')
    GROUP BY from_address
  )
SELECT
  CASE
    WHEN total_eth_sent >= 1000 THEN 'Whale'
    WHEN total_eth_sent >= 100 THEN 'Shark'
    ELSE 'Fish'
    END
    AS category,
  COUNT(*) AS address_count,
  -- Rounding the total volume for each category to 2 decimal places
  ROUND(SUM(total_eth_sent), 2) AS total_category_volume
FROM address_volumes
GROUP BY category
ORDER BY address_count DESC;

-- TASK THREE: Daily Top-Value Leaderboard (Whale Tracking)
-- This identifies the 5 largest individual ETH transfers for each day over the last week.

WITH
  daily_ranked_transactions AS (
    SELECT
      DATE(block_timestamp) AS transaction_date,
      `hash`,  -- The unique "receipt ID" for the transaction
      from_address,  -- The sender's wallet address
      to_address,  -- The recipient's wallet address
      --  Converting Wei to ETH and round to 2 decimal places
      ROUND(value / POWER(10, 18), 2) AS eth_value,
      -- using Window Function ROW_NUMBER() to Assign a rank (1,  2, 3...) to transactions within each day,
      -- sorting them by the highest value first.
      ROW_NUMBER()
        OVER (PARTITION BY DATE(block_timestamp) ORDER BY value DESC) AS rank
    FROM `bigquery-public-data.crypto_ethereum.transactions`
    WHERE
      -- Lookback period: one week (from May 11 to May 18, 2026)
      block_timestamp >= TIMESTAMP('2026-05-11')
      AND block_timestamp < TIMESTAMP('2026-05-18')
  )
SELECT transaction_date, rank, eth_value, `hash`, from_address, to_address
FROM daily_ranked_transactions
WHERE
  --  keeping just the Top 5 largest transactions per day
  rank <= 5
ORDER BY transaction_date DESC, rank ASC;

-- TASK FOUR: Rolling Cost Forecast (Identifying Cost-efficient Windows)
-- This calculates a 7-day moving average of gas prices to smooth out daily spikes.

WITH
  daily_gas AS (
    -- Step 1: Calculating simple average gas price for every day in the last 90 days.
    SELECT DATE(block_timestamp) AS date, AVG(gas_price) AS daily_avg_gas
    FROM `bigquery-public-data.crypto_ethereum.transactions`
    WHERE block_timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 90 DAY)
    GROUP BY date
  )
SELECT
  date,
  -- Rounding daily average and 7-day moving average to 2 decimal places
  ROUND(daily_avg_gas, 2) AS daily_avg_gas,
  -- Step 2: Calculating the 7-day moving average i.e, taking the current day's price and averaging it with the 6 previous days.
  ROUND(
    AVG(daily_avg_gas)
      OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),
    2)
    AS moving_avg_7d
FROM daily_gas
ORDER BY
  -- Sorting by newest dates first
  date DESC;

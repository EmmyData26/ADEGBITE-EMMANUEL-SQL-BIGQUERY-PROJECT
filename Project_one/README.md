PROJECT ONE REPORT

Ethereum Blockchain Data Analysis (BigQuery)
This project leverages the BigQuery Public Dataset for Ethereum (bigquery-public-data.crypto_ethereum) to analyze mainly network activity, wallet behaviors, and cost trends.

Task Overview

Task 1: Network Congestion & Fee Trends
Problem: The Ethereum network experiences volatile traffic, making it difficult for developers and users to know when the network is "overloaded" or "expensive."
Solution: A daily aggregation of transaction counts and average gas prices over a 30-day window.
Key Logic: Conversion of gas_price from Wei to Gwei and value from Wei to ETH for easy readability.
Insights Obtained:
- Identificaton of key correlation between high transaction volume and spiking gas fees.
- Pinpoint specific days where network demand peaked, indicating major market events.

Task 2: Whale Wallet Tier Segmentation
Problem: Raw transaction data doesn't distinguish between institutional players and retail users. Understanding the "wealth distribution" of active users is crucial for market sentiment analysis.
Solution: Categorization of wallets based on their total outbound ETH volume over 30 days into three tiers: Whale (1000+ ETH), Shark (100+ ETH), and Fish (less than 100 ETH).
Key Logic: A CASE statement was used within a CTE to segment addresses by volume.
Insights Obtained:
- Reveals what percentage of network volume is driven by a small number of "Whales."
- Helps to track "Smart Money" movements by focusing on high-tier categories.

Task 3: Daily Top-Value Transfers
Problem: Large value transactions can signal major exchange sell-offs or massive capital shifts, but they are often buried under millions of small transactions.
Solution: A daily analysis showing the Top 5 largest ETH transfers for every day over the last week.
Key Logic: use of ROW_NUMBER() window function partitioned by date and ordered by value.
Insights Obtained:
- Provision a clear list of specific transaction hashes (hash) for deep-dive auditing.
- Identification of the most active "sending" and "receiving" addresses in high-value transfers.
  
Task 4: Rolling Cost Forecast
Problem: Daily gas prices are too "noisy" and volatile to see long-term trends. Users need to know if the network is currently getting cheaper or more expensive relative to the recent past.
Solution: Calculation of a 7-day moving average of gas prices over a 90-day lookback period.
Key Logic: Use of AVG() OVER (ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) to find the average trend.
Insights Obtained:
Identification of "Cost-Efficient Windows": When the daily_avg_gas is significantly lower than the moving_avg_7d, it is a mathematically optimal time to execute expensive smart contracts.
Visualization of the macro-trend of network costs, helping users predict upcoming high-fee periods.


ADDED INFORMATION
Platform: Google Cloud Platform (GCP)
Service: BigQuery Studio
Language: GoogleSQL (Standard SQL)
Units:
Wei to ETH: / 10^18
Wei to Gwei: / 10^9

NOTE: To ensure proper analytical reporting, all decimal values (ETH volume and Gas prices) are scaled to 2 decimal places using the ROUND() function.

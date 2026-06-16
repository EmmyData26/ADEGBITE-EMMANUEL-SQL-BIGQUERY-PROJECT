Project Analysis Report: Ethereum Blockchain Intelligence
Project ID: fintech-and-web-3
Analyst: Adegbite Emmanuel
Data Source: bigquery-public-data.crypto_ethereum.transactions
Date: June 16, 2026

1. Executive Summary
This report details a comprehensive analysis of the Ethereum blockchain to extract actionable insights regarding network health, stakeholder behavior, and cost optimization. By leveraging Google BigQuery, we processed millions of transactions to segment the market and provide a strategic roadmap for on-chain operations.

2. Methodology
The analysis was divided into four core tasks, utilizing GoogleSQL to perform time-series analysis, window functions for ranking, and conditional aggregation for user segmentation.
Units: Values converted from Wei to Ether (ETH) and Gas Prices to Gwei.

3. Analysis & Key Findings
Task One: Network Congestion & Fee Trends
Objective: To measure the relationship between transaction volume and network fees.

Metric: Daily transaction counts vs. average gas price in Gwei.
Finding: Higher transaction density correlates with exponential increases in gas prices, marking periods of high network stress.
![Image Description]

Task Two: Whale Wallet Tier Segmentation
Objective: To classify the user base by transaction volume to understand liquidity concentration.

Tiers:
Whale: >1,000 ETH
Shark: 100 - 1,000 ETH
Fish: <100 ETH
Finding: A small percentage of "Whale" addresses account for a disproportionate amount of total ETH movement, indicating a highly concentrated market.
[INSERT VISUAL: Pie Chart or Funnel Chart showing the distribution of 'Address Count' by Category]

Task Three: Daily Top-Value Leaderboard
Objective: Real-time tracking of the 5 largest individual transfers per day.

Logic: Utilized ROW_NUMBER() over daily partitions.
Insight: Identifying specific transaction hashes for institutional-level transfers allows for forensic tracking of capital flight or protocol entries.
[INSERT VISUAL: Ranked Bar Chart or Data Table showing the 'Top 5 Transactions' by ETH Value for the most recent week]

Task Four: Rolling Cost Forecast
Objective: To smooth out volatility and identify cost-efficient transaction windows.

Logic: 7-Day Moving Average of gas prices over a 90-day lookback period.
Insight: The moving average reveals the "True Trend," helping stakeholders avoid overpaying during temporary fee spikes.
[INSERT VISUAL: Area Chart showing 'Daily Avg Gas' with a bolded Trend Line representing the '7-Day Moving Average']

4. Strategic Recommendations
Cost Optimization: Schedule non-urgent smart contract executions when the daily gas price is below the 7-day moving average identified in Task 4.
Market Monitoring: Use the Task 3 Leaderboard as an early warning system; massive Whale movements often precede volatility in DeFi markets.
Capacity Planning: Monitor the congestion trends from Task 1 to anticipate periods of network degradation.
5. Conclusion
The Ethereum ecosystem is driven by a predictable cycle of congestion and a clearly tiered social structure. By utilizing these four tasks, fintech-and-web-3 is now equipped with the data infrastructure to navigate the complexities of Web3 with precision and cost-efficiency.

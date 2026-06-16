Project Analysis Report: Ethereum Blockchain Intelligence
Project ID: fintech-and-web-3
Analyst: Adegbite Emmanuel
Data Source: bigquery-public-data.crypto_ethereum.transactions
Date: June 16, 2026

1. Report Summary
This report details a comprehensive analysis of the Ethereum blockchain to extract actionable insights regarding network health, stakeholder behavior, and cost optimization. By leveraging Google BigQuery, millions of transactions was processed to segment the market and provide a strategic roadmap for on-chain operations.

2. Methodology
The analysis was divided into four core tasks, utilizing GoogleSQL to perform time-series analysis, window functions for ranking, and conditional aggregation for user segmentation.
Units: Values converted from Wei to Ether (ETH) and Gas Prices to Gwei.

3. Analysis & Key Findings
Task One: Network Congestion & Fee Trends
Objective: To measure the relationship between transaction volume and network fees.

Metric: Daily transaction counts vs. average gas price in Gwei.
Finding: Higher transaction density correlates with exponential increases in gas prices, marking periods of high network stress.
![Image Description](https://github.com/EmmyData26/ADEGBITE-EMMANUEL-SQL-BIGQUERY-PROJECT/blob/16a3457d8c9130a370aa73889f27b432b101a199/Project_one/Fintech%20and%20Web%203%20On%20chain%20Task%201.png)

from the visual above, we can observe:
- Peak Network Stress: The visual identifies the specific date (represented by the highest bar and line spike) where transaction demand reached its maximum, causing gas prices to hit their 30-day peak.
- Optimal Efficiency Floor: The chart highlights the lowest Gwei points, revealing the most cost-effective windows for executing high-value transactions without overpaying for network space.
- Direct Cost Correlation: The visual clearly demonstrates a consistent lock-step trend, where every significant increase in transaction volume (congestion) is met with an immediate, proportional rise in average fees.


Task Two: Whale Wallet Tier Segmentation
Objective: To classify the user base by transaction volume to understand liquidity concentration.

Tiers:
Whale: >1,000 ETH
Shark: 100 - 1,000 ETH
Fish: <100 ETH
Finding: A small percentage of "Whale" addresses account for a disproportionate amount of total ETH movement, indicating a highly concentrated market.
![Image Description](https://github.com/EmmyData26/ADEGBITE-EMMANUEL-SQL-BIGQUERY-PROJECT/blob/16a3457d8c9130a370aa73889f27b432b101a199/Project_one/Fintech%20and%20Web%203%20On%20Chain%20Task%202.png)

from the visual above, we can observe:
The "Whale" category accounts for a dominant 88.17% of Total Category Volume (82.54M), significantly skewing the mean to 31.204M. The "Shark" category represents the lowest volume at 5.78% (5.41M). 


Task Three: Daily Top-Value Leaderboard
Objective: Real-time tracking of the 5 largest individual transfers per day.

Logic: Utilized ROW_NUMBER() over daily partitions.
Insight: Identifying specific transaction hashes for institutional-level transfers allows for forensic tracking of capital flight or protocol entries.
![Image Description](https://github.com/EmmyData26/ADEGBITE-EMMANUEL-SQL-BIGQUERY-PROJECT/blob/16a3457d8c9130a370aa73889f27b432b101a199/Project_one/Fintech%20and%20Web%203%20On%20Chain%20Task%203.png)

From the visual above, we can observe:
- Highest Single Peak: May 15, 2026, recorded the absolute largest single transaction in the dataset, with the Rank 1 transfer hitting 45,000 ETH.
- Late-Week Decline: There is a sharp decline in transaction values toward the end of the period (May 16 and May 17), where even the highest-ranked transactions struggled to exceed 16,800–20,300 ETH.
- Varying Competitive Gaps: On some days like May 16, the top 5 transactions were extremely close in value, tightly clustered between roughly 16,500 ETH and 20,300 ETH.
  On other days like May 12, there was a massive spread, with Rank 1 (33,196.61 ETH) being more than double the size of Rank 5 (13,967.14   ETH).
- High Institutional Floor: For most of the week (May 11–15), the baseline to even make it into the top 5 was incredibly high, requiring a minimum of roughly 14,000 to 25,000 ETH per transaction.


Task Four: Rolling Cost Forecast
Objective: To smooth out volatility and identify cost-efficient transaction windows.

Logic: 7-Day Moving Average of gas prices over a 90-day lookback period.
Insight: The moving average reveals the "True Trend," helping stakeholders avoid overpaying during temporary fee spikes.
![Image Description](https://github.com/EmmyData26/ADEGBITE-EMMANUEL-SQL-BIGQUERY-PROJECT/blob/16a3457d8c9130a370aa73889f27b432b101a199/Project_one/Fintech%20and%20Web%203%20On%20Chain%20Task%204.png)

From the visual above, we can observe:
- Massive Gas Spike: The daily average gas experiences a sharp, aggressive surge starting around 12:00 AM on June 14, climbing rapidly from roughly 500,000,000 to over 1,000,000,000 by Monday the 15th. This indicates a sudden burst of intense network congestion or highly complex smart contract interactions.
- Lagging Moving Average: The 7-day moving average continues a gentle downward trend, moving from above 800,000,000 down toward 730,000,000. Because it factorizes a full week of older, lower-activity data, it completely smooths out and lags behind the massive real-time spike.
- The Trend Crossover: On June 14, around 12:00 PM, the daily average aggressively crosses above the 7-day moving average.
P.S:  In on-chain analytics, this crossover is a strong signal that the network has abruptly shifted from a quiet, low-fee period into a high-demand macro event (such as a major NFT mint, a market liquidation event, or a token launch).


4. Recommendations
- Cost Optimization: It's effective to Schedule non-urgent smart contract executions when the daily gas price is below the 7-day moving average as identified in Task 4.
- Market Monitoring: insights obtained from the top 5 transactions as shown in Tas 3 can help to serve as an early warning system; massive Whale movements often precede volatility in DeFi markets.
- Capacity Planning: Monitoring congestion trends, as shown in task one can guide in anticipating periods of network degradation.


5. Conclusion
The Ethereum ecosystem is driven by a predictable cycle of congestion and a clearly tiered social structure. By utilizing these four tasks, fintech-and-web-3 is now equipped with the data infrastructure to navigate the complexities of Web3 with precision and cost-efficiency.

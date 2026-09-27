# E-Commerce Customer LTV & Probabilistic Churn Prediction

## 📌 Project Overview
In crowded e-commerce marketplaces, it's easy to spend more acquiring a customer than you'll ever make back from their first order. This project digs into the [Brazilian E-Commerce Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?utm_source=gemini) to figure out exactly how much future revenue is on the line when customers start to drift away.

Rather than reaching for a standard "will they churn, yes or no" classifier, I used **Buy 'Til You Die (BTYD)** probabilistic models — the kind that actually predict *how many* purchases a customer is likely to make in the next 6 months and *how much* they'll spend doing it. The end goal was turning those raw model outputs into something a non-technical stakeholder could open in Power BI and immediately act on.

## 🛠️ Tech Stack
* **Data Processing & ML:** Python (`pandas`, `numpy`, `scipy`, `lifetimes`)
* **Modeling Framework:** BG/NBD (Beta Geometric/Negative Binomial Distribution) and Gamma-Gamma
* **Business Intelligence:** Power BI, DAX

## 🧠 Methodology & Machine Learning Approach
The Olist data threw a curveball early on: over 95% of customers only ever bought once, which is an extreme case of zero-inflation that trips up most standard churn models — they just don't converge on a distribution that skewed. To work around this, I built the pipeline around a repeat-buyer cohort analysis instead:

1. **RFM Calculation:** Pulled Recency, Frequency, and Monetary metrics out of the raw transactional SQL data.
2. **Temporal Scaling:** Rescaled the timeline from days to weeks — without this, the `Scipy` optimizer kept hitting float overflow and failing to converge.
3. **BG/NBD Churn Model:** Trained a Beta-Geometric model to estimate the probability that a customer is still "alive" and to forecast their transaction volume over the next 180 days.
4. **Gamma-Gamma Value Model:** Modeled the expected average order value, conditioned on each customer's historical frequency and monetary behavior.
5. **LTV Synthesis:** Combined predicted future transactions with expected order value to arrive at a personalized 180-day Customer Lifetime Value (LTV) for every customer.

## 📊 Business Impact & Power BI Dashboard
The Python pipeline outputs a cleaned `.csv`, which then feeds into Power BI. From there, custom DAX measures do the work of turning raw probabilities into things a retention or marketing team can actually act on:

* **Revenue at Risk:** A dynamic measure that surfaces the exact dollar value of future LTV tied to customers whose survival probability has dropped below 50%.
* **Risk Segmentation:** Customers are automatically bucketed into "Loyal," "At Risk," and "Churned" based on algorithmic thresholds.
* **The VIP Risk Matrix:** A scatter plot that isolates the customers who are both high-value *and* high-risk — the ones marketing teams should be targeting first with win-back campaigns.

![Power BI Dashboard](E-commerce%20Dashboard.png)

## 📂 Repository Structure
* `/data` - Raw RFM summary plus the final scored `final_dashboard_data.csv`.
* `/notebooks` - The Jupyter Notebook covering data cleaning, and BG/NBD and Gamma-Gamma model training.
* `/dashboard` - The `.pbix` Power BI file, along with a high-resolution screenshot of the final dashboard.

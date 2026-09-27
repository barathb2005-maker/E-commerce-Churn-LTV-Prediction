# E-Commerce Customer LTV & Probabilistic Churn Prediction

## 📌 Project Overview
In highly saturated e-commerce marketplaces, customer acquisition costs often outweigh the profits of a single transaction. This project analyzes the Brazilian e-commerce dataset (Olist) to identify exactly how much future revenue is at risk from customer churn. 

Instead of traditional binary classification, this project utilizes **Buy 'Til You Die (BTYD)** probabilistic models to predict exactly *how many* purchases a customer will make in the next 6 months and *how much* they will spend, translating raw machine learning outputs into an actionable, executive-ready Power BI dashboard.

## 🛠️ Tech Stack
* **Data Processing & ML:** Python (`pandas`, `numpy`, `scipy`, `lifetimes`)
* **Modeling Framework:** BG/NBD (Beta Geometric/Negative Binomial Distribution) and Gamma-Gamma
* **Business Intelligence:** Power BI, DAX

## 🧠 Methodology & Machine Learning Approach
The Olist dataset presented a unique challenge: extreme zero-inflation, as over 95% of users were one-time buyers. Standard churn models fail to converge on this distribution. To solve this, the pipeline was structured around a repeat-buyer cohort analysis:

1. **RFM Calculation:** Extracted Recency, Frequency, and Monetary metrics from raw transactional SQL data.
2. **Temporal Scaling:** Scaled timeline variables from days to weeks to prevent `Scipy` optimizer float overflow and convergence failures.
3. **BG/NBD Churn Model:** Trained a Beta-Geometric model to calculate the probability of a customer being "alive" and predict their transaction volume over the next 180 days.
4. **Gamma-Gamma Value Model:** Modeled the expected average order value conditionally based on historical transaction frequency and monetary metrics.
5. **LTV Synthesis:** Multiplied predicted future transactions by the expected order value to generate a personalized 180-day Customer Lifetime Value (LTV).

## 📊 Business Impact & Power BI Dashboard
The Python pipeline outputs a cleaned `.csv` which is ingested into Power BI. Custom DAX measures were engineered to translate probabilities into immediate business actions:

* **Revenue at Risk:** A dynamic measure that calculates the exact dollar amount of future LTV tied to customers with a survival probability under 50%.
* **Risk Segmentation:** Customers are bucketed into "Loyal", "At Risk", and "Churned" based on algorithmic thresholds.
* **The VIP Risk Matrix:** A scatter plot isolating high-value, high-churn-risk customers so marketing and retention teams can immediately target them with win-back campaigns.

![Power BI Dashboard](E-commerce%20Dashboard.png)

## 📂 Repository Structure
* `/data` - Contains the raw RFM summary and the final scored `final_dashboard_data.csv`.
* `/notebooks` - The Jupyter Notebook containing the data cleaning, BG/NBD, and Gamma-Gamma model training.
* `/dashboard` - The `.pbix` Power BI file and a high-resolution screenshot of the final dashboard.

-- 1. First we will be specifying the database we are using,
USE olist_ecommerce;

-- 2. viewing the tables present in the database
SELECT *
FROM olist_customers_dataset;

SELECT *
FROM olist_order_payments_dataset;

SELECT *
FROM olist_orders_dataset;

-- 3. CTE sum of payments
WITH order_payments AS (
    SELECT order_id, SUM(payment_value) AS total_order_value
    FROM olist_order_payments_dataset
    GROUP BY order_id
),
valid_orders AS (
    SELECT c.customer_unique_id, o.order_id, o.order_purchase_timestamp, p.total_order_value
    FROM olist_customers_dataset c
    JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
    JOIN order_payments p ON o.order_id = p.order_id
    WHERE o.order_status = 'delivered'
)
-- 5.Final math RFM calculation
SELECT customer_unique_id,
COUNT(DISTINCT order_id) - 1 AS frequency,
AVG(total_order_value) AS monetary_value,
DATEDIFF(MAX(order_purchase_timestamp), MIN(order_purchase_timestamp)) AS recency,
DATEDIFF('2018-09-01', MIN(order_purchase_timestamp)) AS T
FROM valid_orders
GROUP BY customer_unique_id
;

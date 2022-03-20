WITH orders AS (
    SELECT
        *
    FROM 
        {{ ref('stg_orders') }}
),

orders_enriched AS (
    SELECT
        user_guid,
        (EXTRACT(EPOCH FROM delivered_at) - EXTRACT(EPOCH FROM created_at))/(60 * 60) AS total_time_elapsed_hrs,
        order_status,
        order_cost
    FROM
        orders
)

SELECT 
    user_guid,
    count(1) AS total_ordered,
    SUM(CASE WHEN order_status = 'delivered' THEN 1 ELSE 0 END) AS total_delivered,
    SUM(CASE WHEN order_status = 'preparing' THEN 1 ELSE 0 END) AS total_being_prepared,
    SUM(CASE WHEN order_status = 'shipped' THEN 1 ELSE 0 END) AS total_shipped,
    AVG(total_time_elapsed_hrs) AS average_time_for_delivery_hrs,
    AVG(order_cost) avg_order_cost
FROM
    orders_enriched
GROUP BY 
    user_guid
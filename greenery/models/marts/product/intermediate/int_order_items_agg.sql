
WITH order_items AS (
    SELECT 
        *
    FROM 
        {{ ref('stg_order_items') }}   
)

SELECT
    SUM(quantity) AS total_product_bought,
    product_guid
FROM 
    order_items
GROUP by 
    product_guid
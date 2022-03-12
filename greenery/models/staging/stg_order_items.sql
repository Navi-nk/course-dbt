WITH order_items_source AS (
    SELECT 
        *
    FROM 
        {{ source('postgres_source', 'order_items') }}
)

SELECT
    order_id AS order_guid,
    product_id AS product_guid,
    quantity
FROM    
    order_items_source
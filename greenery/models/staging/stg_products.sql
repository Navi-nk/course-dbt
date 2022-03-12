WITH products_source AS (
    SELECT 
        *
    FROM 
        {{ source('postgres_source', 'products') }}
)

SELECT
    product_id AS product_guid,
    name,
    price,
    inventory
FROM    
    products_source
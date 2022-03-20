WITH products AS (
    SELECT 
        *
    FROM 
        {{ ref('stg_products') }}
),

products_bought AS (
    SELECT 
        *
    FROM 
        {{ ref('int_order_items_agg') }}   
)

SELECT 
    prod.product_guid,
    prod.name,
    prod.price AS unit_price,
    prod.inventory AS current_inventory,
    prod_bght.total_product_bought
FROM 
    products prod 
LEFT JOIN
    products_bought prod_bght 
ON 
    prod.product_guid = prod_bght.product_guid


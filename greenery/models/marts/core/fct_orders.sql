WITH orders AS (
    SELECT
        *
    FROM 
        {{ ref('stg_orders') }}
),

order_items AS (
    SELECT 
        *
    FROM 
        {{ ref('stg_order_items') }}   
),

promos AS ( 
    SELECT 
        *
    FROM
        {{ ref('stg_promos') }} 
),

addresses AS (
    SELECT 
        *
    FROM 
        {{ ref('int_addresses') }}
),

users AS (
    SELECT 
        *
    FROM 
        {{ ref('int_users') }}
)


SELECT  
    ord.order_guid,
    usr.full_name,
    usr.phone_number AS contact_number,
    usr.email,
    addr.full_address AS shipping_address,
    COALESCE(promos.discount, 0) AS discount_applied_in_pct,
    ord_items.product_guid,
    ord_items.quantity,
    ord.order_cost,
    ord.shipping_cost,
    ord.order_total,
    ord.created_at,
    ord.estimated_delivery_at,
    ord.delivered_at,
    ord.shipping_service,
    ord.tracking_guid,
    ord.order_status
FROM 
    orders ord
LEFT JOIN
    users usr
ON
    ord.user_guid = usr.user_guid
LEFT JOIN 
    addresses addr
ON 
    ord.address_guid = addr.address_guid
LEFT JOIN
    promos
ON 
    ord.promo_guid = promos.promo_guid
LEFT JOIN
    order_items ord_items
ON 
    ord.order_guid = ord_items.order_guid
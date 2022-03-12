WITH promos_source AS (
    SELECT 
        *
    FROM 
        {{ source('postgres_source', 'promos') }}
)

SELECT
    promo_id AS promo_guid,
    discount,
    status
FROM    
    promos_source
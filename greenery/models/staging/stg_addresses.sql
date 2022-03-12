WITH addresses_source AS (
    SELECT 
        *
    FROM 
        {{ source('postgres_source', 'addresses') }}
)

SELECT
    address_id AS address_guid,
    address,
    zipcode,
    state,
    country
FROM    
    addresses_source
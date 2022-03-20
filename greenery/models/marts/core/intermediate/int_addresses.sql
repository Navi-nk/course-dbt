{{
    config(
        materialized = 'view'
    )
}}

WITH addresses AS (
    SELECT 
        *
    FROM 
        {{ ref('stg_addresses') }}   
)

SELECT 
    address_guid,
    CONCAT_WS(', ', address, state, zipcode, country) AS full_address
FROM    
    addresses
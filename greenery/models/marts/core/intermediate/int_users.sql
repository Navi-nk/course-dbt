{{
    config(
        materialized = 'view'
    )
}}


WITH users AS (
    SELECT 
        *
    FROM 
        {{ ref('stg_users') }}
)

SELECT 
    user_guid,
    CONCAT_WS(' ', first_name, last_name) AS full_name,
    email,
    phone_number,
    created_at,
    updated_at,
    address_guid
FROM 
    users
WITH users AS (
    SELECT 
        *
    FROM 
        {{ ref('int_users') }}
),

addresses AS (
    SELECT 
        *
    FROM 
        {{ ref('int_addresses') }}   
)

SELECT 
    usr.user_guid,
    usr.full_name,
    usr.email,
    usr.phone_number,
    addr.full_address,
    usr.created_at,
    usr.updated_at
FROM 
    users usr 
LEFT JOIN
    addresses addr 
ON usr.address_guid = addr.address_guid


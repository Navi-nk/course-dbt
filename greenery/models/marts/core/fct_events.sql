WITH events AS ( 
    SELECT 
        *
    FROM 
        {{ ref('stg_events') }}
)

SELECT
    event_guid,
    session_guid,
    user_guid,
    page_url,
    event_type,
    created_at,
    order_guid,
    product_guid
FROM
    events
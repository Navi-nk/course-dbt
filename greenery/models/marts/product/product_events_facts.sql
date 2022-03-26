

WITH events AS (
    SELECT
        *
    FROM
        {{ ref('fct_events') }}
),

products AS (
    SELECT
        *
    FROM
        {{ ref('dim_products') }}
),

orders AS (
    SELECT 
        *
    FROM
        {{ ref('fct_orders') }}
), 

events_enriched as (
    SELECT 
        events.event_guid, 
        events.session_guid,
        events.event_type,
        events.order_guid, 
        COALESCE(orders.product_guid, events.product_guid) as product_guid, 
        events.created_at
    FROM 
        events 
    LEFT JOIN 
        orders 
    ON 
        events.order_guid = orders.order_guid
),

session_events_agg AS (
    SELECT
        *
    FROM
        ( {{ session_dim_aggregate('events_enriched', 'product_guid') }} ) agg
),

session_length AS (
    SELECT 
        session_guid,
        MIN(created_at) AS first_event_time, 
        MAX(created_at) AS last_event_time
    FROM 
        events
    GROUP BY
        session_guid
)

SELECT 
    sess_agg.session_guid,
    sess_agg.product_guid,
    prod.name as product_name,
    sess_agg.page_view,
    sess_agg.add_to_cart,
    sess_agg.package_shipped,
    sess_agg.checkout,
    sess_len.first_event_time,
    sess_len.last_event_time,
    (EXTRACT(EPOCH FROM sess_len.last_event_time) - EXTRACT(EPOCH FROM sess_len.first_event_time))/60  AS total_time_elapsed_mins
FROM
    session_events_agg sess_agg
LEFT JOIN
    products prod
ON 
    sess_agg.product_guid = prod.product_guid
LEFT JOIN
    session_length sess_len
ON
    sess_agg.session_guid = sess_len.session_guid
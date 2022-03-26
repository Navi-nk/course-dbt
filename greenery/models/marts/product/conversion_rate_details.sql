
WITH product_events AS (
    SELECT 
        *
    FROM 
        {{ ref('product_events_facts') }}
),

overall_conversion_rate AS (
    SELECT
        ROUND(COUNT(DISTINCT CASE WHEN checkout>0 THEN session_guid ELSE NULL END)::DECIMAL / 
            COUNT(DISTINCT session_guid) * 100, 2) AS conversion_rate
    FROM product_events 
),

product_conversion_rate AS (
    SELECT
        product_name, 
        COUNT(DISTINCT CASE WHEN checkout>0 THEN session_guid ELSE NULL END) AS total_sessions_with_checkout,
        COUNT(DISTINCT CASE WHEN page_view>0 THEN session_guid ELSE NULL END) AS total_sessions_with_page_view
    FROM 
        product_events 
    GROUP BY 
        product_name 
)

SELECT 
    product_name,
    ROUND(total_sessions_with_checkout::DECIMAL / total_sessions_with_page_view * 100 , 2) as product_conversion_rate,
    (SELECT conversion_rate FROM overall_conversion_rate ) AS overall_conversion_rate
FROM 
    product_conversion_rate

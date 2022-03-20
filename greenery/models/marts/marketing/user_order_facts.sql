WITH users AS (
    SELECT 
        *
    FROM 
        {{ ref('dim_users') }}
),

order_facts AS (
    SELECT 
        *
    FROM
        {{ ref('int_order_user_agg') }}
)

SELECT 
    usr.user_guid,
    usr.full_name,
    usr.email,
    usr.phone_number,
    usr.full_address,
    ord_fct.total_ordered,
    ord_fct.total_delivered,
    ord_fct.total_being_prepared,
    ord_fct.total_shipped,
    ord_fct.average_time_for_delivery_hrs,
    ord_fct.avg_order_cost
FROM
    users usr
LEFT JOIN
    order_facts ord_fct
ON
    usr.user_guid = ord_fct.user_guid

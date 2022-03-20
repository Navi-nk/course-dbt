WITH events AS (
    SELECT
        *
    FROM
        {{ ref('fct_events') }}
),

users AS (
    SELECT 
        *
    FROM
        {{ ref('dim_users') }}
),

session_events_agg AS (
    SELECT
        *
    FROM
        {{ ref('int_session_events_agg') }}
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
    sess_agg.user_guid,
    usr.full_name,
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
    users usr
ON 
    sess_agg.user_guid = usr.user_guid
LEFT JOIN
    session_length sess_len
ON
    sess_agg.session_guid = sess_len.session_guid

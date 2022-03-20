{%
    set event_types = dbt_utils.get_query_results_as_dict(
        "SELECT DISTINCT QUOTE_LITERAL(event_type) AS event_type, event_type AS event_value from"
        ~ ref('fct_events')
    )
%}

WITH events AS (
    SELECT
        *
    FROM
        {{ ref('fct_events') }}
)

SELECT 
    session_guid,
    user_guid,
    created_at,
    {% for event_type in event_types['event_type'] %}
        SUM(CASE WHEN event_type = {{event_type}} THEN 1 ELSE 0 END) AS {{ event_types['event_value'][loop.index0] }}
        {{ ", " if not loop.last else "" }}
    {% endfor %}
FROM 
    events
{{dbt_utils.group_by(3) }}
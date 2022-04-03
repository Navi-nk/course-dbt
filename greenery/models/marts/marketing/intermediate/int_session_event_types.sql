{% set results = get_event_types(ref('fct_events'), 'event_type') %}

SELECT
    session_guid,
    {% for event_type in results %}
        SUM(CASE WHEN event_type = '{{event_type}}' THEN 1 ELSE 0 END) AS {{ event_type }}
        {{ ", " if not loop.last else "" }}
    {% endfor %}
FROM 
    {{ ref('fct_events') }}
GROUP BY 1
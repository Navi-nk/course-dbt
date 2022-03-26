{% macro session_dim_aggregate(events_ref, dim_guid) %}

    {%
        set event_types = dbt_utils.get_query_results_as_dict(
            "SELECT DISTINCT QUOTE_LITERAL(event_type) AS event_type, event_type AS event_value from"
            ~ ref("fct_events")
        )
    %}

    SELECT 
        session_guid,
        {{ dim_guid }},
        created_at,
        {% for event_type in event_types['event_type'] %}
            SUM(CASE WHEN event_type = {{event_type}} THEN 1 ELSE 0 END) AS {{ event_types['event_value'][loop.index0] }}
            {{ ", " if not loop.last else "" }}
        {% endfor %}
    FROM 
      {{ events_ref }}      
    {{dbt_utils.group_by(3) }}

{% endmacro %}
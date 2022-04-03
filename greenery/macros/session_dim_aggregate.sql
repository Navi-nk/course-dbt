{% macro session_dim_aggregate(enum_ref, enum_column, events_ref, dim_guid) %}

    {% set results = get_event_types(enum_ref, enum_column) %}
    
    {{ log("results from macro: " ~ results ) }}
    SELECT 
        session_guid,
        {{ dim_guid }},
        created_at,
        {% for event_type in results %}
            SUM(CASE WHEN event_type = '{{event_type}}' THEN 1 ELSE 0 END) AS {{ event_type }}
            {{ ", " if not loop.last else "" }}
        {% endfor %}
    FROM 
        {{ events_ref }}      
    {{dbt_utils.group_by(3) }}


{% endmacro %}
{% macro session_dim_aggregate(enum_ref, enum_column, events_ref, dim_guid) %}

    {% set event_enum_query %}
        select distinct {{ enum_column }} from {{ enum_ref }}
    {% endset %}

    {% set results = run_query(event_enum_query) %}

    {% if execute %}
        SELECT 
            session_guid,
            {{ dim_guid }},
            created_at,
            {% for event_type in results.columns[0].values() %}
                SUM(CASE WHEN event_type = '{{event_type}}' THEN 1 ELSE 0 END) AS {{ event_type }}
                {{ ", " if not loop.last else "" }}
            {% endfor %}
        FROM 
            {{ events_ref }}      
        {{dbt_utils.group_by(3) }}
    
    {% endif %}
    

{% endmacro %}
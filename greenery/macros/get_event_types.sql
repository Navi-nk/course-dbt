{% macro get_event_types(source_ref, event_column) %}

    {% set event_enum_query %}
        select distinct {{ event_column }} from {{ source_ref }}
    {% endset %}
    {% set results = run_query(event_enum_query) %}

    {% if execute %}
        {{ return(results.columns[0].values()) }}
    {% else %}
        {{ return([]) }}
    {% endif %}

{% endmacro %}
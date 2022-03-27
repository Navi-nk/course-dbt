{% macro grant_privilege(schema, role) %}

  GRANT USAGE ON SCHEMA {{ schema }} TO {{ role }};
  GRANT SELECT ON ALL TABLES IN SCHEMA {{ schema }} TO {{ role }};
{% endmacro %}
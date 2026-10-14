{% macro debug_target() %}

    {{ log("target.name=" ~ target.name, info=True) }}
    {{ log("target.schema=" ~ target.schema, info=True) }}
    {{ log("target.role=" ~ target.role, info=True) }}

{% endmacro %}
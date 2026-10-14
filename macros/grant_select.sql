{% macro grant_select(schema = target.schema, role = 'ACCOUNTADMIN') %} -- had to hard-code role because 'NONE' was throwing an error
    


        {% set sql %}

            grant usage on schema {{ schema }} to role {{ role }} ;
            grant select on all tables in schema {{ schema }} to role {{ role }} ;
            grant select on all views in schema {{ schema }} to role {{ role }} ;

        {% endset %}

        {% do run_query(sql) %}


{% endmacro %}
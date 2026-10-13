-- {%- set payment_methods = ['credit_card', 'bank_transfer', 'coupon', 'gift_card'] -%} -- hard coded values
{%- set payment_methods = dbt_utils.get_column_values( table = ref( 'stg_stripe__payment' ), column = 'payment_method') -%} -- dynamic values


with payments as (

    select *
    from {{ ref('stg_stripe__payment') }}
    where payment_status != 'fail'

),
final as (

    select 
        order_id,

        {% for method in payment_methods %}

            sum(CASE WHEN payment_method = '{{ method }}' THEN amount else 0 end) as {{ method }}_amount

            {%- if not loop.last -%}
                , 
            {%- endif -%}

        {% endfor %}
    from
        payments
    group by 
        1

) 

select *
from final
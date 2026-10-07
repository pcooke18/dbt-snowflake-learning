with orders as (

    select * from {{ ref('stg_jaffle_shop__orders')}}

),

payments as (

    select * from {{ ref('stg_stripe__payment')}}

),

order_payments as (

    select
        order_id,
        sum(payment_amount) as amount
    from
        payments
    where
        payment_status = 'success'
    group by
        order_id

),

final as (

    select 
        orders.order_id, 
        orders.customer_id,
        orders.order_date,
        order_payments.amount
    from
        orders 
        left join order_payments using(order_id)

)

select * from final
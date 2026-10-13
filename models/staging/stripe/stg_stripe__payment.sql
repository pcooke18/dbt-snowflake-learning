with 

source as (

    select * from {{ source('stripe', 'payment') }}

),

renamed as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status as payment_status,
        -- originally cents, so converted to dollars
        {{ cents_to_dollars("amount", 2) }} as amount,
        created,
        _batched_at

    from source

)

select * from renamed
{% snapshot orders_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='order_guid',
      strategy='check',
      check_cols=['order_status', 'shipping_service', 'tracking_guid', 'estimated_delivery_at', 'delivered_At'],
    )
  }}

  SELECT * FROM {{ ref('stg_orders') }}

{% endsnapshot %}
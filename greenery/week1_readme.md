### Week 1 Assignment
#### Question 1: How many users do we have?
```
select 
  count(distinct(user_guid)) 
from 
  dbt_nkumar.stg_users;

Result : 130
```

#### Question 2: On average, how many orders do we receive per hour?
```
with hourly_cnt as (
    select date_trunc('hour', created_at) "hour", 
    count(1) as cnt
  from dbt_nkumar.stg_orders
  group by hour
)
select avg(cnt) from hourly_cnt;

Result: 7.5208333333333333
```

#### Question 3: On average, how long does an order take from being placed to being delivered?
```
with orders_deliveres as (
  select * from dbt_nkumar.stg_orders where order_status='delivered'
)
select avg(delivered_at - created_at) from orders_deliveres;

Result: 3 days 21:24:11.803279
```

#### Question 4: How many users have only made one purchase? Two purchases? Three+ purchases?
```
with user_order_count as (
  select 
  	user_guid,
  	count(1) as cnt
  	from dbt_nkumar.stg_orders
  group by user_guid
),
purchase_categories as (
 select 
  case when cnt = 1 then 'One Purchase' 
  	  when cnt = 2 then 'Two Purchases' 
  	  else 'Three+ Purchases' 
  	 end as categories 
  from 
    user_order_count
)
select 
	categories, 
	count(1) 
from purchase_categories
group by categories;

Result: 
One Purchase 25
Two Purchases 28
Three+ Purchases 71
```

#### Question 4: On average, how many unique sessions do we have per hour?
```
with sessions_count_per_hour as (
    select count(distinct session_guid) as sessions_count_per_hour 
    from dbt_nkumar.stg_events
group by date_trunc('hour', created_at)
)

select avg(sessions_count_per_hour) from sessions_count_per_hour;

Result: 16.3275862068965517
```
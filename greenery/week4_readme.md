### Week 4 Assignment

#### Part 1: DBT Snapshots

```
SELECT 
    order_guid, 
    tracking_guid,
    shipping_service,
    estimated_delivery_at,
    order_status,
    dbt_valid_from, 
    dbt_valid_to 
FROM snapshots.orders_snapshot
WHERE
    order_guid in ('914b8929-e04a-40f8-86ee-357f2be3a2a2', '05202733-0e17-4726-97c2-0520c024ab85','939767ac-357a-4bec-91f8-a7b25edd46c9')
order by order_guid,dbt_valid_from;
```

Result:

| order_guid | tracking_guid | shipping_service | estimated_delivery_at | order_status | dbt_valid_from | dbt_valid_to|
| ----------- | ----------- |-----------| ----------- | ----------- | ----------- | ----------- |
05202733-0e17-4726-97c2-0520c024ab85||||preparing|2022-04-03 14:23:15.003569|2022-04-03 14:26:00.189633|
05202733-0e17-4726-97c2-0520c024ab85|8404ed05-0128-4aeb-8ed5-6e44908875c4|ups|2021-02-19 10:15:26|shipped|2022-04-03 14:26:00.189633||
914b8929-e04a-40f8-86ee-357f2be3a2a2||||preparing|2022-04-03 14:23:15.003569|2022-04-03 14:26:00.189633|
914b8929-e04a-40f8-86ee-357f2be3a2a2|a807fe66-d8b1-4d38-b409-558fed8bd75f|ups|2021-02-19 10:15:26|shipped|2022-04-03 14:26:00.189633||
939767ac-357a-4bec-91f8-a7b25edd46c9||||preparing|2022-04-03 14:23:15.003569|2022-04-03 14:26:00.189633|
939767ac-357a-4bec-91f8-a7b25edd46c9|0a1177bd-5a6d-421b-a13d-11617ef68143|ups|2021-02-19 10:15:26|shipped|2022-04-03 14:26:00.189633||

### Part 2: Modeling Challenge
 
How are users moving through the product funnel? Which steps in the funnel have the largest drop off points?

```
select * from dbt_nkumar.product_funnel;
```
Result:

| total_sessions | add_to_cart_checkout_events | checkout_events | 
| ----------- | ----------- |-----------|
578|467|361


From this we can see:

- The dropoff from a level 1 to level 2 is 19.2% (`1 - ( add_to_cart_checkout_events / total_sessions)`).
- The dropoff from a level 2 to level 3 is 22.7% (`1 - (checkout_event / add_to_cart_checkout_events)`).

So, the largest dropoff point is at the last level where checkout happens.

### Part 3: Reflection Questions.

#### 3A. DBT Next steps.

We started using DBT last year and it has been a great decision for our organisation, we use snowflake for our datalake and DBT works seemlessly with it. The main objective for me to take this course was to get to know some best practices followed by other organisations and implement the ones that seem fit for us. The project sessions and various firechats have been useful in that aspect. I am a Data Engineer and I like buiding data centric applications so not keen on being a Analytical engineer. DBT is another tool that I wanted to learn to enhance my skills and this course has been very useful.

#### 3B. Setting up for production / scheduled dbt run of your project

We use Airflow for scheduling our Dags and it meets our requirement so well that we did not feel the need to explore other tools like Dagster. Will check it out in my next step of DBT learning.
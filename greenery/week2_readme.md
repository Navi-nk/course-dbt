### Week 1 Assignment
#### What is our user repeat rate?
```
select 
    (SUM(CASE WHEN total_ordered > 1 THEN 1 ELSE 0 END)::numeric /count(1)) * 100 as repeat_rate 
from int_order_user_agg;

Result : 79.83 %
```

#### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
Some of the good indicators that may indicate users will buy again are:
1. The number of products bought in the order and type of product.
2. If the user visited the website again after making first order.
3. Did the user receive the order within estimated time.
4. Do they have a promo code

Some of the indicators that may indicate users will not buy again are:
1. If the order delivered time is considerably more than the estimated time.
2. If the user did not visit the website after first purchase
3. If the average time per session is less.

Product reviews info might help in coming up with better metric to answer the question

#### Explain the marts models you added. Why did you organize the models in the way you did?
In core mart, I have added following models
1. users dimension model by joining staging users and addresses models. 
2. Events fact model from staging events model
3. orders fact model by joining users, addresses, order items , orders and promos model. 

In Marketing, I have added a model which provides user wise order stats.

In Product, I have added following models
1. products dimension model by joining products and order items staging model
2. page views fact model to provide session wise stats for different events

#### What assumptions are you making about each model? (i.e. why are you adding each test?)

Following are the assumption made
1. The ids are all unique and will be non null
2. The foreign key relation is properly maintained (user -> addresses , order -> order items etc)
3. Numeric values for quantity, amount and percentages are positive values 
4. Enumerations seen in the given data set contains the exhaustive list of values.

#### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
In the orders data, found that tracking_id, shipping_service, estimated_delivery_at, delivered_at are present for specific status. 
In events data, the order_id and product_id are present for only subset of events. 

Added tests for the above scenarios and did not clean any data.

#### Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

The pipelines need to be set up to run the tests right after the models are executed to populate data. The errors then would be communicated via automated process such as mail or slack.
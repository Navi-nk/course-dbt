### Week 3 Assignment

#### Part 1: What is our overall conversion rate?
```
Answer: 62.46%
```
#### Part 1: What is our conversion rate by product?

Answer:

| product_name      | conversion_rate |
| ----------- | ----------- |
|Alocasia Polly|41.18|
|Aloe Vera|49.23|
|Angel Wings Begonia|39.34|
|Arrow Head|55.56|
|Bamboo|53.73|
|Bird of Paradise|45.00|
|Birds Nest Fern|42.31|
|Boston Fern|41.27|
|Cactus|54.55|
|Calathea Makoyana|50.94|
|Devil's Ivy|48.89|
|Dragon Tree|46.77|
|Ficus|42.65|
|Fiddle Leaf Fig|50.00|
|Jade Plant|47.83|
|Majesty Palm|49.25|
|Money Tree|46.43|
|Monstera|51.02|
|Orchid|45.33|
|Peace Lily|40.91|
|Philodendron|48.39|
|Pilea Peperomioides|47.46|
|Pink Anthurium|41.89|
|Ponytail Palm|40.00|
|Pothos|34.43|
|Rubber Plant|51.85|
|Snake Plant|39.73|
|Spider Plant|47.46|
|String of pearls|60.94|
|ZZ Plant|53.97|

Created `conversion_rate_details` model to get the answer. This model uses the `product_events_facts` model which has product level events data


### Part 2: Create a macro to simplify part of a model(s).

- Answer: I created macro `session_dim_aggregate.sql` that identifies the event types and provides event_type counts for provided dim column(user/product), this is used in `product_events_facts` and `user_events_facts`.  Another macro is `grant_privilege.sql` that is used in the post hooks to grant access to reporting role.

### Part 3: Add a post hook to your project to apply grants to the role “reporting”.

- Answer: `grant_privilege.sql` is used to create macro that is used in `on-run-end` post hook to grant privileges

### Part 4: Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project.

- Answer: Yes used the dbt-expectations package to add tests, dbt_utils and codegen I had used in earlier weeks. 

### Part 5: Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages.

- Answer: The DAG image is attached in slack along with project submission
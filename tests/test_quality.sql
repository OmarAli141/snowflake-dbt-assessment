-- Custom tests for your models

-- Test: Ensure total_orders is not negative
SELECT *
FROM {{ ref('bouns_model') }}
WHERE total_orders < 0;

-- Test: Ensure total_revenue is positive
SELECT *
FROM {{ ref('my_second_dbt_model') }}
WHERE total_revenue < 0;

-- Test: Ensure nation and region names are not null
SELECT *
FROM {{ ref('bouns_model2') }}
WHERE nation_name IS NULL
   OR region_name IS NULL;

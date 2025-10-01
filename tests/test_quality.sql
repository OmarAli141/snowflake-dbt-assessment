-- This custom test combines 4 essential data quality checks using UNION ALL.
-- EXPECTATIONS : ZERO rows

-- Test 1: Order Key must be positive (checks data integrity in my_first_dbt_model)
SELECT
    'Invalid_Order_Key' AS failure_reason,
    -- Using CAST to ensure the key column type is uniform (VARCHAR) across all branches
    CAST(o_orderkey AS VARCHAR) AS test_key 
FROM {{ ref('my_first_dbt_model') }}
WHERE o_orderkey <= 0

UNION ALL

-- Test 2: Order Year is valid (ensures data is not corrupt, TPC-H data is recent)
SELECT
    'Order_Year_Too_Old' AS failure_reason,
    CAST(o_orderkey AS VARCHAR) AS test_key
FROM {{ ref('my_first_dbt_model') }}
WHERE order_year < 1992 -- TPC-H data typically starts in 1992 or 1993

UNION ALL

-- Test 3: Total Revenue must be non-negative (Critical check on the Gold Layer metric)
SELECT
    'Negative_Total_Revenue' AS failure_reason,
    CAST(customer_id AS VARCHAR) AS test_key
FROM {{ ref('my_second_dbt_model') }}
WHERE total_revenue < 0

UNION ALL

-- Test 4: Total Orders must be positive (ensures all customers in the bonus model have orders)
SELECT
    'Zero_Total_Orders_Found' AS failure_reason,
    CAST(customer_id AS VARCHAR) AS test_key
FROM {{ ref('bouns_model') }}
WHERE total_orders <= 0
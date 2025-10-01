WITH orders AS (
    SELECT * FROM {{ source('tpch', 'orders') }}
),
customers AS (
    SELECT * FROM {{ source('tpch', 'customer') }}
)

SELECT
    c.c_custkey AS customer_id,
    c.c_name AS customer_name,
    COUNT(DISTINCT o.o_orderkey) AS total_orders,
    MIN(o.o_orderdate) AS first_order_date,
    MAX(o.o_orderdate) AS last_order_date
FROM orders o
JOIN customers c ON o.o_custkey = c.c_custkey
GROUP BY c.c_custkey, c.c_name
ORDER BY total_orders DESC
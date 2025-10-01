WITH orders AS (
    SELECT * FROM {{ source('tpch', 'orders') }}
),
customers AS (
    SELECT * FROM {{ source('tpch', 'customer') }}
)

SELECT
    o.o_orderkey,
    o.o_custkey,
    c.c_name AS customer_name,
    YEAR(o.o_orderdate) AS order_year,
    o.o_totalprice AS total_price
FROM orders o
JOIN customers c
ON o.o_custkey = c.c_custkey
WITH orders AS (
    SELECT * FROM {{ source('tpch', 'orders') }}
),
lineitems AS (
    SELECT * FROM {{ source('tpch', 'lineitem') }}
),
customers AS (
    SELECT * FROM {{ source('tpch', 'customer') }}
)

SELECT
c.c_custkey AS customer_id,
c.c_name AS customer_name,
ROUND(SUM(l.l_extendedprice*(1-l.l_discount)),2) AS total_revenue
FROM orders o
JOIN lineitems l
ON o.o_orderkey = l.l_orderkey
JOIN customers c 
ON o.o_custkey = c.c_custkey
GROUP BY c.c_custkey, c.c_name

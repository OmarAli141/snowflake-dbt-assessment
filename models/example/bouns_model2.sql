WITH nations AS (
    SELECT * FROM {{ source('tpch', 'nation') }}
),
region AS (
    SELECT * FROM {{ source('tpch', 'region') }}
)

SELECT
    n.n_nationkey AS nation_key,
    r.r_regionkey AS region_key,
    n.n_name AS nation_name,
    r.r_name AS region_name
FROM nations n 
JOIN region r 
ON n.n_regionkey = r.r_regionkey

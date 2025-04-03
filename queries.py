# # queries.py
#
# # Queries for the Star Schema
# queries_star = {
#     # 1) Complex Join
#     "Top Products": {
#         "query": """
#             SELECT
#                 p.product_name,
#                 r.region_name,
#                 t.year,
#                 SUM(f.sales_amount) AS total_sales
#             FROM sales_fact f
#             JOIN dim_product p ON f.product_id = p.product_id
#             JOIN dim_region r  ON f.region_id = r.region_id
#             JOIN dim_time t    ON f.time_id   = t.time_id
#             GROUP BY
#                 p.product_name,
#                 r.region_name,
#                 t.year
#             ORDER BY total_sales DESC
#             LIMIT 10;
#         """,
#         "columns": ["product_name", "region_name", "year", "total_sales"]
#     },
#
#     # 2) Aggregation
#     "Region Revenue Share": {
#         "query": """
#             SELECT
#                 r.region_name,
#                 t.year,
#                 SUM(f.sales_amount) AS total_sales
#             FROM sales_fact f
#             JOIN dim_region r  ON f.region_id = r.region_id
#             JOIN dim_time t    ON f.time_id   = t.time_id
#             GROUP BY
#                 r.region_name,
#                 t.year
#             ORDER BY t.year, r.region_name;
#         """,
#         "columns": ["region_name", "year", "total_sales"]
#     },
#
#     # 3) Filtered Query
#     "Trend (Year 2023)": {
#         "query": """
#             SELECT
#                 f.sales_id,
#                 f.sales_amount,
#                 t.year
#             FROM sales_fact f
#             JOIN dim_time t ON f.time_id = t.time_id
#             WHERE t.year = 2023
#             ORDER BY f.sales_amount DESC
#             LIMIT 1000;
#         """,
#         "columns": ["sales_id", "sales_amount", "year"]
#     },
#
#     # 4) Window Function
#     "Customer Sales": {
#         "query": """
#             SELECT
#                 f.sales_id,
#                 c.customer_name,
#                 r.region_name,
#                 SUM(f.sales_amount) OVER (PARTITION BY c.customer_name) AS total_customer_sales
#             FROM sales_fact f
#             JOIN dim_customer c ON f.customer_id = c.customer_id
#             JOIN dim_region r   ON f.region_id   = r.region_id
#             LIMIT 1000;
#         """,
#         "columns": ["sales_id", "customer_name", "region_name", "total_customer_sales"]
#     }
# }
#
# # Queries for the Snowflake Schema
# queries_snowflake = {
#     # 1) Complex Join
#     "Top Products": {
#         "query": """
#             SELECT
#                 p.product_name,
#                 c.category_name,
#                 b.brand_name,
#                 r.region_name,
#                 t.year,
#                 SUM(f.sales_amount) AS total_sales
#             FROM sales_fact f
#             JOIN dim_product  p ON f.product_id = p.product_id
#             JOIN dim_category c ON p.category_id = c.category_id
#             JOIN dim_brand    b ON p.brand_id   = b.brand_id
#             JOIN dim_region   r ON f.region_id  = r.region_id
#             JOIN dim_time     t ON f.time_id    = t.time_id
#             GROUP BY
#                 p.product_name,
#                 c.category_name,
#                 b.brand_name,
#                 r.region_name,
#                 t.year
#             ORDER BY total_sales DESC
#             LIMIT 10;
#         """,
#         "columns": [
#             "product_name",
#             "category_name",
#             "brand_name",
#             "region_name",
#             "year",
#             "total_sales"
#         ]
#     },
#
#     # 2) Aggregation
#     "Region Revenue Share": {
#         "query": """
#             SELECT
#                 r.region_name,
#                 t.year,
#                 cat.category_name,
#                 b.brand_name,
#                 SUM(f.sales_amount) AS total_sales
#             FROM sales_fact f
#             JOIN dim_region   r   ON f.region_id  = r.region_id
#             JOIN dim_time     t   ON f.time_id    = t.time_id
#             JOIN dim_product  p   ON f.product_id = p.product_id
#             JOIN dim_category cat ON p.category_id = cat.category_id
#             JOIN dim_brand    b   ON p.brand_id   = b.brand_id
#             GROUP BY
#                 r.region_name,
#                 t.year,
#                 cat.category_name,
#                 b.brand_name
#             ORDER BY t.year, r.region_name;
#         """,
#         "columns": [
#             "region_name",
#             "year",
#             "category_name",
#             "brand_name",
#             "total_sales"
#         ]
#     },
#
#     # 3) Filtered Query
#     "Trend (Year 2023)": {
#         "query": """
#             SELECT
#                 f.sales_id,
#                 f.sales_amount,
#                 t.year,
#                 c.customer_name,
#                 b.brand_name
#             FROM sales_fact f
#             JOIN dim_time t     ON f.time_id     = t.time_id
#             JOIN dim_customer c ON f.customer_id = c.customer_id
#             JOIN dim_product p  ON f.product_id  = p.product_id
#             JOIN dim_brand b    ON p.brand_id    = b.brand_id
#             WHERE t.year = 2023
#             ORDER BY f.sales_amount DESC
#             LIMIT 1000;
#         """,
#         "columns": [
#             "sales_id",
#             "sales_amount",
#             "year",
#             "customer_name",
#             "brand_name"
#         ]
#     },
#
#     # 4) Window Function
#     "Customer Sales": {
#         "query": """
#             SELECT
#                 f.sales_id,
#                 c.customer_name,
#                 r.region_name,
#                 SUM(f.sales_amount) OVER (PARTITION BY c.customer_name) AS total_customer_sales
#             FROM sales_fact f
#             JOIN dim_customer c ON f.customer_id = c.customer_id
#             JOIN dim_region r   ON f.region_id   = r.region_id
#             LIMIT 1000;
#         """,
#         "columns": [
#             "sales_id",
#             "customer_name",
#             "region_name",
#             "total_customer_sales"
#         ]
#     }
# }
# queries.py

# Queries for the Star Schema
queries_star = {
    # 1) Complex Join
    "Top Products": {
        "query": """
            SELECT
                p.product_name,
                r.region_name,
                t.year,
                SUM(f.sales_amount) AS total_sales
            FROM sales_fact f
            JOIN dim_product p ON f.product_id = p.product_id
            JOIN dim_region r  ON f.region_id = r.region_id
            JOIN dim_time t    ON f.time_id   = t.time_id
            GROUP BY
                p.product_name,
                r.region_name,
                t.year
            ORDER BY total_sales DESC
            FETCH FIRST 10 ROWS ONLY
        """,
        "columns": ["product_name", "region_name", "year", "total_sales"]
    },

    # 2) Aggregation
    "Region Revenue Share": {
        "query": """
            SELECT
                r.region_name,
                t.year,
                SUM(f.sales_amount) AS total_sales
            FROM sales_fact f
            JOIN dim_region r  ON f.region_id = r.region_id
            JOIN dim_time t    ON f.time_id   = t.time_id
            GROUP BY
                r.region_name,
                t.year
            ORDER BY t.year, r.region_name
        """,
        "columns": ["region_name", "year", "total_sales"]
    },

    # 3) Filtered Query
    "Trend (Year 2023)": {
        "query": """
            SELECT
                f.sales_id,
                f.sales_amount,
                t.year
            FROM sales_fact f
            JOIN dim_time t ON f.time_id = t.time_id
            WHERE t.year = 2023
            ORDER BY f.sales_amount DESC
            FETCH FIRST 1000 ROWS ONLY
        """,
        "columns": ["sales_id", "sales_amount", "year"]
    },

    # 4) Window Function
    "Customer Sales": {
        "query": """
            SELECT
                f.sales_id,
                c.customer_name,
                r.region_name,
                SUM(f.sales_amount) OVER (PARTITION BY c.customer_name) AS total_customer_sales
            FROM sales_fact f
            JOIN dim_customer c ON f.customer_id = c.customer_id
            JOIN dim_region r   ON f.region_id   = r.region_id
            FETCH FIRST 1000 ROWS ONLY
        """,
        "columns": ["sales_id", "customer_name", "region_name", "total_customer_sales"]
    }
}

# Queries for the Snowflake Schema
queries_snowflake = {
    # 1) Complex Join
    "Top Products": {
        "query": """
            SELECT
                p.product_name,
                c.category_name,
                b.brand_name,
                r.region_name,
                t.year,
                SUM(f.sales_amount) AS total_sales
            FROM sales_fact f
            JOIN dim_product  p ON f.product_id = p.product_id
            JOIN dim_category c ON p.category_id = c.category_id
            JOIN dim_brand    b ON p.brand_id   = b.brand_id
            JOIN dim_region   r ON f.region_id  = r.region_id
            JOIN dim_time     t ON f.time_id    = t.time_id
            GROUP BY
                p.product_name,
                c.category_name,
                b.brand_name,
                r.region_name,
                t.year
            ORDER BY total_sales DESC
            FETCH FIRST 10 ROWS ONLY
        """,
        "columns": [
            "product_name",
            "category_name",
            "brand_name",
            "region_name",
            "year",
            "total_sales"
        ]
    },

    # 2) Aggregation
    "Region Revenue Share": {
        "query": """
            SELECT
                r.region_name,
                t.year,
                cat.category_name,
                b.brand_name,
                SUM(f.sales_amount) AS total_sales
            FROM sales_fact f
            JOIN dim_region   r   ON f.region_id  = r.region_id
            JOIN dim_time     t   ON f.time_id    = t.time_id
            JOIN dim_product  p   ON f.product_id = p.product_id
            JOIN dim_category cat ON p.category_id = cat.category_id
            JOIN dim_brand    b   ON p.brand_id   = b.brand_id
            GROUP BY
                r.region_name,
                t.year,
                cat.category_name,
                b.brand_name
            ORDER BY t.year, r.region_name
        """,
        "columns": [
            "region_name",
            "year",
            "category_name",
            "brand_name",
            "total_sales"
        ]
    },

    # 3) Filtered Query
    "Trend (Year 2023)": {
        "query": """
            SELECT
                f.sales_id,
                f.sales_amount,
                t.year,
                c.customer_name,
                b.brand_name
            FROM sales_fact f
            JOIN dim_time t     ON f.time_id     = t.time_id
            JOIN dim_customer c ON f.customer_id = c.customer_id
            JOIN dim_product p  ON f.product_id  = p.product_id
            JOIN dim_brand b    ON p.brand_id    = b.brand_id
            WHERE t.year = 2023
            ORDER BY f.sales_amount DESC
            FETCH FIRST 1000 ROWS ONLY
        """,
        "columns": [
            "sales_id",
            "sales_amount",
            "year",
            "customer_name",
            "brand_name"
        ]
    },

    # 4) Window Function
    "Customer Sales": {
        "query": """
            SELECT
                f.sales_id,
                c.customer_name,
                r.region_name,
                SUM(f.sales_amount) OVER (PARTITION BY c.customer_name) AS total_customer_sales
            FROM sales_fact f
            JOIN dim_customer c ON f.customer_id = c.customer_id
            JOIN dim_region r   ON f.region_id   = r.region_id
            FETCH FIRST 1000 ROWS ONLY
        """,
        "columns": [
            "sales_id",
            "customer_name",
            "region_name",
            "total_customer_sales"
        ]
    }
}

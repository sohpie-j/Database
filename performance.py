import pandas as pd
import time
from sqlalchemy import create_engine, text
from queries import queries_star, queries_snowflake

DB_URI_STAR = "oracle+oracledb://star_user:It1234@localhost:1521/?service_name=oracle8276.ottawa.algonquin.com"
engine_star = create_engine(DB_URI_STAR)

DB_URI_SNOW = "oracle+oracledb://snow_user:It1234@localhost:1521/?service_name=oracle8276.ottawa.algonquin.com"
engine_snow = create_engine(DB_URI_SNOW)

def run_queries_with_explain(engine, query_set, schema_label):
    results = {}
    for name, info in query_set.items():
        with engine.begin() as conn:
            # Step 1: EXPLAIN PLAN
            try:
                conn.execute(text(f"EXPLAIN PLAN FOR {info['query']}"))
                plan_result = conn.execute(text("SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY)"))
                explain_text = "\n".join(row[0] for row in plan_result.fetchall())
            except Exception as e:
                explain_text = f"EXPLAIN failed: {str(e)}"

            # Step 2: Run query and time it
            start = time.perf_counter()
            try:
                result = conn.execute(text(info['query']))
                rows = result.fetchall()
                elapsed = round(time.perf_counter() - start, 4)
                df = pd.DataFrame(rows, columns=info['columns'])
            except Exception as e:
                df = pd.DataFrame(columns=info['columns'])
                df.loc[0] = [f"Query failed: {e}"] + [""] * (len(info["columns"]) - 1)
                elapsed = None

            # Store for dashboard
            results[name] = {
                "data": df,
                "explain": explain_text,
                "Execution Time (s)": elapsed
            }

    return results

# Run both schemas and collect data
star_data = run_queries_with_explain(engine_star, queries_star, "Star Schema")
snow_data = run_queries_with_explain(engine_snow, queries_snowflake, "Snowflake Schema")

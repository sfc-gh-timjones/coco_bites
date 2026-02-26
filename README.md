# Row Access Control Demo

A Streamlit app demonstrating Snowflake row-level security. Users can simulate different roles and see how row access policies filter data by region.

## What It Does

- Creates 4 sample tables (EMPLOYEES, CUSTOMERS, ORDERS, PRODUCTS) with a REGION column
- Applies a row access policy that restricts data by role:
  - **ACCOUNTADMIN**: All regions
  - **SYSADMIN**: NORTH only
  - **PUBLIC**: SOUTH only
  - **USERADMIN**: EAST only
- Deploys a Streamlit app to visualize and download filtered data

## Setup Order

Run these scripts in Snowflake as ACCOUNTADMIN:

1. **row_access_download_setup_step1.sql** - Creates warehouse, database, tables, data, and row access policy
2. Upload `row_access_download_streamlit.py` to the stage `@Streamlit_Mock_Data.DEMO.STREAMLIT_STAGE`
3. **row_access_download_setup_step2.sql** - Creates the stage and Streamlit app

## Cleanup

Run **row_access_download_cleanup.sql** to remove all created objects.

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
2. **row_access_download_setup_step2.sql** - Creates git repo, stage, copies Streamlit file, and creates the app

Or use **row_access_download_setup_step3.sql** to run step1 and step2 via EXECUTE IMMEDIATE from Git (requires git repo to exist first).

## Cleanup

Run **row_access_download_cleanup.sql** to remove all created objects.

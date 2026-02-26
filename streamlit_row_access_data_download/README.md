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

## Setup

Run **RUN_row_access_download_setup.sql** in Snowflake as ACCOUNTADMIN - that's it!

This script sets up the git repo connection and runs everything via EXECUTE IMMEDIATE.

## Cleanup

Uncomment the cleanup line at the end of **RUN_row_access_download_setup.sql**, or run **row_access_download_cleanup.sql** directly.

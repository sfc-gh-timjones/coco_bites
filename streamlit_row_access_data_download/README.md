# Row Access Control Demo

A Streamlit app demonstrating Snowflake row-level security. Users can simulate different roles and see how row access policies filter data by region.

## Quick Start

1. Open Snowflake
2. Open a Worksheet (Projects > Worksheets > + Worksheet)
3. Copy the contents of **RUN_THIS.sql** into the worksheet
4. Click "Run All" to execute the entire script

After it completes:
1. Navigate to **Projects > Streamlit**
2. Click on **ROW_ACCESS_DEMO_APP**

> **Note:** You may need to hard refresh your browser (Cmd+Shift+R or Ctrl+Shift+R) for the app to appear in the list.

## What It Does

- Creates 4 sample tables (EMPLOYEES, CUSTOMERS, ORDERS, PRODUCTS) with a REGION column
- Applies a row access policy that restricts data by role:
  - **ACCOUNTADMIN**: All regions
  - **SYSADMIN**: NORTH only
  - **PUBLIC**: SOUTH only
  - **USERADMIN**: EAST only
- Deploys a Streamlit app to visualize and download filtered data

## Cleanup

Uncomment the cleanup line at the end of **RUN_THIS.sql** and run it, or run **row_access_download_cleanup.sql** directly.

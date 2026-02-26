-- ============================================
-- ROW ACCESS CONTROL DEMO - CLEANUP SCRIPT
-- ============================================
-- This script removes all objects created by the setup scripts.
-- ============================================

USE ROLE ACCOUNTADMIN;

-- ============================================
-- 1. DROP STREAMLIT APP
-- ============================================
DROP STREAMLIT IF EXISTS Streamlit_Mock_Data.DEMO.ROW_ACCESS_DEMO_APP;

-- ============================================
-- 2. DROP DATABASE (includes schema, tables, stage, row access policy)
-- ============================================
DROP DATABASE IF EXISTS Streamlit_Mock_Data;

-- ============================================
-- 3. DROP WAREHOUSE
-- ============================================
DROP WAREHOUSE IF EXISTS WH_TESTING;

-- ============================================
-- CLEANUP COMPLETE
-- ============================================

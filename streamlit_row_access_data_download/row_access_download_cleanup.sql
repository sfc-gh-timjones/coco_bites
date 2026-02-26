-- ============================================
-- ROW ACCESS CONTROL DEMO - CLEANUP SCRIPT
-- ============================================
-- This script removes all objects created by the setup scripts.
-- ============================================

USE ROLE ACCOUNTADMIN;

-- ============================================
-- 1. DROP STREAMLIT APP
-- ============================================
DROP STREAMLIT IF EXISTS STREAMLIT_MOCK_DATA.DEMO.ROW_ACCESS_DEMO_APP;

-- ============================================
-- 2. DROP DATABASE (includes schema, tables, stage, row access policy, git repo)
-- ============================================
DROP DATABASE IF EXISTS STREAMLIT_MOCK_DATA;

-- ============================================
-- 3. DROP API INTEGRATION (account-level object)
-- ============================================
DROP API INTEGRATION IF EXISTS COCO_BITES_GIT_API_INTEGRATION;

-- ============================================
-- 4. DROP WAREHOUSE
-- ============================================
DROP WAREHOUSE IF EXISTS WH_TESTING;

-- ============================================
-- CLEANUP COMPLETE
-- ============================================

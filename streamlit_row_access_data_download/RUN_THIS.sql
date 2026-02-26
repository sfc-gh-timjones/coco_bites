-- ============================================
-- ROW ACCESS CONTROL DEMO - RUN THIS!
-- ============================================
-- One-click deployment! This script:
-- 1. Creates the git repo connection
-- 2. Runs setup scripts via EXECUTE IMMEDIATE
-- ============================================

USE ROLE ACCOUNTADMIN;

-- ============================================
-- 1. CREATE WAREHOUSE
-- ============================================
CREATE WAREHOUSE IF NOT EXISTS WH_TESTING
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE;

USE WAREHOUSE WH_TESTING;

-- ============================================
-- 2. CREATE API INTEGRATION FOR GIT
-- ============================================
CREATE OR REPLACE API INTEGRATION COCO_BITES_GIT_API_INTEGRATION
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/sfc-gh-timjones/coco_bites.git')
  ENABLED = TRUE;

-- ============================================
-- 3. CREATE DATABASE/SCHEMA FOR GIT REPO
-- ============================================
CREATE DATABASE IF NOT EXISTS STREAMLIT_MOCK_DATA;
CREATE SCHEMA IF NOT EXISTS STREAMLIT_MOCK_DATA.DEMO;

CREATE OR REPLACE GIT REPOSITORY STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO
  API_INTEGRATION = COCO_BITES_GIT_API_INTEGRATION
  ORIGIN = 'https://github.com/sfc-gh-timjones/coco_bites';

ALTER GIT REPOSITORY STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO FETCH;

-- ============================================
-- 4. EXECUTE SETUP SCRIPTS FROM GIT
-- ============================================
EXECUTE IMMEDIATE FROM @STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO/branches/main/streamlit_row_access_data_download/setup_step1_data.sql;
EXECUTE IMMEDIATE FROM @STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO/branches/main/streamlit_row_access_data_download/setup_step2_app.sql;

-- ============================================
-- DONE! Access your app at:
-- Streamlit Apps > STREAMLIT_MOCK_DATA.DEMO.ROW_ACCESS_DEMO_APP
-- ============================================

-- ============================================
-- 5. CLEANUP (uncomment to run)
-- ============================================
-- EXECUTE IMMEDIATE FROM @STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO/branches/main/streamlit_row_access_data_download/row_access_download_cleanup.sql;

-- ============================================
-- ROW ACCESS CONTROL DEMO - EXECUTE FROM GIT
-- ============================================
-- One-click deployment! This script:
-- 1. Creates the git repo connection
-- 2. Runs step1 and step2 via EXECUTE IMMEDIATE
-- ============================================

USE ROLE ACCOUNTADMIN;

-- ============================================
-- 1. CREATE API INTEGRATION FOR GIT
-- ============================================
CREATE OR REPLACE API INTEGRATION COCO_BITES_GIT_API_INTEGRATION
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/sfc-gh-timjones/coco_bites.git')
  ENABLED = TRUE;

-- ============================================
-- 2. CREATE DATABASE/SCHEMA FOR GIT REPO
-- ============================================
CREATE DATABASE IF NOT EXISTS STREAMLIT_MOCK_DATA;
CREATE SCHEMA IF NOT EXISTS STREAMLIT_MOCK_DATA.DEMO;

CREATE OR REPLACE GIT REPOSITORY STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO
  API_INTEGRATION = COCO_BITES_GIT_API_INTEGRATION
  ORIGIN = 'https://github.com/sfc-gh-timjones/coco_bites';

ALTER GIT REPOSITORY STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO FETCH;

-- ============================================
-- 3. EXECUTE SETUP SCRIPTS FROM GIT
-- ============================================
EXECUTE IMMEDIATE FROM @STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO/branches/main/streamlit_row_access_data_download/row_access_download_setup_step1.sql;
EXECUTE IMMEDIATE FROM @STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO/branches/main/streamlit_row_access_data_download/row_access_download_setup_step2.sql;

--DONE. THE STREAMLIT IS BUILT. IF YOU WANT TO DELETE ALL ARTIFACTS, RUN CLEANUP STEP BELOW.

-- ============================================
-- 4. CLEANUP (uncomment to run)
-- ============================================
-- EXECUTE IMMEDIATE FROM @STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO/branches/main/streamlit_row_access_data_download/row_access_download_cleanup.sql;

-- ============================================
-- DONE! Access your app at:
-- Streamlit Apps > STREAMLIT_MOCK_DATA.DEMO.ROW_ACCESS_DEMO_APP
-- ============================================

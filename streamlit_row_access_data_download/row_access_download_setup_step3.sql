-- ============================================
-- ROW ACCESS CONTROL DEMO - EXECUTE FROM GIT
-- ============================================
-- This script runs the full setup directly from the Git repository.
-- Requires git repo to be set up first (done by step2).
-- ============================================

USE ROLE ACCOUNTADMIN;

-- ============================================
-- 1. EXECUTE SETUP SCRIPTS FROM GIT
-- ============================================
EXECUTE IMMEDIATE FROM @STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO/branches/main/streamlit_row_access_data_download/row_access_download_setup_step1.sql;


EXECUTE IMMEDIATE FROM @STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO/branches/main/streamlit_row_access_data_download/row_access_download_setup_step2.sql;

-- ============================================
-- 2. CLEANUP (uncomment to run)
-- ============================================
-- EXECUTE IMMEDIATE FROM @STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO/branches/main/streamlit_row_access_data_download/row_access_download_cleanup.sql;

-- ============================================
-- DONE! Access your app at:
-- Streamlit Apps > STREAMLIT_MOCK_DATA.DEMO.ROW_ACCESS_DEMO_APP
-- ============================================

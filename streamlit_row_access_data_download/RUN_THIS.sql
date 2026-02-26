-- ============================================
-- ROW ACCESS CONTROL DEMO
-- ============================================
-- Run SETUP to deploy, run CLEANUP to remove
-- ============================================

USE ROLE ACCOUNTADMIN;

-- SETUP
EXECUTE IMMEDIATE FROM @STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO/branches/main/streamlit_row_access_data_download/setup_deploy.sql;

-- CLEANUP
-- EXECUTE IMMEDIATE FROM @STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO/branches/main/streamlit_row_access_data_download/row_access_download_cleanup.sql;

-- ============================================
-- 7. CREATE STAGE FOR STREAMLIT APP
-- ============================================
CREATE OR REPLACE STAGE Streamlit_Mock_Data.DEMO.STREAMLIT_STAGE
DIRECTORY = (ENABLE = TRUE);

-- ============================================
-- 8. UPLOAD STREAMLIT APP FILE
-- ============================================
-- After running this script, upload row_access_download_streamlit.py to the stage:
-- 
-- Option A: Using Snowsight UI
--   1. Navigate to Data > Databases > STREAMLIT_MOCK_DATA > DEMO > Stages > STREAMLIT_STAGE
--   2. Click "+ Files" and upload row_access_download_streamlit.py
--
-- Option B: Using SnowSQL CLI
--   PUT file://path/to/row_access_download_streamlit.py @Streamlit_Mock_Data.DEMO.STREAMLIT_STAGE AUTO_COMPRESS=FALSE OVERWRITE=TRUE;

-- ============================================
-- 9. CREATE STREAMLIT APP (run after uploading .py file)
-- ============================================
-- UPDATE: Change WH_MEDIUM to your warehouse name if different

CREATE OR REPLACE STREAMLIT Streamlit_Mock_Data.DEMO.ROW_ACCESS_DEMO_APP
  FROM @Streamlit_Mock_Data.DEMO.STREAMLIT_STAGE
  MAIN_FILE = 'row_access_download_streamlit.py'
  QUERY_WAREHOUSE = WH_TESTING;

ALTER STREAMLIT Streamlit_Mock_Data.DEMO.ROW_ACCESS_DEMO_APP ADD LIVE VERSION FROM LAST;

-- ============================================
-- 10. VERIFY SETUP
-- ============================================
SHOW STREAMLITS IN SCHEMA Streamlit_Mock_Data.DEMO;

SELECT 'EMPLOYEES' as TABLE_NAME, COUNT(*) as ROW_COUNT FROM Streamlit_Mock_Data.DEMO.EMPLOYEES
UNION ALL SELECT 'CUSTOMERS', COUNT(*) FROM Streamlit_Mock_Data.DEMO.CUSTOMERS
UNION ALL SELECT 'ORDERS', COUNT(*) FROM Streamlit_Mock_Data.DEMO.ORDERS
UNION ALL SELECT 'PRODUCTS', COUNT(*) FROM Streamlit_Mock_Data.DEMO.PRODUCTS;

-- ============================================
-- DONE! Access your app at:
-- Streamlit Apps > STREAMLIT_MOCK_DATA.DEMO.ROW_ACCESS_DEMO_APP
-- ============================================
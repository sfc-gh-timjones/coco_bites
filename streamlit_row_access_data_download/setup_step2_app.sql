-- ============================================
-- 7. CREATE STAGE FOR STREAMLIT APP
-- ============================================
CREATE OR REPLACE STAGE STREAMLIT_MOCK_DATA.DEMO.STREAMLIT_STAGE
DIRECTORY = (ENABLE = TRUE);

-- ============================================
-- 8. COPY STREAMLIT APP FILE TO STAGE
-- ============================================
-- Option A: Copy from Git repo (requires git repo from RUN script)
COPY FILES
  INTO @STREAMLIT_MOCK_DATA.DEMO.STREAMLIT_STAGE
  FROM @STREAMLIT_MOCK_DATA.DEMO.COCO_BITES_REPO/branches/main/streamlit_row_access_data_download/
  FILES = ('row_access_download_streamlit.py');

-- Option B: Using Snowsight UI
--   1. Navigate to Data > Databases > STREAMLIT_MOCK_DATA > DEMO > Stages > STREAMLIT_STAGE
--   2. Click "+ Files" and upload row_access_download_streamlit.py
--
-- Option C: Using SnowSQL CLI
--   PUT file://path/to/row_access_download_streamlit.py @STREAMLIT_MOCK_DATA.DEMO.STREAMLIT_STAGE AUTO_COMPRESS=FALSE OVERWRITE=TRUE;

-- ============================================
-- 9. CREATE STREAMLIT APP
-- ============================================
-- After this runs, navigate to: Projects > Streamlit
-- You may need to hard refresh your browser (Cmd+Shift+R or Ctrl+Shift+R) for the app to appear in the list

CREATE OR REPLACE STREAMLIT STREAMLIT_MOCK_DATA.DEMO.ROW_ACCESS_DEMO_APP
  FROM @STREAMLIT_MOCK_DATA.DEMO.STREAMLIT_STAGE
  MAIN_FILE = 'row_access_download_streamlit.py'
  QUERY_WAREHOUSE = WH_TESTING;

ALTER STREAMLIT STREAMLIT_MOCK_DATA.DEMO.ROW_ACCESS_DEMO_APP ADD LIVE VERSION FROM LAST;

-- ============================================
-- 10. VERIFY SETUP
-- ============================================
SHOW STREAMLITS IN SCHEMA STREAMLIT_MOCK_DATA.DEMO;

SELECT 'EMPLOYEES' as TABLE_NAME, COUNT(*) as ROW_COUNT FROM STREAMLIT_MOCK_DATA.DEMO.EMPLOYEES
UNION ALL SELECT 'CUSTOMERS', COUNT(*) FROM STREAMLIT_MOCK_DATA.DEMO.CUSTOMERS
UNION ALL SELECT 'ORDERS', COUNT(*) FROM STREAMLIT_MOCK_DATA.DEMO.ORDERS
UNION ALL SELECT 'PRODUCTS', COUNT(*) FROM STREAMLIT_MOCK_DATA.DEMO.PRODUCTS;

-- ============================================
-- DONE! Access your app at:
-- Streamlit Apps > STREAMLIT_MOCK_DATA.DEMO.ROW_ACCESS_DEMO_APP
-- ============================================
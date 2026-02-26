import streamlit as st
import pandas as pd
import base64
from snowflake.snowpark.context import get_active_session

st.set_page_config(page_title="Row Access Control Demo", layout="wide")
st.title("Row Access Control Demo")

session = get_active_session()

TABLES = ["EMPLOYEES", "CUSTOMERS", "ORDERS", "PRODUCTS"]
ROLES = ["ACCOUNTADMIN", "SYSADMIN", "PUBLIC", "USERADMIN"]
ROLE_REGIONS = {
    "ACCOUNTADMIN": None,
    "SYSADMIN": "NORTH",
    "PUBLIC": "SOUTH",
    "USERADMIN": "EAST"
}
ROLE_DISPLAY = {
    "ACCOUNTADMIN": "ALL REGIONS",
    "SYSADMIN": "NORTH only",
    "PUBLIC": "SOUTH only",
    "USERADMIN": "EAST only"
}

def get_csv_download_link(dataframe, filename):
    csv = dataframe.to_csv(index=False)
    b64 = base64.b64encode(csv.encode()).decode()
    href = f'<a href="data:text/csv;base64,{b64}" download="{filename}" style="display:inline-block;padding:0.5em 1em;background-color:#FF4B4B;color:white;text-decoration:none;border-radius:0.5em;">Download {filename}</a>'
    return href

st.sidebar.header("Settings")
selected_role = st.sidebar.selectbox("Simulate Role", ROLES, help="Simulate different role access levels")
st.sidebar.info(f"**{selected_role}** has access to: **{ROLE_DISPLAY[selected_role]}**")

selected_table = st.sidebar.selectbox("Select Table", TABLES)

st.subheader(f"Viewing: {selected_table}")
st.caption(f"Simulated Role: **{selected_role}** | Access: **{ROLE_DISPLAY[selected_role]}**")

region_filter = ROLE_REGIONS[selected_role]
if region_filter:
    query = f"SELECT * FROM STREAMLIT_MOCK_DATA.DEMO.{selected_table} WHERE REGION = '{region_filter}'"
else:
    query = f"SELECT * FROM STREAMLIT_MOCK_DATA.DEMO.{selected_table}"
df = session.sql(query).to_pandas()

if not df.empty:
    with st.expander("Filter Data", expanded=False):
        columns = df.columns.tolist()
        filter_col = st.selectbox("Filter by column", ["None"] + columns)
        if filter_col != "None":
            unique_vals = df[filter_col].unique().tolist()
            selected_vals = st.multiselect(f"Select {filter_col} values", unique_vals, default=unique_vals)
            df = df[df[filter_col].isin(selected_vals)]
    
    st.dataframe(df, use_container_width=True)
    st.caption(f"Showing {len(df)} rows")
    
    filename = f"{selected_table}_{selected_role}.csv"
    st.markdown(get_csv_download_link(df, filename), unsafe_allow_html=True)
else:
    st.warning("No data available for this role.")

st.divider()
st.subheader("Access Control Summary")
col1, col2, col3, col4 = st.columns(4)
with col1:
    st.metric("ACCOUNTADMIN", "All Regions")
with col2:
    st.metric("SYSADMIN", "NORTH")
with col3:
    st.metric("PUBLIC", "SOUTH")
with col4:
    st.metric("USERADMIN", "EAST")

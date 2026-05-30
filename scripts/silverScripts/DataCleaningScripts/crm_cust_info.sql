--Data Cleaning for crm_cust_info (Bronze to Silver)

--Check For Bronze

select * from bronze.crm_cust_info

-- Check for Nulls/Duplicates in Primary Key
-- Expectation : No Result

Select cst_id,COUNT(*)
from bronze.crm_cust_info
Group BY cst_Id
Having COUNT(*) > 1 OR cst_id is null -- (If 1 NUll, with OR value will not show)

-- Check for Unwanted spaces
-- Expectation : No unwanted spaces

Select cst_firstname from bronze.crm_cust_info Where cst_firstname != TRIM(cst_firstName)
Select cst_lastname from bronze.crm_cust_info Where cst_lastname != TRIM(cst_lastname)
Select cst_marital_status from bronze.crm_cust_info Where cst_marital_status != TRIM(cst_marital_status)
Select cst_gndr from bronze.crm_cust_info Where cst_gndr != TRIM(cst_gndr)


-- Data Standardization & consistency

Select Distinct cst_gndr from bronze.crm_cust_info
Select Distinct cst_marital_status from bronze.crm_cust_info

--Check For Silver

select * from silver.crm_cust_info

-- Check for Nulls/Duplicates in Primary Key
-- Expectation : No Result

Select cst_id,COUNT(*)
from silver.crm_cust_info
Group BY cst_Id
Having COUNT(*) > 1 OR cst_id is null -- (If 1 NUll, with OR value will not show)

-- Check for Unwanted spaces
-- Expectation : No unwanted spaces

Select cst_firstname from silver.crm_cust_info Where cst_firstname != TRIM(cst_firstName)
Select cst_lastname from silver.crm_cust_info Where cst_lastname != TRIM(cst_lastname)
Select cst_marital_status from silver.crm_cust_info Where cst_marital_status != TRIM(cst_marital_status)
Select cst_gndr from silver.crm_cust_info Where cst_gndr != TRIM(cst_gndr)


-- Data Standardization & consistency

Select Distinct cst_gndr from silver.crm_cust_info
Select Distinct cst_marital_status from silver.crm_cust_info

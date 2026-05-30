--Data Cleaning for crm_cust_info (Bronze to Silver)

--Check For Bronze

select * from bronze.crm_prd_info

-- Check for Nulls/Duplicates in Primary Key
-- Expectation : No Result

Select prd_id,COUNT(*)
from bronze.crm_prd_info
Group BY prd_Id
Having COUNT(*) > 1 OR prd_id is null -- (If 1 NUll, with OR value will not show)

-- Check for Unwanted spaces
-- Expectation : No unwanted spaces

Select prd_key from bronze.crm_prd_info Where prd_key != TRIM(prd_key)
Select prd_nm from bronze.crm_prd_info Where prd_nm != TRIM(prd_nm)
Select prd_line from bronze.crm_prd_info Where prd_line != TRIM(prd_line)


-- Data Standardization & consistency

Select Distinct prd_line from bronze.crm_prd_info

-- Check for NUlls/Negative Numbers
-- Expectation : No result

Select prd_cost from bronze.crm_prd_info Where prd_cost < 0 or prd_cost IS NULL

-- Check For Invalid Date Orders

Select * 
from bronze.crm_prd_info 
Where prd_end_dt < prd_start_dt

-- To Correct 
Select *
,DATEADD(day,-1,LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER by prd_start_dt))
from bronze.crm_prd_info 
Where prd_key in ('AC-HE-HL-U509-R','AC-HE-HL-U509')

--Check For Silver

select * from silver.crm_prd_info

-- Check for Nulls/Duplicates in Primary Key
-- Expectation : No Result

Select prd_id,COUNT(*)
from silver.crm_prd_info
Group BY prd_Id
Having COUNT(*) > 1 OR prd_id is null -- (If 1 NUll, with OR value will not show)

-- Check for Unwanted spaces
-- Expectation : No unwanted spaces

Select prd_key from silver.crm_prd_info Where prd_key != TRIM(prd_key)
Select prd_nm from silver.crm_prd_info Where prd_nm != TRIM(prd_nm)
Select prd_line from silver.crm_prd_info Where prd_line != TRIM(prd_line)


-- Data Standardization & consistency

Select Distinct prd_line from silver.crm_prd_info

-- Check for NUlls/Negative Numbers
-- Expectation : No result

Select prd_cost from silver.crm_prd_info Where prd_cost < 0 or prd_cost IS NULL

-- Check For Invalid Date Orders

Select * 
from silver.crm_prd_info 
Where prd_end_dt < prd_start_dt

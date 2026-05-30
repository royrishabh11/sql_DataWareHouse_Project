--select * from silver.crm_cust_info
TRUNCATE TABLE silver.crm_cust_info;
Insert Into silver.crm_cust_info
(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)
SELECT 
	cst_id,
	cst_key,
	TRIM(cst_firstname) cst_firstname,	-- Trimming (Removing Unwanted Spaces)
	TRIM(cst_lastname) cst_lastname,	-- Trimming (Removing Unwanted Spaces)
	CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
		WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
		ELSE 'n/a'						-- Handling Missing Data
	END cst_marital_status,				-- Normalized marital status values to readable format
	CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		ELSE 'n/a'						-- Handling Missing Data
	END cst_gndr,						-- Normalized gender values to readable format
	cst_create_date
FROM 
(
	SELECT *,ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) RowNum
	FROM bronze.crm_cust_info
	WHERE cst_id IS NOT NULL
)t WHERE RowNum = 1						-- Removing Duplicates 
										-- Filtering most recent record

--select * from silver.crm_prd_info
TRUNCATE TABLE silver.crm_prd_info;
Insert Into silver.crm_prd_info
(
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
SELECT 
prd_id,
REPLACE(SUBSTRING(prd_key, 1, 5),'-','_') Cat_Id,	-- Derived Columns (Extract Category Id)
SUBSTRING(prd_key,7,len(prd_key)) prd_key,			-- Derived Columns (Extract Product Key)
prd_nm,
ISNULL(prd_cost, 0) prd_cost,						-- Handling Missing Info
CASE UPPER(TRIM(prd_line)) 
	 WHEN 'M' THEN 'Mountain'
	 WHEN 'R' THEN 'Road'
	 WHEN 'S' THEN 'Other Sales'
	 WHEN 'T' THEN 'Touring'
	 ELSE 'n/a'
END prd_line,										-- Data Mormalization (Descriptive Value)
prd_start_dt,
DateADD(day,-1,LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER by prd_start_dt))-- Data Enrichment
FROM bronze.crm_prd_info


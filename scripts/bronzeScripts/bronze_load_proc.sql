--EXEC bronze.load_bronze

CREATE or ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	Declare @startTime DATETIME, @endTime DATETIME, @batchStartTime DATETIME, @batchEndTime DATETIME;
	BEGIN TRY
		Set @batchStartTime = GETDATE()
		PRINT '===================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '===================================================';

		PRINT '---------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '---------------------------------------------------';
	
		Set @startTime = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into : bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\Personal\Study\DataWarehouse_Project\DataWarehouseMaterials\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		Set @endTime = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@startTime,@endTime) AS Nvarchar) + ' seconds';
		Print '--------------------------------'

		--SELECT * from bronze.crm_cust_info
		--Select COUNT(*) from bronze.crm_cust_info

		Set @startTime = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into : bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\Personal\Study\DataWarehouse_Project\DataWarehouseMaterials\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		Set @endTime = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@startTime,@endTime) AS Nvarchar) + ' seconds';
		Print '--------------------------------'
		--SELECT * from bronze.crm_prd_info

		Set @startTime = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into : bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Personal\Study\DataWarehouse_Project\DataWarehouseMaterials\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		Set @endTime = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@startTime,@endTime) AS Nvarchar) + ' seconds';
		Print '--------------------------------'

		PRINT '---------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '---------------------------------------------------';

		Set @startTime = GETDATE();
		PRINT '>> Truncating Table : bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Data Into : bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Personal\Study\DataWarehouse_Project\DataWarehouseMaterials\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		Set @endTime = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@startTime,@endTime) AS Nvarchar) + ' seconds';
		Print '--------------------------------'

		Set @startTime = GETDATE();
		PRINT '>> Truncating Table : bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data Into : bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Personal\Study\DataWarehouse_Project\DataWarehouseMaterials\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		Set @endTime = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@startTime,@endTime) AS Nvarchar) + ' seconds';
		Print '--------------------------------'

		Set @startTime = GETDATE();
		PRINT '>> Truncating Table : bronze.erp_px_cat_g1V2';
		TRUNCATE TABLE bronze.erp_px_cat_g1V2;

		PRINT '>> Inserting Data Into : bronze.erp_px_cat_g1V2';
		BULK INSERT bronze.erp_px_cat_g1V2
		FROM 'D:\Personal\Study\DataWarehouse_Project\DataWarehouseMaterials\sql-data-warehouse-project\datasets\source_erp\px_cat_g1V2.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		Set @endTime = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@startTime,@endTime) AS Nvarchar) + ' seconds';
		Print '--------------------------------'

		Set @batchEndTime = GETDATE();
		PRINT '===================================================';
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batchStartTime, @batchEndTime) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='

	END TRY
	BEGIN CATCH
		PRINT '===================================================';
		PRINT 'Error Loading Bronze Layer';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '===================================================';
	END CATCH
END

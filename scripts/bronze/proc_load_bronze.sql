/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY
		DECLARE @start_time DATETIME, @end_time DATETIME,@batch_start_time DATETIME, @batch_end_time DATETIME
		PRINT '==============================='
		PRINT 'Loading Bronze Layer'
		PRINT '==============================='
		PRINT '==============================='
		PRINT 'Loading crm Tables'
		PRINT '==============================='
		SET @batch_start_time = GETDATE();
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'V:\Data Engineering\SQL Resources\DWH project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT 'Load Duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '-------------------------------------'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'V:\Data Engineering\SQL Resources\DWH project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT 'Load Duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '-------------------------------------'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'V:\Data Engineering\SQL Resources\DWH project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT 'Load Duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '-------------------------------------'
		SET @start_time = GETDATE();
		PRINT '==============================='
		PRINT 'Loading erp Tables'
		PRINT '==============================='
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'V:\Data Engineering\SQL Resources\DWH project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT 'Load Duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '-------------------------------------'
		SET @start_time = GETDATE();

		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'V:\Data Engineering\SQL Resources\DWH project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		)
		SET @end_time = GETDATE();
		PRINT 'Load Duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '-------------------------------------'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'V:\Data Engineering\SQL Resources\DWH project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '==========================================='
		PRINT 'Loading Bronze Layer Completed'
		SET @batch_end_time = GETDATE();
		PRINT 'Batch Load Duration: '+CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds';
		PRINT '==========================================='
	END TRY
	BEGIN CATCH
		PRINT '================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message:'+ ERROR_MESSAGE();
		PRINT 'Error Message:'+ CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT '================================='
	END CATCH
END

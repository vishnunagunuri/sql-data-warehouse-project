/*
=========================================
Create Database and Schemas
=========================================
Purpose:
	This Script creates a new Database named 'DataWarehouse' after checking if it already exists.
	If the database exists,it will be dropped and recreated.Additionally, the script  sets up three 
	schema within the datadase:bronze,silver and gold

Warning:
	Running this script will drop the entire database if it already exists.
	All the data in the databse will be permanently deleted.
*/



USE MASTER;
GO
--Drop and create datawarehouse database--
IF EXISTS(Select 1 from sys.databases where name ='DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE DataWarehouse
END;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO
SELECT DB_NAME() AS CurrentDatabase;
GO
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO

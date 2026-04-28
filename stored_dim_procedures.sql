--Channeling it to use the below specific database--
USE [pc_sale_datapipeline];
GO
--A stored procedure is essentially a saved block of SQL code that you can run whenever you need. 
--Instead of rewriting the same SQL statements over and over, you package them into one reusable procedure.
--sp dim location--
DROP PROCEDURE IF EXISTS dbo.sp_create_dim_location;
GO
CREATE PROCEDURE sp_create_dim_location
AS
BEGIN
        DROP TABLE [pc_sale_datapipeline].[dbo].[dim_location];
        CREATE TABLE [pc_sale_datapipeline].[dbo].[dim_location] (
        locationID INT IDENTITY (1,1) PRIMARY KEY,
        Continent NVARCHAR(250) NOT NULL,
        Country_or_State NVARCHAR(250) NOT NULL,
        Province_or_City NVARCHAR(250) NOT NULL)
    INSERT INTO [pc_sale_datapipeline].[dbo].[dim_location] (Continent, Country_or_State, Province_or_City)
    SELECT DISTINCT Continent, Country_or_State, Province_or_City
    FROM [pc_sale_datapipeline].[dbo].[raw_pc_data];
END;

--sp dim date--
DROP PROCEDURE IF EXISTS dbo.sp_create_dim_date;
GO
CREATE PROCEDURE sp_create_dim_date
AS
BEGIN 
    DROP TABLE [pc_sale_datapipeline].[dbo].[dim_date];
CREATE TABLE [pc_sale_datapipeline].[dbo].[dim_date] (
    [DateID] INT IDENTITY (1,1) PRIMARY KEY,
    [Purchase_Date] DATE NOT NULL,
    [Ship_Date] DATE NULL
)
INSERT INTO [pc_sale_datapipeline].[dbo].[dim_date] (Purchase_Date, Ship_Date)
SELECT Distinct
    TRY_CONVERT(DATE, Purchase_Date),
    TRY_CONVERT(DATE, Ship_Date)
 FROM [pc_sale_datapipeline].[dbo].[raw_pc_data];
 End;
 
 --sp dim customer--
DROP PROCEDURE IF EXISTS dbo.sp_create_dim_customer;
GO
CREATE PROCEDURE sp_create_dim_customer
AS
BEGIN
Drop table [pc_sale_datapipeline].[dbo].[dim_customer]
       Create Table [pc_sale_datapipeline].[dbo].[dim_customer] (
       [customerID] INT IDENTITY (1,1) Primary Key,
       [Customer_Name] [nvarchar](250) not null,
       [Customer_Surname] [nvarchar](250) not null,
       [Customer_Contact_Number] [nvarchar](250) not null,
       [Customer_Email_Address] [nvarchar](250) not null)
       Insert into [pc_sale_datapipeline].[dbo].[dim_customer] (Customer_Name,Customer_Surname,Customer_Contact_Number,Customer_Email_Address)
       select Distinct Customer_Name,Customer_Surname,Customer_Contact_Number,Customer_Email_Address
       from [pc_sale_datapipeline].[dbo].[raw_pc_data]
       End;
   --sp dim employee--   

DROP PROCEDURE IF EXISTS dbo.sp_create_dim_employee;
GO
CREATE PROCEDURE sp_create_dim_employee
AS
BEGIN
       Drop table [pc_sale_datapipeline].[dbo].[dim_employee]
       Create Table [pc_sale_datapipeline].[dbo].[dim_employee] (
       [EmployeeID] INT IDENTITY (1,1) Primary Key,
       [Sales_Person_Name] [nvarchar](250) not null,
       [Sales_Person_Department] [nvarchar](250) not null)
       Insert into [pc_sale_datapipeline].[dbo].[dim_employee] (Sales_Person_Name,Sales_Person_Department)
       select Distinct Sales_Person_Name,Sales_Person_Department
       from [pc_sale_datapipeline].[dbo].[raw_pc_data]
       End;
      
-- sp dim product--
DROP PROCEDURE IF EXISTS dbo.sp_create_dim_product;
GO
CREATE PROCEDURE sp_create_dim_product
AS
BEGIN
        Drop table [pc_sale_datapipeline].[dbo].[dim_product]
       Create Table [pc_sale_datapipeline].[dbo].[dim_product] (
       [ProductID] INT IDENTITY (1,1) Primary Key,
       [PC_Make] [nvarchar](250) not null,
       [PC_Model] [nvarchar](250) not null,
       [Storage_Type] [nvarchar](250) not null,
       [RAM] [nvarchar](250) not null,
       [Storage_Capacity] [nvarchar](250) not null)

       Insert into [pc_sale_datapipeline].[dbo].[dim_product] (PC_Make,PC_Model,Storage_Type,RAM,Storage_Capacity)
       select Distinct PC_Make,PC_Model,Storage_Type,RAM,Storage_Capacity
       from [pc_sale_datapipeline].[dbo].[raw_pc_data]
   End;
   
--sp dim store--
DROP PROCEDURE IF EXISTS dbo.sp_create_dim_store;
GO
CREATE PROCEDURE sp_create_dim_store
AS
BEGIN  
       Drop table [pc_sale_datapipeline].[dbo].[dim_store]
       Create Table [pc_sale_datapipeline].[dbo].[dim_store] (
       [StoreID] INT IDENTITY (1,1) Primary Key,
       [Shop_Name] [nvarchar](250) not null,
       [Shop_Age] [nvarchar](250) not null)
       Insert into [pc_sale_datapipeline].[dbo].[dim_store] (Shop_Name,Shop_Age)
       select Distinct Shop_Name,Shop_Age
       from [pc_sale_datapipeline].[dbo].[raw_pc_data]
       End;
      
--spdim payment-- 
DROP PROCEDURE IF EXISTS dbo.sp_create_dim_payment;
GO
CREATE PROCEDURE sp_create_dim_payment
AS
BEGIN
       Drop table [pc_sale_datapipeline].[dbo].[dim_payment]
       Create Table [pc_sale_datapipeline].[dbo].[dim_payment] (
       [PaymentID] INT IDENTITY (1,1) Primary Key,
       [Payment_Method] [nvarchar](250) not null)
       Insert into [pc_sale_datapipeline].[dbo].[dim_payment] (Payment_Method)
       select Distinct Payment_Method
       from [pc_sale_datapipeline].[dbo].[raw_pc_data]
       End;
    
--sp dim channel--
DROP PROCEDURE IF EXISTS dbo.sp_create_dim_channel;
GO
CREATE PROCEDURE sp_create_dim_channel
AS
BEGIN
Drop table [pc_sale_datapipeline].[dbo].[dim_channel]
       Create Table [pc_sale_datapipeline].[dbo].[dim_channel] (
       [ChannelID] INT IDENTITY (1,1) Primary Key,
       [Channel] [nvarchar](250) not null)
       Insert into [pc_sale_datapipeline].[dbo].[dim_channel] (Channel)
       select Distinct Channel
       from [pc_sale_datapipeline].[dbo].[raw_pc_data]
       End;
       
--sp dim priority--
DROP PROCEDURE IF EXISTS dbo.sp_create_dim_priority;
GO       
CREATE PROCEDURE sp_create_dim_priority
AS
BEGIN
       Drop table [pc_sale_datapipeline].[dbo].[dim_priority]
       Create Table [pc_sale_datapipeline].[dbo].[dim_priority] (
       [PriorityID] INT IDENTITY (1,1) Primary Key,
       [Priority] [nvarchar](250) not null)
       Insert into [pc_sale_datapipeline].[dbo].[dim_priority] (Priority)
       select Distinct Priority
       from [pc_sale_datapipeline].[dbo].[raw_pc_data]
       End;
--sp all execution--

      exec sp_create_dim_payment
      exec sp_create_dim_product
      exec sp_create_dim_store;
      exec sp_create_dim_priority;
      Exec sp_create_dim_channel;
      exec sp_create_dim_location;
      exec sp_create_dim_date;
      exec sp_create_dim_customer;
      exec sp_create_dim_employee;
      



      
     
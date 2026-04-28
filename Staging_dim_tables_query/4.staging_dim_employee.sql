--1.create table if not exist--
-- drop table is remove any table if exist--
-- we include the creation of unique identifier which is the Dim-ID--
       Drop table [pc_sale_datapipeline].[dbo].[dim_employee]
       Create Table [pc_sale_datapipeline].[dbo].[dim_employee] (
       [EmployeeID] INT IDENTITY (1,1) Primary Key,
       [Sales_Person_Name] [nvarchar](250) not null,
       [Sales_Person_Department] [nvarchar](250) not null)
 --2 Insert data into the table--
 -- the reason why we select distinct is to remove duplicates--
       Insert into [pc_sale_datapipeline].[dbo].[dim_employee] (Sales_Person_Name,Sales_Person_Department)
       select Distinct Sales_Person_Name,Sales_Person_Department
       from [pc_sale_datapipeline].[dbo].[raw_pc_data]
--3 select all the data from dim loaction --
       select * from [pc_sale_datapipeline].[dbo].[dim_employee]
--4 add primary key which is the locationID when creating the table on stgep 1--
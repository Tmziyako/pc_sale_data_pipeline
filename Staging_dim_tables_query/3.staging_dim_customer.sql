--1.create table if not exist--
-- drop table is remove any table if exist--
-- we include the creation of unique identifier which is the Dim-ID--
       Drop table [pc_sale_datapipeline].[dbo].[dim_customer]
       Create Table [pc_sale_datapipeline].[dbo].[dim_customer] (
       [customerID] INT IDENTITY (1,1) Primary Key,
       [Customer_Name] [nvarchar](250) not null,
       [Customer_Surname] [nvarchar](250) not null,
       [Customer_Contact_Number] [nvarchar](250) not null,
       [Customer_Email_Address] [nvarchar](250) not null)
 --2 Insert data into the table--
 -- the reason why we select distinct is to remove duplicates--
       Insert into [pc_sale_datapipeline].[dbo].[dim_customer] (Customer_Name,Customer_Surname,Customer_Contact_Number,Customer_Email_Address)
       select Distinct Customer_Name,Customer_Surname,Customer_Contact_Number,Customer_Email_Address
       from [pc_sale_datapipeline].[dbo].[raw_pc_data]
--3 select all the data from dim loaction --
       select * from [pc_sale_datapipeline].[dbo].[dim_customer]
--4 add primary key which is the locationID when creating the table on stgep 1--
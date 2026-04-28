--1.create table if not exist--
-- drop table is remove any table if exist--
-- we include the creation of unique identifier which is the Dim-ID--
       Drop table [pc_sale_datapipeline].[dbo].[dim_store]
       Create Table [pc_sale_datapipeline].[dbo].[dim_store] (
       [StoreID] INT IDENTITY (1,1) Primary Key,
       [Shop_Name] [nvarchar](250) not null,
       [Shop_Age] [nvarchar](250) not null)
 --2 Insert data into the table--
 -- the reason why we select distinct is to remove duplicates--
       Insert into [pc_sale_datapipeline].[dbo].[dim_store] (Shop_Name,Shop_Age)
       select Distinct Shop_Name,Shop_Age
       from [pc_sale_datapipeline].[dbo].[raw_pc_data]
--3 select all the data from dim loaction --
       select * from [pc_sale_datapipeline].[dbo].[dim_store]
--4 add primary key which is the locationID when creating the table on stgep 1--
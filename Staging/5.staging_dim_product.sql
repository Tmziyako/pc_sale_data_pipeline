--1.create table if not exist--
-- drop table is remove any table if exist--
-- we include the creation of unique identifier which is the Dim-ID--
       Drop table [pc_sale_datapipeline].[dbo].[dim_product]
       Create Table [pc_sale_datapipeline].[dbo].[dim_product] (
       [ProductID] INT IDENTITY (1,1) Primary Key,
       [PC_Make] [nvarchar](250) not null,
       [PC_Model] [nvarchar](250) not null,
       [Storage_Type] [nvarchar](250) not null,
       [RAM] [nvarchar](250) not null,
       [Storage_Capacity] [nvarchar](250) not null)
 --2 Insert data into the table--
 -- the reason why we select distinct is to remove duplicates--
       Insert into [pc_sale_datapipeline].[dbo].[dim_product] (PC_Make,PC_Model,Storage_Type,RAM,Storage_Capacity)
       select Distinct PC_Make,PC_Model,Storage_Type,RAM,Storage_Capacity
       from [pc_sale_datapipeline].[dbo].[raw_pc_data]
--3 select all the data from dim loaction --
       select * from [pc_sale_datapipeline].[dbo].[dim_product]
--4 add primary key which is the locationID when creating the table on stgep 1--
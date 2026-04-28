
--1.create table if not exist--
-- drop table is remove any table if exist--
-- we include the creation of unique identifier which is the Dim-ID--
       Drop table [pc_sale_datapipeline].[dbo].[dim_location]
       Create Table [pc_sale_datapipeline].[dbo].[dim_location] (
       [locationID] INT IDENTITY (1,1) Primary Key,
       [Continent] [nvarchar](250) not null,
       [Country_or_State] [nvarchar](250) not null,
       [Province_or_City] [nvarchar](250) not null)
 --2 Insert data into the table--
       Insert into [pc_sale_datapipeline].[dbo].[dim_location] (Continent,Country_or_State,Province_or_City)
       select Continent,Country_or_State,Province_or_City
       from [pc_sale_datapipeline].[dbo].[raw_pc_data]
--3 select all the data from dim loaction --
       select * from [pc_sale_datapipeline].[dbo].[dim_location]
--4 add primary key which is the locationID when creating the table on stgep 1--
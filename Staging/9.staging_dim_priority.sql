--1.create table if not exist--
-- drop table is remove any table if exist--
-- we include the creation of unique identifier which is the Dim-ID--

--A stored procedure is essentially a saved block of SQL code that you can run whenever you need. 
--Instead of rewriting the same SQL statements over and over, you package them into one reusable procedure.
--
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
END;
exec sp_create_dim_priority

       
 --2 Insert data into the table--
 -- the reason why we select distinct is to remove duplicates--
       
--3 select all the data from dim loaction --
       select * from [pc_sale_datapipeline].[dbo].[dim_priority]
--4 add primary key which is the locationID when creating the table on stgep 1--
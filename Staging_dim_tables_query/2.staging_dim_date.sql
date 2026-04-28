
-- Drop the table if it already exists
IF OBJECT_ID('[pc_sale_datapipeline].[dbo].[dim_date]', 'U') IS NOT NULL
    DROP TABLE [pc_sale_datapipeline].[dbo].[dim_date];

-- Create the dimension table
CREATE TABLE [pc_sale_datapipeline].[dbo].[dim_date] (
    [DateID] INT IDENTITY (1,1) PRIMARY KEY,
    [Purchase_Date] DATE NOT NULL,
    [Ship_Date] DATE NULL   -- allow NULL if ship date is missing
);

-- Insert converted dates from raw data
INSERT INTO [pc_sale_datapipeline].[dbo].[dim_date] (Purchase_Date, Ship_Date)
SELECT Distinct
    TRY_CONVERT(DATE, Purchase_Date),
    TRY_CONVERT(DATE, Ship_Date)
FROM [pc_sale_datapipeline].[dbo].[raw_pc_data];

select * from [pc_sale_datapipeline].[dbo].[dim_date]
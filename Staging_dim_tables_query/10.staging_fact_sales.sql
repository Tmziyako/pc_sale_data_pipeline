--1. Clean up data e.g if existing then delete then recreate--
IF OBJECT_ID('[pc_sale_datapipeline].[dbo].[fact_sales]', 'U') IS NOT NULL
    DROP TABLE [pc_sale_datapipeline].[dbo].[fact_sales];

-- 2. CREATE Fact TABLE--
-- Fact table is the surrogate key(unique identifier--
--the other IDs are foreign keys that connect to dimensions--
--the ither are measures to be analysed--
CREATE TABLE [pc_sale_datapipeline].[dbo].[fact_sales] (
    FactID INT IDENTITY(1,1) PRIMARY KEY,
    DateID INT NOT NULL,
    PriorityID INT NOT NULL,
    ProductID INT NOT NULL,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    StoreID INT NOT NULL,
    PaymentID INT NOT NULL,
    ChannelID INT NOT NULL,
    LocationID INT NOT NULL,
    discount_amount INT NOT NULL,
    finance_amount NVARCHAR(250) NOT NULL,
    credit_score INT NOT NULL,
    pc_market_price INT NOT NULL,
    total_sales_per_employee INT NOT NULL,
    sales_price INT NOT NULL,
    cost_price INT NOT NULL,
    cost_of_repair NVARCHAR(250) NULL);
    --3. Close down the craete table at the end with );--
    --Inserting into the created fact table-- 
    --Loads data into fact table by joining raw_pc_data with all dimensions tables--
    --Each join matches descriptive attributes in raw data (like PC_Make, Customer_Name, Payment_Method) to the corresponding dimension table--
    --The dimension tables return their surrogate keys (DateID, ProductID, etc.), which are stored in the fact table--
    --The measures (discount_amount, finance_amount, sales_price, etc.) are taken directly from raw data--
    --The raw data stored dates as text hence we used TRY_Convert(DATE,r.purchase_date,103) converts text to date using the correct format(dd/mm/yyyy)(hence the 103)--
    INSERT INTO [pc_sale_datapipeline].[dbo].[fact_sales] 
    (DateID, PriorityID, ProductID, CustomerID, EmployeeID, StoreID, PaymentID, ChannelID, LocationID, 
     discount_amount, finance_amount, credit_score, pc_market_price, total_sales_per_employee, sales_price, cost_price, cost_of_repair)
SELECT DISTINCT
    d.DateID,
    pr.PriorityID,
    p.ProductID,
    c.CustomerID,
    e.EmployeeID,
    s.StoreID,
    pm.PaymentID,
    ch.ChannelID,
    l.LocationID,
    r.discount_amount,
    r.finance_amount,
    r.credit_score,
    r.pc_market_price,
    r.total_sales_per_employee,
    r.Sale_Price,
    r.cost_price,
    r.Cost_of_Repairs
FROM [pc_sale_datapipeline].[dbo].[raw_pc_data] r
INNER JOIN [pc_sale_datapipeline].[dbo].[dim_date] d  ON TRY_CONVERT(DATE,r.Purchase_Date,103) = d.Purchase_Date
AND TRY_CONVERT(DATE,r.ship_Date, 103) = d.Ship_Date
INNER JOIN [pc_sale_datapipeline].[dbo].[dim_product] p ON r.PC_Make = p.PC_Make
AND r.PC_Model = P.PC_Model
AND r.Storage_Type = p.Storage_Type
AND r.RAM =P.RAM
AND r.Storage_Capacity = p.Storage_Capacity
INNER JOIN [pc_sale_datapipeline].[dbo].[dim_priority] Pr ON r.Priority = Pr.Priority
INNER JOIN [pc_sale_datapipeline].[dbo].[dim_customer] c ON r.Customer_Name = c.Customer_Name
AND r.Customer_surname = c.Customer_Surname
AND r.Customer_Contact_Number = c.Customer_Contact_Number
AND r.Customer_Email_Address = c.Customer_Email_Address
INNER JOIN [pc_sale_datapipeline].[dbo].[dim_employee] e ON r.Sales_Person_Name = e.Sales_Person_Name
AND r.Sales_Person_Department = e.Sales_Person_Department
INNER JOIN [pc_sale_datapipeline].[dbo].[dim_payment] pm ON r.Payment_Method = pm.Payment_Method
INNER JOIN [pc_sale_datapipeline].[dbo].[dim_channel] ch ON r.Channel = ch.Channel
INNER JOIN [pc_sale_datapipeline].[dbo].[dim_location] l ON r.Continent = l.Continent
AND r.Country_or_State = l.Country_or_State
AND r.Province_or_City = l.Province_or_City
INNER JOIN [pc_sale_datapipeline].[dbo].[dim_store] s ON r.Shop_Name = s.Shop_Name
AND r.Shop_Age = s.Shop_Age;
-- 4. when we say altar table we command to make changes om the table created already--
-- Each ALTER TABLE adds a foreign key constraint linking the fact table column to the primary key in its dimension--
--Constraint apply a rule to this table so certain conditions must always be true--
--foreign key Ensures values in one table exist in another table, Every ProductID in fact_sales must exist in dim_product--
--why added the constraint: “These IDs in the fact table must match the IDs in the dimension tables.”--
ALTER TABLE [pc_sale_datapipeline].[dbo].[fact_sales]
ADD CONSTRAINT FK_fact_date FOREIGN KEY (DateID)
REFERENCES [pc_sale_datapipeline].[dbo].[dim_date](DateID);

ALTER TABLE [pc_sale_datapipeline].[dbo].[fact_sales]
ADD CONSTRAINT FK_fact_priority FOREIGN KEY (PriorityID)
REFERENCES [pc_sale_datapipeline].[dbo].[dim_priority](PriorityID);

ALTER TABLE [pc_sale_datapipeline].[dbo].[fact_sales]
ADD CONSTRAINT FK_fact_product FOREIGN KEY (ProductID)
REFERENCES [pc_sale_datapipeline].[dbo].[dim_product](ProductID);

ALTER TABLE [pc_sale_datapipeline].[dbo].[fact_sales]
ADD CONSTRAINT FK_fact_customer FOREIGN KEY (CustomerID)
REFERENCES [pc_sale_datapipeline].[dbo].[dim_customer](CustomerID);

ALTER TABLE [pc_sale_datapipeline].[dbo].[fact_sales]
ADD CONSTRAINT FK_fact_employee FOREIGN KEY (EmployeeID)
REFERENCES [pc_sale_datapipeline].[dbo].[dim_employee](EmployeeID);

ALTER TABLE [pc_sale_datapipeline].[dbo].[fact_sales]
ADD CONSTRAINT FK_fact_store FOREIGN KEY (StoreID)
REFERENCES [pc_sale_datapipeline].[dbo].[dim_store](StoreID);

ALTER TABLE [pc_sale_datapipeline].[dbo].[fact_sales]
ADD CONSTRAINT FK_fact_payment FOREIGN KEY (PaymentID)
REFERENCES [pc_sale_datapipeline].[dbo].[dim_payment](PaymentID);

ALTER TABLE [pc_sale_datapipeline].[dbo].[fact_sales]
ADD CONSTRAINT FK_fact_channel FOREIGN KEY (ChannelID)
REFERENCES [pc_sale_datapipeline].[dbo].[dim_channel](ChannelID);

ALTER TABLE [pc_sale_datapipeline].[dbo].[fact_sales]
ADD CONSTRAINT FK_fact_location FOREIGN KEY (LocationID)
REFERENCES [pc_sale_datapipeline].[dbo].[dim_location](LocationID);
--Selecting the Fact tables with data--
 select * from [pc_sale_datapipeline].[dbo].[fact_sales]

    

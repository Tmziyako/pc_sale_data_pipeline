
-- 1. CLEANUP
IF OBJECT_ID('[pc_sale_datapipeline].[dbo].[fact_sales]', 'U') IS NOT NULL
    DROP TABLE [pc_sale_datapipeline].[dbo].[fact_sales];

-- 2. CREATE TABLE
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
    finanace_amount [nvarchar] (250) NOT NULL,
    credit_score INT NOT NULL,
    pc_market_price INT NOT NULL,
    total_sales_per_employee INT NOT NULL,
    sales_price INT NOT NULL,
    cost_price INT NOT NULL,
    cost_of_repair [nvarchar] (250) NULL)

    -- Fixed: Added commas at the end of EVERY constraint line except the last one
    CONSTRAINT FK_fact_date FOREIGN KEY (DateID) REFERENCES dim_date(DateID),
    CONSTRAINT FK_fact_priority FOREIGN KEY (PriorityID) REFERENCES dim_priority(PriorityID),
    CONSTRAINT FK_fact_customer FOREIGN KEY (CustomerID) REFERENCES dim_customer(CustomerID),
    CONSTRAINT FK_fact_product FOREIGN KEY (ProductID) REFERENCES dim_product(ProductID),
    CONSTRAINT FK_fact_employee FOREIGN KEY (EmployeeID) REFERENCES dim_employee(EmployeeID),
    CONSTRAINT FK_fact_store FOREIGN KEY (StoreID) REFERENCES dim_store(StoreID),
    CONSTRAINT FK_fact_payment FOREIGN KEY (PaymentID) REFERENCES dim_payment(PaymentID),
    CONSTRAINT FK_fact_channel FOREIGN KEY (ChannelID) REFERENCES dim_channel(ChannelID),
    CONSTRAINT FK_fact_location FOREIGN KEY (LocationID) REFERENCES dim_location(LocationID)

-- 3. INSERT DATA
INSERT INTO [pc_sale_datapipeline].[dbo].[fact_sales] 
    (DateID, PriorityID, ProductID, CustomerID, EmployeeID, StoreID, PaymentID, ChannelID, LocationID, 
     discount_amount, finanace_amount, credit_score, pc_market_price, total_sales_per_employee, sales_price, cost_price, cost_of_repair)
SELECT DISTINCT
    dim_date.DateID,
    dim_priority.PriorityID,
    dim_product.ProductID,
    dim_customer.CustomerID,
    dim_employee.EmployeeID,
    dim_store.StoreID,
    dim_payment.PaymentID,
    dim_channel.ChannelID,
    dim_location.LocationID,
    raw_pc_data.discount_amount,
    raw_pc_data.finance_amount,
    raw_pc_data.credit_score,
    raw_pc_data.pc_market_price,
    raw_pc_data.total_sales_per_employee,
    raw_pc_data.sales_price,
    raw_pc_data.cost_price,
    raw_pc_data.cost_of_repair
FROM [pc_sale_datapipeline].[dbo].[raw_pc_data]
INNER JOIN dim_date     ON raw_pc_data.sale_date      = dim_date.FullDate 
INNER JOIN dim_priority ON raw_pc_data.priority_level = dim_priority.PriorityName
INNER JOIN dim_product  ON raw_pc_data.product_name   = dim_product.ProductName
INNER JOIN dim_customer ON raw_pc_data.customer_email = dim_customer.CustomerEmail
INNER JOIN dim_employee ON raw_pc_data.employee_name  = dim_employee.EmployeeName
INNER JOIN dim_store    ON raw_pc_data.store_name     = dim_store.StoreName
INNER JOIN dim_payment  ON raw_pc_data.payment_method = dim_payment.PaymentMethod
INNER JOIN dim_channel  ON raw_pc_data.channel_name   = dim_channel.ChannelName
INNER JOIN dim_location ON raw_pc_data.city           = dim_location.City;

# 🖥️ PC Sales Data Pipeline

## 📌 Project Overview

This project demonstrates an end-to-end **data pipeline** designed to process PC sales data from raw ingestion through data modelling and transformation. The pipeline extracts raw PC sales data, cleans and transforms it, and loads it into dimension and fact tables. This enables efficient querying and supports business intelligence for efficient analyitcs and reporting.A data pipeline is important because it automates the movement, transformation, and delivery of data, ensuring that information flows reliably from source systems to destinations. Without pipelines, analytics would be slow, error‑prone, and outdated, making it harder for businesses to make timely, data‑driven decisions.

# 🏗️ Architecture
The pipeline follows a layered architecture:

- #**Raw Layer:** Source CSV files  
- Dimension table creation and surrogate keys  
- #**Data Modelling:** Cleans and transforms data through star schema 
- #**SQL:** create dim tables, fact tables and stored procedures using the SMSS  

## 🔑 Skills Demonstrated
- SQL Server stored procedures for ETL  
- Data modeling with star schema design  
- Dimension table creation and surrogate keys  
- Data cleaning and transformation (e.g., `TRY_CONVERT`, `DISTINCT`)  
- Automation of pipeline execution  

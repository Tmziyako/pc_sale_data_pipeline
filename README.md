
# 🖥️ PC Sales Data Pipeline

## 📌 Project Overview

This project demonstrates an end-to-end **data pipeline** designed to process PC sales data from raw ingestion through data modelling and transformation. The pipeline extracts raw PC sales data, cleans and transforms it, and loads it into dimension and fact tables. This enables efficient querying and supports business intelligence for efficient analyitcs and reporting.A data pipeline is important because it automates the movement, transformation, and delivery of data, ensuring that information flows reliably from source systems to destinations. Without pipelines, analytics would be slow, error‑prone, and outdated, making it harder for businesses to make timely, data‑driven decisions.

# 🏗️ Architecture
The pipeline follows a layered architecture:
#**Raw Layer:** Source CSV files
#**Staging Layer:** Cleans and transforms data using stored procedures
#**Analytics Layer:** Star schema for reporting

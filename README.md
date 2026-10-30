# Healthcare-Inventory-and-Patient-Management-System
<img width="529" height="587" alt="Screenshot 2026-05-03 182315" src="https://github.com/user-attachments/assets/09aba865-e38b-4b6b-9c8e-68b17f1cfa0a" />
A comprehensive Healthcare Data Warehouse built using **MS SQL Server** based on a **Star Schema** architecture. This project not only implements a robust multi-dimensional database structure but also includes a full suite of analytical **T-SQL queries** designed to solve critical real-world healthcare operational, financial, and clinical questions.

# Project Architecture (Star Schema)
The system is built around a centralized **FactTable** linked via Foreign Keys to various Dimension tables, optimized for high-performance analytical processing (OLAP).

# Database Entities & Tables
*   **`FactTable`**: The core table containing measurable quantitative metrics (e.g., Gross Charge, Payments) and dimensional foreign keys.
*   **`dimPatient`**: Captures comprehensive patient data including Name, Email, Age, Gender, and Location.
*   **`dimCptCode`**: Stores clinical procedures mapped by CPT groupings (Medicine, Surgery, Radiology, etc.).
*   **`dimPhysician`**: Contains provider metrics, NPI codes, specialties, and FTE status.
*   **`dimLocation`**: Tracks clinical facility locations (e.g., Evergreen Clinic, Twin Mountains Hospital).
*   **`dimPayer`**: Manages insurance types (Medicare, Medicaid, Commercial, etc.).
*   **`dimTransaction`**, **`dimDiagnosisCode`**, **`dimDate`**: Support dimensions for transaction tracking, ICD mapping, and time-series analysis.

# Tech Stack
- **Database Engine:** Microsoft SQL Server (MS SQL Express)
- **Query Tool:** SQL Server Management Studio (SSMS)
- **Language:** Transact-SQL (T-SQL)

# Analytical Business Questions Solved (Included Scripts)
The project includes a dedicated `analytical_queries.sql` script featuring solution code for key healthcare metrics, categorized by difficulty:

# Easy level
1.  **Revenue Volumes**: Filtering data volume based on financial thresholds (e.g., identifying rows with `GrossCharge > $100`).
2.  **Unique Patient Counting**: Determining distinct total patient reach inside the ecosystem.
3.  **Procedure Classification**: Breaking down medical procedure frequencies (`CptCodes`) within each overarching clinical category (`CptGrouping`).

# Intermediate Level
4.  **Insurance Claim Insights**: Utilizing multi-table joins and subqueries to pinpoint physician workloads tied exclusively to `Medicare` claims.
5.  **Financial Efficiency (Gross Collection Rate)**: Calculating the Gross Collection Rate (**GCR = Total Payments / Total Gross Charges**) aggregated across different hospital facility locations to measure financial performance.
6.  **Patient Demographic Segmentation (Case/Bucketing)**: Utilizing conditional logic (`CASE WHEN`) to bucket patients into custom age demographics (`Under 18`, `18-65`, `Over 65`) alongside complex string concatenations for neat reporting (`PatientName` and `CityName`).

# Project Structure & Execution Setup
To run this repository locally:
1. Clone the repository via Git Bash:
   ```bash
   git clone https://github.com
   ```
2. Open **SQL Server Management Studio (SSMS)**.
3. Open and run your main table creation/schema setup script.
4. Run `create_relations_and_constraints.sql` to link all Foreign Key constraints.
5. Open and execute `analytical_queries.sql` to experience the business dashboard data extraction in action!

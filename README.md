# Hospital_Management_System

A relational SQL database and query collection built around a hospital management workflow. It models day-to-day clinical and administrative records—including physicians, hospital departments, staff affiliations, nurses, patients, medical diagnoses, prescriptions, and diagnostic procedures—alongside a progressive set of SQL queries ranging from basic data retrieval to window functions and CTEs.

## What's Inside

- **`Hospital_Database.sql`**: Sets up the `Hospital_Management_System` database, creates the core tables (`Physician`, `department`, `affiliated_with`, `Nurse`, `Patient`, `PATIENT_DIAGNOSIS`, and `procedures`), defines primary and foreign key relationships, and populates them with sample hospital records.
- **`Hospital_Query.sql`**: Contains the complete set of practice and analytical queries organized across core SQL concepts.

## Queries Covered

- **Foundational Retrieval & Filtering**: Sorting physician names alphabetically, filtering patient and nurse records with `WHERE`, `AND`/`OR`, `NOT`, `LIKE` pattern matching, and `LIMIT` pagination.
- **Data Modification & Schema Updates**: Updating patient records (`UPDATE`) and altering table structures (`ALTER TABLE`).
- **Joins & Multi-Table Lookups**: Connecting patients, physicians, departments, affiliations, and diagnoses using `INNER JOIN` and `LEFT JOIN`.
- **Subqueries**: Finding procedures above or below average cost, locating maximum-cost procedures, and filtering physicians or patients based on nested conditions.
- **Window Functions & CTEs**: Ranking procedure costs, calculating running totals and percentage shares, comparing consecutive procedures with `LAG` and `LEAD`, computing moving averages (`ROWS` vs. `RANGE`), partitioning patient and nurse counts, and chaining CTEs for multi-step physician and diagnosis analysis.
- **Additional SQL Patterns**: Filtering grouped results with `HAVING`, conditional aggregation and bucketing with `CASE WHEN`, distinct counts, `NOT EXISTS`, combining staff lists with `UNION ALL`, string extraction, and quartile/percentile ranking with `NTILE` and `PERCENT_RANK`.

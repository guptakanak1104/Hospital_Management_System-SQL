Hospital_Management_System

This repository contains my SQL practice project built around a Hospital_Management_System database. I created this project to go beyond basic queries and practice writing real-world analytical SQL on connected healthcare data—covering physicians, departments, nurses, patients, diagnoses, and medical procedures.

What This Project Is About

The database models the day-to-day operations of a hospital. It keeps track of doctors and their specialties, which departments they belong to and head, nursing staff and their registration status, patient records, clinical diagnoses with prescriptions, and the costs of different medical procedures.

Instead of testing SQL concepts on isolated, single-table examples, everything here is connected so queries can answer practical questions like how patient workload is distributed across doctors, which diagnoses show up most frequently, and how procedure costs compare across the catalog.

What Queries Are Included

The query file is organized progressively from core SQL fundamentals to more advanced analytical patterns:

Basics, Filtering & Table Updates: Sorting records, filtering with logical and LIKE pattern operators, pagination, updating patient details, and altering table columns.

Joins & Subqueries: Combining data across physicians, departments, affiliations, patients, and diagnoses using INNER and LEFT joins, along with scalar and IN subqueries to compare costs and filter clinical records.

Window Functions & CTEs: Ranking procedures by cost (RANK, DENSE_RANK, ROW_NUMBER), calculating running totals and percentage shares, comparing consecutive rows with LAG and LEAD, working with FIRST_VALUE, LAST_VALUE, moving averages, ROWS vs. RANGE frames, and breaking down multi-step logic using single and chained Common Table Expressions (WITH).

Grouping, Conditional Logic & Set Operations: Filtering aggregated groups with HAVING, building conditional counts and cost tiers using CASE WHEN, checking unmatched records with NOT EXISTS, combining staff lists with UNION ALL, parsing text with string functions, and splitting procedures into quartiles with NTILE and PERCENT_RANK.

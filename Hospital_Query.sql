#SQL QUERIES

#1. Write a query in SQL to obtain the name of the physician in alphabetical order. 
SELECT NAME AS PHYSICIAN_NAME
FROM PHYSICIAN
ORDER BY NAME;

#2. Write a query in SQL to obtain the fullname of the patients whose gender is male.
SELECT CONCAT(NAME,' ',SURNAME) AS Patients_Fullname,GENDER
FROM PATIENT
WHERE GENDER = 'MALE';

#3. Write a query in SQL to find the name of the nurse who are the head of their department and are registered.
SELECT * FROM NURSE
WHERE POSITION ='Head Nurse' AND REGISTERED = "YES";

#4. Write a query in SQL to find the name of the nurse who are Team Leader or not registered.
SELECT NAME,POSITION,REGISTERED
FROM NURSE
WHERE Position = 'Team Leader' OR REGISTERED = "NO";

#5. Write a query to obtain the avg cost of all the medical procedures.
SELECT AVG(COST) as Average_cost
FROM PROCEDURES;

#6 Write a query to obtain name and cost of the procedure whose cost is greater than 2000.
SELECT NAME as Procedure_Name,COST as Procedure_Cost 
FROM PROCEDURES
WHERE NOT COST < 2000;

#7. Write a query to update the name of the patient to Robert Fernandez having patientid as 5.
UPDATE PATIENT
SET NAME = 'Robert',SURNAME = 'Fernandez'
WHERE PATIENT_ID = 5;

SELECT * FROM PATIENT;

#8. Write a query to drop phone column from patient table.
ALTER TABLE Patient
DROP phone;

SELECT * FROM PATIENT;

#9. Second maximum cost of medical procedure
SELECT NAME,MAX(COST) as Procedure_cost
FROM PROCEDURES 
GROUP BY name
ORDER BY Procedure_cost DESC
LIMIT 1,1;

#Like Operator

#10. Write a query in SQL to obtain the name of the patients starting with letter A.
SELECT CONCAT(NAME,' ',SURNAME) AS FULL_NAME,GENDER
FROM PATIENT
WHERE CONCAT(NAME,' ',SURNAME) LIKE 'A%';

#11. Write a query in SQL to obtain the name of the patients whose third letter is M.
SELECT CONCAT(NAME,' ',SURNAME) AS FULL_NAME,GENDER
FROM PATIENT
WHERE CONCAT(NAME,' ',SURNAME) LIKE '__M%';

#12. Write a query in SQL to obtain the name of the patients whose name start with letter J and ends with Z.
SELECT CONCAT(NAME,' ',SURNAME) AS FULL_NAME,GENDER
FROM PATIENT
WHERE CONCAT(NAME,' ',SURNAME) LIKE 'J%Z';

#13. Write a query to obtain patient details having patient_id 11 to 20.
SELECT * 
FROM PATIENT
LIMIT 10,10;

#14. Find diagnoses occurring at least twice.
SELECT Diagnosis, COUNT(*) AS cnt
FROM PATIENT_DIAGNOSIS
GROUP BY Diagnosis
HAVING COUNT(*) >= 2;

#15. Count registered and unregistered nurses for each position.
SELECT position,
       SUM(CASE WHEN registered = 'Yes' THEN 1 ELSE 0 END) AS registered_yes,
       SUM(CASE WHEN registered = 'No' THEN 1 ELSE 0 END) AS registered_no
FROM Nurse
GROUP BY position;

#16. Categorize procedures into cost tiers and count how many are in each tier.
SELECT CASE
           WHEN cost < 1000 THEN 'Low'
           WHEN cost < 4000 THEN 'Medium'
           ELSE 'High'
       END AS cost_tier,
       COUNT(*) AS proc_count
FROM procedures
GROUP BY CASE
             WHEN cost < 1000 THEN 'Low'
             WHEN cost < 4000 THEN 'Medium'
             ELSE 'High'
         END;

#17. Count distinct diagnoses and distinct prescriptions in the diagnosis table.
SELECT COUNT(DISTINCT Diagnosis) AS unique_diagnoses,
       COUNT(DISTINCT Prescription) AS unique_prescriptions
FROM PATIENT_DIAGNOSIS;

#18. Find physicians who have no records in the diagnosis table.
SELECT employeeid, name, position
FROM Physician ph
WHERE NOT EXISTS (
    SELECT 1 FROM PATIENT_DIAGNOSIS pd WHERE pd.Physician_id = ph.employeeid
);

#19. Combine physician and nurse names with their role into one list.
SELECT name, 'Physician' AS role FROM Physician
UNION ALL
SELECT name, 'Nurse' AS role FROM Nurse;

#20. Extract the text after the first space in each physician's position.
SELECT name, position,
       SUBSTRING(position, LOCATE(' ', position) + 1) AS role_detail
FROM Physician
WHERE LOCATE(' ', position) > 0;

#21. Divide procedures into 4 cost buckets and show each procedure's percentile rank.
SELECT name, cost,
       NTILE(4) OVER (ORDER BY cost) AS cost_bucket,
       PERCENT_RANK() OVER (ORDER BY cost) AS pct_rank
FROM procedures;

#JOINS

#22.  Write a query in SQL to obtain the name of the physicians who are the head of each department
select p.name as Doctor_name,d.dept_name
from physician p
inner join department d
on p.employeeid = d.head;

#23. Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement
select CONCAT(p.name,' ',p.SURNAME) as PATIENT_NAME,ph.NAME as PHY_WHO_DID_PRI_TREATMENT
FROM PATIENT p
LEFT JOIN PHYSICIAN ph
ON p.PRIMARY_CHECK = ph.EMPLOYEEID;

#24. Write a query in SQL to obtain the name of the physician with the department who are done with affiliation.
select p.name as physician_name,d.dept_name as department_name
from physician p
inner join affiliated_with aw
on p.employeeid = aw.physicianid
inner join department d
on aw.departmentid = d.department_id
where primaryaffiliation='t';

#25. Write a query to obtain physician name,position and department they are affiliated with.
SELECT p.name AS physician_name, p.position AS physician_position, d.dept_name AS department_name
FROM Physician p
JOIN affiliated_with a 
ON p.employeeid = a.physicianid
JOIN department d
ON a.departmentid = d.department_id;

#26. Write a query in SQL to obtain the patient name from which physician they get primary_checkup and also mention the patient diagnosis with prescription.
SELECT PH.EMPLOYEEID,PH.NAME AS Physician_Name,PH.POSITION AS Designation,P.PATIENT_ID,CONCAT(P.NAME,' ',P.SURNAME) AS Patient_treated,P.GENDER,PD.DIAGNOSIS,PD.PRESCRIPTION
FROM PATIENT_DIAGNOSIS pd
LEFT JOIN Physician ph
ON pd.Physician_id = ph.employeeid
LEFT JOIN PATIENT P
ON P.PATIENT_ID = PD.PATIENT_ID;

#SUBQUERY

#27. Write a query in SQL to obtain the maximum cost of the medical procedure.
SELECT NAME,COST FROM PROCEDURES
WHERE COST IN (SELECT MAX(COST) FROM PROCEDURES);

#28. Write a query in SQL to obtain the details of patient who has diagnosed with chronic pain.
SELECT * FROM Patient
WHERE patient_id IN (SELECT Patient_ID FROM PATIENT_DIAGNOSIS WHERE Diagnosis = 'Chronic Pain');

#29. Write a query in SQL to obtain the procedure name and cost whose cost is greater than the avg cost of all the procedure.
SELECT name as Procedure_name,cost as Procedure_cost
FROM procedures
WHERE cost > (SELECT AVG(cost) FROM procedures);

#30. Write a query in SQL to obtain the procedure name and cost whose cost is less than the avg cost of all the procedure.
SELECT name as Procedure_name,cost as Procedure_cost
FROM procedures
WHERE cost < (SELECT AVG(cost) FROM procedures);

#31. Write a query in SQL to obtain the physician name who are either head chief or senior in their respective department.
SELECT * 
FROM Physician 
WHERE position IN (SELECT position FROM Physician
                   WHERE position
                   LIKE '%Senior%' OR position LIKE '%Head Chief%'
                   );

#32.  Write a query in SQL to obtain the employeeid, physician name and position whose primary affiliation has not been done. 
SELECT * 
FROM Physician 
WHERE employeeid IN (SELECT physicianid 
                     FROM affiliated_with 
                     WHERE primaryaffiliation = 'f'
                     );

# Window Functions & CTEs

# 33. Rank procedures from highest to lowest cost.
SELECT code, name, cost, RANK() OVER (ORDER BY cost DESC) AS cost_rank
FROM procedures;

# 34. Return the top 2 highest-cost procedure tiers using a CTE.
WITH ranked_proc AS (
    SELECT code, name, cost, DENSE_RANK() OVER (ORDER BY cost DESC) AS rnk
    FROM procedures
)
SELECT code, name, cost FROM ranked_proc WHERE rnk <= 2;

#35. Show cumulative procedure cost ordered by procedure code.
SELECT code, name, cost, SUM(cost) OVER (ORDER BY code) AS running_cost
FROM procedures;

#36. Show each procedure's percentage share of total procedure cost.
SELECT name, cost, ROUND(cost * 100.0 / SUM(cost) OVER (), 2) AS pct_share
FROM procedures;

#37. Show each procedure's cost, average procedure cost, and difference from average.
SELECT name, cost, AVG(cost) OVER () AS avg_cost, cost - AVG(cost) OVER () AS diff_from_avg
FROM procedures;

# 38. Show each patient with the count of patients sharing their primary physician.
SELECT p.patient_id, CONCAT(p.name, ' ', p.surname) AS patient_name, p.primary_check,
       COUNT(*) OVER (PARTITION BY p.primary_check) AS physician_patient_count
FROM Patient p;

#39. Rank all physicians by their primary-checkup patient count using a CTE.
WITH load_cte AS (
    SELECT ph.employeeid, ph.name, COUNT(p.patient_id) AS patient_cnt
    FROM Physician ph
    LEFT JOIN Patient p ON ph.employeeid = p.primary_check
    GROUP BY ph.employeeid, ph.name
)
SELECT employeeid, name, patient_cnt, RANK() OVER (ORDER BY patient_cnt DESC) AS load_rank
FROM load_cte;

#40. Return the first patient alphabetically for each primary physician.
WITH ordered_patients AS (
    SELECT patient_id, name, surname, primary_check,
           ROW_NUMBER() OVER (PARTITION BY primary_check ORDER BY name, surname) AS rn
    FROM Patient
)
SELECT patient_id, name, surname, primary_check FROM ordered_patients WHERE rn = 1;

#41. Show each nurse with the count of nurses having the same position and registration status.
SELECT nurse_id, name, position, registered,
       COUNT(*) OVER (PARTITION BY position, registered) AS matching_nurses
FROM Nurse;

#42. Show physicians and their primary department alongside department head details using a CTE.
WITH dept_heads AS (
    SELECT d.department_id, d.dept_name, p.name AS head_name
    FROM department d
    JOIN Physician p ON d.head = p.employeeid
)
SELECT ph.name AS physician_name, dh.dept_name, dh.head_name,
       ROW_NUMBER() OVER (PARTITION BY ph.employeeid ORDER BY dh.dept_name) AS row_num
FROM Physician ph
JOIN affiliated_with aw ON ph.employeeid = aw.physicianid
JOIN dept_heads dh ON aw.departmentid = dh.department_id
WHERE aw.primaryaffiliation = 't';

#43. Compare each procedure's cost with the previous procedure by code.
SELECT code, name, cost, LAG(cost) OVER (ORDER BY code) AS prev_cost,
       cost - LAG(cost) OVER (ORDER BY code) AS cost_change
FROM procedures;

#44. Show each procedure alongside the next procedure's name and cost in code order.
SELECT code, name, cost, LEAD(name) OVER (ORDER BY code) AS next_procedure,
       LEAD(cost) OVER (ORDER BY code) AS next_cost
FROM procedures;

#45. Compare each procedure's cost to the first and last procedure costs ordered by code.
SELECT code, name, cost,
       FIRST_VALUE(cost) OVER (ORDER BY code) AS first_cost,
       LAST_VALUE(cost) OVER (ORDER BY code ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_cost
FROM procedures;

#46. Calculate a 3-row moving average of procedure cost ordered by code.
SELECT code, name, cost,
       AVG(cost) OVER (ORDER BY code ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg_3
FROM procedures;

#47. Compare cumulative procedure cost using ROWS versus RANGE ordered by cost.
SELECT code, name, cost,
       SUM(cost) OVER (ORDER BY cost ROWS UNBOUNDED PRECEDING) AS rows_running_sum,
       SUM(cost) OVER (ORDER BY cost RANGE UNBOUNDED PRECEDING) AS range_running_sum
FROM procedures;

#48. Rank diagnoses by how often they appear using CTEs and join diagnosis records.
WITH diag_counts AS (
    SELECT Diagnosis, COUNT(*) AS diag_total
    FROM PATIENT_DIAGNOSIS
    GROUP BY Diagnosis
),
diag_ranked AS (
    SELECT Diagnosis, diag_total, RANK() OVER (ORDER BY diag_total DESC) AS rnk
    FROM diag_counts
)
SELECT pd.Patient_ID, pd.Diagnosis, pd.Prescription, dr.diag_total, dr.rnk
FROM PATIENT_DIAGNOSIS pd
JOIN diag_ranked dr ON pd.Diagnosis = dr.Diagnosis;

#49. Find physicians affiliated with more than one department using chained CTEs.
WITH aff_summary AS (
    SELECT physicianid, COUNT(*) AS dept_count
    FROM affiliated_with
    GROUP BY physicianid
    HAVING COUNT(*) > 1
),
multi_phys AS (
    SELECT p.employeeid, p.name, a.dept_count
    FROM aff_summary a
    JOIN Physician p ON a.physicianid = p.employeeid
)
SELECT mp.employeeid, mp.name, mp.dept_count, d.dept_name, aw.primaryaffiliation
FROM multi_phys mp
JOIN affiliated_with aw ON mp.employeeid = aw.physicianid
JOIN department d ON aw.departmentid = d.department_id;

#50. Count distinct diagnoses and total diagnosis rows per physician in a CTE and rank physicians.
WITH phys_diag AS (
    SELECT Physician_id, COUNT(DISTINCT Diagnosis) AS distinct_diags, COUNT(*) AS total_diags
    FROM PATIENT_DIAGNOSIS
    GROUP BY Physician_id
)
SELECT p.name, pd.distinct_diags, pd.total_diags,
       RANK() OVER (ORDER BY pd.total_diags DESC) AS diag_rank
FROM phys_diag pd
JOIN Physician p ON pd.Physician_id = p.employeeid;

#51. Show each primary physician's patient count and percentage of all assigned patients using a CTE.
WITH p_counts AS (
    SELECT primary_check, COUNT(*) AS cnt
    FROM Patient
    GROUP BY primary_check
)
SELECT ph.name, pc.cnt, ROUND(pc.cnt * 100.0 / SUM(pc.cnt) OVER (), 2) AS pct_of_total
FROM p_counts pc
JOIN Physician ph ON pc.primary_check = ph.employeeid;

#52. Build a multi-CTE query showing patient diagnosis, primary physician, department, and physician diagnosis rank.
WITH diag_info AS (
    SELECT Patient_ID, Physician_id, Diagnosis, Prescription
    FROM PATIENT_DIAGNOSIS
),
phys_rank AS (
    SELECT Physician_id, COUNT(*) AS case_cnt, RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM PATIENT_DIAGNOSIS
    GROUP BY Physician_id
)
SELECT CONCAT(pt.name, ' ', pt.surname) AS patient_name, di.Diagnosis, di.Prescription,
       ph.name AS physician_name, d.dept_name, pr.case_cnt, pr.rnk
FROM diag_info di
JOIN Patient pt ON di.Patient_ID = pt.patient_id
JOIN Physician ph ON di.Physician_id = ph.employeeid
LEFT JOIN affiliated_with aw ON ph.employeeid = aw.physicianid AND aw.primaryaffiliation = 't'
LEFT JOIN department d ON aw.departmentid = d.department_id
JOIN phys_rank pr ON di.Physician_id = pr.Physician_id;

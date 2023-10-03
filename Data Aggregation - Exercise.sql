--Language: SQL

--  COUNT of Records 
-- After gaining access to this extremely valuable database, determine the exact number of records contained within it.

SELECT COUNT(*) FROM wizard_deposits;

--Language: SQL

-- Total Deposit Amount
-- Compose a SQL query that calculates the total sum of the deposit amount held at Gringotts Bank. 

SELECT SUM(deposit_amount) FROM wizard_deposits;

--Language: SQL

-- AVG Magic Wand Size
-- In your role as the database manager, compute the average size of "magic_wand_size" that belongs to wizards and round the result to the third decimal place. 

SELECT ROUND(AVG(magic_wand_size),3) FROM wizard_deposits;

--Language: SQL

-- MIN Deposit Charge
-- To become acquainted with the database, determine the smallest amount of "deposit_charge".

SELECT MIN(deposit_charge) FROM wizard_deposits;

--Language: SQL

-- MAX Age
-- Determine the maximum "age" among the wizards in the database.

SELECT MAX(age) FROM wizard_deposits;

--Language: SQL

-- GROUP BY Deposit Interest
-- Write a SQL query to order the "deposit_group" based on the total amount of "deposit_interest" in each group, and then sort the results in descending order by the total interest in each group.
-- Submit your query for this task in the Judge system.
-- Example 
-- deposit_group	deposit_interest
-- Troll Chest	685.35
-- Human Pride	676.97
-- Blue Phoenix	669.01
-- Venomous Tongue	574.64

SELECT deposit_group, SUM(deposit_interest) AS total_interest
FROM wizard_deposits
GROUP BY deposit_group
ORDER BY total_interest DESC;

--Language: SQL

-- LIMIT the Magic Wand Creator
-- Retrieve the "magic_wand_creator" with the smallest "magic_wand_size" from the "wizard_deposits" table. 
-- The query should group the results by "magic_wand_creator" and display the "minimum_wand_size" for each creator. 
-- The results should be sorted in ascending order by the minimum wand size and limited to the top five smallest wand sizes. 
-- Submit your query for this task in the Judge system.
-- Example 
-- magic_wand_creator	minimum_wand_size
-- Mykew Gregorovitch	10
-- Ollivander family	10
-- Death	11
-- …	…
-- Jimmy Kiddell	12

SELECT magic_wand_creator, MIN(magic_wand_size) 
FROM wizard_deposits
GROUP BY magic_wand_creator
ORDER BY MIN(magic_wand_size) ASC
LIMIT 5;

--Language: SQL

-- Bank Profitability
-- Mr. Bodrog is interested in the profitability of the bank and wants to know the average interest rates of all "deposit_groups" rounded down to the nearest integer. 
-- The query should categorize the deposits based on whether they have expired or not 
-- and retrieve data only for deposits that have a "deposit_start_date" after '1985-01-01'. 
-- The results should be sorted in descending order by "deposit_group" and ascending order by the "is_deposit_expired" flag.
-- Submit your query for this task in the Judge system.
-- Example 
-- deposit_group	is_deposit_expired	deposit_interest
-- Venomous Tongue	0	16
-- Venomous Tongue	1	13
-- Troll Chest	0	21
-- …	…	…
-- Human Pride	1	13
-- …	…	…
-- Blue Phoenix	1	21

-- SELECT deposit_group, 
--              CASE 
--                  WHEN deposit_expiration_date < NOW() THEN 1 
--                  ELSE 0 
--              END AS is_deposit_expired, 
--              FLOOR(AVG(deposit_interest)) AS deposit_interest 
-- FROM wizard_deposits 
-- WHERE deposit_start_date > '1985-01-01' 
-- GROUP BY deposit_group, is_deposit_expired, deposit_expiration_date
-- ORDER BY deposit_group DESC, is_deposit_expired ASC;

-- SELECT deposit_group, 
--        CASE 
--            WHEN deposit_expiration_date < NOW() THEN 1 
--            ELSE 0 
--        END AS is_deposit_expired, 
--        FLOOR(AVG(deposit_interest)) AS deposit_interest
-- FROM wizard_deposits
-- WHERE deposit_start_date > '1985-01-01'
-- GROUP BY deposit_group, is_deposit_expired, deposit_expiration_date
-- ORDER BY deposit_group DESC, is_deposit_expired ASC;

-- SELECT
-- 	   deposit_group,
-- 	   is_deposit_expired,
-- 	   FLOOR(AVG(deposit_interest)) AS "Deposit Interest"
-- FROM wizard_deposits
-- WHERE deposit_start_date > '1985-01-01'
-- GROUP BY deposit_group, is_deposit_expired
-- ORDER BY deposit_group DESC, is_deposit_expired ASC;

SELECT deposit_group, 
       is_deposit_expired,
         FLOOR(AVG(deposit_interest)) AS "Deposit Interest"
FROM wizard_deposits
WHERE deposit_start_date > '1985-01-01'
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC, is_deposit_expired ASC;

--Language: SQL

-- Notes with Dumbledore
-- Generate a SQL query to retrieve the "last_name" of each wizard and the number of "notes" they wrote that contains the word "Dumbledore" in the "wizard_deposits" table.
-- Submit your query for this task in the Judge system.
-- Example
-- last_name	notes_with_dumbledore
-- Grindelwald	1
-- Brown	1
-- Lovegood	1
-- …	…
-- Creevey	2
-- …	…
-- Weasley	4
-- …	…
-- Dumbledore	1

SELECT last_name, 
         COUNT(notes) AS notes_with_dumbledore
FROM wizard_deposits
WHERE notes LIKE '%Dumbledore%'
GROUP BY last_name;

--Language: SQL

-- Wizard View
-- Create a view in SQL named "view_wizard_deposits_with_expiration_date_before_1983_08_17" that fetches data from the "wizard_deposits" table. The view should display the full name of the wizard, concatenated from their "first_name" and "last_name", along with the "deposit_start_date", "deposit_expiration_date", and "deposit_amount". The view's results should be grouped by the "wizard_name", "start_date", "expiration_date", and "amount". Additionally, the view should only include deposits that have an expiration date before or on '1983-08-17', and should be ordered by the "expiration_date" in ascending order.
-- Submit your query for this task in the Judge system.
-- Example 
-- wizard_name	start_date	expiration_date	amount
-- Alicia Spinnet	1980-02-06	1980-03-04	6269.39
-- Anthony Goldstein	1980-05-11	1980-05-22	5264.16
-- Wilhelmina Grubbly-Plank	1980-08-19	1980-08-21	21263.21
-- Hermione Granger	1980-11-17	1981-01-13	20232.87
-- …	…	…	…
-- Marvolo Gaunt	1981-04-12	1981-09-20	22895.49
-- …	…	…	…
-- Remus Lupin	1982-05-08	1982-06-04	17821.66
-- …	…	…	…
-- Hepzibah Smith	1983-05-25	1983-08-17	33665.13

CREATE OR REPLACE VIEW view_wizard_deposits_with_expiration_date_before_1983_08_17
AS SELECT
          CONCAT(w.first_name, ' ', w.last_name) AS "Wizard Name",
          w.deposit_start_date AS "Start Date",
          w.deposit_expiration_date AS "Expiration Date",
          w.deposit_amount AS "Amount"
FROM wizard_deposits AS w
GROUP BY "Wizard Name", "Start Date", "Expiration Date", "Amount"
HAVING w.deposit_expiration_date <= '1983-08-17'
ORDER BY "Expiration Date" ASC;


-- CREATE OR REPLACE VIEW
-- 		view_wizard_deposits_with_expiration_date_before_1983_08_17
-- AS SELECT
-- 		  CONCAT(w.first_name, ' ', w.last_name) AS "Wizard Name",
-- 		  w.deposit_start_date AS "Start Date",
-- 		  w.deposit_expiration_date AS "Expiration Date",
-- 		  w.deposit_amount AS "Amount"
-- FROM wizard_deposits AS w
-- GROUP BY "Wizard Name", "Start Date", "Expiration Date", "Amount"
-- HAVING w.deposit_expiration_date <= '1983-08-17'
-- ORDER BY "Expiration Date" ASC;

--Language: SQL

-- Filter Max Deposit
-- Create a SQL query that retrieves the name of the "magic_wand_creator" and their maximum "deposit_amount" from the "wizard_deposits" table. 
-- The results should be grouped by the "magic_wand_creator" and 
-- filtered to only include those with a maximum "deposit_amount" that falls outside the range of 20000 to 40000. 
-- Order the results by "max_deposit_amount" in descending order, and limit the results to 3 records.

SELECT magic_wand_creator,
        MAX(deposit_amount) AS "Max deposit"
FROM wizard_deposits
GROUP BY magic_wand_creator
HAVING MAX(deposit_amount)> 20000 OR MAX(deposit_amount)< 40000
ORDER BY "Max deposit" DESC
LIMIT 3;

--Language: SQL

-- Age Group
-- Create a SQL query that groups the wizards from the "wizard_deposits" table into age groups of 
-- '[0-10]', '[11-20]', '[21-30]', '[31-40]', '[41-50]', '[51-60]', and '[61+]'. 
-- The query should count the number of wizards in each "age_group" and display the results in ascending order based on the "age_group".
SELECT 
    CASE 
        WHEN age <= 10 THEN '[0-10]'
        WHEN age <= 20 THEN '[11-20]'
        WHEN age <= 30 THEN '[21-30]'
        WHEN age <= 40 THEN '[31-40]'
        WHEN age <= 50 THEN '[41-50]'
        WHEN age <= 60 THEN '[51-60]'
        ELSE '[61+]'
    END AS age_group,
    COUNT(*) AS num_wizards
FROM (
    SELECT 
        last_name, 
        age
    FROM wizard_deposits
) AS wizard_ages
GROUP BY age_group
ORDER BY age_group ASC;

--Language: SQL

-- SUM the Employees
-- Your first task as an analyst at SoftUni is to write an SQL query that calculates the total number of employees in each department. The "department_id" is stored in the "employees" table, and the following IDs are used to identify each department:
-- 1 - Engineering
-- 2 - Tool Design
-- 3 - Sales
-- 4 - Marketing
-- 5 - Purchasing
-- 6 - Research and Development
-- 7 - Production 

-- SELECT
-- 	   COUNT(CASE WHEN department_id=1 THEN 1 END) AS "Engineering",
-- 	   COUNT(CASE WHEN department_id=2 THEN 1 END) AS "Tool Design",
-- 	   COUNT(CASE WHEN department_id=3 THEN 1 END) AS "Sales",
-- 	   COUNT(CASE WHEN department_id=4 THEN 1 END) AS "Marketing",
-- 	   COUNT(CASE WHEN department_id=5 THEN 1 END) AS "Purchasing",
-- 	   COUNT(CASE WHEN department_id=6 THEN 1 END) AS "Research and Development",
-- 	   COUNT(CASE WHEN department_id=7 THEN 1 END) AS "Production"
-- FROM employees;

SELECT
       COUNT(CASE WHEN department_id=1 THEN 1 END) AS "Engineering",
       COUNT(CASE WHEN department_id=2 THEN 1 END) AS "Tool Design",
       COUNT(CASE WHEN department_id=3 THEN 1 END) AS "Sales",
       COUNT(CASE WHEN department_id=4 THEN 1 END) AS "Marketing",
       COUNT(CASE WHEN department_id=5 THEN 1 END) AS "Purchasing",
       COUNT(CASE WHEN department_id=6 THEN 1 END) AS "Research and Development",
       COUNT(CASE WHEN department_id=7 THEN 1 END) AS "Production"
FROM employees;

--Language: SQL

-- Update Employees' Data
-- You have been tasked with updating the salaries and job titles of employees based on their hire dates. 
-- Write a SQL query that updates the "salary" and "job_title" columns of the "employees" table according to the following rules:
-- •	if the employee's "hire_date" is before '2015-01-16', their salary should be increased by 2500 and their job title should be prefixed with "Senior"
-- •	if the employee's "hire_date" is before '2020-03-04, their salary should be increased by 1500 and their job title should be prefixed with "Mid-"
-- •	otherwise, the employee's salary and job title should remain unchanged.
-- Submit your query for this task in the Judge system.
-- Example 
-- Before update
-- first_name	job_title	salary
-- Guy	Production Technician	12500.000
-- Kevin	Marketing Assistant	13500.000
-- Roberto	Engineering Manager	43300.000
-- …	…	…
-- Ruth	Production Technician	13500.000
-- …	…	…
-- Suroor	Production Technician	11000.000
-- …	…	…
-- Alex	Production Technician	10000.000
-- …	…	…
-- Hazem	Quality Assurance Manager	28800.000


UPDATE employees
SET salary = 
    CASE 
        WHEN hire_date < '2015-01-16' THEN salary + 2500
        WHEN hire_date < '2020-03-04' THEN salary + 1500
        ELSE salary
    END,
    job_title = 
    CASE 
        WHEN hire_date < '2015-01-16' THEN CONCAT('Senior ', job_title)
        WHEN hire_date < '2020-03-04' THEN CONCAT('Mid-', job_title)
        ELSE job_title
    END;

--Language: SQL

-- Categorizes Salary
-- Write a SQL query that groups employees by their job titles and calculates the average salary for each group. The query should also add a column called "category" that categorizes each "job_title" based on the following rules:
-- •	if the average "salary" is greater than 45,800, the category should be "Good"
-- •	if the average "salary" is between 27,500 and 45,800 (inclusive), the category should be "Medium"
-- •	if the average salary for the job title is less than 27,500, the scale should be "Need Improvement"
-- Arrange the outcomes based on the "category" column in ascending sequence. If there are several employees within the group, arrange them by their "job_title" in alphabetical order. 
-- Submit your query for this task in the Judge system.
-- Example 
-- job_title	category
-- Mid-Chief Financial Officer	Good
-- Senior Chief Executive Officer	Good
-- Senior Information Services Manager	Good
-- … 	… 
-- Mid-Accounts Manager	Medium
-- Mid-Application Specialist	Medium
-- … 	… 
-- Accountant	Need Improvement
-- Application Specialist	Need Improvement
-- … 	… 
-- Stocker	Need Improvement


SELECT
       job_title,
       CASE
       		WHEN AVG(salary) > 45800 THEN 'Good'
            WHEN AVG(salary) BETWEEN 27500 AND 45800 THEN 'Medium'
            WHEN AVG(salary) < 27500 THEN 'Need Improvement'
  	   END AS "Category"
FROM employees
GROUP BY job_title
ORDER BY "Category" ASC, job_title ASC;

-- SELECT
-- 	   job_title,
-- 	   CASE
-- 	   		WHEN AVG(salary) > 45800 THEN 'Good'
-- 			WHEN AVG(salary) BETWEEN 27500 AND 45800 THEN 'Medium'
-- 			WHEN AVG(salary) < 27500 THEN 'Need Improvement'
--  	   END AS "Category"
-- FROM employees
-- GROUP BY job_title
-- ORDER BY "Category" ASC, job_title ASC;

--Language: SQL

-- WHERE Project Status
-- Create a SQL query that selects the "project_name" with the word '%Mountain%' in their name from the "projects" table. The project status should be determined based on the following criteria:
-- •	if a project has NO "start_date" and "end_date", its status is "Ready for development"
-- •	if a project has a "start_date" but NO "end_date", its status is "In Progress".
-- •	otherwise, its status is "Done".
-- Submit your query for this task in the Judge system.
-- Example 
-- project_name	project_status
-- HL Mountain Frame	In Progress
-- LL Mountain Frame	Done
-- Mountain-100	In Progress
-- Mountain	Done
-- …	…
-- Mountain	Ready for development
-- Mountain	Done
-- Women`s Mountain Shorts	Ready for development
-- …	…
-- Fender Set - Mountain	In Progress

SELECT project_name,
       CASE
       		WHEN start_date IS NULL AND end_date IS NULL THEN 'Ready for development'
            WHEN start_date IS NOT NULL AND end_date IS NULL THEN 'In Progress'
            ELSE 'Done'
       END AS "Project Status"
FROM projects
WHERE project_name LIKE '%Mountain%';

--Language: SQL

-- HAVING Salary Level
-- Write a SQL query to retrieve the number of employees and salary level of each department from the "employees" table. The "salary_level" column should be determined based on the following rules:
-- •	if the average "salary" of a department is above 50,000, the salary level is "Above average"
-- •	if the average "salary" of a department is below or equal to 50,000, the salary level is "Below average"
-- •	only departments with an average "salary" above 30,000 should be included in the result.
-- The resulting dataset should encompass the subsequent columns: "department_id", "num_employees" and "salary_level". Arrange the output based on the "department_id".
-- Submit your query for this task in the Judge system.
-- Example 
-- department_id	num_employees	salary_level
-- 1	4	Below average
-- 6	3	Below average
-- 11	10	Below average
-- 16	2	Above average

SELECT department_id,
       COUNT(*) AS num_employees,
       CASE
       		WHEN AVG(salary) > 50000 THEN 'Above average'
            WHEN AVG(salary) <= 50000 THEN 'Below average'
       END AS "Salary Level"
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 30000
ORDER BY department_id ASC;

--Language: SQL

-- * Nested CASE Conditions
-- To create a view ("view_performance_rating"), select the "first_name", "last_name", "job_title", "salary", and "department_id" from the "employees" table. 
-- Then, use the following conditions to generate the "performance_rating" column:
-- •	if an employee's "salary" is greater than or equal to 25,000 and their " job_title" starts with 'Senior%', their "performance_rating" should be "High-performing Senior"
-- •	if an employee's "salary" is greater than or equal to 25,000 and their "job_title" does not start with "Senior", their "performance_rating" should be "High-performing Employee"
-- •	if neither of the above criteria is met, the employee's "performance_rating" should be "Average-performing".
-- Submit your query for this task in the Judge system.
-- Example 
-- first_name	last_name	job_title	salary	department_id	performance_rating
-- Guy 	Gilbert	Senior Production Technician	15000.000 	7	Average-performing
-- Kevin	Brown	Senior Marketing Assistant	16000.000	4	Average-performing
-- Roberto	Tamburello	Senior Engineering Manager	45800.000	1	High-performing Senior
-- …	…	…	…	…	…
-- Roberto 	Tamburello	Senior Engineering Manager	45800.000	1	High-performing Senior
-- …	…	…	…	…	…
-- Reuben	D`sa	Mid-Production Supervisor	26500.000	7	High-performing Employee
-- … 	… 	… 	… 	…	…
-- Hazem	Abolrous	Quality Assurance Manager	28800.000	13	High-performing Employee


CREATE VIEW view_performance_rating AS
SELECT
    first_name,
    last_name,
    job_title,
    salary,
    department_id,
    CASE
        WHEN salary >= 25000 AND job_title LIKE 'Senior%' THEN 'High-performing Senior'
        WHEN salary >= 25000 AND job_title NOT LIKE 'Senior%' THEN 'High-performing Employee'
        ELSE 'Average-performing'
    END AS performance_rating
FROM employees;

--Language: SQL

-- * Foreign Key
-- Create a table named "employees_projects" with columns for "id", "employee_id", and "project_id". 
-- The "employee_id" column should have a foreign key constraint that references the "id" column in the "employees" table, 
-- and the "project_id" column should have a foreign key constraint that references the "id" column in the "projects" table.
-- Submit your query for this task in the Judge system.
-- Example
-- id
-- [PK] integer	employee_id
-- integer	project_id
-- integer

CREATE TABLE employees_projects (
    id INT PRIMARY KEY,
    employee_id INT,
    project_id INT,
    FOREIGN KEY (employee_id) REFERENCES employees(id),
    FOREIGN KEY (project_id) REFERENCES projects(id)
);

--Language: SQL

-- * JOIN Tables
-- Write a SQL query to join all columns from the "departments" table and the "employees" table where the "id" column in the "departments" table matches the "department_id" column in the "employees" table. The result set should include all columns from both tables.
-- Submit your query for this task in the Judge system.
-- Example 
-- id	department_name	manager_id	id	first_name	last_name	…	department_id	… 
-- 7 	Production	148	1	Guy	Gilbert	… 	7	… 
-- 4	Marketing	46	2	Kevin	Brown	…	4	…
-- 1	Engineering	12	3	Roberto	Tamburello	… 	1	… 
-- 2	Tool Design	4	4	Rob	Walters	… 	2	… 
-- 2	Tool Design	4	5	Thierry	D`Hers	… 	2	… 
-- … 	… 	… 	… 	… 	… 	… 	… 	… 
-- 7	Production	148	199	Stefen	Hesse	… 	7	… 
-- 13	Quality Assurance	274	200	Hazem	Abolrous	… 	13	… 

SELECT *
FROM departments
JOIN employees
ON departments.id = employees.department_id;

--Language: SQL
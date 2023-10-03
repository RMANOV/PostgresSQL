--Language: SQL

1.	Departments Info (by id)
Write a query to count the number of employees in each department by id. Order the information by department_id. Submit your queries.

SELECT department_id, COUNT(*) AS "Number of Employees"
FROM employees
GROUP BY department_id
ORDER BY department_id;

--Language: SQL

2.	Departments Info (by salary)
Write a query to count the number of employees in each department by salary. Order the information by department_id. Submit your queries.
Note, that the NULL values for salary will be ignored.

SELECT department_id, COUNT(salary) AS "Number of Employees"
FROM employees

GROUP BY department_id
ORDER BY department_id;

--Language: SQL

3.	Sum Salaries per Department
Write a query to sum the salaries of employees in each department. Order the information by department_id. 

SELECT department_id, SUM(salary) AS "Sum of Salaries"
FROM employees
GROUP BY department_id
ORDER BY department_id;

--Language: SQL

4.	Maximum Salary per Department
Write a query to retrieve information about the departments grouped by department_id with their maximum salary. Order the information by department_id. 

SELECT department_id, MAX(salary) AS "Max Salary"
FROM employees
GROUP BY department_id
ORDER BY department_id;

--Language: SQL

5.	Minimum Salary per Department
Write a query to retrieve information about the departments grouped by department_id with their minimum salary. Order the information by department_id. 

SELECT department_id, MIN(salary) AS "Min Salary"
FROM employees
GROUP BY department_id
ORDER BY department_id;

--Language: SQL

6.	Average Salary per Department
Write a query to calculate the average salary in each department. Order the information by department_id. Submit 

SELECT department_id, AVG(salary) AS "Average Salary"
FROM employees
GROUP BY department_id
ORDER BY department_id;

--Language: SQL

7.	Filter Total Salaries
Write a query to filter the total salary per department, where the total salary is less than 4200. Submit your queries, ordered by department_id. 

SELECT department_id, SUM(salary) AS "Total Salary"
FROM employees
GROUP BY department_id
HAVING SUM(salary) < 4200
ORDER BY department_id;

--Language: SQL

8.	Department Names
Write a query to retrieve information from table employees about the department names, according to department_id. The output should have the following fields:
•	id of the employee
•	first_name
•	last_name
•	salary – formatted to the second decimal place.
•	department_id
•	department_name – use Simple CASE Expression
o	1 – "Management"
o	2 – "Kitchen Staff"
o	3 – "Service Staff"
o	any other number – "Other"
See the examples for more information. Format the salary to 2 digits after the decimal point. Submit your queries, ordered by employee id. 
Example
id	first_name	last_name	salary	department_id	department_name
1	Jasmine	Maggot	1250.00	2	Kitchen Staff
2	Nancy	Olson	1350.00	2	Kitchen Staff
3	Karen	Bender	2400.00	1	Management
4	Pricilia	Parker	980.00	2	Kitchen Staff
5	Stephen	Bedford	780.00	2	Kitchen Staff
6	Jack	McGee	1700.00	1	Management
7	Clarence	Willis	650.00	3	Service Staff
8	Michael	Boren	780.00	3	Service Staff
9	Lila	Young	NULL	4	Other

SELECT id, first_name, last_name, ROUND(salary::numeric, 2) AS salary, department_id,
CASE department_id
    WHEN 1 THEN 'Management'
    WHEN 2 THEN 'Kitchen Staff'
    WHEN 3 THEN 'Service Staff'
    ELSE 'Other'
END AS department_name
FROM employees
ORDER BY id;

--Language: SQL
--Language: SQL

-- 1. Mountains and Peaks
-- Write a query to create two tables – mountains and peaks and link their fields properly by setting Foreign Key Constraint (fk_peaks_mountains). 
-- Tables should have:
-- •	Mountains:
-- o	id 
-- o	name, max-length = 50
-- •	Peaks: 
-- o	id
-- o	name, max-length = 50
-- o	mountain_id
-- Submit your queries.

CREATE TABLE mountains(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE peaks(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    mountain_id INT NOT NULL,
    CONSTRAINT fk_peaks_mountains FOREIGN KEY(mountain_id) REFERENCES mountains(id)
);

--Language: SQL

-- 2. Trip Organization
-- Write a query to retrieve information about SoftUni camp's transportation organization. Get information about people who are drivers (driver_name and driver_id) and their vehicle type. The driver’s name field represents the full name of a driver.
-- Submit your queries.
-- Example
-- driver_id	vehicle_type	driver_name
-- 1	bus	Simo Sheytanov
-- 2	van	Roli Dimitrova
-- 1	van	Simo Sheytanov

SELECT v.driver_id, v.vehicle_type, CONCAT(c.first_name, ' ', c.last_name) AS driver_name
FROM vehicles AS v
JOIN campers AS c
ON v.driver_id = c.id;

--Language: SQL

-- 3. SoftUni Hiking
-- Get information about the hiking routes (start_point and end_point) and their leaders (leader_name and leader_id).
--  Submit your queries.
-- Example
-- start_point	end_point	leader_id	leader_name
-- Hotel Malyovitsa	Malyovitsa Peak	3	RoYaL Yonkov
-- Hotel Malyovitsa	Malyovitsa Hut	3	RoYaL Yonkov
-- Ribni Ezera Hut	Rila Monastery	3	RoYaL Yonkov
-- Borovets	Musala Peak	4	Ivan Ivanov

SELECT r.start_point, r.end_point, r.leader_id, CONCAT(c.first_name, ' ', c.last_name) AS leader_name
FROM routes AS r
JOIN campers AS c
ON r.leader_id = c.id;

--Language: SQL

-- 4. Delete Mountains
-- Drop tables from Task 1.
-- Write a query to create a one-to-many relationship between table mountains (id, name) and table peaks (id, name, mountain_id). 
-- Set a Foreign Key Constraint (fk_mountain_id) and On 
-- Delete rule.
-- When a mountain is removed from the database, all its peaks are also deleted.
-- Submit your queries.

-- CREATE TABLE mountains(
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(50) NOT NULL
-- );

-- CREATE TABLE peaks(
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(50) NOT NULL,
--     mountain_id INT NOT NULL,
--     CONSTRAINT fk_peaks_mountains FOREIGN KEY(mountain_id) REFERENCES mountains(id)
-- );

DROP TABLE IF EXISTS mountains CASCADE;

--Language: SQL

-- Find value that is under the maximal value from the table

SELECT MAX(value) FROM table_name WHERE value < (SELECT MAX(value) FROM table_name); -- uses subquery to find the max value and then compares it to the other values

-- same task but use only one query

SELECT value FROM table_name WHERE value < (SELECT MAX(value) FROM table_name) ORDER BY value DESC LIMIT 1; -- uses subquery to find the max value and then compares it to the other values

-- same task but use only one query and no subquery

SELECT value FROM table_name ORDER BY value DESC --jump first to the max value and then go to the next one 
OFFSET 1 -- jump to the next one
LIMIT 1; -- get the next one

--Language: SQL
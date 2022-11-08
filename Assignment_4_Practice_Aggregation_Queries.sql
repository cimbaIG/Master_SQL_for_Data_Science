CREATE TABLE fruit_imports
(
	id integer,
	name varchar(20),
	season varchar(10),
	state varchar(20),
	supply integer,
	cost_per_unit decimal
);

insert into fruit_imports values(1, 'Apple', 'All Year', 'Kansas', 32900, 0.22);
insert into fruit_imports values(2, 'Avocado', 'All Year', 'Nebraska', 27000, 0.15);
insert into fruit_imports values(3, 'Coconut', 'All Year', 'California', 15200, 0.75);
insert into fruit_imports values(4, 'Orange', 'Winter', 'California', 17000, 0.22);
insert into fruit_imports values(5, 'Pear', 'Winter', 'Iowa', 37250, 0.17);
insert into fruit_imports values(6, 'Lime', 'Spring', 'Indiana', 40400, 0.15);
insert into fruit_imports values(7, 'Mango', 'Spring', 'Texas', 13650, 0.60);
insert into fruit_imports values(8, 'Orange', 'Spring', 'Iowa', 18000, 0.26);
insert into fruit_imports values(9, 'Apricot', 'Spring', 'Indiana', 55000, 0.20);
insert into fruit_imports values(10, 'Cherry', 'Summer', 'Texas', 62150, 0.02);
insert into fruit_imports values(11, 'Cantaloupe', 'Summer', 'Texas', 8000, 0.49);
insert into fruit_imports values(12, 'Apricot', 'Summer', 'Kansas', 14500, 0.20);
insert into fruit_imports values(13, 'Mango', 'Summer', 'Texas', 17000, 0.68);
insert into fruit_imports values(14, 'Pear', 'Fall', 'Nebraska', 30500, 0.12);
insert into fruit_imports values(15, 'Grape', 'Fall', 'Illinois', 72500, 0.35);

SELECT *
FROM fruit_imports;

--1.)
SELECT state
FROM fruit_imports 
GROUP BY state
ORDER BY SUM(supply) desc
LIMIT 1;

--2.)
SELECT season, MAX(cost_per_unit) AS max_unit_per_season
FROM fruit_imports
GROUP BY season;

SELECT season, MAX(cost_per_unit) highest_cost_per_unit
FROM fruit_imports
GROUP BY season;

--3.)
SELECT state
FROM fruit_imports
GROUP BY state, name
HAVING COUNT(*) > 1;

SELECT state
FROM fruit_imports
GROUP BY state, name
HAVING COUNT(name) > 1;

--4.)
SELECT season
FROM fruit_imports
GROUP BY season
HAVING count(name) = 3 OR COUNT(name) = 4;

SELECT season, COUNT(name)
FROM fruit_imports
GROUP BY season
HAVING count(name) = 3 OR count(name) = 4;

--5.)
SELECT state, supply * cost_per_unit AS total_import_cost
FROM fruit_imports
GROUP BY state, total_import_cost
ORDER BY SUM(supply * cost_per_unit) DESC
LIMIT 1;

SELECT state, SUM(supply * cost_per_unit) total_cost
FROM fruit_imports
GROUP BY state
ORDER BY total_cost desc
LIMIT 1

--6.) Execute the below SQL script and write the query that returns the count of 4...
CREATE table fruits (fruit_name varchar(10));
INSERT INTO fruits VALUES ('Orange');
INSERT INTO fruits VALUES ('Apple');
INSERT INTO fruits VALUES (NULL);
INSERT INTO fruits VALUES (NULL);

SELECT COUNT(*) AS value_counts
FROM fruits;

SELECT COUNT(COALESCE(fruit_name, 'SOMEVALUE'))
FROM fruits;
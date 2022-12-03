-- Create table with data
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

-- 1.) Write a query that displays 3 columns. The query should display the fruit and it's total supply along with 
-- a category of either LOW, ENOUGH or FULL. Low category means that the total supply of the fruit is less than 20,000. 
-- The enough category means that the total supply is between 20,000 and 50,000. If the total supply is greater than 50,000 
-- then that fruit falls in the full category.
SELECT name, total_supply,
CASE
	WHEN total_supply < 20000 THEN 'LOW'
	WHEN total_supply >= 20000 AND total_supply <= 50000 THEN 'ENOUGH'
	WHEN total_supply > 50000 THEN 'FULL'
END AS category
FROM (
SELECT name, SUM(supply) AS total_supply
FROM fruit_imports
GROUP BY name
) AS a;

-- 2.) Taking into consideration the supply column and the cost_per_unit column, you should be able to tabulate the 
-- total cost to import fruits by each season. The result will look something like this:
-- "Winter" "10072.50"
-- "Summer" "19623.00"
-- "All Year" "22688.00"
-- "Spring" "29930.00"
-- "Fall" "29035.00"
SELECT season, SUM( supply*cost_per_unit ) AS total_cost
FROM fruit_imports
GROUP BY season;

-- Write a query that would transpose this data so that the seasons become columns and the total cost for each season 
-- fills the first row?
SELECT SUM(CASE WHEN season = 'Winter' THEN total_cost END) AS winter_total,
SUM(CASE WHEN season = 'Summer' THEN total_cost END) AS summer_cost,
SUM(CASE WHEN season = 'Spring' THEN total_cost END) AS spring_cost,
SUM(CASE WHEN season = 'Fall' THEN total_cost end) as fall_cost,
SUM(CASE WHEN season = 'All Year' THEN total_cost end) as all_year_cost
FROM (
SELECT season, SUM(supply*cost_per_unit) AS total_cost
FROM fruit_imports
GROUP BY season
) AS a;
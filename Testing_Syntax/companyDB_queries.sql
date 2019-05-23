-- SELECT QUERIES

-- Find All Employees
SELECT * FROM employee;

-- Find All Clients
SELECT * FROM client;

-- Find All Employees Ordered By Salary
SELECT * FROM employee ORDER BY salary DESC;

-- Find All Employess Ordered By Sex and then Name
SELECT * FROM employee ORDER BY sex, first_name, last_name;

-- Find the First 5 Employess from in the table
SELECT * FROM employee LIMIT 5;

-- Find the First and Last Names of All Employees
SELECT first_name, last_name FROM employee;

-- Find the forename and surnames of all employees
SELECT first_name AS forename, last_name AS surname FROM employee;

-- Find Out All the Different Genders or Branches
SELECT DISTINCT sex FROM employee;
SELECT DISTINCT branch_id FROM employee;

-- Functions (counting, aggregating)

-- Count the Number of Employees
SELECT COUNT(emp_id) FROM employee;

-- How Employees Have Supervisors
SELECT COUNT(super_id) FROM employee;

-- Find the Number of Female Employees born after 1970
SELECT COUNT(emp_id) FROM employee WHERE sex = "F" AND birth_day > "1970-01-01";

-- Find the Average of All Employees Salaries & Round it OR Male
SELECT AVG(salary) FROM employee;
SELECT ROUND(AVG(salary), 2) FROM employee;
SELECT ROUND(AVG(salary), 2) FROM employee WHERE sex = "M";

-- Find the Sum of All Employee Salaries and Sum of Female Salaries
SELECT SUM(salary) FROM employee;
SELECT SUM(salary) FROM employee WHERE sex = "F";

-- Find Out How Many Males and How Many Females there are
SELECT COUNT(sex), sex FROM employee GROUP BY sex;

-- Find the Total Sales of each Salesman
SELECT SUM(total_sales), emp_id FROM works_with GROUP BY emp_id;
SELECT SUM(total_sales), works_with.emp_id, concat(first_name, " ", last_name) AS name 
FROM works_with JOIN employee ON employee.emp_id = works_with.emp_id GROUP BY emp_id
ORDER BY total_sales DESC;

-- WildCards (& like keyword) % = any # characters, _ = one character [pattern mathcing (RE)]

-- Find Any Client's who are an LLC
SELECT * FROM client WHERE client_name LIKE "%LLC"; -- (any number of characters ending with LLC)

-- Find Any Branch Suppliers that are in the Label Business
SELECT * FROM branch_supplier WHERE supplier_name lIKE "% Label %";

-- Find any Employee Born in October
SELECT * FROM employee WHERE birth_day LIKE "____-10-__";

-- Find Any Clients Who are Schools
SELECT * FROM client WHERE client_name LIKE "%school%";

-- Union's in SQL -> JOINS!

-- Find a List of Employee and Branch Names (MUST HAVE SAME No OF COLUMNS & SIMILAR DATA TYPE!)
SELECT first_name FROM employee UNION SELECT branch_name FROM branch;

-- Find a List of All clients & branch suppliers' names
SELECT client_name AS Names, branch_id FROM client UNION SELECT supplier_name, branch_id FROM branch_supplier;




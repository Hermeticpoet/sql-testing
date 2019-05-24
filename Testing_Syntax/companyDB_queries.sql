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

-- Union's in SQL (combine like data types into one column)

-- Find a List of Employee and Branch Names (MUST HAVE SAME No OF COLUMNS & SIMILAR DATA TYPE!)
SELECT first_name FROM employee UNION SELECT branch_name FROM branch;

-- Find a List of All clients & branch suppliers' names
SELECT client_name AS Names, branch_id FROM client UNION SELECT supplier_name, branch_id FROM branch_supplier;

-- Find a List of All Money Spent or Earned by the Company
SELECT salary AS company_spend FROM employee UNION SELECT total_sales FROM works_with;

-- JOINS ( create new table from 'joining' multiple table columns )

-- Find All Branches and the Names of their Managers
SELECT employee.emp_id, concat( employee.first_name, " ", employee.last_name ) AS name, branch.branch_name 
FROM employee JOIN branch ON employee.emp_id = branch.mgr_id;

-- JOIN: (DEFAULT SETTING OF INNER!!)
-- INNER JOIN: Only take those which correspond to the matching columns/data types (above)
-- LEFT JOIN: Include ALL of the rows from the Left Table ( initial FROM statement )
-- RIGHT JOIN: Include ALL of the rows from the Right Table
-- OUTER JOIN: Full Outer Join combines LEFT / RIGHT whether conditions met or not ( matching columns )!

-- Nested Queries ( using multiple select statements ) - 1 result informs another!!
-- SQL 'tackles' the inner(nested) query FIRST then looks for outer query...

-- Find Names of all employees who have sold over 30,000 to a single client
SELECT concat( employee.first_name, " ", employee.last_name ) AS Name 
FROM employee 
WHERE employee.emp_id IN (
    SELECT works_with.emp_id 
    FROM works_with 
    WHERE works_with.total_sales > 30000
);

-- Find All Clients who are handled by the branch that Michael Scott manages (assume you know his ID)
SELECT client.client_name
FROM client
WHERE client.branch_id = (
    SELECT branch.branch_id 
    FROM branch
    WHERE branch.mgr_id = 102
    LIMIT 1
);

-- On DELETE ( when foreign keys associated to that data )

-- ON DELETE SET NULL: if record deleted that has a foreign key
-- to another table, then that field becomes NULL in the table
-- that it was a primary key for...

-- e.g: 
DELETE FROM employee WHERE employee_id = 102; 
-- (branch table mgr_id is now set to NULL)
-- (employee table super_id for matching records are now also set to NULL)

-- ON DELETE SET CASCADE: if recored deleted that has a foreign key
-- to another table, then that entire row(record) is then deleted
-- from that other table completely...
-- e.g:
DELETE FROM branch WHERE branch_id = 2;
-- (supplier table will now also delete all suppliers who had branch_id of 2)

-- WHEN TO USE? IF DELETING THE VALUE OR ROW MEANS DELETING THE PRIMARY KEY
-- OF A TABLE, THEN YOU SHOULD HAVE CONSTRAINT SET TO CASCADE AS PRIMARY KEY
-- IS NEEDED TO SEARCH & QUERY THE TABLES. HOWEVER, IF THE FIELD THAT CAN BE 
-- DELETED IS ONLY A FOREIGN KEY AND THE REST OF DATA IN THE TABLE CAN REMAIN
-- UNSCATHED & QUERIABLE, THEN USE DELETE SET NULL...!!!

-- TRIGGERS (block of sql code that will define action to happen when operation 
-- performed on the database - like event listener**)

CREATE TABLE trigger_table (
    message VARCHAR(100)
);

-- Delimiter tells SQL that $ & not ; is now used for this block
-- this allows for the use of ; delimiter within the INSERT statement
-- needed to run inside the for each statement...**
-- We then have to change delimiter back to semi-colon at the end!!!
DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_table VALUES("added new employee");
    END$$
DELIMITER;

-- Access Attribute of the 'thing' we just added (NEW name)** 
DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_table VALUES(NEW.first_name);
    END$$
DELIMITER ;

-- Using Trigger with a Conditional
DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        IF NEW.sex = "M" THEN
            INSERT INTO  trigger_table VALUES("added male employee");
        ELSEIF NEW.sex = "F" THEN
            INSERT INTO trigger_table VALUES("added female employee");
        ELSE
            INSERT INTO trigger_table VALUES("added other employee");
        END IF;
    END$$
DELIMITER ;

-- Can also use for UPDATE, DELETE ( NOT JUST [BEFORE INSERT] )
-- Alternatively use an 'AFTER' INSERT/DELETE/UPDATE...

-- To cancel or delete a Trigger:
DROP TRIGGER my_trigger;




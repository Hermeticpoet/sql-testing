/* -- Creating / Setting up a database and altering its schema (adding CONSTRAINTS)-- */

CREATE TABLE Student (
    student_id INT AUTO_INCREMENT, 
    name VARCHAR(25) NOT NULL,
    major VARCHAR(20) DEFAULT "undecided",
    PRIMARY KEY(student_id)
);

/* -- View & Inspect table -- */

DESC Student; /* Schema & Layout */
SELECT * FROM Student; /* Show Actual table & values */

/* DROP TABLE Student; -- deletes Table */

ALTER TABLE Student ADD gpa DECIMAL(3, 2);
/* ALTER TABLE Student DROP COLUMN gpa;  -- remove a column */

/* -- Inserting Data Into Your Tables (database) -- */

INSERT INTO Student(name, major, gpa) VALUES("Jack", "Biology", 3.1);
INSERT INTO Student(name, major, gpa) VALUES("Kate", "Sociology", 2.9);
INSERT INTO Student(name, gpa) VALUES("Claire", 3.0);
INSERT INTO Student(name, major, gpa) VALUES("Tony", "Sports", 3.7);
INSERT INTO Student(name, major, gpa) VALUES("Kevin", "Comp Science", 3.88);
INSERT INTO Student(name, major, gpa) VALUES("Jack", "Biology", 2.55);
INSERT INTO Student(name, major, gpa) VALUES("Claire", "Chemistry", 4.0);

/* Updating Info in the Table */

UPDATE Student SET major = "Bio" WHERE major = "Biology";
UPDATE Student SET major = "Comp-Sci" WHERE major = "Comp Science";
UPDATE Student SET major = "Biochemistry" WHERE major = "Bio" OR major = "Chemistry";
UPDATE Student SET name = "Tom", major = "Maths" WHERE student_id = 1;

/* Delete rows from the Table */

DELETE FROM Student; /* will delete All rows */
DELETE FROM Student WHERE student_id = 5;
DELETE FROM Student WHERE name = "Tony" AND major = "Sports";

/* Querying the Database */

SELECT name, gpa, major FROM Student WHERE gpa > 3.3;
SELECT Student.name, Student.student_id FROM Student ORDER BY student_id ASC;
SELECT Student.name, Student.student_id FROM Student ORDER BY student_id DESC;
SELECT * FROM Student ORDER BY major, student_id;
SELECT * FROM Student ORDER BY student_id DESC LIMIT 2;
SELECT * FROM Student WHERE major = "Biology";
SELECT name, major FROM Student WHERE major = "Chemistry" OR name = "Kate";

-- comment in SQl: <> = not equal to
SELECT * FROM Student WHERE student_id <> 3;
SELECT * FROM Student WHERE student_id <> 2 AND name <> "Jack";
 -- user IN keyword search:
SELECT * FROM Student WHERE name IN ("Claire", "Tony", "Kevin");
SELECT * FROM Student WHERE major IN ("Biology", "Chemistry") AND student_id > 2;





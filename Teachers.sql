CREATE TABLE Teachers
(register_num INT(9),
 degree_id VARCHAR(100),
 core_module VARCHAR(40),
 optional_module VARCHAR(40),
);

CREATE TABLE Degrees
(degree_id VARCHAR(100),
  credits INT(40),
  level_id VARCHAR(10),
);



-- add the degrees
SELECT Students.register_num, Departments.department
FROM Departments
LEFT JOIN Students
ON Departments.register_num = Students.register_num

UPDATE Teachers
SET degree_id = 'MSc in Business Administration',
WHERE department_id = 'BUS';

UPDATE Teachers
SET degree_id = 'MEng Software Engineering with a Year in Industry',
WHERE department_id = 'COM';

UPDATE Teachers
SET degree_id = 'BSc Information Systems',
WHERE (department_id = 'COM' AND department_id = 'BUS') OR (department_id = 'COM' AND department_id = 'LAN');

UPDATE Teachers
SET degree_id = 'MPsy Cognitive Science',
WHERE department_id = 'PSY' AND department_id = 'COM';










-- ensure modules are supplied by all relevant partner-departments

-- add core modules

-- add optional modules

-- check degree credits

-- register a student

-- progress these students through the levels

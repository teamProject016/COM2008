CREATE TABLE Students
(register_num INT(9),
 title CHAR(3),
 surname VARCHAR(20),
 forename VARCHAR(20),
 email VARCHAR(20),
 password VARCHAR(10),
 modules CHAR(30),
 grade FLOAT(100)
 );

 CREATE TABLE Departments
(department_id VARCHAR(4),
 department CHAR(20),
 register_num INT(9)
 );

 INSERT INTO Departments
 VALUES('Business School(BUS)','Computer Science(CDM)','Psychology(PSY)','Modern Language(LAN)');

--add, drop student
ALTER TABLE Students
(ADD register_num INT(9),
     title CHAR(3),
     surname VARCHAR(20),
     forename VARCHAR(20),
     email VARCHAR(20),
     password VARCHAR(10),
     modules CHAR(30),
     grade FLOAT(100)
 );
 ALTER TABLE Students
(DROP register_num INT(9),
     title CHAR(3),
     surname VARCHAR(20),
     forename VARCHAR(20),
     email VARCHAR(20),
     password VARCHAR(10),
     modules CHAR(30),
     grade FLOAT(100)
 );


 --add, drop department
ALTER TABLE Departments
(ADD department_id VARCHAR(4),
     department CHAR(20),
     register_num INT(9)
 );
ALTER TABLE Departments
(DROP department_id VARCHAR(4),
     department CHAR(20),
     register_num INT(9)
 );


--student from department list
 SELECT Departments.department, Students.register_num
 FROM Departments
 INNER JOIN Students ON
 Departments.register_num=Students.register_num;

 --student's grade list
 SELECT Students.register_num, Students.grade
 FROM Students
 UNION
 SELECT Modules.register_num, Modules.grade
 FROM Modules

 --fail student list
 SELECT Students.register_num, Students.grade
 FROM Students
 WHERE Students.modules = '1-year MSc'
 INTERSECT
 SELECT Modules.register_num, Modules.grade
 WHERE Modules.grade<49.5
 UNION
 SELECT Students.register_num, Students.grade
 FROM Students
 WHERE Students.modules = 'BSc, BEng degrees'
 INTERSECT
 SELECT Modules.register_num, Modules.grade
 WHERE Modules.grade<39.5
 UNION
 SELECT Students.register_num, Students.grade
 FROM Students
 WHERE Students.modules = 'MComp, MEng degrees'
 INTERSECT
 SELECT Modules.register_num, Modules.grade
 WHERE Modules.grade<49.5

 --pass student list
 SELECT Students.register_num, Students.grade
 FROM Students
 WHERE Students.modules = '1-year MSc'
 INTERSECT
 SELECT Modules.register_num, Modules.grade
 WHERE Modules.grade>49.4
 UNION
 SELECT Students.register_num, Students.grade
 FROM Students
 WHERE Students.modules = 'BSc, BEng degrees'
 INTERSECT
 SELECT Modules.register_num, Modules.grade
 WHERE Modules.grade>39.4
 UNION
 SELECT Students.register_num, Students.grade
 FROM Students
 WHERE Students.modules = 'MComp, MEng degrees'
 INTERSECT
 SELECT Modules.register_num, Modules.grade
 WHERE Modules.grade>49.4


CREATE TABLE Modules(
  register_num INT(20) NOT NULL,
  module_name TEXT          NOT NULL,
  module_code VARCHAR(100)     NOT NULL,
  credits INT(200)        NOT NULL,
  level_study INT(10) NOT NULL,
  module_status TEXT,
  final_result TEXT,
  PRIMARY KEY (module_code),
);


-- add or update grades
ALTER TABLE Modules(
ADD grades FLOAT(100) NOT NULL,
    register_num INT(20) NOT NULL,
    module_name TEXT          NOT NULL,
    module_code VARCHAR(100)     NOT NULL,
    credits INT(200)        NOT NULL,
    level_study VARCHAR(20) NOT NULL,
    module_status TEXT,
    final_result TEXT,
    PRIMARY KEY (module_code),

);
ALTER TABLE Modules(
ADD resit_exam FLOAT(100),
    register_num INT(20) NOT NULL,
    module_name TEXT          NOT NULL,
    module_code VARCHAR(100)     NOT NULL,
    credits INT(200)        NOT NULL,
    level_study VARCHAR(20) NOT NULL,
    module_status TEXT,
    final_result TEXT,
    PRIMARY KEY (module_code),

);
ALTER TABLE Modules(
ADD repeat_year FLOAT(100),
    register_num INT(20) NOT NULL,
    module_name TEXT          NOT NULL,
    module_code VARCHAR(100)     NOT NULL,
    credits INT(200)        NOT NULL,
    level_study VARCHAR(20) NOT NULL,
    module_status TEXT,
    final_result TEXT,
    PRIMARY KEY (module_code),
);

ALTER TABLE Modules(
DROP  register_num INT(20) NOT NULL,
      module_name TEXT          NOT NULL,
      module_code VARCHAR(100)     NOT NULL,
      credits INT(200)        NOT NULL,
      level_study VARCHAR(20) NOT NULL,
      module_status TEXT,
      final_result TEXT,
      PRIMARY KEY (module_code),
);


-- calculate the mean grade for a period of study
SELECT ID,NAME,mean_grade=(AVG(grades))
FROM Modules

-- check the module credits 120 for undergraduate 180 for postgraduates
SELECT level_study,module_code,all_credits=SUM(credits),
FROM Modules



-- pass a module
SELECT module_code, grades,
CASE
    WHEN grades >= 40 THEN 'Pass'
    WHEN grades < 40 THEN 'Need a resit'
END AS module_status
FROM Modules;

-- student may progress or not
UPDATE Modules
SET module_status='pass'
WHERE grades >= 40 AND level_study <=2;
INSERT INTO Modules (final_result)
VALUES ('progrees to next level');

UPDATE Modules
SET module_status='pass'
WHERE grades >= 40 AND level_study >=3;
INSERT INTO Modules (final_result)
VALUES ('graduate');

UPDATE Modules
SET module_status='fail'
WHERE grades < 40;
INSERT INTO Modules(final_result)
VALUES ('fail to progress');

-- resit and repeat year


UPDATE Modules
SET resit_exam = 40
WHERE resit_exam >= 40 AND level_study <= 2;
INSERT INTO Modules (final_result)
VALUES ('progress to next level');

UPDATE Modules
SET resit_exam = 50
WHERE resit_exam >= 50 AND level_study >= 3;
INSERT INTO Modules (final_result)
VALUES ('graduate');

UPDATE Modules
SET repeat_year = 40
WHERE repeat_year >= 40 AND level_study <= 2;
INSERT INTO Modules(final_result)
VALUES ('progress to next level');

UPDATE Modules
SET repeat_year = 50
WHERE repeat_year >= 50 AND level_study >= 3;
INSERT INTO Modules (final_result)
VALUES ('graduate');

UPDATE Modules
SET module_status='fail'
WHERE repeat_year < 40;
INSERT INTO Modules (final_result)
VALUES ('fail to progress');


-- determine the degree class
SELECT Modules.module_code, (AVG(grades)) AS TotalMark,degree_class,
    CASE WHEN (AVG(grades)) < 39.5 IN ('1-year MSc','BSc,BEng degrees','MComp,MEng degrees')
    THEN 'fail'
    WHEN (AVG(grades)) < 44.4 AND (AVG(grades)) > 39.5 IN ('1-year MSc','MComp,MEng degrees')
    THEN 'fail'
    WHEN (AVG(grades)) < 44.4 AND (AVG(grades)) > 39.5 IN ('BSc,BEng degrees')
    THEN 'pass(non-honours)'
    WHEN (AVG(grades)) < 44.5 AND (AVG(grades)) > 49.4 IN ('1-year MSc','MComp,MEng degrees')
    THEN 'fail'
    WHEN (AVG(grades)) < 44.5 AND (AVG(grades)) > 49.4 IN ('BSc,BEng degrees')
    THEN 'third class'

    WHEN (AVG(grades)) < 59.4 AND (AVG(grades)) > 49.5 IN ('1-year MSc')
    THEN 'pass'
    WHEN (AVG(grades)) < 59.4 AND (AVG(grades)) > 49.5 IN ('BSc,BEng degrees','MComp,MEng degrees')
    THEN 'lower second'
    WHEN (AVG(grades)) < 69.4 AND (AVG(grades)) > 59.5 IN ('1-year MSc')
    THEN 'merit'
    WHEN (AVG(grades)) < 69.4 AND (AVG(grades)) > 59.5 IN ('BSc,BEng degrees','MComp,MEng degrees')
    THEN 'upper second'
    WHEN (AVG(grades)) >= 69.5 IN ('1-year MSc')
    THEN 'distinction'
    WHEN (AVG(grades)) >= 69.5 IN ('BSc,BEng degrees','MComp,MEng degrees')
    THEN 'first class'
    END AS DEGREE_CLASS
    FROM Modules;

-- student and modules
SELECT *
FROM Students
INNER JOIN Modules ON Students.register_num = Modules.register_num;


-- view the status of all students
SELECT *
FROM student
FULL OUTER JOIN Modules ON Students.register_num = Modules.register_num
ORDER BY Students.surname;

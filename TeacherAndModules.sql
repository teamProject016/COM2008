CREATE TABLE module_info(
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
ALTER TABLE module_info(
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
ALTER TABLE module_info(
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
ALTER TABLE module_info(
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

ALTER TABLE module_info(
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
FROM module_info

-- check the module credits 120 for undergraduate 180 for postgraduates
SELECT level_study,module_code,all_credits=SUM(credits),
FROM module_info



-- pass a module
SELECT module_code, grades,
CASE
    WHEN grades >= 40 THEN 'Pass'
    WHEN grades < 40 THEN 'Need a resit'
END AS module_status
FROM module_info;

-- student may progress or not
UPDATE module_info
SET module_status='pass'
WHERE grades >= 40 AND level_study <=2;
INSERT INTO module_info (final_result)
VALUES ('progrees to next level');

UPDATE module_info
SET module_status='pass'
WHERE grades >= 40 AND level_study >=3;
INSERT INTO module_info (final_result)
VALUES ('graduate');

UPDATE module_info
SET module_status='fail'
WHERE grades < 40;
INSERT INTO module_info (final_result)
VALUES ('fail to progress');

-- resit and repeat year


UPDATE module_info
SET resit_exam = 40
WHERE resit_exam >= 40 AND level_study <= 2;
INSERT INTO module_info (final_result)
VALUES ('progress to next level');

UPDATE module_info
SET resit_exam = 50
WHERE resit_exam >= 50 AND level_study >= 3;
INSERT INTO module_info (final_result)
VALUES ('graduate');

UPDATE module_info
SET repeat_year = 40
WHERE repeat_year >= 40 AND level_study <= 2;
INSERT INTO module_info (final_result)
VALUES ('progress to next level');

UPDATE module_info
SET repeat_year = 50
WHERE repeat_year >= 50 AND level_study >= 3;
INSERT INTO module_info (final_result)
VALUES ('graduate');

UPDATE module_info
SET module_status='fail'
WHERE repeat_year < 40;
INSERT INTO module_info (final_result)
VALUES ('fail to progress');


-- determine the degree class
SELECT module_info.module_code, (AVG(grades)) AS TotalMark,degree_class,
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
    FROM module_info;

-- student and modules
SELECT *
FROM Students
INNER JOIN module_info ON Students.register_num = module_info.register_num;


-- view the status of all students
SELECT *
FROM student
FULL OUTER JOIN module_info ON Students.register_num = module_info.register_num
ORDER BY Students.surname;

CREATE TABLE ACADEMIC_MODULE (
NAME TEXT          NOT NULL,
MODULE_CODE VARCHAR(10)     NOT NULL,
CREDITS INT        NOT NULL,
PERIOD ENUM('Autumn','Spring','Academic Year'),
PRIMARY KEY (MODULE_CODE),
);

/* filter the modules which in level 1/2/3 */
SELECT * FROM ACADEMIC_MODULE
WHERE CREDITS=20;

/* filter the modules which in level 4 */
SELECT * FROM ACADEMIC_MODULE
WHERE CREDITS=15;

/* filter the modules which in undergraduate dissertation */
SELECT * FROM ACADEMIC_MODULE
WHERE CREDITS=40;

/* filter the modules which in master dissertation */
SELECT * FROM ACADEMIC_MODULE
WHERE CREDITS=60;

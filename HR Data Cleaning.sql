CREATE DATABASE project;

USE project;

SELECT * FROM hr;

DESCRIBE hr;
-- Data Cleaning 

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

UPDATE hr 
SET birthdate = CASE
  WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
  WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
  ELSE NULL
END;

ALTER TABLE HR
MODIFY COLUMN birthdate DATE;

UPDATE hr 
SET  hire_date= CASE
  WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
  WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
  ELSE NULL
END;

SELECT hire_date FROM hr;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT termdate FROM hr;

UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%M-%D %H:%m:%s UTC'))
WHERE termdate IS NOT NULL AND termdate !='';
 
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

SELECT * FROM hr;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr 
SET age = timestampdiff(YEAR, birthdate, curdate());

SELECT 
MIN(age) AS Youngest,
MAX(age) AS Oldest
FROM hr;

SELECT birthdate, age FROM hr;

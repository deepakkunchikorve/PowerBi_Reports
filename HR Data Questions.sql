-- QUESTIONS

-- 1. What is the gender breakdown of employees in the compnay?

SELECT gender, count(*) AS COUNT
FROM hr
WHERE age >= 18 AND termdate = ''
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees in th company?

SELECT race, COUNT(*) AS COUNT
FROM hr
WHERE age >=18 AND termdate = ''
GROUP BY RACE
ORDER BY COUNT(*) DESC;

-- 3. What is the age distribution of employees in the company?

SELECT 
MIN(age) AS Youngest,
MAX(AGE) AS Oldest
FROM hr
WHERE age >= 18 AND termdate = '';

SELECT 
CASE
WHEN age >= 18 AND age <= 24 THEN '18-24'
WHEN age >= 25 AND age <= 34 THEN '25-34'
WHEN age >= 35 AND age <= 44 THEN '35-44'
WHEN age >= 44 AND age <= 54 THEN '44-54'
WHEN age >= 55 AND age <= 64 THEN '55-64'
ELSE '65+'
END AS age_group,
COUNT(*) AS COUNT
FROM hr
WHERE age >= 18 AND termdate = ''
GROUP BY age_group
order by age_group;

SELECT 
CASE
WHEN age >= 18 AND age <= 24 THEN '18-24'
WHEN age >= 25 AND age <= 34 THEN '25-34'
WHEN age >= 35 AND age <= 44 THEN '35-44'
WHEN age >= 44 AND age <= 54 THEN '44-54'
WHEN age >= 55 AND age <= 64 THEN '55-64'
ELSE '65+'
END AS age_group, gender,
COUNT(*) AS COUNT 
FROM hr
WHERE age >= 18 AND termdate = ''
GROUP BY age_group, gender
order by age_group, gender;

-- 4. How many employees work at headquaters versus remote locations?

SELECT location, COUNT(*) AS count
FROM HR
WHERE age >= 18 AND termdate = ''
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?

SELECT 
ROUND(AVG(DATEDIFF(termdate, hire_date))/365,0)  AS avg_length_employment
FROM hr
WHERE termdate <= CURDATE() AND TERMDATE <>'' AND age >= 18;

-- 6. How does the gender distribution vary across departments and job titles?

SELECT department, gender, COUNT(*) AS COUNT
FROM hr
WHERE age >= 18 AND termdate = ''
GROUP BY department, gender
ORDER BY department;

-- 7. What is the distribution of job titles across the company?

SELECT jobtitle, COUNT(*) AS COUNT
FROM hr
WHERE age >= 18 AND termdate = ''
GROUP BY jobtitle
ORDER BY jobtitle DESC; 

-- 8. Which department has the highest termination rate?

SELECT department, total_count, terminated_count, terminated_count / total_count AS termination_rate
FROM (
SELECT department,
COUNT(*) AS total_count,
SUM(CASE WHEN TERMDATE<>'' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
FROM HR
WHERE age >=18
GROUP BY department
) AS subquery
ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across location by city and state?

SELECT location_state , COUNT(*) AS COUNT
FROM hr
WHERE age >= 18 AND termdate = ''
GROUP BY location_state
ORDER BY COUNT DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?

SELECT year, hires, terminations, hires - terminations AS net_change,
round((hires - terminations)/hires * 100,2) AS net_change_percent
FROM(
SELECT 
YEAR(hire_date) AS YEAR,
count(*) AS hires,
Sum(CASE WHEN termdate <> '' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
FROM hr 
WHERE age >= 18
GROUP BY YEAR(hire_date)
) AS subquery
ORDER by YEAR ASC;

-- 11. What is the tenure distribution for each department?

SELECT department, round(avg(datediff(termdate, hire_date)/365),0) AS avg_tenure
FROM hr
WHERE termdate <= curdate() AND termdate<>'' AND age >= 18
GROUP BY department;

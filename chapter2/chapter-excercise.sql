SELECT * FROM teachers
ORDER BY last_name ASC;

SELECT * FROM teachers
WHERE first_name ILIKE 's%'
	AND (salary > 40000);
	
SELECT * FROM teachers
WHERE hire_date >= '2010-01-01'
	ORDER BY salary DESC;

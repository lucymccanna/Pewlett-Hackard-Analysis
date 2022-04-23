-- Challenge Assignment

-- Deliverable 1: The Number of Retiring Employees by Title

-- #1 Retrieve the emp_np, first_name, and last_name columns from the employees table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title 
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- retrieve number of employees about to retire
SELECT COUNT (title), title 
--INTO retiring_titles
FROM unique_titles 
GROUP BY title
ORDER BY count DESC;


-- Deliverable 2: Employees Eligible for the Mentorship Program
SELECT DISTINCT ON (emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
	ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;


-- Supporting Results: 

-- How many currently employed employees are there? 
SELECT DISTINCT ON (emp_no) emp_no
INTO current_employed
FROM dept_emp
WHERE (to_date = '9999-01-01');
-- receive count of current employees
SELECT COUNT (emp_no) emp_no
FROM current_employed;

-- group mentorship eligibility by title
SELECT COUNT (title), title
INTO mentorship_titles
FROM mentorship_eligibility
GROUP BY title
ORDER BY count DESC;


-- Compare number retiring titles to mentorship titles
SELECT rt.title AS Title,
	rt.count AS Total_Retiring_Count, 
	mt.count AS Total_Mentor_Ready_Count
INTO retiring_vs_mentorready
FROM retiring_titles as rt
LEFT JOIN mentorship_titles as mt
ON (rt.title = mt.title);

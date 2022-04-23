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
INTO retiring_titles
FROM unique_titles 
GROUP BY title
ORDER BY count DESC;

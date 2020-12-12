--SELECT * Statements 
SELECT * FROM titles;
SELECT * FROM salaries;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM dept_emp;
SELECT * FROM departments;

--Query the following Questions

--List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT ep.emp_no AS employee_number,last_name,first_name,sex,salary
FROM employees AS ep 
JOIN salaries AS sl ON ep.emp_no = sl.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name,last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT dp.dept_no AS department_number, dept_name AS department_name,dm.emp_no AS manager_employee_number,last_name,first_name
FROM employees AS ep
JOIN dept_manager AS dm ON dm.emp_no = ep.emp_no
JOIN departments AS dp ON dp.dept_no = dm.dept_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT de.emp_no,last_name,first_name,dept_name
FROM dept_emp AS de
JOIN employees AS ep ON ep.emp_no = de.emp_no
JOIN departments AS dp ON de.dept_no = dp.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name,last_name,sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT ep.emp_no AS employee_number,last_name,first_name,dept_name AS department_name
FROM employees AS ep
JOIN dept_emp AS de ON de.emp_no = ep.emp_no
JOIN departments AS dp ON dp.dept_no = de.dept_no
WHERE dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT ep.emp_no AS employee_number,last_name,first_name,dept_name AS department_name
FROM employees AS ep
JOIN dept_emp AS de ON de.emp_no = ep.emp_no
JOIN departments AS dp ON dp.dept_no = de.dept_no
WHERE dept_name IN ('Sales','Development');

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT last_name, COUNT(last_name) AS num_of_sharedLastNames
FROM employees
GROUP BY last_name;

SELECT last_name, COUNT(last_name) AS num_of_sharedLastNames
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;
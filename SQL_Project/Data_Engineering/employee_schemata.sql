CREATE TABLE titles (
	title_id VARCHAR(255) PRIMARY KEY,
	title CHAR(255) NOT NULL);

CREATE TABLE employees (
	emp_no SERIAL PRIMARY KEY,
	emp_title_id VARCHAR(255) NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
	birth_date DATE NOT NULL,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	sex CHAR(1) NOT NULL,
	hire_date DATE NOT NULL CHECK (birth_date < hire_date));

CREATE TABLE salaries (
	emp_no SERIAL NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	salary INT NOT NULL CHECK (salary > 0));

CREATE TABLE departments (
	dept_no VARCHAR(255) PRIMARY KEY,
	dept_name CHAR(255) NOT NULL);

CREATE TABLE dept_emp (
	emp_no SERIAL NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	dept_no VARCHAR(255),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no));

CREATE TABLE dept_manager (
	dept_no VARCHAR(255),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	emp_no SERIAL NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no));

----- Deparments ------------------

drop table if exists departments;

create table departments(
	dept_no varchar(20) not null primary key,
	dept_name varchar(20)
);

COPY departments(dept_no,dept_name)
FROM '/Users/rafa/BootCamp/sql-challenge/sql-challenge/data/departments.csv'
DELIMITER ','
CSV HEADER;


select * from departments;

----- dept_emp ------------------

drop table if exists dept_emp;

create table dept_emp(
	emp_no varchar(20),
	dept_no varchar(20),
	constraint dept_no 
	foreign key (dept_no)
	references departments(dept_no)
);

COPY dept_emp(emp_no,dept_no)
FROM '/Users/rafa/BootCamp/sql-challenge/sql-challenge/data/dept_emp.csv'
DELIMITER ','
CSV HEADER;

select * from dept_emp limit(5);

----- dept_manager ------------------

drop table if exists dept_manager;

create table dept_manager(
	emp_no varchar(20),
	dept_no varchar(20),
	constraint dept_no 
	foreign key (dept_no)
	references departments(dept_no)
);

COPY dept_manager(dept_no,emp_no)
FROM '/Users/rafa/BootCamp/sql-challenge/sql-challenge/data/dept_manager.csv'
DELIMITER ','
CSV HEADER;

select * from dept_manager limit(5);

----- employees ------------------
drop table if exists employees;

create table employees(
	emp_no varchar(20) not null primary key,
	emp_title_id varchar(20),
	birth_data varchar(20),
	first_name varchar(20),
	last_name varchar(20),
	sex varchar(2),
	hire_date varchar(20)
);

COPY employees(emp_no,emp_title_id,birth_data,first_name,last_name,sex,hire_date)
FROM '/Users/rafa/BootCamp/sql-challenge/sql-challenge/data/employees.csv'
DELIMITER ','
CSV HEADER;

select * from employees limit(5);

----- salaries ------------------
drop table if exists salaries;

create table salaries(
	emp_no varchar(20) not null primary key,
	salary int not null
);

COPY salaries(emp_no,salary)
FROM '/Users/rafa/BootCamp/sql-challenge/sql-challenge/data/salaries.csv'
DELIMITER ','
CSV HEADER;

select * from salaries limit(5);

----- titles ------------------
drop table if exists titles;

create table titles(
	title_id varchar(20) not null primary key,
	title varchar(20) not null
);

COPY titles(title_id,title)
FROM '/Users/rafa/BootCamp/sql-challenge/sql-challenge/data/titles.csv'
DELIMITER ','
CSV HEADER;

select * from titles limit(5);


----- Query 1 --------
select e.emp_no, last_name, first_name, sex, salary
from employees as e, salaries as s
where e.emp_no=s.emp_no;

----- Query 1 --------
select e.emp_no, last_name, first_name, sex, salary
from employees as e, salaries as s
where e.emp_no=s.emp_no;


---- Query 2 ----------

select first_name, last_name, hire_date
from employees
where cast(extract(year from to_date(hire_date,'MM/DD/YYYY')) as int)=1986;

---- Query 3 ---------

select d.dept_no, d.dept_name, e.emp_no, last_name, first_name
from dept_manager as dm
left join employees as e
on dm.emp_no=e.emp_no
left join departments as d
on dm.dept_no=d.dept_no;

-------- Query 4 ------------

select e.emp_no, last_name, first_name, dept_name
from employees as e
left join dept_emp as de
on e.emp_no=de.emp_no
left join departments as d
on d.dept_no=de.dept_no;

-------- Query 5 ------------

select first_name, last_name, sex
from employees
where first_name='Hercules'
and last_name like 'B%';

-------- Query 6 ------------

select e.emp_no, last_name,first_name, dept_name
from employees as e
left join dept_emp as de
on e.emp_no=de.emp_no
left join departments as d
on de.dept_no=d.dept_no
where d.dept_name='Sales';


-------- Query 7 ------------

select e.emp_no, last_name,first_name, dept_name
from employees as e
left join dept_emp as de
on e.emp_no=de.emp_no
left join departments as d
on de.dept_no=d.dept_no
where d.dept_name='Sales' or d.dept_name='Development';

------ Query 8 ------------

select last_name, count(last_name) as count_last
from employees
group by last_name
order by count_last desc;




-- SQL queries Portfolio 
-- NAME: Bruno Araujo De Carvalho 
-- Data Analyst 

-- These queries enable me to showcase my skill in writing effective queries that address real business challenges.


--Intermediate Level:



--    Find the number of employees in the database.

select count(first_name) as number_of_employee
from employees e



--    Get the details of employees who were hired on or after 1997.

select first_name, last_name  , d.dept_name ,birth_date,  hire_date 
from employees e
join dept_emp de  
on e.emp_no = de.emp_no
join departments d 
on de.dept_no = d.dept_no 
where hire_date > '1997-01-01'



--    Retrieve the employees who belong to the reseach department.

select first_name, last_name
from employees e
join dept_emp de  
on e.emp_no = de.emp_no
join departments d 
on de.dept_no = d.dept_no 
where d.dept_name = 'Research'



--    Find the average salary of all employees.

select round(avg(salary),2) as average_salary 
from salaries s 



--    Get the total count of male and female employees.

select (select count(gender) from employees e where gender ='M') as Count_Male,
(select count(gender) from employees e where gender ='F') as Count_female



--    Find the employee with the highest salary.

select first_name, last_name, salary
from employees e 
join salaries s 
on e.emp_no = s.emp_no
order by salary desc 
limit 1



--    Get the departments with the highest number of employees.

select dept_name, count(d.dept_name) as Count_Dept
from employees e 
join dept_emp de  
on e.emp_no = de.emp_no
join departments d 
on de.dept_no = d.dept_no 
group by dept_name
order by Count_Dept desc
limit 1



--    Retrieve the employees who have the same first name.

select first_name, last_name 
from employees e 
where first_name in (
select first_name from employees e2 group by first_name having count(*) > 1)
order by first_name 




--Advanced Level:



--    Retrieve the employees who have worked in multiple departments.

select a.first_name, a.last_name
from employees e2 
join 
(select e.emp_no, e.first_name, e.last_name, count(d.dept_name) as count_dep
from employees e 
join dept_emp de 
on e.emp_no = de.emp_no 
join departments d 
on de.dept_no = d.dept_no 
group by e.emp_no, first_name, last_name
having count(dept_name) > 1) a
on e2.emp_no = a.emp_no




--    Get the employees who have never changed their department.

select a.first_name, a.last_name
from employees e2 
join 
(select e.emp_no, e.first_name, e.last_name, count(d.dept_name) as count_dep
from employees e 
join dept_emp de 
on e.emp_no = de.emp_no 
join departments d 
on de.dept_no = d.dept_no 
group by e.emp_no, first_name, last_name
having count(dept_name) = 1) a
on e2.emp_no = a.emp_no




--    Find the department(s) with the highest average salary.

select a.dept_name, round(avg(a.salary)) as avg_salary
from
(
select d.dept_name, s.salary 
from employees e 
join dept_emp de  
on  e.emp_no = de.emp_no 
join salaries s 
on e.emp_no = s.emp_no 
join departments d 
on de.dept_no = d.dept_no) a 
group by a.dept_name
order by a.dept_name desc 
limit 1




--    Find the highest salary in each department.

select d.dept_name, max(a.max_salary) as max_salary_dept
from departments d 
join  (
select d.dept_name, max(s.salary) as max_salary ,e.first_name, e.last_name
from employees e 
join dept_emp de  
on  e.emp_no = de.emp_no 
join salaries s 
on e.emp_no = s.emp_no 
join departments d 
on de.dept_no = d.dept_no
group by d.dept_name , e.first_name , e.last_name
order by max_salary desc) a
on d.dept_name = a.dept_name
group by d.dept_name
order by max_salary_dept desc




--    Get the employees who have never changed their salary.

select a.first_name, a.last_name
from
(
select first_name, last_name, count(*)
from employees e 
join dept_emp de  
on  e.emp_no = de.emp_no 
join salaries s 
on e.emp_no = s.emp_no 
join departments d 
on de.dept_no = d.dept_no
group by first_name, last_name
having count(*)= 1) a


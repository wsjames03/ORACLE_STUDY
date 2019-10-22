
--子查询 ，，查询结果作为另外sql的过滤条件
select SALARY from EMPLOYEES where SALARY>= (SELECT SALARY from EMPLOYEES  where  LAST_NAME= 'Abel');

-- 查询员工名为chen的manager的信息
select LAST_NAME from EMPLOYEES where EMPLOYEE_ID =(SELECT MANAGER_ID from EMPLOYEES where LAST_NAME="Chen")

-- 返回job_id和41号员工相同，salary比143号员工多的员工姓名，job_id和工资
select LAST_NAME,JOB_ID,SALARY from EMPLOYEES where JOB_ID=(select JOB_ID from  EMPLOYEES where  EMPLOYEE_ID=141) and SALARY >(select SALARY from EMPLOYEES where EMPLOYEE_ID=143);

--返回公司工资最少的员工的last_name,job_id,salary
select LAST_NAME,JOB_ID,SALARY from EMPLOYEES where SALARY = (select min(SALARY) from EMPLOYEES);

--查询最低工资大于50号部门最低工资的部门id和他的最低工资
select DEPARTMENT_ID,min(SALARY) from EMPLOYEES
group by DEPARTMENT_ID
having min(SALARY)>(select min(SALARY) from EMPLOYEES where DEPARTMENT_ID=50);
--select DEPARTMENT_ID,min(SALARY) from EMPLOYEES where min(SALARY)>(select min(SALARY) from EMPLOYEES having DEPARTMENT_ID=50);

--返回其他部门中比job_id为'IT_PROG'部门任一工资低的员工的员工号，姓名，job_id以及salary
select EMPLOYEE_ID,JOB_ID,LAST_NAME,SALARY from EMPLOYEES  where JOB_ID <> 'IT_PROG' and SALARY <any(
    select SALARY from EMPLOYEES where JOB_ID='IT_PROG')

-- 1.	查询和Zlotkey相同部门的员工姓名和雇用日期

select LAST_NAME,HIRE_DATE ,DEPARTMENT_ID from EMPLOYEES where DEPARTMENT_ID = (select DEPARTMENT_ID from EMPLOYEES where LAST_NAME='Zlotkey');

-- 2.	查询工资比公司平均工资高的员工的员工号，姓名和工资
select  EMPLOYEE_ID,LAST_NAME,SALARY from EMPLOYEES where SALARY>(SELECT avg(SALARY) from  EMPLOYEES);

-- 3.	查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资
--错误原因:group by 返回的是多行结果，要用where限定  select  EMPLOYEE_ID,LAST_NAME,SALARY from EMPLOYEES where SALARY >(select avg(SALARY) from EMPLOYEES group by DEPARTMENT_ID)
select  EMPLOYEE_ID,LAST_NAME,SALARY from EMPLOYEES e1 where SALARY >(select avg(SALARY) from EMPLOYEES e2 where e1.DEPARTMENT_ID=e2.DEPARTMENT_ID group by DEPARTMENT_ID)

-- 4.	查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
select EMPLOYEE_ID,LAST_NAME from EMPLOYEES where DEPARTMENT_ID in (select DEPARTMENT_ID from EMPLOYEES where LAST_NAME like '%u%') and LAST_NAME not like '%u%';

-- 查询在部门的location_id为1700的部门工作的员工的员工号
select  EMPLOYEE_ID  from EMPLOYEES where DEPARTMENT_ID in (select DEPARTMENT_ID from DEPARTMENTS where LOCATION_ID=1700);

-- 查询管理者是King的员工姓名和工资
select  LAST_NAME,SALARY from EMPLOYEES where MANAGER_ID  in (select MANAGER_ID from EMPLOYEES where LAST_NAME='King');



----分组函数
--组函数
select avg(SALARY),max(SALARY),min(SALARY),sum(SALARY) from EMPLOYEES;
select count(EMPLOYEE_ID),count(LAST_NAME),count(HIRE_DATE) from EMPLOYEES;
-- avg函数会忽略空值，使用NVL函数可以解决
select avg(nvl(COMMISSION_PCT,0)) from EMPLOYEES;
--去重
select count(distinct DEPARTMENT_ID) from EMPLOYEES;

--group by
-- 求出employees表中的各个部门的平均工资
select DEPARTMENT_ID,avg(SALARY) from EMPLOYEES group by DEPARTMENT_ID;

-- where 和from 紧挨着
select DEPARTMENT_ID,avg(SALARY) from EMPLOYEES where DEPARTMENT_ID in(40,70,80) group by DEPARTMENT_ID;

-- 求出employees表中的各个部门 不同工种 的平均工资

select DEPARTMENT_ID,avg(SALARY) from EMPLOYEES group by DEPARTMENT_ID,JOB_ID;

-- 凡是不含组函数的列，用group by语句就要跟着这些列

--Having 不可以在where子句里面使用组函数
--求出各个部门平均工资大于6000的部门以及其平均工资
select DEPARTMENT_ID,avg(SALARY) from EMPLOYEES group by DEPARTMENT_ID having avg(SALARY)>6000;

--5.  查询各job_id的员工工资的最大值，最小值，平均值，总和
select max(SALARY),min(SALARY),avg(SALARY),sum(SALARY),JOB_ID from  EMPLOYEES group by JOB_ID;

--6.	选择具有各个job_id的员工人数
select JOB_ID,count(JOB_ID) from  EMPLOYEES group by JOB_ID;
-- 8.	查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
select MANAGER_ID,min(SALARY) from EMPLOYEES where MANAGER_ID is not null  group by MANAGER_ID having min(SALARY)>=6000

-- 9.	查询所有部门的名字，location_id，员工数量和工资平均值
select d.DEPARTMENT_NAME,d.LOCATION_ID,count(EMPLOYEE_ID),Avg(SALARY) from EMPLOYEES right join DEPARTMENTS D on EMPLOYEES.DEPARTMENT_ID = D.DEPARTMENT_ID left join LOCATIONS L on D.LOCATION_ID = L.LOCATION_ID group by d.DEPARTMENT_NAME, d.LOCATION_ID
select department_name,location_id,count(employee_id),avg(salary) from employees e right outer join departments d on e.department_id = d.department_id group by department_name,location_id


-- 等值内连接
select e.EMPLOYEE_ID
     , e.DEPARTMENT_ID
     , d.DEPARTMENT_NAME
     , l.CITY
from EMPLOYEES e,
     DEPARTMENTS d,
     LOCATIONS l
where e.DEPARTMENT_ID = d.DEPARTMENT_ID
  and d.LOCATION_ID = l.LOCATION_ID

-- 非等值内连接
select EMPLOYEE_ID, LAST_NAME, SALARY, GRADE_LEVEL
from EMPLOYEES e,
     JOB_GRADES j
where e.SALARY between j.LOWEST_SAL and j.HIGHEST_SAL;

-- 左外连接
select e.LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from EMPLOYEES e,
     DEPARTMENTS d
where e.DEPARTMENT_ID = d.DEPARTMENT_ID(+);
--or
select e.LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from EMPLOYEES e
         left join
     DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- 右外连接
select e.LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from EMPLOYEES e,
     DEPARTMENTS d
where e.DEPARTMENT_ID(+) = d.DEPARTMENT_ID;
--or
select e.LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from EMPLOYEES e
         right join
     DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- nature连接，所有共有字段都会匹配
-- 列名和数据类型要一样 使用using
select EMPLOYEE_ID, DEPARTMENT_ID, DEPARTMENT_NAME
from EMPLOYEES
         join DEPARTMENTS using (DEPARTMENT_ID);

-- 使用on
select EMPLOYEE_ID, DEPARTMENT_ID, DEPARTMENT_NAME
from EMPLOYEES e
         join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- 全外连接,满外连接
select EMPLOYEE_ID, d.DEPARTMENT_ID, DEPARTMENT_NAME
from EMPLOYEES e
         full outer join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- 自连接
-- 查询公司中员工'chen'的manager的信息
select emp.LAST_NAME, man.LAST_NAME, emp.SALARY, man.EMAIL
from EMPLOYEES emp,
     EMPLOYEES man
where emp.MANAGER_ID = man.EMPLOYEE_ID
  and lower(emp.LAST_NAME) = 'chen';

--3.	选择所有有奖金的员工的 last_name , department_name , location_id , city

select LAST_NAME, DEPARTMENT_NAME, l.LOCATION_ID, CITY
from EMPLOYEES e
         join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
         join LOCATIONS L on d.LOCATION_ID = L.LOCATION_ID
where e.COMMISSION_PCT is not null

--3.	4.	选择city在Toronto工作的员工的last_name , job_id , department_id , department_name

select LAST_NAME,JOB_ID, DEPARTMENT_NAME,d.DEPARTMENT_ID
from EMPLOYEES e
         join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
         join LOCATIONS L on d.LOCATION_ID = L.LOCATION_ID
where lower(l.CITY)='toronto'

--5.	选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式
--      结果类似于下面的格式
--      employees	Emp#	manager	Mgr#
--      kochhar	    101	    king	100
select emp.LAST_NAME As employees,emp.EMPLOYEE_ID As Emp#,mgr.LAST_NAME As manger,mgr.EMPLOYEE_ID As Mgr#
       from  EMPLOYEES emp left join EMPLOYEES mgr on emp.MANAGER_ID = mgr.EMPLOYEE_ID;




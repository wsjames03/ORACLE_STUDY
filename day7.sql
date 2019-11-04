---- set 操作符，，联合查询
create table EMPLOYEES01 as
select *
from EMPLOYEES
where DEPARTMENT_ID in (70, 80);

-- Union 两个表的结构要一样
-- union会去重
select EMPLOYEE_ID, DEPARTMENT_ID
from EMPLOYEES01
union
select EMPLOYEE_ID, DEPARTMENT_ID
from EMPLOYEES02;
-- union all只是单纯拼接所有的结果，不会去重
select EMPLOYEE_ID, DEPARTMENT_ID
from EMPLOYEES01
union all
select EMPLOYEE_ID, DEPARTMENT_ID
from EMPLOYEES02;

--intersect 取交集
select EMPLOYEE_ID, DEPARTMENT_ID
from EMPLOYEES01
intersect
select EMPLOYEE_ID, DEPARTMENT_ID
from EMPLOYEES02;

--minus 取交集的补集，即差集
select EMPLOYEE_ID, DEPARTMENT_ID
from EMPLOYEES01
minus
select EMPLOYEE_ID, DEPARTMENT_ID
from EMPLOYEES02;

--注意事项：括号可以改变执行的顺序；
-- order by子句：只能在语句的最后出现，可以使用第一个查询中的列名,直接写列序号

-- 强制类型不一样， 类型匹配
select EMPLOYEE_ID, DEPARTMENT_ID, to_char(null)
from EMPLOYEES01
union
select to_number(null), DEPARTMENT_ID, DEPARTMENT_NAME
from DEPARTMENTS;

-- 1.查询部门的部门号，其中不包活job_id 是"SA_MAN"的部门号
select DEPARTMENT_ID
from DEPARTMENTS
minus
select DEPARTMENT_ID
from EMPLOYEES
where JOB_ID = 'SA_MAN';

-- 2.查询10，59，20 部门的JOB_ID,DEPARTMENT_ID
-- 并且按10，50，20 顺序排序
select JOB_ID, DEPARTMENT_ID
from (
         select JOB_ID, DEPARTMENT_ID, '1'
         from EMPLOYEES
         where DEPARTMENT_ID = 10
         union
         select JOB_ID, DEPARTMENT_ID, '3'
         from EMPLOYEES
         where DEPARTMENT_ID = 20
         union
         select JOB_ID, DEPARTMENT_ID, '2'
         from EMPLOYEES
         where DEPARTMENT_ID = 50
         order by 3);

--------------------------------------------------------------------------

---- 高级子查询

--查询last_name为chen的manager的信息 --单列子查询
select EMPLOYEE_ID, LAST_NAME
from EMPLOYEES
where EMPLOYEE_ID
          = (select MANAGER_ID from EMPLOYEES where LAST_NAME = 'Chen');

--- 多列子查询
--问题：查询与141号或174号员工的manager_id和department_id相同的
-- 其他员工的employee_id, manager_id, department_id
select EMPLOYEE_ID, MANAGER_ID, DEPARTMENT_ID
from EMPLOYEES e1
where (MANAGER_ID, DEPARTMENT_ID) in
      (select MANAGER_ID, DEPARTMENT_ID from EMPLOYEES where EMPLOYEE_ID in (141, 174))
  and EMPLOYEE_ID not in (141, 174)


--- 在From子句中使用子查询
--返回比本部门平均工资高的员工的last_name, department_id, salary及平均工资
--1.第一种
select LAST_NAME,
       DEPARTMENT_ID,
       SALARY,
       (select avg(SALARY) from EMPLOYEES e3 where e1.DEPARTMENT_ID = e3.DEPARTMENT_ID group by DEPARTMENT_ID)
from EMPLOYEES e1
where SALARY > (select avg(SALARY) from EMPLOYEES e2 where e1.DEPARTMENT_ID = e2.DEPARTMENT_ID group by DEPARTMENT_ID)
--2.第二种
-- --在from里使用子查询，即在联表查询的时候，用子查询生成一张临时表用来个关联查询
select LAST_NAME,
       e1.DEPARTMENT_ID,
       t1.avg_salary
           SALARY
from EMPLOYEES e1,
     (select DEPARTMENT_ID, avg(SALARY) as avg_salary from EMPLOYEES e2 group by DEPARTMENT_ID) t1
where e1.DEPARTMENT_ID = t1.DEPARTMENT_ID

--- 单列子查询升级 CASE
-- 显示员工的employee_id,last_name和location。
-- 其中，若员工department_id与location_id为1800的department_id相同，
-- 则location为’Canada’,其余则为’USA’。

select EMPLOYEE_ID,
       LAST_NAME,
       (
           case DEPARTMENT_ID
               when (select DEPARTMENT_ID from DEPARTMENTS where LOCATION_ID = 1800) then 'Canada'
               else 'USA'
               end
           )
           AS LOCATION
from EMPLOYEES e
-- 查询员工的employee_id,last_name,要求按照员工的department_name排序
select EMPLOYEE_ID, LAST_NAME
from EMPLOYEES e
order by (select DEPARTMENT_NAME from DEPARTMENTS d where d.DEPARTMENT_ID = e.DEPARTMENT_ID)

---相关子查询
--相关子查询按照一行接一行的顺序实行，主查询的每一行都执行一次子查询
-- 即子查询中使用主查询中的列

-- 若employees表中employee_id与job_history表中employee_id相同的数目不小于2，
-- 输出这些相同id的员工的employee_id,last_name和其job_id
select EMPLOYEE_ID, LAST_NAME, JOB_ID
from EMPLOYEES e1
where 2 <= (
    select COUNT(*) from JOB_HISTORY j1 where j1.EMPLOYEE_ID = e1.EMPLOYEE_ID
)

--EXISTS操作符
-- EXISTS 操作符检查在子查询中是否存在满足条件的行
-- 如果在子查询中存在满足条件的行:
-- 不在子查询中继续查找,条件返回 TRUE
-- 如果在子查询中不存在满足条件的行:
-- 条件返回 FALSE,继续在子查询中查找
-- NOT EXISTS则刚好相反

--查询公司管理者的employee_id,last_name,job_id,department_id信息
select EMPLOYEE_ID, LAST_NAME, JOB_ID, DEPARTMENT_ID
from EMPLOYEES e1
where exists(select 'A' from EMPLOYEES e2 where e1.EMPLOYEE_ID = e2.MANAGER_ID)

---相关更新：使用相关子查询依据一个表中的数据更新另一个表的数据

update EMP011 e
set DEPARTMENT_NAME =(select DEPARTMENT_NAME from DEPARTMENTS d where e.DEPARTMENT_ID = d.DEPARTMENT_ID)

-- 相关删除：使用相关子查询依据一个表中的数据删除另一个表的数据
--删除表employees中，其与emp_history表皆有的数据
DELETE
FROM employees E
WHERE employee_id =
      (SELECT employee_id
       FROM emp_history
       WHERE employee_id = E.employee_id);

--- WITH 子句
-- 使用 WITH 子句, 可以避免在 SELECT 语句中重复书写相同的语句块
-- WITH 子句将该子句中的语句块执行一次并存储到用户的临时表空间中
-- 使用 WITH 子句可以提高查询效率

--查询公司中工资比Abel高的员工的信息
--传统方式：
select EMPLOYEE_ID, LAST_NAME, SALARY
from EMPLOYEES
where SALARY > (select SALARY from EMPLOYEES where LAST_NAME = 'Abel');

--with子句：
with Abel_sal as (select SALARY from EMPLOYEES where LAST_NAME = 'Abel')
select EMPLOYEE_ID, LAST_NAME, SALARY
from EMPLOYEES
where SALARY > (select SALARY from Abel_sal);

--练习
--1.	查询员工的last_name, department_id, salary.其中员工的salary,department_id与有奖金的任何一个员工的salary,department_id相同即可
select LAST_NAME, DEPARTMENT_ID, SALARY
from EMPLOYEES
where (SALARY, DEPARTMENT_ID) in (select SALARY, DEPARTMENT_ID from EMPLOYEES where COMMISSION_PCT is not null)

--2.	选择工资大于所有JOB_ID = 'SA_MAN'的员工的工资的员工的last_name, job_id, salary
select LAST_NAME, JOB_ID, SALARY
from EMPLOYEES
where SALARY > all (select SALARY from EMPLOYEES where JOB_ID = 'SA_MAN')
  AND JOB_ID <> 'SA_MAN'

--3.	选择所有没有管理者的员工的last_name
--select LAST_NAME from EMPLOYEES e1 where MANAGER_ID=(select EMPLOYEE_ID from  EMPLOYEES e2 where e1.EMPLOYEE_ID=e2.EMPLOYEE_ID)

select last_name
from employees e1
where not exists(
        select 'A'
        from employees e2
        where e1.manager_id = e2.employee_id
    )

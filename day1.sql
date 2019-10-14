select *
from EMPLOYEES;
-- describe  EMPLOYEES
select EMPLOYEE_ID, LAST_NAME, SALARY
from EMPLOYEES
where DEPARTMENT_ID = 90;
select LAST_NAME, HIRE_DATE
from EMPLOYEES; --where HIRE_DATE=DATE('1994-6-7');
select EMPLOYEE_ID, LAST_NAME, SALARY
from EMPLOYEES
where DEPARTMENT_ID in (70, 80, 90);
select EMPLOYEE_ID, LAST_NAME, SALARY
from EMPLOYEES
where LAST_NAME like '%a%';
select EMPLOYEE_ID, LAST_NAME, SALARY
from EMPLOYEES
where LAST_NAME like '_a%';--'第一个字符串是任意，用下划线代替
select LAST_NAME, DEPARTMENT_ID, SALARY
from EMPLOYEES
where DEPARTMENT_ID = 80
order by SALARY asc, LAST_NAME desc;


-- 单行函数
select lower('ATGUIGUJAVA'), UPPER('AtGuiGuJava'), initcap('ATGUIGUJAVA')
from dual;

select *
from EMPLOYEES
where lower(LAST_NAME) = 'king';

--concat,substr,instr
select concat('hello', 'world'), substr('helloweold', 2, 4)
from dual;
select instr('helloJava', 'J')
from dual;

-- lpad,rpad
select EMPLOYEE_ID, LAST_NAME, lpad(SALARY, 10, ' '), rpad(SALARY, 10, ' ')
from EMPLOYEES;

-- trim,raplace
select trim('o' from 'helloworld')
from dual;
select replace('helloworld', 'l', 'q')
from dual;


-- round
select round(435.45, 2), round(455.45), round(435.45, -2)
from dual;

select sysdate, sysdate + 2
from dual;

--TRUNC()函数截取时不进行四舍五入
select EMPLOYEE_ID,
       LAST_NAME,
       trunc(sysdate - HIRE_DATE) worked_days,
       months_between(sysdate, HIRE_DATE)
from EMPLOYEES;

select add_months(SYSDATE, 2), next_day(sysdate, '星期日')
from DUAL;

--来公司的员工当中，hiredate是每个月倒数第二天来公司的有哪些
select LAST_NAME, HIRE_DATE
from EMPLOYEES
where HIRE_DATE = LAST_DAY(HIRE_DATE) - 1;

--varchar是标准sql里面的。 varchar2是oracle提供的独有的数据类型。
-- varchar对于汉字占两个字节，对于英文是一个字节，占的内存小，varchar2都是占两个字节。
-- varchar对空串不处理，varchar2将空串当做null来处理。
-- varchar存放固定长度的字符串，最大长度是2000，varchar2是存放可变长度的字符串，最大长度是4000.
-- 如果是要跟换不同的数据库，例如mysql，那么就用varchar，如果就用oracle，那么用varchar2比较好一点

-- date<--->varchar2<--->number  隐式转换
select sysdate + '2'
from DUAL;
select sysdate + 2
from DUAL;
select '14' + 2
from DUAL;


-- |------  tochar -------↓-------- tochar ------|
-- DATE <--todate- -----varchar -tonumber--> NUMBER

select EMPLOYEE_ID, to_char(HIRE_DATE, 'yyyy-mm-dd')
from EMPLOYEES;
select EMPLOYEE_ID, to_char(HIRE_DATE, 'yyyy"年"mm"月"dd"日"')
from EMPLOYEES;
select TO_DATE('1996-08-05', 'yyyy-mm-dd')
from dual;

select to_char(123456.789, '999,999,999.99')
from dual;
select to_number('$12345.8', '$99999.9')
from dual;

--nvl
-- 求公司员工的年薪
select EMPLOYEE_ID, LAST_NAME, COMMISSION_PCT, SALARY * 12 * (1 + nvl(COMMISSION_PCT, 0))
from EMPLOYEES;
select EMPLOYEE_ID, LAST_NAME, COMMISSION_PCT, （SALARY*12*(1+nvl(COMMISSION_PCT, 0)) ） AS "年薪"
from EMPLOYEES;

--nvl2(expr1,expr2,expr3) :1不为空返回2，1为空返回3
select LAST_NAME, COMMISSION_PCT, nvl2(COMMISSION_PCT, COMMISSION_PCT + 0.015, 'null')
from EMPLOYEES;


--IF-THEN-ELSE
--CASE,DECODE
select EMPLOYEE_ID,
       LAST_NAME,
       DEPARTMENT_ID,
       SALARY,
       case DEPARTMENT_ID
           when 10 then SALARY * 1.1
           when 20 then SALARY * 1.2
           when 30 then SALARY * 1.3 end new_sal
from EMPLOYEES
where DEPARTMENT_ID in (10, 20, 30)

select EMPLOYEE_ID,
       LAST_NAME,
       DEPARTMENT_ID,
       decode(DEPARTMENT_ID, 10, SALARY * 1.1, 20, SALARY * 1.2, SALARY) new_Saklary
FROM EMPLOYEES;


select (LAST_NAME || ' earns ' || to_char(SALARY, '$999999') || ' monthly but wants ' ||
        to_char(3 * SALARY, '$999999')) AS "Dream Salary"
from EMPLOYEES;
select LAST_NAME,
       JOB_ID As "Job_id",
       decode(JOB_ID, 'AD_PRES', 'A',
              'ST_MAN', 'B',
              'IT_PROG', 'C',
              'SA_REP', 'D',
              'ST_CLERK', 'E'
           )  AS Grade
from EMPLOYEES
where lower(LAST_NAME) = 'king'

select LAST_NAME,
       JOB_ID,
       case JOB_ID
           when 'AD_PRES' then 'A'
           when 'ST_MAN' then 'B'
           when 'IT_PROG' then 'C'
           when 'SA_REP' then 'D'
           when 'ST_CLERK' then 'E' end Grade
from EMPLOYEES;









--约束
create table emp2
(
    id     number(10)
        constraint emp2_id_nn not null,
    name   varchar2(20) not null,
    salary number(10, 2)
)

-- unique 唯一键约束
create table emp4
(
    -- 列级约束
    id     number(10)
        constraint emp4_id_uk unique,
    name   varchar2(20)
        constraint emp4_name_nn not null,
    email  varchar2(20),
    salary number(10, 2),
    -- 表级约束
    constraint emp3_email_uk unique (email)
)
-- unique是可以插入空值的

--主键约束:非空唯一
create table emp5
(
    -- 列级约束
    id     number(10)
        constraint emp5_id_pk primary key,
    name   varchar2(20)
        constraint emp5_name_nn not null,
    email  varchar2(20),
    salary number(10, 2),
    -- 表级约束
    -- constraint emp3_email_uk unique(email)
    -- constraint emp4_id_pk primary key(id)
)

--外键约束，插入的值必须来自参照的父表
create table emp6
(
    -- 列级约束
    id            number(10),
    name          varchar2(20),
    email         varchar2(20),
    slary         number(10, 2),
    department_id number(10)
        -- 表级约束
        constraint emp6_email_uk unique(email),
    constraint emp6_id_pk primary key (id),
    constraint emp6_dept_id_fk foreign key (department_id) references DEPARTMENTS (DEPARTMENT_ID) on delete set null
)
-- check约束
create table emp8
(
    id     number(10),
    name   varchar2(20),
    email  varchar2(20),
    salary number(10, 2) check ( salary > 200 )
--    constraint emp8_chk_sly check ( salary>300 )

)

-- 添加或者删除约束
alter table emp5
    modify (salary number(10, 2) not null)

alter table emp6
    drop constraint emp6_email_uk;
alter table emp6
    add constraint emp6_email_uk unique (email);

-- 有效化和无效化
alter table emp4
    disable constraint emp4_name_nn;
insert into EMP4
values (2001, null, 'aa', 3000);


--视图 view
create view empv1 as
select EMPLOYEE_ID, SALARY, LAST_NAME
from EMPLOYEES
where DEPARTMENT_ID = 80;

create view empv2 as
select EMPLOYEE_ID id, LAST_NAME name, salary, DEPARTMENT_NAME
from EMPLOYEES e,
     DEPARTMENTS d
where e.EMPLOYEE_ID = d.DEPARTMENT_ID

-- 只读的view
create view empv3 as
select EMPLOYEE_ID id, LAST_NAME name, salary, DEPARTMENT_NAME
from EMPLOYEES e,
     DEPARTMENTS d
where e.EMPLOYEE_ID = d.DEPARTMENT_ID
    with read only

-- 使用到分组函数：复杂视图
create or replace view empv4
as
select d.DEPARTMENT_NAME, avg(salary) AS avg_sal
from EMPLOYEES e,
     DEPARTMENTS d
where e.DEPARTMENT_ID = d.DEPARTMENT_ID
group by DEPARTMENT_NAME

-- 删除视图：
drop view empv4;

select ROWNUM rn, EMPLOYEE_ID, LAST_NAME, salary
from (select EMPLOYEE_ID, LAST_NAME, salary from EMPLOYEES order by SALARY desc)
where ROWNUM <= 10;

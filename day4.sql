--用户定义的表:
select *
from USER_TABLES;

--查看用户定义的表, 视图, 同义词和序列
select *
from USER_CATALOG;

--查看用户定义的各种数据库对象
select *
from USER_OBJECTS;

--DDL:
--创建表的第一种方式：白手起家
create table emp1
(
    id        number(10)   not null,
    name      varchar2(20) not null,
    salary    number(10, 2),
    hire_date date
);
--创建表的第二中方式:依托于现有的表（数据也会复制过来）
create table emp4 as
select EMPLOYEE_ID id, LAST_NAME name, HIRE_DATE, salary
from EMPLOYEES where 1=2;

--增加列
alter table emp1 add (email varchar2(20)) ;
--编辑列
alter table emp1 modify (email varchar2(30) default 'abc@qq.com') ;
--删除列
alter table emp1 drop column email;
--重命名
alter table emp1 rename column id to id2;

--删除表
drop table emp1;
-- 删除表数据，表结构保留
truncate table em1;
-- 表重命名
rename emp1 to emp2;

-- 以上操作命令不能回滚

--DML
insert into emp1 values (1001,'ZQ',2000,sysdate);
commit ;
insert into emp1 values (1002,'zq2',3000,to_date('1996-08-05','yyyy-mm-dd'));

insert into emp1(id2,hire_date,name,salary) select EMPLOYEE_ID,HIRE_DATE,LAST_NAME,SALARY from EMPLOYEES where LAST_NAME like '%u%';
commit

update set;
delete from;

savepoint A;
rollback to savepoint A;
commit







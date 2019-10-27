-- 序列：主要用来提供主键值，，，，类似mysql的 auto_increment
create sequence sqemp1
    increment by 10 --每次增长10个数
    start with 10 -- 从10开始增长
    maxvalue 100 -- 提供的最大值
    cycle -- 需要循环
    nocache -- 不需要缓存登录

create table emp01
as
select EMPLOYEE_ID, LAST_NAME, SALARY
from EMPLOYEES
where 1 = 2;

drop sequence sqemp1;

-- 索引:加快查询速度：列中数据值分布范围很广；
-- 列经常在where子句或者连接条件中出现；表经常被访问而且数据量很大，占总数据量2%-4%
--下面情况不要创建：表很小；查询的数据大于2%-4%；表经常更新；列不经常在where子句或者连接条件中出现

create index emp01_id_ix on emp01 (EMPLOYEE_ID);

drop index emp01_id_ix;

--同义词
create synonym e for EMPLOYEES;


-- 命令行的权限控制

--创建用户
create user c##ZQ
    identified by 0805
--ERROR:
--ORA-01045: 用户 C##ZQ 没有 CREATE SESSION 权限; 登录被拒绝

-- 用户的权限
--create session\table\sequence\view\procedure....
grant create session to c##ZQ;
grant create table to c##ZQ;

--创建用户表空间
-- 用户拥有create table 权限以外，还需要分配对应的表空间才可以开辟存储空间用于创建表

alter user c##ZQ quota unlimited on users;
alter user c##ZQ identified by newpasswd;


create table emp
(
    id   number(10),
    name varchar2(10)
)

--创建角色
create role ZQ_manager;
grant create session,create table,create view to ZQ_manager;
grant ZQ_manager to c##ZQ;

--对象权限
--不同的对象具有不同的对象权限，对象的拥有者拥有所有的权限并且可以向外分配权限
-- grant object_priv[(columns)]
-- on object
-- to {user|role|public}
-- [with grant option] -- 能否授予别人

grant select
on c##JAMES.EMPLOYEES
to c##ZQ;

--select * from C##JAMES.EMPLOYEES

-- 收回对象的权限
-- revoke  {privilege[,privilege]|ALL}
-- on object
-- from {user|role|public}
-- [cascade constraints]
revoke select
on C##JAMES.EMPLOYEES
from c##ZQ;

--查看权限分配的情况
-- ROLE_SYS_PRIVS, 角色拥有的系统权限
-- ROLE_TAB_PRIVS, 角色拥有的对象权限
-- USER_ROLE_PRIVS,用户拥有的角色
-- USER_TAB_PRIVS_MADE,用户分配的关于表对象权限
-- USER_TAB_PRIVS_RECD,用户拥有的关于表对权限
-- USER_COL_PRIVS_MADE,用户分配的关于列对象权限
-- USER_COL_PRIVS_RECD,用户拥有的关于列对象权限
-- USER_SYS_PRIVS,用户拥有的系统权限

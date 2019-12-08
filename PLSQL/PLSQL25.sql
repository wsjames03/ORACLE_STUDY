-- 要求: 定义一个存储过程: 获取给定部门的工资总和 和 该部门的员工总数(定义为 OUT 类型的参数).
-- 要求: 部门号定义为参数, 工资总额定义为返回值.
create or replace procedure get_sal3(dept_id number,v_sum_sal out number)

is
   cursor  salary_cursor is select EMPLOYEES.SALARY from EMPLOYEES where DEPARTMENT_ID = dept_id;
begin
   v_sum_sal :=0;
   for c in salary_cursor loop
     v_sum_sal := v_sum_sal +c.SALARY;
     -- DBMS_OUTPUT.PUT_LINE(c.SALARY);
  end loop;
    --select sum(SALARY) into v_sum_sal from EMPLOYEES where DEPARTMENT_ID = dept_id;
end;
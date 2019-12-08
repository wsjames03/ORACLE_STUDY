-- 定义一个函数：获取给定部门的工资总和，要求：部门号定义为参数，
-- 工资总额定义为返回值

create or replace function get_sal(dept_id number)
return number
is
   v_sum_sal number(8) := 0;
   cursor  salary_cursor is select EMPLOYEES.SALARY from EMPLOYEES where DEPARTMENT_ID = dept_id;
begin
   for c in salary_cursor loop
     v_sum_sal := v_sum_sal +c.SALARY;
     DBMS_OUTPUT.PUT_LINE(c.SALARY);
  end loop;
    --select sum(SALARY) into v_sum_sal from EMPLOYEES where DEPARTMENT_ID = dept_id;
   return v_sum_sal;
end;
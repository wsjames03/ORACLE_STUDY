declare
  -- 声明变量
  --v_sal number(10,2);
  v_sal employees.salary%type;
  v_email varchar2(20);
  v_hire_date date;
begin
--sql语句的操作:select ... into ... from ... where ...
  select salary,email,hire_date into v_sal,v_email,v_hire_date from employees where employee_id = 100;
  --打印
  dbms_output.put_line(v_sal||','||v_email||','||v_hire_date);
end;
declare
-- 声明一个记录类型
type emp_record is record (
  v_sal employees.salary%type,
  v_email varchar2(20),
  v_hire_date date
);
-- 定义一个记录类型的成员变量
v_emp_record emp_record;
begin
  --赋值
  select salary,email,hire_date into v_emp_record from employees where employee_id = 100;
  --输出
  dbms_output.put_line(v_emp_record.v_sal||','||v_emp_record.v_email||','||v_emp_record.v_hire_date);

end;
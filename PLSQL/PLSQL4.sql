declare
v_sal number(8,2) :=0;
begin
select salary into v_sal from employees where employee_id = 123;
dbms_output.put_line('工资是:'||v_sal);
end;
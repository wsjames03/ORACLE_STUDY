-- helloworld级别的触发器
create or replace trigger update_emp_triger
    after
        update on EMPLOYEES
   -- for each row
begin
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
end;
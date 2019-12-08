--预定义异常
declare
    e_too_high_sal exception;
    v_sal EMPLOYEES.salary%type;
begin
    select SALARY into v_sal from EMPLOYEES where EMPLOYEE_ID =100;
    if v_sal>10000 then
        raise e_too_high_sal;
    end if;
exception
    when e_too_high_sal then DBMS_OUTPUT.PUT_LINE('工资太高了');
end;
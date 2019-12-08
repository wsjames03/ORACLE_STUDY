-- 预定义的异常
declare

    v_salary employees.salary%type;

begin

    select SALARY into v_salary from EMPLOYEES where EMPLOYEE_ID>100;

    DBMS_OUTPUT.PUT_LINE(v_salary);

exception
    when too_many_rows then DBMS_OUTPUT.PUT_LINE('输出的行数太多了！！');
    when others then DBMS_OUTPUT.PUT_LINE('出现其他异常');
end;
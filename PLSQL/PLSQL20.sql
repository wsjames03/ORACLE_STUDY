--更新指定员工的工资，如果工资小于300，则加100；对于NO_DATA_FOUND异常， TOO_MANY_ROWS异常进行处理；
declare
    v_sal employees.salary%type;
begin

select SALARY into v_sal from EMPLOYEES where EMPLOYEE_ID = 10909;
    if v_sal<300 then
        update EMPLOYEES set SALARY = SALARY+100 where EMPLOYEE_ID=100;
    end if;
    DBMS_OUTPUT.PUT_LINE(v_sal);
exception
    when no_data_found  then DBMS_OUTPUT.PUT_LINE('查无此人');
    when too_many_rows  then DBMS_OUTPUT.PUT_LINE('输出行太多了');
end;


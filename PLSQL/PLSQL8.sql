declare
    v_sal employees.salary%type;
    v_temp varchar2(20);

begin
    select SALARY into v_sal from EMPLOYEES where EMPLOYEE_ID = 150 ;

    v_temp :=
    case trunc(v_sal/5000)
        when 0 then 'salary <5000'
        when 1 then '5000<=salary<10000'
    else  'salary >=10000'
    end;

    DBMS_OUTPUT.PUT_LINE('工资是：'|| v_sal||','||v_temp);

end;
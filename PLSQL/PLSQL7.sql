declare
    -- 语句
    v_sal employees.salary%type;
begin
    select SALARY into v_sal from EMPLOYEES where EMPLOYEE_ID = 150 ;
    if v_sal>=10000 then DBMS_OUTPUT.PUT_LINE('salary >=10000');
    elsif v_sal>=5000 then DBMS_OUTPUT.PUT_LINE('5000<=salary <10000');
    else DBMS_OUTPUT.PUT_LINE('salary<5000');
    end if;
    DBMS_OUTPUT.PUT_LINE('工资是：'|| v_sal);
end;
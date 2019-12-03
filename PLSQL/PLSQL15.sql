/*
利用游标，调整公司中员工的工资

工资范围      调整基数
0-5000          5%
5000-10000      3%
10000-15000     2%
15000 -         1%
*/

declare
    cursor emp_sal_cur is select EMPLOYEE_ID,SALARY from EMPLOYEES;
    -- 用于记录调整基数
    v_temp number(4,2);
    v_empid employees.employee_id%type;
    v_sal employees.salary%type;

begin

    open emp_sal_cur;
    fetch emp_sal_cur into v_empid,v_sal;
    while emp_sal_cur%found loop

        if v_sal<5000 then v_temp :=0.05;
        elsif v_sal<10000 then v_temp :=0.03;
        elsif v_sal<15000 then v_temp :=0.02;
        else v_temp :=0.01;
        end if;
--         update EMPLOYEES set SALARY=SALARY*(1+v_temp)
--         where EMPLOYEE_ID=v_empid;
        DBMS_OUTPUT.PUT_LINE(v_sal ||',' ||v_sal *(1+v_temp));
    fetch emp_sal_cur into v_empid,v_sal;
    end loop;

    close emp_sal_cur;

end;


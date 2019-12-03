-- 打印出80号部门的所有员工的工资：salary :xxx
declare
    --声明一个记录类型
    type emp_record is record (
          v_sal employees.salary%type,
          v_id employees.EMPLOYEE_ID%type
        );
    -- 声明一个记录类型的变量
    v_emp_record emp_record;

--     v_sal employees.salary%type;
--     v_id employees.EMPLOYEE_ID%type;
    --定义一个游标
    cursor emp_sal_cursor is select SALARY,EMPLOYEE_ID from EMPLOYEES where DEPARTMENT_ID = 80;
begin
    --打开游标
    open emp_sal_cursor;

    --提取游标
    --fetch emp_sal_cursor into v_sal,v_id;
    fetch emp_sal_cursor into v_emp_record;
    while emp_sal_cursor%found loop
        DBMS_OUTPUT.PUT_LINE('id:'||v_emp_record.v_id||',salary:'||v_emp_record.v_sal);
        fetch emp_sal_cursor into v_emp_record;
    end loop;

    --关闭游标
    close emp_sal_cursor;

end;







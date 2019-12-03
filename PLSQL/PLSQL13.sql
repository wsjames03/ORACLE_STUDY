-- 打印出80号部门的所有员工的工资：salary :xxx
-- 增强for循环
declare
    --声明一个记录类型
    type emp_record is record (
          v_sal employees.salary%type,
          v_id employees.EMPLOYEE_ID%type
        );
    -- 声明一个记录类型的变量
    v_emp_record emp_record;
    --定义一个游标
    cursor emp_sal_cursor is select SALARY,EMPLOYEE_ID from EMPLOYEES where DEPARTMENT_ID = 80;
begin
    for c in emp_sal_cursor loop
        DBMS_OUTPUT.PUT_LINE('id:'||c.SALARY||',salary:'||c.EMPLOYEE_ID);
    end loop;

end;







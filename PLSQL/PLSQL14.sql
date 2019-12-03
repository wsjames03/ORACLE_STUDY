-- 打印出manager_id 为180的员工的last_name,email,salary的信息（使用游标，记录类型）

declare
  type emp_record is record (
       v_last_name EMPLOYEES.last_name%type,
       v_email EMPLOYEES.email%type,
       v_sal EMPLOYEES.salary%type
      );
   v_emp_record emp_record;
    cursor  v_emp_cursor is select last_name,email,salary from EMPLOYEES ;

begin

    DBMS_OUTPUT.PUT_LINE('HELLO');
   open v_emp_cursor;
    fetch v_emp_cursor into v_emp_record;
    while v_emp_cursor%found loop
        DBMS_OUTPUT.PUT_LINE('last_name:'||v_emp_record.v_last_name||',email'||v_emp_record.v_email||',salary'||v_emp_record.v_sal);
        fetch v_emp_cursor into v_emp_record;
    end loop;
   close v_emp_cursor;

end;
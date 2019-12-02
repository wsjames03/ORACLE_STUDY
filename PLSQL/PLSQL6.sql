declare
v_emp_record employees%rowtype;
begin

    select * into v_emp_record
    from EMPLOYEES where EMPLOYEE_ID=123;

    DBMS_OUTPUT.PUT_LINE('EMPLOYEE_ID:'||v_emp_record.EMPLOYEE_ID || ',EMAIL:'||v_emp_record.EMAIL||',SALARY:'||v_emp_record.SALARY);

end;
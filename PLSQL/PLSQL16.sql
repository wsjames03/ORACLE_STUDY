declare
cursor emp_sal_cur(dept_id number,sal number) is select SALARY,EMPLOYEE_ID from EMPLOYEES where DEPARTMENT_ID=dept_id and SALARY>sal;

begin

for c in emp_sal_cur(dept_id => 80,sal => 9000) loop

    DBMS_OUTPUT.PUT_LINE('Salary:'||c.SALARY||',ID:'||c.EMPLOYEE_ID);

end loop;

end;
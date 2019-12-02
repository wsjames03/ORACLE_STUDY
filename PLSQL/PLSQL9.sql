declare
    v_JobID employees.JOB_ID%type;
    v_temp varchar2(20);
begin
    select JOB_ID into v_JobID from employees where EMPLOYEE_ID=122;

    v_temp :=
    case v_JobID when 'IT_PROG' then 'GRADE:A'
                 when 'AC_MGT'  then 'GRADE:B'
                 when 'AC_ACCOUNT'then 'GRADE C'
                 else 'GRADE D' end;
    DBMS_OUTPUT.PUT_LINE(v_temp||','||v_JobID);

end;
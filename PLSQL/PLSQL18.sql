-- 非预定义异常
declare
 e_deleteid_exception exception ;
 pragma exception_init ( e_deleteid_exception ,-2292);
begin
    delete from EMPLOYEES where EMPLOYEE_ID = 100;
exception
    when e_deleteid_exception then DBMS_OUTPUT.PUT_LINE('违反完整性约束条件，不可删除此用户');
end;
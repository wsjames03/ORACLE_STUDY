-- 函数的HELLOWORLD：返回"HELLOWORLD"字符串
create or replace  function hello_world(v_name varchar2)
return varchar2
is
    v_date date;
begin
    v_date := sysdate;
    DBMS_OUTPUT.PUT_LINE(v_date);
    return 'Hello,'||v_name;
end;
/

--使用 :new, :old 修饰符
create or replace trigger EMPLOYEES_TRIGGER
    after
     update on EMPLOYEES
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('old:salary'||:old.SALARY||','||'new salary:'||:NEW.SALARY);
end;
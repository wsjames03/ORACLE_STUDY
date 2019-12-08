create or replace trigger del_emp3_trigger
before
 delete on EMP3
    for each row
 begin
     insert into EMP1_BAK values (:old.ID,:old.NAME,:old.SALARY,:old.HIRE_DATE);
 end;
-- 输出2-100之间的质数
declare
    v_flag number(1) :=1;
begin
    for v_i in 2..100 loop
        for v_j in 2..sqrt(v_i) loop
          if mod(v_i,v_j) = 0 then v_flag := 0;
              goto label;
              end if;
         end loop;
        <<label>>
        if v_flag =1 then  DBMS_OUTPUT.PUT_LINE(v_i);
        end if;
        v_flag :=1;
        end loop;
end;
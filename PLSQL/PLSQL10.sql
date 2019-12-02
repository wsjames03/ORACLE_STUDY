-- 使用循环语句打印1-100
-- 1.初始化条件2.循环体3.循环条件4.迭代条件
declare
    --1
    v_i number(5) := 1;
begin
    /*
    loop
         --2
        DBMS_OUTPUT.PUT_LINE(v_i);
    --3
    exit when v_i>=100;
        --4
        v_i := v_i +1;
    end loop;
    */
    while v_i <= 100 loop
        if v_i mod 2 =0 then
        DBMS_OUTPUT.PUT_LINE(v_i);
        end if;
        v_i := v_i +1;
    end loop;

--     FOR c IN reverse 1..100  LOOP
--             DBMS_OUTPUT.PUT_LINE(c);
--     END LOOP;

end;
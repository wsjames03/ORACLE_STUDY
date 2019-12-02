declare
    type salary_record is record (
        v_name varchar2(20),
        v_salary number(10,2),
        v_region_id number(2),
        v_region_name regions.region_name%type
--         v_region_name varchar2(50)
        );
    v_sal_record salary_record;
begin
    v_sal_record.v_name :='Liu';
    v_sal_record.v_salary :='2000';
    v_sal_record.v_region_id :=6;
    v_sal_record.v_region_name := 'Africa';
    DBMS_OUTPUT.PUT_LINE('name:'||v_sal_record.v_name||',salary:'||v_sal_record.v_salary);
--     insert into REGIONS values (v_sal_record.v_region_id,v_sal_record.v_region_name);
--     commit;
end;
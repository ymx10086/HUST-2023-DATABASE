-- 编写一存储过程，自动安排某个连续期间的大夜班的值班表:

-- show tables;
-- select * from employee;
delimiter $$
create procedure sp_night_shift_arrange(in start_date date, in end_date date)
begin
    declare done int default false;
    declare tp, wk int default false;
    declare doctor, nurse1, nurse2 char(30);
    declare pointer char(30);
    declare nur_name cursor for select e_name from employee where e_type = 3;
    declare doc_type cursor for select e_type, e_name from employee where e_type != 3;
    declare continue handler for not found set done = true;

    open nur_name;
    open doc_type;

    WHILE start_date <= end_date DO
        FETCH nur_name into nurse1;
        if done then
            close nur_name;
            open nur_name;
            set done = false;
            fetch nur_name into nurse1;
        end if;

        fetch nur_name into nurse2;
        if done then
            close nur_name;
            open nur_name;
            set done = false;
            fetch nur_name into nurse2;
        end if;

        set wk = weekday(start_date);
        if wk = 0 and pointer is not null then
            set doctor = pointer;
            set pointer = null;
        else
            fetch doc_type into tp, doctor;
            if done then
                close doc_type;
                open doc_type;
                set done = false;
                fetch doc_type into tp, doctor;
            end if;

            if wk > 4 and tp = 1 then
                -- 轮到主任周末夜班，用主任后面的医生递补
                set pointer = doctor;
                fetch doc_type into tp, doctor;
                if done then
                    close doc_type;
                    open doc_type;
                    set done = false;
                    fetch doc_type into tp, doctor;
                end if;
            end if;
        end if;
        insert into night_shift_schedule values (start_date, doctor, nurse1, nurse2);
        set start_date = date_add(start_date, interval 1 day);
    end while;


end$$

delimiter ;

/*  end  of  your code  */ 

-- DELIMITER $$ 
-- CREATE PROCEDURE sp_cursor_demo(INOUT average_goals FLOAT)
-- BEGIN
--     DECLARE done INT DEFAULT FALSE;
--     DECLARE matches int DEFAULT(0);
--     DECLARE goals int DEFAULT(0);
--     DECLARE half_time_goals INT;
    
--     DECLARE team_cursor CURSOR FOR SELECT HTHG FROM epl WHERE (home_team = 'Liverpool') and (ftr = 'H');
--     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
--     OPEN team_cursor;
--     FETCH team_cursor INTO half_time_goals;
--     WHILE NOT DONE DO
--       SET  goals = goals + half_time_goals;
--       SET  matches = matches + 1;
--          FETCH team_cursor INTO half_time_goals;
--     END while; 
 
--     SET  average_goals = goals / matches;
--     CLOSE team_cursor;
-- END $$ 
-- DELIMITER; 
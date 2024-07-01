use fib;

-- 创建存储过程`sp_fibonacci(in m int)`，向表fibonacci插入斐波拉契数列的前m项，及其对应的斐波拉契数。fibonacci表初始值为一张空表。请保证你的存储过程可以多次运行而不出错。

drop procedure if exists sp_fibonacci;
delimiter $$
create procedure sp_fibonacci(in m int)
begin
######## 请补充代码完成存储过程体 ########
    -- set m = m - 1;
    -- with
    --     recursive cte (id, cur, pre) as (
    --         select 0, 0, 0
    --         union all
    --         select
    --             id + 1,
    --             if (id < 2, 1, cur + pre),
    --             cur
    --         from cte
    --         where id < m
    --     )
    -- select id n, cur fibn
    -- from cte;

    declare n, fibn, a, b int;
    set n = 2,a = 0,b = 1;
    if m > 0 then
        insert into fibonacci values(0, 0);
    end if;
    if m > 1 THEN
        insert into fibonacci values(1, 1);
    end if;
    while m > n DO
        set fibn = a + b;
        insert into fibonacci values(n, fibn);
        set a = b;
        set b = fibn;
        set n = n + 1;
    end while;


end $$

delimiter ;

 

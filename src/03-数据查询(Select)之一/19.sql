-- 19) 以日历表格式列出2022年2月每周每日基金购买总金额，输出格式如下：
-- week_of_trading Monday Tuesday Wednesday Thursday Friday
--               1
--               2    
--               3
--               4
--   请用一条SQL语句实现该查询：

SELECT
    wk week_of_trading,
    SUM(if(dayId = 0, amount, null)) Monday,
    SUM(if(dayId = 1, amount, null)) Tuesday,
    SUM(if(dayId = 2, amount, null)) Wednesday,
    SUM(if(dayId = 3, amount, null)) Thursday,
    SUM(if(dayId = 4, amount, null)) Friday
FROM
    (
        SELECT
            week(pro_purchase_time) - week('2022-2-5') wk,
            weekday(pro_purchase_time) dayId,
            SUM(pro_quantity * f_amount) amount
        FROM
            property
            JOIN fund ON pro_pif_id = f_id
        WHERE
            pro_purchase_time LIKE "2022-02-%"
            AND pro_type = 3
        GROUP BY
            pro_purchase_time
    ) t
GROUP BY
    wk;






/*  end  of  your code  */
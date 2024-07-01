-- 14) 查询每份保险金额第4高保险产品的编号和保险金额。
--     在数字序列8000,8000,7000,7000,6000中，
--     两个8000均为第1高，两个7000均为第2高,6000为第3高。
-- 请用一条SQL语句实现该查询：

SELECT i_id, i_amount
FROM (
        SELECT i_id, i_amount, dense_rank() OVER (ORDER BY i_amount DESC) AS rk
        FROM insurance
    ) t
WHERE rk = 4
ORDER BY i_id;






/*  end  of  your code  */ 
   -- 3) 查询购买了所有畅销理财产品的客户
--   请用一条SQL语句实现该查询：

SELECT DISTINCT pro_c_id
FROM property t1
WHERE NOT EXISTS (
        SELECT *
        FROM (
                SELECT DISTINCT pro_pif_id
                FROM property
                WHERE pro_type = 1
                GROUP BY pro_pif_id
                HAVING COUNT(*) > 2
            ) t3
        WHERE pro_pif_id NOT IN (
                SELECT DISTINCT pro_pif_id
                FROM property t2
                WHERE t1.pro_c_id = t2.pro_c_id
                    AND t2.pro_type = 1
            )
    )
ORDER BY pro_c_id;



/*  end  of  your code  */
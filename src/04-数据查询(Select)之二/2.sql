  -- 2) 投资积极且偏好理财类产品的客户
--   请用一条SQL语句实现该查询：


SELECT t1.pro_c_id
FROM (
        SELECT pro_c_id,
            COUNT(pro_pif_id) AS p_cnt
        FROM property
        WHERE pro_type = 1
        GROUP BY pro_c_id
        HAVING COUNT(pro_pif_id) >= 3
    ) t1
    ,(
        SELECT pro_c_id,
            COUNT(pro_pif_id) AS f_cnt
        FROM property
        WHERE pro_type = 3
        GROUP BY pro_c_id
    ) t2
WHERE t1.pro_c_id = t2.pro_c_id and f_cnt < p_cnt
order by pro_c_id;




/*  end  of  your code  */
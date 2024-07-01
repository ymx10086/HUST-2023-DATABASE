 -- 1) 查询销售总额前三的理财产品
--   请用一条SQL语句实现该查询：

SELECT *
FROM (
        SELECT pyear,
            RANK() OVER(
                PARTITION BY pyear
                ORDER BY sumamount DESC
            ) rk,
            p_id,
            sumamount
        FROM (
                SELECT pyear,
                    p_id,
                    SUM(pro_quantity * p_amount) AS sumamount
                FROM (
                        SELECT *,
                            year(pro_purchase_time) pyear
                        FROM property
                    ) t1 join finances_product on pro_pif_id = p_id
                WHERE 
                    pro_type = 1
                GROUP BY p_id, pyear
            ) t3
        where pyear = 2010 or pyear = 2011
        ORDER BY pyear,
            rk,
            p_id
    ) t4
WHERE rk <= 3;





/*  end  of  your code  */
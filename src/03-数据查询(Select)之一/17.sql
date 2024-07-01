-- 17 查询2022年2月购买基金的高峰期。至少连续三个交易日，所有投资者购买基金的总金额超过100万(含)，则称这段连续交易日为投资者购买基金的高峰期。只有交易日才能购买基金,但不能保证每个交易日都有投资者购买基金。2022年春节假期之后的第1个交易日为2月7日,周六和周日是非交易日，其余均为交易日。请列出高峰时段的日期和当日基金的总购买金额，按日期顺序排序。总购买金额命名为total_amount。
--    请用一条SQL语句实现该查询：

SELECT
    t3.t as pro_purchase_time,
    t3.amount as total_amount
FROM
    (
        SELECT
            *,
            COUNT(*) OVER (
                PARTITION BY t2.workday - t2.rownum
            ) cnt
        FROM
            (
                SELECT
                    *,
                    row_number() OVER (
                        ORDER BY
                            workday
                    ) rownum
                FROM
                    (
                        SELECT
                            pro_purchase_time t,
                            SUM(pro_quantity * f_amount) amount,
                            @row := datediff(
                                pro_purchase_time,
                                "2021-12-31"
                            ) - 2 * week(pro_purchase_time) workday
                        FROM
                            property,
                            fund
                        WHERE
                            pro_purchase_time LIKE "2022-02-%"
                            AND pro_type = 3
                            AND pro_pif_id = f_id
                        GROUP BY
                            pro_purchase_time
                    ) t1
                WHERE
                    amount > 1000000
            ) t2
    ) t3
WHERE
    t3.cnt >= 3;

-- /*  end  of  your code  */
-- 13) 综合客户表(client)、资产表(property)、理财产品表(finances_product)、
--     保险表(insurance)、基金表(fund)和投资资产表(property)，
--     列出所有客户的编号、名称和总资产，总资产命名为total_property。
--     总资产为储蓄卡余额，投资总额，投资总收益的和，再扣除信用卡透支的金额
--     (信用卡余额即为透支金额)。客户总资产包括被冻结的资产。
--    请用一条SQL语句实现该查询：

SELECT c_id, c_name, ifnull(SUM(amount), 0) as total_property
FROM client LEFT JOIN(
        (SELECT pro_c_id,sum(pro_quantity*p_amount) as amount
            FROM property, finances_product
            WHERE pro_pif_id = p_id AND pro_type = 1
            group by pro_c_id
        )
        UNION ALL
        (
            select pro_c_id,sum(pro_quantity*i_amount) as total
            from property left join insurance on(pro_pif_id = i_id)
            where pro_type = 2
            group by pro_c_id
        )
        UNION ALL 
        (
            SELECT pro_c_id, sum(pro_quantity * f_amount) as amount
            FROM property, fund
            WHERE pro_pif_id = f_id AND pro_type = 3
            group by pro_c_id
        )
        UNION ALL 
        (
            SELECT pro_c_id, SUM(pro_income) as amount
            FROM property
            GROUP BY pro_c_id
        )
        UNION ALL 
        (
            SELECT b_c_id, SUM(if (b_type = '储蓄卡', b_balance,- b_balance)) as amount
            FROM bank_card
            GROUP BY b_c_id
        )
    ) pro ON c_id = pro.pro_c_id
GROUP BY c_id
ORDER BY c_id;






/*  end  of  your code  */ 
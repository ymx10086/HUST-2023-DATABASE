-- 15) 查询资产表中客户编号，客户基金投资总收益,基金投资总收益的排名(从高到低排名)。
--     总收益相同时名次亦相同(即并列名次)。总收益命名为total_revenue, 名次命名为rank。
--     第一条SQL语句实现全局名次不连续的排名，
--     第二条SQL语句实现全局名次连续的排名。

-- (1) 基金总收益排名(名次不连续)

SELECT pro_c_id, SUM(pro_income) as total_revenue, RANK() OVER(ORDER BY (SUM(pro_income)) desc) as 'rank'
FROM property
WHERE pro_type = 3
GROUP BY pro_c_id
ORDER BY total_revenue desc, pro_c_id;

-- (2) 基金总收益排名(名次连续)

SELECT pro_c_id, SUM(pro_income) as total_revenue, DENSE_RANK() OVER(ORDER BY (SUM(pro_income)) desc) 'rank'
FROM property
WHERE pro_type = 3
GROUP BY pro_c_id
ORDER BY total_revenue desc, pro_c_id;

/*  end  of  your code  */
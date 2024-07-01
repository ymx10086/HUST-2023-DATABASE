-- 6) 查询资产表中所有资产记录里商品收益的众数和它出现的次数。
--    请用一条SQL语句实现该查询：

SELECT pro_income, COUNT(*) AS presence
FROM property
GROUP BY pro_income
HAVING COUNT(*) >= (SELECT MAX(num) FROM (SELECT COUNT(*) AS num FROM property GROUP BY pro_income) AS t);

-- select pro_income,COUNT(*) presence
-- from property
-- group by pro_income
-- having presence >= ALL(
--     select COUNT(*)
--     from property
--     group by pro_income
-- );

/*  end  of  your code  */
-- 8) 查询持有两张(含）以上信用卡的用户的名称、身份证号、手机号。
--    请用一条SQL语句实现该查询：

-- SELECT c_name, c_id_card, c_phone 
-- FROM client, (
--     SELECT b_c_id, b_type 
--     FROM bank_card 
--     GROUP BY b_c_id, b_type 
--     HAVING COUNT(*) > 1
-- ) AS t
-- WHERE client.c_id = t.b_c_id AND t.b_type = '信用卡'

SELECT c_name, c_id_card, c_phone 
FROM client
WHERE (c_id, '信用卡') in (
    SELECT b_c_id, b_type 
    FROM bank_card 
    GROUP BY b_c_id, b_type 
    HAVING COUNT(*) > 1
);

/*  end  of  your code  */
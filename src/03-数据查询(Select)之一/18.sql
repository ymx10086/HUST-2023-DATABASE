 -- 18) 查询至少有一张信用卡余额超过5000元的客户编号，以及该客户持有的信用卡总余额，总余额命名为credit_card_amount。
--    请用一条SQL语句实现该查询：


SELECT b_c_id, SUM(b_balance) AS credit_card_amount
    FROM bank_card
    WHERE b_type = '信用卡'
    GROUP BY b_c_id
    HAVING MAX(b_balance) >= 5000
    ORDER BY b_c_id;




/*  end  of  your code  */


 
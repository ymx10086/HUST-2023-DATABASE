use finance1;
-- 请用一条SQL语句删除client表中没有银行卡的客户信息：


DELETE FROM  client
where not exists (
	select * from bank_card
	where client.c_id = bank_card.b_c_id
);

/* the end of your code */ 
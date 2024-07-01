-- 7) 查询身份证隶属武汉市没有买过任何理财产品的客户的名称、电话号、邮箱。
--    请用一条SQL语句实现该查询：


-- select c_name,c_phone,c_mail from client
-- where(select left(client.c_id_card, 4)=4201)
-- and c_id not in(select pro_c_id from property where pro_type=1);

select c_name,c_phone,c_mail from client
where not exists(
    select *
    FROM property
    where client.c_id_card not like '4201%' or (client.c_id = pro_c_id and pro_type = 1)
);

/*  end  of  your code  */
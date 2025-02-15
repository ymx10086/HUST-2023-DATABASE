 -- 12) 综合客户表(client)、资产表(property)、理财产品表(finances_product)、保险表(insurance)和
 --     基金表(fund)，列出客户的名称、身份证号以及投资总金额（即投资本金，
 --     每笔投资金额=商品数量*该产品每份金额)，注意投资金额按类型需要查询不同的表，
 --     投资总金额是客户购买的各类资产(理财,保险,基金)投资金额的总和，总金额命名为total_amount。
 --     查询结果按总金额降序排序。
 -- 请用一条SQL语句实现该查询：


select c_name,c_id_card,ifnull(sum(total), 0) as total_amount
from client left outer join (
    select pro_c_id,sum(pro_quantity*p_amount) as total
    from property left join finances_product on(pro_pif_id = p_id)
    where pro_type = 1
    group by pro_c_id

    union

    select pro_c_id,sum(pro_quantity*i_amount) as total
    from property left join insurance on(pro_pif_id = i_id)
    where pro_type = 2
    group by pro_c_id

    union 

    select pro_c_id,sum(pro_quantity*f_amount) as total
    from property left join fund on(pro_pif_id = f_id)
    where pro_type = 3
    group by pro_c_id
) as P on (c_id = pro_c_id)
group by c_id
order by total_amount desc;


/*  end  of  your code  */ 

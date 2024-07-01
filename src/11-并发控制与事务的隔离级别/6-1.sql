-- 事务1:
use testdb1;
start transaction;
set @n = sleep(10);
select tickets from ticket where flight_no = 'MU2455';
set @n = sleep(2);
select tickets from ticket where flight_no = 'MU2455';
commit;

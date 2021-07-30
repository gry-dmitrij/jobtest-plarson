delimiter //

drop procedure if exists day_count//
# ¬ыводит кол-во дней в каждом мес€це текущего года
create procedure day_count()
begin
	declare month int default 2;
	# сначала задаем первый день мес€ца, использу€ текущий год и нужный мес€ц,
	# затем с помощью LAST_DAY находим последний день в этом мес€це
	# и выводим этот день через dayofmonth
	set @sql_string = 'select month, dayofmonth(LAST_DAY(concat(year(CURDATE()), "-", month, "-01"))) from (select 1 as "month"';
	while month <= 12 DO
		set @sql_string = CONCAT(@sql_string, ' union select ', month); 
		set month = month + 1;
	end while;
	set @sql_string = CONCAT(@sql_string, ') t');
	prepare sql_query from @sql_string;
	execute sql_query;
	drop prepare sql_query;
end//

delimiter ;

call day_count();



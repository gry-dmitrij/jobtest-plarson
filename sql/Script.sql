delimiter //

drop procedure if exists day_count//
# ������� ���-�� ���� � ������ ������ �������� ����
create procedure day_count()
begin
	declare month int default 2;
	# ������� ������ ������ ���� ������, ��������� ������� ��� � ������ �����,
	# ����� � ������� LAST_DAY ������� ��������� ���� � ���� ������
	# � ������� ���� ���� ����� dayofmonth
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



-- union all. Вертикальное объединение идентичных таблиц.Если есть одинковые строки,то они дублируются!!!
-- одна таблица присоединяется ниже с другой таблицей.
-- Важное условие такого объединия это одинаковые поля.
select *,'one table' as number_table
from  data_set.subscriber_information_join
union all
select *,'two table' as number_table
from  data_set.subscriber_information_join;


-- union. Вертикальное объединение идентичных таблиц.Остаются только уникальные строки(похоже на group by или distinct)!!!
-- одна таблица присоединяется ниже с другой таблицей.
-- Важное условие такого объединия это одинаковые поля.
select *
from  data_set.subscriber_information_join
union
select *
from  data_set.subscriber_information_join;

-- FULL JOIN объединение LEFT JOIN + RIGHT JOIN
select *
from  data_set.subscriber_information_join
left join data_set.period_traffic_join
on data_set.subscriber_information_join.id_abon = data_set.period_traffic_join.id_abon
union
select *
from  data_set.subscriber_information_join
right join data_set.period_traffic_join
on data_set.subscriber_information_join.id_abon = data_set.period_traffic_join.id_abon;


-- FULL JOIN, но оставляем только те данные что отстутсвуют в соседних таблицах
select *
from  data_set.subscriber_information_join
left join data_set.period_traffic_join
on data_set.subscriber_information_join.id_abon = data_set.period_traffic_join.id_abon
where data_set.period_traffic_join.id_abon is null
union
select *
from  data_set.subscriber_information_join
right join data_set.period_traffic_join
on data_set.subscriber_information_join.id_abon = data_set.period_traffic_join.id_abon
where data_set.subscriber_information_join.id_abon is null;
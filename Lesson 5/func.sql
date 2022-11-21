--ФУНКЦИИ
--https://postgrespro.ru/docs/postgresql/14/functions?lang=ru-en
--функция агрегация max() поиск максимального значения
select max(comment_id) from public.comment_info;


-- ЛИСТ 14, функция агрегация min() поиск минимального значения
select min(comment_id) from public.comment_info;

--функция агрегация avg() поиск среднего значения значения
select avg(comment_id) from public.comment_info;

--возвращает случайное число
select random();

-- round(), обычное округление
select round(5.4)  as r;
select round(5.5)  as r;

-- ceiling(), округление в большую сторону
select ceiling(5.4) as c;

-- floor(),  округление в меньшую сторону
select floor(5.6) as f;

-- now(), текущая дата
select now();

--to_date(строка,маска), конвертация строки формата маски в формат даты
--https://oracleplsql.ru/to_date-postgresql.html
select to_date('2015/04/23', 'YYYY/MM/DD');
select to_date('042321', 'MMDDYY');
select to_date('February 08, 2010', 'Month DD, YYYY');
select to_date('01.05.2013 12:59','DD.MM.YYYY HH:MI');

-- to_char(дата,маска), конвертация даты в формат строки в формате маски
select created_at,to_char(created_at,'YYYY/MM/DD') from public.user_comment;

-- concat(1,2,3....), объединение полей
select concat("number",'-',"name",'-',email) from public.user_info;
-- или ||
select "number" || '-' || "name" || '-' || email from public.user_info;

-- УСЛОВИЯ CASE
-- case, множественное условие when и все остально else
select *,
CASE
	WHEN "name" = 'Abel' THEN 'Шпион 1'
	WHEN "name" = 'Jeff' THEN 'Шпион 2'
	WHEN "name" = 'Hilton' THEN 'Шпион 3'
	ELSE 'Не шпион'
END SPY
from public.user_info;
-- ВЫБОР SELECT
--выбор всех записей(*)
select * from public.user_comment;

--выбор первых 10 записей
select * from public.user_comment limit 10;

--пропустиить первые 5 записей и показать следующие 10 записи
select * from public.user_comment limit 10 offset 5;

--выбор определенных колонок,перечисление колонок через запятую
select user_id,created_at from public.user_comment;

-- ВЫБОР С УСЛОВИЕМ WHERE

--больше(>) 0  и(and) меньше(<) 3
select * from public.user_comment where comment_id >= 0 and comment_id < 10;

--не равно(<> и !=) 3
select * from public.user_comment where comment_id <> 3;

--равно(=) 3 ИЛИ(or) равно(=) 2
select * from public.user_comment where comment_id= 0  or comment_id = 3;

--только пустые('')
select * from public.comment_info  where "comment" =  '';

--поиск подстроки(LIKE) везде где есть `b` или 'a' в начале,середине или в конце
--LIKE медленный
select * from public.comment_info where "comment" LIKE ('%b%');
select * from public.comment_info where "comment" LIKE ('a%');
select * from public.comment_info where "comment" LIKE ('%a');

--поиск между 0 (включая) и 2(включая) через BETWEEN
select * from public.comment_info where comment_id BETWEEN  47 and 65;

--только то что перечислено в списке
select * from  public.comment_info where "comment" in ('vel','id');

--исключаем то что перечислено в списке
select * from  public.comment_info where "comment" not in ('vel','id');

-- ЛИСТ 12,сортировка(ORDER BY) по увеличению(ASC) и уменьшению(DESC)
select * from  public.comment_info order by comment_id DESC;

--ФУНКЦИИ
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


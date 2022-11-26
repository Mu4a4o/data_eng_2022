--ГРУПИРОВКА GROUP BY
-- инициализируем оператор group by к полю user_id  c функцией агрегации подсчета кол-ва по полю comment_id,
-- а так-же делаем сортировку по возврастанию
select user_id,count(comment_id)
from public.user_comment
group by user_id
order by user_id asc;
--проверка
select  user_id,comment_id from public.user_comment where user_id = 1009510;

-- применяем агрегирующие функции count,max,min,avg,sum

select comment_id,
count(user_id),
max(user_id),
min(user_id),
avg(user_id),
sum(user_id)
from  public.user_comment
group by comment_id;
--проверка
--0	17 8031820 1009510 4011004.117647058824 68187070
select  comment_id,user_id from public.user_comment where comment_id = 0;

-- having, фильтр, который работает так-же как и where, но только с полями сводной таблицы
select comment_id,
count(user_id),
max(user_id),
min(user_id),
avg(user_id),
sum(user_id)
from  public.user_comment
group by comment_id
having   comment_id = 0;

-- having, фильтр с использованием LIKE поля group_concat_first_name
select "comment",count(comment_id)
from  public.comment_info
group by "comment"
having "comment"  like ('a%');


-- порядок выполнения запросов, стандарт для SQL,но есть иссключения, пример кода ниже.
-- https://andreyex.ru/bazy-dannyx/baza-dannyx-mysql/poryadok-operatsij-sql-v-kakom-poryadke-mysql-vypolnyaet-zaprosy/
/*
1.FROM, включая JOINs
2.WHERE
3.GROUP BY
4.HAVING
5.Функции WINDOW
6.SELECT
7.DISTINCT
8.UNION
9.ORDER BY
10.LIMIT и OFFSET
*/

-- пример не правильного запроса, т.к where формируется раньше select и он не знает про псевдоним day_
select  user_id as ui,comment_id from public.user_comment where ui = 1009510;


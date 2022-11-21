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




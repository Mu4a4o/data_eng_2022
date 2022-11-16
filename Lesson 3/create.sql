
--cmd
--chcp 1251
--cd cd C:\Program Files\PostgreSQL\15\scripts\
--runpsql.bat


-- создаем юзера
--    -h хост
--    -s суперюзер
--    -P использовать вход по паролю
--    -e показывает команды, которые createuser генерирует и отправляет на сервер.
createuser -h localhost -p 5432 -P -s -e den

-- задаем пароль нашему юзеру
CREATE ROLE den PASSWORD 'mu4a4o212' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;

-- создаем БД
create database data_engineer;

--смотрим БД
SELECT datname FROM pg_database;

-- активируем БД
\c data_engineer;

-- смотрим список таблиц
\dt

--DROP TABLE  user_info CASCADE;
--DROP TABLE  user_comment CASCADE;
--DROP TABLE  comment_info CASCADE;
--TRUNCATE user_info CASCADE;;

-- создаем таблицу c юзерами
create table user_info
(
number INT UNIQUE, -- телефон
name VARCHAR(255), -- имя
email VARCHAR(255) -- почта
);


-- создаем  таблицу с указанием атрибутов
CREATE table comment_info
(
    comment_id INT UNIQUE, -- ид комента
    comment varchar(255) -- коммет
    --FOREIGN KEY (comment_id)  REFERENCES user_attribute (comment_id)
);

-- создаем таблицу связку с атрибутами
CREATE table user_comment
(
    user_id INT, -- поле с телефоном из user_info.number
    comment_id INT, --  поле с ид комментария из attribute_info.number
    created_at Date, -- дата создание связи
    FOREIGN KEY (user_id)  REFERENCES user_info (number), -- связь с телефоном user_info.number
    FOREIGN KEY (comment_id)  REFERENCES comment_info (comment_id) -- связь с телефоном comment_info.comment_id
);



-- смотрим список таблиц
\dt

--смотрим связи на схеме
data_engineer - GENERATE ERD

-- генерируем данные
http://filldb.info
генерируем БД по 1.jpg,2.jpg,3.jpg
export
открываем запрос в pgAmin  и применяем




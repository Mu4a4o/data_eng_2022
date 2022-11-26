-- Таблицы для join

create table `data_set`.`subscriber_information_join`
(`id_abon`VARCHAR(50) PRIMARY KEY,
`first_name` VARCHAR(25),
`last_name` VARCHAR(25),
`connection_date` DATE,
`trust_payment` INT,
`number_of_internet_devices` INT,
`number_of_tv_devices` INT,
`comment_when_сonnecting` VARCHAR(100));

insert into `data_set`.`subscriber_information_join` (`id_abon`,`first_name`,`last_name`,`connection_date`,`trust_payment`,`number_of_internet_devices`,`number_of_tv_devices`) values ('fdf40c5f-50d4-4d9f-a015-b5aece2aa944','Luke','Saunders','2020-01-15',0,1,3);
insert into `data_set`.`subscriber_information_join` (`id_abon`,`first_name`,`last_name`,`connection_date`,`trust_payment`,`number_of_internet_devices`,`number_of_tv_devices`) values ('d8e7f123-18f6-4c09-a683-d466ee1217e1','Kirsten','Cowan','2020-01-21',0,1,1);
insert into `data_set`.`subscriber_information_join` (`id_abon`,`first_name`,`last_name`,`connection_date`,`trust_payment`,`number_of_internet_devices`,`number_of_tv_devices`,`comment_when_сonnecting`) values ('c069c890-e499-4593-99ec-163aaedbaa90','Mackenzie','Nelson','2020-01-27',0,2,5,'good');
insert into `data_set`.`subscriber_information_join` (`id_abon`,`first_name`,`last_name`,`connection_date`,`trust_payment`,`number_of_internet_devices`,`number_of_tv_devices`,`comment_when_сonnecting`) values ('3f8af854-26a1-449d-a4a7-9bcd06a17088','Hank','Collins','2020-01-09',1,1,2,'good');

create table `data_set`.`period_traffic_join`
(`id_abon`VARCHAR(50),
`day` DATE ,
`traffic_gb` INT,
PRIMARY KEY (`id_abon`,`day`));

insert into `data_set`.`period_traffic_join` (`id_abon`,`day`,`traffic_gb`) values ('fdf40c5f-50d4-4d9f-a015-b5aece2aa944',str_to_date('01.02.2020','%d.%m.%Y'),462);
insert into `data_set`.`period_traffic_join` (`id_abon`,`day`,`traffic_gb`) values ('fdf40c5f-50d4-4d9f-a015-b5aece2aa944',str_to_date('02.02.2020','%d.%m.%Y'),130);
insert into `data_set`.`period_traffic_join` (`id_abon`,`day`,`traffic_gb`) values ('fdf40c5f-50d4-4d9f-a015-b5aece2aa944',str_to_date('03.02.2020','%d.%m.%Y'),316);
insert into `data_set`.`period_traffic_join` (`id_abon`,`day`,`traffic_gb`) values ('d8e7f123-18f6-4c09-a683-d466ee1217e1',str_to_date('01.02.2020','%d.%m.%Y'),145);
insert into `data_set`.`period_traffic_join` (`id_abon`,`day`,`traffic_gb`) values ('d8e7f123-18f6-4c09-a683-d466ee1217e1',str_to_date('02.02.2020','%d.%m.%Y'),182);
insert into `data_set`.`period_traffic_join` (`id_abon`,`day`,`traffic_gb`) values ('d8e7f123-18f6-4c09-a683-d466ee1217e1',str_to_date('03.02.2020','%d.%m.%Y'),32);
insert into `data_set`.`period_traffic_join` (`id_abon`,`day`,`traffic_gb`) values ('c069c890-e499-4593-99ec-163aaedbaa90',str_to_date('01.02.2020','%d.%m.%Y'),119);
insert into `data_set`.`period_traffic_join` (`id_abon`,`day`,`traffic_gb`) values ('c069c890-e499-4593-99ec-163aaedbaa90',str_to_date('02.02.2020','%d.%m.%Y'),83);
insert into `data_set`.`period_traffic_join` (`id_abon`,`day`,`traffic_gb`) values ('acbfe937-0329-4ff6-9680-cbe1b866c8d1',str_to_date('01.02.2020','%d.%m.%Y'),217);

-- union all. Вертикальное объединение идентичных таблиц.Если есть одинковые строки,то они дублируются!!!
-- одна таблица присоединяется ниже с другой таблицей.
-- Важное условие такого объединия это одинаковые поля.
select *,'one table' as number_table
from  `subscriber_information_join`
union all
select *,'two table' as number_table
from  `subscriber_information_join`


-- union. Вертикальное объединение идентичных таблиц.Остаются только уникальные строки(похоже на group by или distinct)!!!
-- одна таблица присоединяется ниже с другой таблицей.
-- Важное условие такого объединия это одинаковые поля.
select *
from  `subscriber_information_join`
union
select *
from  `subscriber_information_join`


-- LEFT JOIN горизонтальное объедиение таблиц
-- происходит левое объедиение таблиц, где к таблице, которая указана первой(левая) во from присоединяется вторая(правая) таблица
-- через оператор 'left join'. После через оператор 'on' определяется ключ или ключи.
-- Левая таблица основная. Все ее строки сохраняются, там где нет совпадений по ключу правой таблицы в новых полях проставляются null
select `si`.*, `pi`.`day`,`pi`.`traffic_gb`
from  `subscriber_information_join` as `si`
right join  `period_traffic_join` as `pi`
on `pi`.`id_abon` = `si`.`id_abon`

-- INNER JOIN горизонтальное объедиение таблиц
-- происходит объединение таблиц только по общим ключам
select `si`.*, `pi`.`day`,`pi`.`traffic_gb`
from  `subscriber_information_join` as `si`
inner join  `period_traffic_join` as `pi`
on `pi`.`id_abon` = `si`.`id_abon`


-- FULL JOIN объединение LEFT JOIN + RIGHT JOIN
-- т.к. Mysql нет `FULL JOIN` логика реализуется через UNION
select *
from  `subscriber_information_join`
left join `period_traffic_join`
on `subscriber_information_join`.`id_abon` = `period_traffic_join`.`id_abon`
union
select *
from  `subscriber_information_join`
right join `period_traffic_join`
on `subscriber_information_join`.`id_abon` = `period_traffic_join`.`id_abon`

-- FULL JOIN объединение LEFT JOIN + RIGHT JOIN
-- т.к. Mysql нет `FULL JOIN` логика реализуется через UNION
select *
from  `subscriber_information_join`
left join `period_traffic_join`
on `subscriber_information_join`.`id_abon` = `period_traffic_join`.`id_abon`
union
select *
from  `subscriber_information_join`
right join `period_traffic_join`
on `subscriber_information_join`.`id_abon` = `period_traffic_join`.`id_abon`

-- FULL JOIN, но оставляем только те данные что отстутсвуют в соседних таблицах
select *
from  `subscriber_information_join`
left join `period_traffic_join`
on `subscriber_information_join`.`id_abon` = `period_traffic_join`.`id_abon`
where `period_traffic_join`.`id_abon` is null
union
select *
from  `subscriber_information_join`
right join `period_traffic_join`
on `subscriber_information_join`.`id_abon` = `period_traffic_join`.`id_abon`
where `subscriber_information_join`.`id_abon` is null
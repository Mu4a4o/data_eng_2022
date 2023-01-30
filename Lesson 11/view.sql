
-- Создание представление/отображение
-- Динамическая таблица, где кэширование обновляется атоматически с обновлением базы
CREATE VIEW `new_view` AS
select * from  `subscriber_information`
left join `period_traffic` USING(`id_abon`)
-- Вызов отображения
SELECT * FROM data_set.new_view;

-- Создание процедур
-- создаем процедуру, которая  принимает на вход дату и возвращает таблицу по этой дате
CREATE  PROCEDURE `table_to_date`(in in_date date) -- список переменных подающих на вход
BEGIN
	SELECT *
    FROM  `subscriber_information`
    WHERE  `connection_date` = in_date;
END


-- Создание фукнции
-- фукнция возращает одно значение
CREATE FUNCTION `count_user_subscriber_information`()
    RETURNS int -- тип возращаемого значения
    READS SQL DATA -- флаг
BEGIN
	declare count_col int;
    set count_col = (select count(*) from `subscriber_information`);
RETURN count_col;
END

-- вызов функции
select `count_user_subscriber_information`()


-- Создание фукнции
-- фукнция возращает кол-во символов в строке
CREATE FUNCTION `count_str`(count_val varchar(50))
    RETURNS int -- тип возращаемого значения
    READS SQL DATA -- флаг
BEGIN
	declare count_col int;
    set count_col = LENGTH(count_val);
RETURN count_col;
END

-- проверка созданной процедуры
set @s = (select `id_abon` from `subscriber_information` limit 1); -- создаем переменную @s. В ней храниться строка
select `count_str`(@s);


-- Создание транзакций
-- позволяет делать инстркции по шагово не внося изменения в базу до их подтверждения (commit) или до отказа изменений (rollback)
START TRANSACTION;
INSERT INTO `data_set`.`subscriber_information`
(`id_abon`,`first_name`,`last_name`,`connection_date`,`trust_payment`,`number_of_internet_devices`,`number_of_tv_devices`,`comment_when_сonnecting`)
VALUES (''1,'Test','Test','2020-01-01',1,0,0,null);
--COMMIT;
--ROLLBACK;

--Пример

-- Создаем процедуру по добавлению данных с проверкой на id_abon .
CREATE DEFINER=`den`@`%` PROCEDURE `insert_into_table`(
in id_abon varchar(50) ,
in first_name varchar(25),
in last_name varchar(25) ,
in connection_date date ,
in trust_payment int ,
in number_of_internet_devices int ,
in number_of_tv_devices int ,
in comment_when_сonnecting varchar(100)
)
BEGIN
    START TRANSACTION; -- Включаем транзакцию
    IF (SELECT `count_str`(id_abon)) < 36 THEN ROLLBACK; SELECT 'ROLLBACK'; -- Прверяем при помощи соданной функции кол-во символов. Если меньше 36,то ROLLBACK
    ELSE -- Если 36 и более то инсертим данные и коммитим
		INSERT INTO `data_set`.`subscriber_information`
			(`id_abon`,`first_name`,`last_name`,`connection_date`,`trust_payment`,`number_of_internet_devices`,`number_of_tv_devices`,`comment_when_сonnecting`)
	 		VALUES (id_abon,first_name,last_name,connection_date,trust_payment,number_of_internet_devices,number_of_tv_devices,comment_when_сonnecting);
		COMMIT;
		SELECT 'COMMIT';
    END IF;
END

-- Проверяем на неправильный инсерт
CALL `data_set`.`insert_into_table` ('1','Test','Test','2020-01-01',1,0,0,null);
select * from `subscriber_information`

-- Проверяем на правильный инсерт
CALL `data_set`.`insert_into_table` ('111111111111111111111111111111111112','Test','Test','2020-01-01',1,0,0,null);
select * from `subscriber_information`
-- Удаляем не нужный id
DELETE FROM `data_set`.`subscriber_information` WHERE `id_abon` = '111111111111111111111111111111111112';


-- Триггеры
-- Время триггера
BEFORE --  триггер выполнятеся перед выполнением запроса (позволяет контролировать процесс изменения данных)
AFTER -- после выполнения запроса выполняется запрос триггера (после изменения данных происходит запрос триггера)

-- Флаг/действие триггера
CREATE,DELETE,UPDATE -- при каких запросах должен сработать
-- Тип поля
NEW.name_columns -- NEW говорит о новых данных

-- Пример триггера на проверку кол-ва символов при инсерте поля subscriber_information.id_abon
CREATE DEFINER = CURRENT_USER TRIGGER `data_set`.`subscriber_information_BEFORE_INSERT` BEFORE INSERT ON `subscriber_information` FOR EACH ROW
BEGIN
	IF (SELECT `count_str`(NEW.`id_abon`)) < 36 THEN
		SIGNAL sqlstate '45000'
			SET message_text = 'id_abon < 36 simbols';
	END IF;
END

--Проеверка на срабатываание триггера
INSERT INTO `data_set`.`subscriber_information`
(`id_abon`,
`first_name`,
`last_name`,
`connection_date`,
`trust_payment`,
`number_of_internet_devices`,
`number_of_tv_devices`,
`comment_when_сonnecting`)
VALUES
('1','Test','Test','2020-01-01',1,0,0,null);
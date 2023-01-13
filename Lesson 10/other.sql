-- https://postgrespro.ru/docs/postgrespro/10/apjs04.html

-- bookings.ticket_flights
--     Столбец     |     Тип       | Модификаторы |    Описание
-------------------+---------------+--------------+---------------------
-- ticket_no       | char(13)      | not null     | Номер билета
-- flight_id       | integer       | not null     | Идентификатор рейса
-- fare_conditions | varchar(10)   | not null     | Класс обслуживания
-- amount          | numeric(10,2) | not null     | Стоимость перелет

-- bookings.flights
--       Столбец       |     Тип     | Модификаторы |          Описание
-----------------------+-------------+--------------+-----------------------------
-- flight_id           | serial      | not null     | Идентификатор рейса
-- flight_no           | char(6)     | not null     | Номер рейса
-- scheduled_departure | timestamptz | not null     | Время вылета по расписанию
-- scheduled_arrival   | timestamptz | not null     | Время прилёта по расписанию
-- departure_airport   | char(3)     | not null     | Аэропорт отправления
-- arrival_airport     | char(3)     | not null     | Аэропорт прибытия
-- status              | varchar(20) | not null     | Статус рейса
-- aircraft_code       | char(3)     | not null     | Код самолета, IATA
-- actual_departure    | timestamptz |              | Фактическое время вылета
-- actual_arrival      | timestamptz |              | Фактическое время прилёта


-- предварительный анализ рейсов
select  * from ticket_flights tf;

-- групировка по рейсам
select tf.flight_id,tf.ticket_no  
from ticket_flights tf 
group by tf.flight_id,tf.ticket_no
order by tf.flight_id;

-- максимальное кол-во билетов у каждого рейса
select tf.flight_id,count(tf.ticket_no) co_
from ticket_flights tf 
group by tf.flight_id 
order by tf.flight_id;

-- Оконная функция
-- Использование функции ROW_NUMBER для нумерации билетов по партициоинированию рейса
SELECT
tf.flight_id,tf.ticket_no,tf.amount,
row_number() OVER (PARTITION BY tf.flight_id,tf.amount) as row_number_id
FROM
ticket_flights tf
ORDER BY tf.flight_id;


-- выводим предыдущую строку  при помощи функции   LAG
SELECT f.aircraft_code,f.flight_id ,f.scheduled_departure,f.scheduled_arrival,
lag (f.scheduled_departure) OVER (PARTITION BY f.aircraft_code ORDER BY  f.flight_id) as lag_scheduled_departure,
lag (f.scheduled_arrival) OVER (PARTITION BY f.aircraft_code ORDER BY  f.flight_id) as lag_scheduled_arrival
from flights f
limit 200;


-- выводим следующую строку при помощи функции LEAD

SELECT f.aircraft_code,f.flight_id ,f.scheduled_departure,f.scheduled_arrival,
lead (f.scheduled_departure,1) OVER (PARTITION BY f.aircraft_code ORDER BY  f.flight_id) as lag_scheduled_departure,
lead (f.scheduled_arrival,1) OVER (PARTITION BY f.aircraft_code ORDER BY f.flight_id) as lag_scheduled_arrival
from flights f;


-- выводим только нужжные строки , которые есть в другой таблице при помощи EXIST
select * from bookings.flights where CAST(scheduled_departure AS date) = '2017-01-01' and  CAST(scheduled_arrival AS date) = '2017-01-02';
select * from bookings.flights where CAST(scheduled_departure AS date) = '2017-01-01' and  CAST(scheduled_arrival AS date) = '2017-01-03';

SELECT tf.*
FROM ticket_flights tf
WHERE EXISTS
  (select * from bookings.flights where CAST(scheduled_departure AS date) = '2017-01-01' and  CAST(scheduled_arrival AS date) = '2017-01-02');

SELECT tf.*
FROM ticket_flights tf
 WHERE EXISTS
  (select * from bookings.flights where CAST(scheduled_departure AS date) = '2017-01-01' and  CAST(scheduled_arrival AS date) = '2017-01-03');



-- функция COALESCE проверяет ячейку на null. В противном случае возращает заглушку
 select * from flights where actual_departure is null;

SELECT f.*
,coalesce(actual_departure,now()) as  actual_departure_not_null
FROM flights f;

SELECT f.*
,actual_departure as  actual_departure_not_null
FROM flights f;



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


-- 1. Получите номера билетов с окончанием 50 (ticket_flights)

-- 2. Получите номер билетов где в середине есть число 50 (ticket_flights)

-- 3. Получите билеты которые стоят от 13000 до 15000 (ticket_flights)

-- 4. Получмте номера билетов, классов обслуживания и статус рейсов(ticket_flights,flights)

-- 5. Получмте номера билетов, классов обслуживания и статус рейсов только тех самолетов,
-- которые вылетали в первом полугодии 2017 г. (ticket_flights,flights)

-- 6. Получите  идентификатор всех рейсов ticket_flights,с джойном индетификаторрм рейсов из flights

-- 7. Получите  идентификатор всех рейсов flights,с джойном индетификаторрм рейсов из ticket_flights

-- 8. Получите  идентификатор рейсов которые есть только в ticket_flights и в flights

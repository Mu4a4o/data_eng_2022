
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

-- bookings.aircrafts_data
--    Столбец    |   Тип   | Модификаторы |             Описание
-----------------+---------+--------------+-----------------------------------
-- aircraft_code | char(3) | not null     | Код самолета, IATA
-- model         | jsonb   | not null     | Модель самолета
-- range         | integer | not null     | Максимальная дальность полета, км

-- bookings.airports_data
--   Столбец    |   Тип   | Модификаторы |                 Описание
----------------+---------+--------------+--------------------------------------------
-- airport_code | char(3) | not null     | Код аэропорта
-- airport_name | jsonb   | not null     | Название аэропорта
-- city         | jsonb   | not null     | Город
-- coordinates  | point   | not null     | Координаты аэропорта (долгота и широта)
-- timezone     | text    | not null     | Часовой пояс аэропорта

-- 1. Получите номера билетов,номера рейсов,моделм самолетов и города (ticket_flights,flights,aircrafts_data,airports_data)

-- 2. Сгруппируйте по городам и классам обслуживания (join arrival_airport) и выясните их кол-во по городам за все время  (airports_data,flights,ticket_flights)
--        Moscow Economy 200
--        Moscow Comfort 300
--        Moscow Business 50
--        ...
-- 3. Выполните 2 п.п. только вместо  Economy -> Эконом, Comfort - Комфорт, Business - Бизнес (Lesson 5-func.sql)

-- 4. Выведите только пустые строки фактического временм вылетов И фактического времи прилётов (flights)

-- 5. Выведите только не пустые строки фактического временм вылетов И фактического времи прилётов (flights)

-- 6. Выведите только пустые строки фактического временм вылетов И фактического времи прилётов И вместо пустых строк сделайте текущее время (flights) (Lesson 10-other.sql)
CREATE DATABASE lesson_5;
USE lesson_5;

create table cars (
	id INT NOT NULL PRIMARY KEY,
    Name VARCHAR(45),
    cost INT
);

LOAD DATA INFILE 'C:\Code2\SQL\lesson5\test_db.csv' INTO TABLE cars;
SELECT * 
FROM cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
CREATE VIEW `V_show_cars_up25k` AS 
SELECT name, cost
FROM cars
WHERE cost < 25000;

SELECT *
FROM `V_show_cars_up25k`;

-- 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
ALTER 
    ALGORITHM=MERGE
VIEW `V_show_cars_up25k` AS
SELECT name, cost
FROM cars
WHERE cost < 30000 ;

SELECT *
FROM `V_show_cars_up25k`;


-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE VIEW `V_show_cars_shkoda_audi` AS 
SELECT name, cost
FROM cars
WHERE name = "Skoda " OR name="Audi ";

SELECT *
FROM `V_show_cars_shkoda_audi`;


/*
Добавьте новый столбец под названием «время до следующей станции». Чтобы получить это значение, 
мы вычитаем время станций для пар смежных станций. Мы можем вычислить это значение без использования
оконной функции SQL, но это может быть очень сложно. Проще это сделать с помощью оконной функции LEAD . 
Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат. 
В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.
*/

CREATE TABLE stations
(
train_id INT NOT NULL,
station varchar(20) NOT NULL,
station_time TIME NOT NULL
);

INSERT stations(train_id, station, station_time)
VALUES (110, "SanFrancisco", "10:00:00"),
(110, "Redwood Sity", "10:54:00"),
(110, "Palo Alto", "11:02:00"),
(110, "San Jose", "12:35:00"),
(120, "SanFrancisco", "11:00:00"),
(120, "Palo Alto", "12:49:00"),
(120, "San Jose", "13:30:00");

SELECT *
FROM stations;

SELECT s.*, t2.*
FROM station s
JOIN (SELECT course, teacher_id FROM lessons  WHERE course = "Знакомство с веб-технологиями") t2 
ON t1.id = t2.teacher_id;

SELECT train_id, station, station_time,
	TIMEDIFF(LEAD(station_time) OVER(ORDER BY train_id),station_time) AS time_to_next_st2
FROM stations;




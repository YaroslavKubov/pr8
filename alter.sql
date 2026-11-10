
-- Практична робота №8
-- Демонстрація ALTER, TRUNCATE та DROP

-- 1. Додавання нового стовпця
ALTER TABLE college.courses
ADD COLUMN description TEXT;

-- 2. Встановлення значення за замовчуванням
ALTER TABLE college.courses
ALTER COLUMN description
SET DEFAULT 'опис відсутній';

-- 3. Видалення стовпця
ALTER TABLE college.courses
DROP COLUMN description;

-- 4. Створення тестової таблиці
CREATE TABLE college.ddl_truncate_demo (
    id INTEGER PRIMARY KEY,
    test_name VARCHAR(50) NOT NULL
);

-- 5. Додавання тестових записів
INSERT INTO college.ddl_truncate_demo (id, test_name)
VALUES
(1, 'Тестовий запис 1'),
(2, 'Тестовий запис 2'),
(3, 'Тестовий запис 3');

-- 6. Перевірка записів до TRUNCATE
SELECT * FROM college.ddl_truncate_demo;

-- 7. Видалення всіх записів зі збереженням структури
TRUNCATE TABLE college.ddl_truncate_demo;

-- 8. Перевірка після TRUNCATE
SELECT * FROM college.ddl_truncate_demo;

-- 9. Повне видалення тестової таблиці
DROP TABLE college.ddl_truncate_demo;

-- 1. Создание таблицы клиентов (содержит данные компаний и контактов)
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100)
);

-- 2. Создание таблицы сотрудников (содержит ФИО, должность и личные данные)
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(100),
    birth_date DATE,
    notes TEXT
);

-- 3. Создание таблицы заказов (связывает клиентов, сотрудников и доставку)
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    employee_id INT REFERENCES employees(employee_id) ON DELETE SET NULL,
    order_date DATE DEFAULT CURRENT_DATE,
    ship_city VARCHAR(100)
);

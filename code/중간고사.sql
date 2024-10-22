-- 1. 테이블 생성하기 (4개)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(10, 2) NOT NULL
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id),
    product_id INT REFERENCES products(id),
    quantity INT NOT NULL,
    price NUMERIC(10, 2) NOT NULL
);

-- 2. 조인문 사용하기 (3개)
--사용자와 주문 정보 조회
SELECT u.username, o.order_date, o.total_amount
FROM users u
JOIN orders o ON u.id = o.user_id;

--주문과 주문 항목 정보를 조회하기
SELECT o.id AS order_id, oi.product_id, oi.quantity, oi.price
FROM orders o
JOIN order_items oi ON o.id = oi.order_id;

--사용자, 주문 및 제품 정보를 조회하기
SELECT u.username, o.order_date, p.name AS product_name, oi.quantity
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id;

-- 3. SELECT문을 사용하여 데이터 탐색하기(3개)
--모든 사용자 정보
SELECT * FROM users;

--nike라는 사람의 정보
SELECT o.id AS order_id, o.order_date, o.total_amount
FROM orders o
JOIN users u ON o.user_id = u.id
WHERE u.username = 'nike';

--가격 정보
SELECT name, price
FROM products;
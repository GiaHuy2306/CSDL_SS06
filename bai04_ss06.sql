CREATE DATABASE bai04_ss06;
USE bai04_ss06;

CREATE TABLE products (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(255),
    price        DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id     INT PRIMARY KEY,
    order_date   DATE,
    status       ENUM('pending', 'completed', 'cancelled')
);

CREATE TABLE order_items (
    order_id   INT,
    product_id INT,
    quantity   INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products VALUES
(1, 'Laptop Dell', 15000000),
(2, 'Chuột Logitech', 500000),
(3, 'Bàn phím cơ', 1200000),
(4, 'Màn hình LG', 4000000),
(5, 'Tai nghe Sony', 2500000);

INSERT INTO orders VALUES
(101, '2025-01-05', 'completed'),
(102, '2025-01-06', 'completed'),
(103, '2025-01-07', 'pending'),
(104, '2025-01-08', 'completed'),
(105, '2025-01-09', 'cancelled'),
(106, '2025-01-10', 'completed'),
(107, '2025-01-11', 'completed');

INSERT INTO order_items VALUES
(101, 1, 1),
(101, 2, 2),

(102, 3, 1),
(102, 4, 1),

(104, 1, 1),
(104, 5, 2),

(106, 4, 2),
(107, 1, 1);


SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM order_items;

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_sold
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_id, p.product_name;

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_id, p.product_name;

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity * p.price) > 5000000;



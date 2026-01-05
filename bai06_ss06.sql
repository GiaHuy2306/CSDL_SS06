CREATE DATABASE bai06_ss06;
USE bai06_ss06;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name   VARCHAR(255),
    city        VARCHAR(255)
);

CREATE TABLE products (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(255),
    price        DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id     INT PRIMARY KEY,
    customer_id  INT,
    order_date   DATE,
    status       ENUM('pending', 'completed', 'cancelled'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_id   INT,
    product_id INT,
    quantity   INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Nguyen Van An', 'Ha Noi'),
(2, 'Tran Thi Binh', 'Da Nang'),
(3, 'Le Van Cuong', 'Ho Chi Minh');

INSERT INTO products VALUES
(1, 'Laptop Dell', 15000000),
(2, 'iPhone 14', 20000000),
(3, 'Tai nghe Sony', 3000000),
(4, 'Ban phim co', 2500000),
(5, 'Chuot Logitech', 1500000),
(6, 'Man hinh LG', 5000000);

INSERT INTO orders VALUES
(101, 1, '2025-01-01', 'completed'),
(102, 1, '2025-01-05', 'completed'),
(103, 2, '2025-01-06', 'completed'),
(104, 2, '2025-01-07', 'completed'),
(105, 3, '2025-01-08', 'completed'),
(106, 3, '2025-01-09', 'pending');

INSERT INTO order_items VALUES
-- Laptop Dell (12 sp)
(101, 1, 3),
(102, 1, 4),
(103, 1, 5),

-- iPhone 14 (11 sp)
(101, 2, 2),
(102, 2, 3),
(103, 2, 6),

-- Tai nghe Sony (15 sp)
(101, 3, 5),
(104, 3, 6),
(105, 3, 4),

-- Bàn phím cơ (8 sp - không đủ điều kiện)
(102, 4, 3),
(104, 4, 5),

-- Chuột Logitech (10 sp)
(103, 5, 4),
(104, 5, 3),
(105, 5, 3),

-- Màn hình LG (6 sp - không đủ)
(105, 6, 6);

SELECT
    p.product_name                      AS product_name,
    SUM(oi.quantity)                    AS total_quantity_sold,
    SUM(oi.quantity * p.price)          AS total_revenue,
    AVG(p.price)                        AS avg_price
FROM products p
JOIN order_items oi 
    ON p.product_id = oi.product_id
JOIN orders o 
    ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) >= 10
ORDER BY total_revenue DESC
LIMIT 5;

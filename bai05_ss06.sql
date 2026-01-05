DROP DATABASE bai05_ss06;
CREATE DATABASE bai05_ss06;
USE bai05_ss06;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name   VARCHAR(255),
    city        VARCHAR(255)
);

CREATE TABLE orders (
    order_id     INT PRIMARY KEY,
    customer_id INT,
    order_date   DATE,
    total_amount DECIMAL(12,2),
    status       ENUM('pending', 'completed', 'cancelled'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(1, 'Nguyen Van An', 'Ha Noi'),
(2, 'Tran Thi Binh', 'Da Nang'),
(3, 'Le Van Cuong', 'Ho Chi Minh'),
(4, 'Pham Thi Dao', 'Ha Noi'),
(5, 'Hoang Van Em', 'Can Tho');

INSERT INTO orders VALUES
-- Khách 1 (VIP: 4 đơn, > 10 triệu)
(201, 1, '2025-01-01', 3000000, 'completed'),
(202, 1, '2025-01-05', 2500000, 'completed'),
(203, 1, '2025-01-10', 2800000, 'completed'),
(204, 1, '2025-01-15', 2200000, 'completed'),

-- Khách 2 (không đủ điều kiện: < 3 đơn)
(205, 2, '2025-01-03', 4000000, 'completed'),
(206, 2, '2025-01-08', 3500000, 'completed'),

-- Khách 3 (VIP: 3 đơn, > 10 triệu)
(207, 3, '2025-01-02', 4500000, 'completed'),
(208, 3, '2025-01-07', 3800000, 'completed'),
(209, 3, '2025-01-12', 4200000, 'completed'),

-- Khách 4 (có đơn nhưng bị hủy)
(210, 4, '2025-01-06', 5000000, 'cancelled'),
(211, 4, '2025-01-09', 3000000, 'completed'),

-- Khách 5 (đơn đang xử lý)
(212, 5, '2025-01-11', 6000000, 'pending');

SELECT
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    AVG(o.total_amount) AS avg_order_value
FROM customers c
LEFT JOIN orders o 
    ON c.customer_id = o.customer_id
    AND o.status = 'completed'
GROUP BY c.customer_id, c.full_name
ORDER BY c.customer_id;

SELECT
    c.customer_id,
    c.full_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    AVG(o.total_amount) AS avg_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.full_name
HAVING 
    COUNT(o.order_id) >= 3
    AND SUM(o.total_amount) > 10000000
ORDER BY total_spent DESC;




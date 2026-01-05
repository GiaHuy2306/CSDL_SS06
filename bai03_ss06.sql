CREATE DATABASE bai03_ss06;
USE bai03_ss06;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name   VARCHAR(255),
    city        VARCHAR(255)
);

CREATE TABLE orders (
    order_id    INT PRIMARY KEY,
    customer_id INT,
    order_date  DATE,
    total_amount DECIMAL(12,2),
    status      ENUM('pending', 'completed', 'cancelled'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(1, 'Nguyen Van An', 'Ha Noi'),
(2, 'Tran Thi Binh', 'Da Nang'),
(3, 'Le Van Cuong', 'Ho Chi Minh'),
(4, 'Pham Thi Dao', 'Ha Noi'),
(5, 'Hoang Van Em', 'Can Tho');

INSERT INTO orders VALUES
(101, 1, '2025-01-05', 4500000, 'completed'),
(102, 1, '2025-01-06', 6000000, 'completed'),
(103, 2, '2025-01-07', 3000000, 'pending'),
(104, 3, '2025-01-08', 5500000, 'completed'),
(105, 3, '2025-01-09', 2000000, 'cancelled'),
(106, 4, '2025-01-05', 7000000, 'completed'),
(107, 5, '2025-01-08', 6000000, 'completed');

SELECT * FROM orders;

SELECT
    order_date,
    SUM(total_amount) AS total_revenue,
    COUNT(order_id) AS total_orders
FROM orders
WHERE status = 'completed'
GROUP BY order_date
HAVING SUM(total_amount) > 10000000;





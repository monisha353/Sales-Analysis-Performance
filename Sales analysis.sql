create database sales_analysis;
use sales_analysis;

create table customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Aarav Traders', 'Bengaluru', 'India'),
(2, 'Mehta Stores', 'Mumbai', 'India'),
(3, 'Global Mart', 'New York', 'USA'),
(4, 'TechZone', 'London', 'UK');

select * from customers;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mobile Phone', 'Electronics', 25000),
(103, 'Headphones', 'Accessories', 2000),
(104, 'Keyboard', 'Accessories', 1500);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
(1001, 1, '2024-01-10'),
(1002, 2, '2024-01-15'),
(1003, 3, '2024-02-05'),
(1004, 4, '2024-02-20');


CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    profit DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_details VALUES
(1, 1001, 101, 1, 8000),
(2, 1001, 103, 2, 500),
(3, 1002, 102, 1, 6000),
(4, 1003, 104, 3, 900),
(5, 1004, 101, 2, 15000);

select * from order_details;

SELECT 
SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id;

SELECT 
SUM(profit) AS total_profit
FROM order_details;

SELECT 
p.product_name,
SUM(od.quantity * p.price) AS revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

SELECT 
p.category,
SUM(od.quantity * p.price) AS category_sales
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.category;

SELECT 
c.customer_name,
SUM(od.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

SELECT 
MONTH(o.order_date) AS month,
SUM(od.quantity * p.price) AS monthly_sales
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY MONTH(o.order_date)
ORDER BY month;

SELECT 
c.country,
SUM(od.quantity * p.price) AS sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.country
ORDER BY sales DESC;





-- SALES PERFORMANCE ANALYSIS USING SQL

-- =========================
-- CUSTOMERS TABLE
-- =========================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

-- =========================
-- PRODUCTS TABLE
-- =========================
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- =========================
-- ORDERS TABLE
-- =========================
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- =========================
-- ORDER DETAILS TABLE
-- =========================
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    profit DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =========================
-- ANALYSIS QUERIES
-- =========================

-- 1. TOTAL PROFIT
SELECT SUM(profit) AS total_profit
FROM order_details;

-- 2. TOTAL SALES REVENUE
SELECT 
SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id;

-- 3. TOP SELLING PRODUCTS
SELECT 
p.product_name,
SUM(od.quantity * p.price) AS revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- 4. SALES BY CATEGORY
SELECT 
p.category,
SUM(od.quantity * p.price) AS category_sales
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.category;

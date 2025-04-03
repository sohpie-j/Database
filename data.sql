-- Disable foreign key checks to prevent errors during inserts
SET FOREIGN_KEY_CHECKS = 0;

-- ✅ Insert into dim_category
INSERT INTO dim_category (category_name) VALUES
('Electronics'),
('Mobile Phones'),
('Appliances');

-- ✅ Insert into dim_product (Uses `category_id` from `dim_category`)
INSERT INTO dim_product (product_name, category_id, brand, price) VALUES
('Laptop X1', 1, 'Brand A', 1200.00),
('Smartphone Y2', 2, 'Brand B', 800.00),
('Microwave Z3', 3, 'Brand C', 300.00);

-- ✅ Insert into dim_time
INSERT INTO dim_time (date, day, month, quarter, year) VALUES
('2024-01-01', 1, 1, 1, 2024),
('2024-02-15', 15, 2, 1, 2024),
('2024-03-10', 10, 3, 1, 2024);

-- ✅ Insert into dim_region
INSERT INTO dim_region (region_name, country) VALUES
('North', 'USA'),
('South', 'USA'),
('East', 'Canada');

-- ✅ Insert into dim_customer
INSERT INTO dim_customer (customer_name, email, city, state, country) VALUES
('John Doe', 'john@example.com', 'New York', 'NY', 'USA'),
('Jane Smith', 'jane@example.com', 'Toronto', 'ON', 'Canada'),
('Alice Brown', 'alice@example.com', 'Los Angeles', 'CA', 'USA');

-- ✅ Insert into dim_operator
INSERT INTO dim_operator (operator_name, store_location, contact_number, email) VALUES
('Alice Johnson', 'Store A', '123-456-7890', 'alice@store.com'),
('Bob Williams', 'Store B', '987-654-3210', 'bob@store.com'),
('Charlie Davis', 'Store C', '555-222-1111', 'charlie@store.com');

-- ✅ Insert into dim_order
INSERT INTO dim_order (order_id, total_order_amount, order_status, payment_method, shipping_address, delivery_date) VALUES
('ORD001', 1200.00, 'Completed', 'Credit Card', '123 Main St, NY, USA', '2024-02-05'),
('ORD002', 800.00, 'Shipped', 'PayPal', '456 Maple St, Toronto, Canada', '2024-02-06'),
('ORD003', 300.00, 'Pending', 'Cash', '789 Oak St, LA, USA', '2024-02-07');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;


INSERT INTO sales_fact 
(order_id, product_id, time_id, region_id, customer_id, operator_id, 
 sales_amount, quantity_sold, profit, discount_amount, tax_amount, cost_price, 
 sales_channel, payment_method, shipment_status, delivery_date)
VALUES 
('ORD001', 1, 1, 1, 1, 1, 1200.00, 1, 200.00, 50.00, 30.00, 1000.00, 
 'Online', 'Credit Card', 'Shipped', '2024-02-01'),

('ORD002', 2, 2, 2, 2, 2, 800.00, 1, 150.00, 30.00, 20.00, 650.00, 
 'Offline', 'PayPal', 'Delivered', '2024-02-06'),

('ORD003', 3, 3, 3, 3, 3, 300.00, 1, 50.00, 10.00, 20.00, 270.00, 
 'Online', 'Cash', 'Pending', '2024-02-07');

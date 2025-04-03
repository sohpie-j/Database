-- SET FOREIGN_KEY_CHECKS = 0;  -- Disable foreign key constraints
-- DROP TABLE IF EXISTS sales_fact;
-- DROP TABLE IF EXISTS dim_order;
-- DROP TABLE IF EXISTS dim_product;
-- DROP TABLE IF EXISTS dim_category;
-- DROP TABLE IF EXISTS dim_time;
-- DROP TABLE IF EXISTS dim_region;
-- DROP TABLE IF EXISTS dim_customer;
-- DROP TABLE IF EXISTS dim_operator;
-- SET FOREIGN_KEY_CHECKS = 1; 

-- Category Dimension Table 
CREATE TABLE dim_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,      
    category_name VARCHAR(100) UNIQUE NOT NULL             
);

-- Product Dimension Table 
CREATE TABLE dim_product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,     
    product_name VARCHAR(255) NOT NULL,         
    category_id INT NOT NULL,  -- ✅ Linked to `dim_category`
    brand VARCHAR(100) NOT NULL,                
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES dim_category(category_id)
);

-- Time Dimension Table
CREATE TABLE dim_time (
    time_id INT AUTO_INCREMENT PRIMARY KEY,        
    date DATE NOT NULL,                            
    day INT NOT NULL,                              
    month INT NOT NULL,                            
    quarter INT NOT NULL CHECK (quarter BETWEEN 1 AND 4), 
    year INT NOT NULL                             
);

-- Region Dimension Table
CREATE TABLE dim_region (
    region_id INT AUTO_INCREMENT PRIMARY KEY,     
    region_name VARCHAR(100) NOT NULL,           
    country VARCHAR(100) NOT NULL                
);

-- Customer Dimension Table
CREATE TABLE dim_customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,   
    customer_name VARCHAR(255) NOT NULL,          
    email VARCHAR(100) UNIQUE NOT NULL,           
    city VARCHAR(100) NOT NULL,                   
    state VARCHAR(100) NOT NULL,                  
    country VARCHAR(100) NOT NULL                 
);

-- Operator Dimension Table
CREATE TABLE dim_operator (
    operator_id INT AUTO_INCREMENT PRIMARY KEY,   
    operator_name VARCHAR(255) NOT NULL,         
    store_location VARCHAR(255),                  
    contact_number VARCHAR(20) UNIQUE,            
    email VARCHAR(100) UNIQUE                     
);

-- Order Dimension Table
CREATE TABLE dim_order (
    order_id VARCHAR(50) PRIMARY KEY,  
    total_order_amount DECIMAL(10,2) NOT NULL,  
    order_status ENUM('Pending', 'Completed', 'Shipped', 'Cancelled') NOT NULL DEFAULT 'Pending', 
    payment_method ENUM('Credit Card', 'Debit Card', 'Cash', 'Bank Transfer', 'PayPal') NOT NULL, 
    shipping_address VARCHAR(255),      
    delivery_date DATE  
);

-- Fact Table (NO category_id, Pure Star Schema)
CREATE TABLE sales_fact (
    sales_id INT AUTO_INCREMENT PRIMARY KEY,         

    order_id VARCHAR(50) NOT NULL,  
    product_id INT NOT NULL,  -- ✅ No `category_id` here
    time_id INT NOT NULL,
    region_id INT NOT NULL,
    customer_id INT NOT NULL,
    operator_id INT NOT NULL,

    -- Sales Metrics
    sales_amount DECIMAL(10,2) NOT NULL,  
    quantity_sold INT NOT NULL,   
    profit DECIMAL(10,2) NOT NULL,      

    -- Discounts & Taxes
    discount_amount DECIMAL(10,2) DEFAULT 0.00,
    tax_amount DECIMAL(10,2) DEFAULT 0.00,
    cost_price DECIMAL(10,2) NOT NULL,    

    -- Order & Payment Details
    sales_channel ENUM('Online', 'Offline') NOT NULL, 
    payment_method ENUM('Credit Card', 'Debit Card', 'Cash', 'Bank Transfer', 'PayPal') NOT NULL,
    shipment_status ENUM('Pending', 'Shipped', 'Delivered', 'Returned', 'Canceled') NOT NULL DEFAULT 'Pending',
    delivery_date DATE, 

    -- Foreign Keys
    FOREIGN KEY (order_id) REFERENCES dim_order(order_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),  
    FOREIGN KEY (time_id) REFERENCES dim_time(time_id),
    FOREIGN KEY (region_id) REFERENCES dim_region(region_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (operator_id) REFERENCES dim_operator(operator_id)
);

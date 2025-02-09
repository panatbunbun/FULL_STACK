-- Create the database
CREATE DATABASE MiniStore;

USE MiniStore;

-- Create table for Customers 
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE,
  address VARCHAR(255),
  phone_number VARCHAR(20)
);

-- Create table for Products 
CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  category VARCHAR(50),  
  image_url VARCHAR(255)
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,  -- Foreign key to Customers table
  order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  order_status ENUM('processing', 'completed', 'cancelled'),
  total_amount DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create table for Order Items 
CREATE TABLE OrderDetail (
  order_id INT NOT NULL,  -- Foreign key to Orders table
  product_id INT NOT NULL,  -- Foreign key to Products table
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Create table for Customer Payments 
CREATE TABLE Payments (
  payment_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,  -- Foreign key to Orders table
  payment_method VARCHAR(50),  -- (COD, Bank Transfer, Credit Card, etc.)
  payment_date DATETIME,
  amount DECIMAL(10,2) NOT NULL,
  remark VARCHAR(255),  -- Stores a unique identifier for the payment (optional)
  payment_status ENUM('pending', 'completed', 'failed'),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- MiniStore.Users definition

CREATE TABLE `Users` (
  `UserName` varchar(100) NOT NULL,
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Password` varchar(100) NOT NULL,
  `Status` varchar(100) DEFAULT NULL,
  `Role` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Users_UNIQUE` (`UserName`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

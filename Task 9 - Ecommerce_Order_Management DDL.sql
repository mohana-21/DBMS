-- ============================================================
-- E-COMMERCE ORDER MANAGEMENT SYSTEM
-- Database Creation and Table Implementation Using DDL Commands
-- ============================================================

-- Step 1: Create the Database
CREATE DATABASE Ecommerce_Order_Management;

-- Step 2: Select the Database
USE Ecommerce_Order_Management;


-- ============================================================
-- 1. CUSTOMER TABLE
-- ============================================================

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address VARCHAR(255),
    Registration_Date DATE
);


-- ============================================================
-- 2. SELLER TABLE
-- ============================================================

CREATE TABLE Seller (
    Seller_ID INT PRIMARY KEY,
    Seller_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address VARCHAR(255)
);


-- ============================================================
-- 3. CATEGORY TABLE
-- ============================================================

CREATE TABLE Category (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(100) NOT NULL
);


-- ============================================================
-- 4. PRODUCT TABLE
-- ============================================================

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL,
    Category_ID INT,
    Seller_ID INT,
    Price DECIMAL(10,2) NOT NULL,
    Stock_Quantity INT NOT NULL,
    Product_Status VARCHAR(50),

    FOREIGN KEY (Category_ID)
        REFERENCES Category(Category_ID),

    FOREIGN KEY (Seller_ID)
        REFERENCES Seller(Seller_ID)
);


-- ============================================================
-- 5. ORDERS TABLE
-- ============================================================

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Order_Date DATE NOT NULL,
    Order_Status VARCHAR(50),
    Total_Amount DECIMAL(10,2),

    FOREIGN KEY (Customer_ID)
        REFERENCES Customer(Customer_ID)
);


-- ============================================================
-- 6. ORDER_DETAILS TABLE
-- ============================================================

CREATE TABLE Order_Details (
    Order_Detail_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Unit_Price DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2),

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),

    FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID)
);


-- ============================================================
-- 7. PAYMENT TABLE
-- ============================================================

CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Payment_Method VARCHAR(50),
    Amount DECIMAL(10,2),
    Payment_Date DATE,
    Payment_Status VARCHAR(50),

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
);


-- ============================================================
-- 8. SHIPPING TABLE
-- ============================================================

CREATE TABLE Shipping (
    Shipping_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Shipping_Address VARCHAR(255),
    Tracking_Number VARCHAR(100),
    Delivery_Status VARCHAR(50),

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID)
);


-- ============================================================
-- VERIFY THE TABLES
-- ============================================================

SHOW TABLES;

-- View individual table structures
DESC Customer;
DESC Seller;
DESC Category;
DESC Product;
DESC Orders;
DESC Order_Details;
DESC Payment;
DESC Shipping;

-- ============================================================
-- E-COMMERCE ORDER MANAGEMENT SYSTEM
-- IMPLEMENTATION OF SQL CONSTRAINTS
-- ============================================================
-- Constraints demonstrated:
-- 1. PRIMARY KEY
-- 2. FOREIGN KEY
-- 3. UNIQUE
-- 4. CHECK
-- 5. DEFAULT
-- ============================================================


-- Step 1: Create the Database
CREATE DATABASE IF NOT EXISTS Ecommerce_Order_Management_Constraints;

-- Step 2: Select the Database
USE Ecommerce_Order_Management_Constraints;


-- ============================================================
-- 1. CUSTOMER TABLE
-- PRIMARY KEY, UNIQUE, CHECK, DEFAULT
-- ============================================================

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15) UNIQUE,
    Address VARCHAR(255),
    Registration_Date DATE DEFAULT (CURRENT_DATE),

    CHECK (CHAR_LENGTH(Customer_Name) >= 2)
);


-- ============================================================
-- 2. SELLER TABLE
-- PRIMARY KEY, UNIQUE, CHECK
-- ============================================================

CREATE TABLE Seller (
    Seller_ID INT PRIMARY KEY,
    Seller_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15) UNIQUE,
    Address VARCHAR(255),

    CHECK (CHAR_LENGTH(Seller_Name) >= 2)
);


-- ============================================================
-- 3. CATEGORY TABLE
-- PRIMARY KEY, UNIQUE
-- ============================================================

CREATE TABLE Category (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(100) NOT NULL UNIQUE
);


-- ============================================================
-- 4. PRODUCT TABLE
-- PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT
-- ============================================================

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL,
    Category_ID INT NOT NULL,
    Seller_ID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock_Quantity INT NOT NULL DEFAULT 0,
    Product_Status VARCHAR(20) DEFAULT 'Available',

    FOREIGN KEY (Category_ID)
        REFERENCES Category(Category_ID),

    FOREIGN KEY (Seller_ID)
        REFERENCES Seller(Seller_ID),

    CHECK (Price > 0),
    CHECK (Stock_Quantity >= 0),
    CHECK (Product_Status IN ('Available', 'Unavailable', 'Out of Stock'))
);


-- ============================================================
-- 5. ORDERS TABLE
-- PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT
-- ============================================================

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Order_Date DATE DEFAULT (CURRENT_DATE),
    Order_Status VARCHAR(20) DEFAULT 'Pending',
    Total_Amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,

    FOREIGN KEY (Customer_ID)
        REFERENCES Customer(Customer_ID),

    CHECK (Total_Amount >= 0),
    CHECK (Order_Status IN ('Pending', 'Confirmed', 'Shipped',
                           'Delivered', 'Cancelled'))
);


-- ============================================================
-- 6. ORDER_DETAILS TABLE
-- PRIMARY KEY, FOREIGN KEY, CHECK
-- ============================================================

CREATE TABLE Order_Details (
    Order_Detail_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Unit_Price DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),

    FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID),

    CHECK (Quantity > 0),
    CHECK (Unit_Price > 0),
    CHECK (Subtotal >= 0)
);


-- ============================================================
-- 7. PAYMENT TABLE
-- PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, DEFAULT
-- ============================================================

CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL UNIQUE,
    Payment_Method VARCHAR(30) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Payment_Date DATE DEFAULT (CURRENT_DATE),
    Payment_Status VARCHAR(20) DEFAULT 'Pending',

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),

    CHECK (Amount > 0),
    CHECK (Payment_Method IN ('Cash', 'Credit Card',
                              'Debit Card', 'UPI', 'Net Banking')),

    CHECK (Payment_Status IN ('Pending', 'Successful',
                              'Failed', 'Refunded'))
);


-- ============================================================
-- 8. SHIPPING TABLE
-- PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, DEFAULT
-- ============================================================

CREATE TABLE Shipping (
    Shipping_ID INT PRIMARY KEY,
    Order_ID INT NOT NULL UNIQUE,
    Shipping_Address VARCHAR(255) NOT NULL,
    Tracking_Number VARCHAR(100) UNIQUE,
    Delivery_Status VARCHAR(20) DEFAULT 'Processing',

    FOREIGN KEY (Order_ID)
        REFERENCES Orders(Order_ID),

    CHECK (Delivery_Status IN ('Processing', 'Shipped',
                              'In Transit', 'Delivered', 'Returned'))
);


-- ============================================================
-- VERIFY THE TABLES
-- ============================================================

SHOW TABLES;

DESC Customer;
DESC Seller;
DESC Category;
DESC Product;
DESC Orders;
DESC Order_Details;
DESC Payment;
DESC Shipping;


-- ============================================================
-- CONSTRAINT SUMMARY
-- ============================================================
--
-- PRIMARY KEY:
-- Customer_ID, Seller_ID, Category_ID, Product_ID,
-- Order_ID, Order_Detail_ID, Payment_ID, Shipping_ID
--
-- FOREIGN KEY:
-- Product.Category_ID -> Category.Category_ID
-- Product.Seller_ID -> Seller.Seller_ID
-- Orders.Customer_ID -> Customer.Customer_ID
-- Order_Details.Order_ID -> Orders.Order_ID
-- Order_Details.Product_ID -> Product.Product_ID
-- Payment.Order_ID -> Orders.Order_ID
-- Shipping.Order_ID -> Orders.Order_ID
--
-- UNIQUE:
-- Customer.Email, Customer.Phone
-- Seller.Email, Seller.Phone
-- Category.Category_Name
-- Payment.Order_ID
-- Shipping.Order_ID, Shipping.Tracking_Number
--
-- CHECK:
-- Product Price > 0
-- Product Stock_Quantity >= 0
-- Valid status values
-- Order amount >= 0
-- Quantity and Unit_Price > 0
-- Payment Amount > 0
--
-- DEFAULT:
-- Registration_Date = CURRENT_DATE
-- Stock_Quantity = 0
-- Product_Status = 'Available'
-- Order_Date = CURRENT_DATE
-- Order_Status = 'Pending'
-- Total_Amount = 0.00
-- Payment_Date = CURRENT_DATE
-- Payment_Status = 'Pending'
-- Delivery_Status = 'Processing'
-- ============================================================

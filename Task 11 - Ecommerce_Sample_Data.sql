-- ============================================================
-- E-COMMERCE ORDER MANAGEMENT SYSTEM
-- SAMPLE DATA INSERTION (DML COMMANDS)
-- ============================================================

USE Ecommerce_Order_Management_Constraints;

-- ============================================================
-- 1. INSERT SAMPLE CUSTOMERS
-- ============================================================

INSERT INTO Customer
(Customer_ID, Customer_Name, Email, Phone, Address, Registration_Date)
VALUES
(101, 'Arun Kumar', 'arun.kumar@email.com', '9876543210', 'Chennai', '2026-01-10'),
(102, 'Priya Sharma', 'priya.sharma@email.com', '9876543211', 'Madurai', '2026-01-15'),
(103, 'Rahul Raj', 'rahul.raj@email.com', '9876543212', 'Coimbatore', '2026-02-01'),
(104, 'Divya S', 'divya.s@email.com', '9876543213', 'Trichy', '2026-02-10'),
(105, 'Karthik M', 'karthik.m@email.com', '9876543214', 'Salem', '2026-03-05');


-- ============================================================
-- 2. INSERT SAMPLE SELLERS
-- ============================================================

INSERT INTO Seller
(Seller_ID, Seller_Name, Email, Phone, Address)
VALUES
(201, 'Tech World', 'techworld@email.com', '9123456780', 'Chennai'),
(202, 'Fashion Hub', 'fashionhub@email.com', '9123456781', 'Madurai'),
(203, 'Book Store', 'bookstore@email.com', '9123456782', 'Coimbatore');


-- ============================================================
-- 3. INSERT SAMPLE CATEGORIES
-- ============================================================

INSERT INTO Category
(Category_ID, Category_Name)
VALUES
(301, 'Electronics'),
(302, 'Clothing'),
(303, 'Books'),
(304, 'Home Appliances');


-- ============================================================
-- 4. INSERT SAMPLE PRODUCTS
-- ============================================================

INSERT INTO Product
(Product_ID, Product_Name, Category_ID, Seller_ID,
 Price, Stock_Quantity, Product_Status)
VALUES
(401, 'Wireless Mouse', 301, 201, 799.00, 50, 'Available'),
(402, 'Bluetooth Headphones', 301, 201, 2499.00, 30, 'Available'),
(403, 'Cotton T-Shirt', 302, 202, 599.00, 100, 'Available'),
(404, 'Denim Jeans', 302, 202, 1499.00, 40, 'Available'),
(405, 'Database Management Book', 303, 203, 850.00, 25, 'Available'),
(406, 'Java Programming Book', 303, 203, 950.00, 20, 'Available');


-- ============================================================
-- 5. INSERT SAMPLE ORDERS
-- ============================================================

INSERT INTO Orders
(Order_ID, Customer_ID, Order_Date, Order_Status, Total_Amount)
VALUES
(501, 101, '2026-04-01', 'Delivered', 799.00),
(502, 102, '2026-04-03', 'Shipped', 2499.00),
(503, 103, '2026-04-05', 'Confirmed', 1198.00),
(504, 104, '2026-04-08', 'Pending', 850.00),
(505, 105, '2026-04-10', 'Delivered', 2449.00);


-- ============================================================
-- 6. INSERT SAMPLE ORDER DETAILS
-- ============================================================

INSERT INTO Order_Details
(Order_Detail_ID, Order_ID, Product_ID, Quantity, Unit_Price, Subtotal)
VALUES
(601, 501, 401, 1, 799.00, 799.00),
(602, 502, 402, 1, 2499.00, 2499.00),
(603, 503, 403, 2, 599.00, 1198.00),
(604, 504, 405, 1, 850.00, 850.00),
(605, 505, 404, 1, 1499.00, 1499.00),
(606, 505, 406, 1, 950.00, 950.00);


-- ============================================================
-- 7. INSERT SAMPLE PAYMENTS
-- ============================================================

INSERT INTO Payment
(Payment_ID, Order_ID, Payment_Method, Amount,
 Payment_Date, Payment_Status)
VALUES
(701, 501, 'UPI', 799.00, '2026-04-01', 'Successful'),
(702, 502, 'Credit Card', 2499.00, '2026-04-03', 'Successful'),
(703, 503, 'Debit Card', 1198.00, '2026-04-05', 'Successful'),
(704, 504, 'UPI', 850.00, '2026-04-08', 'Pending'),
(705, 505, 'Net Banking', 2449.00, '2026-04-10', 'Successful');


-- ============================================================
-- VERIFY INSERTED DATA
-- ============================================================

SELECT * FROM Customer;
SELECT * FROM Seller;
SELECT * FROM Category;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM Order_Details;
SELECT * FROM Payment;

-- E-COMMERCE ORDER MANAGEMENT SYSTEM
-- PL/SQL PROCEDURES AND FUNCTIONS
-- Oracle Database / PL/SQL

SET SERVEROUTPUT ON;

-- 1. FUNCTION: Calculate Order Total
CREATE OR REPLACE FUNCTION calculate_order_total (
    p_order_id IN NUMBER
)
RETURN NUMBER
IS
    v_total NUMBER(10,2);
BEGIN
    SELECT NVL(SUM(subtotal), 0)
    INTO v_total
    FROM Order_Details
    WHERE Order_ID = p_order_id;

    RETURN v_total;
END;
/

-- Test
SELECT calculate_order_total(501) AS Order_Total FROM dual;


-- 2. PROCEDURE: Update Inventory
CREATE OR REPLACE PROCEDURE update_inventory (
    p_product_id IN NUMBER,
    p_quantity   IN NUMBER
)
IS
    v_stock Product.Stock_Quantity%TYPE;
BEGIN
    IF p_quantity <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001,
            'Quantity must be greater than zero');
    END IF;

    SELECT Stock_Quantity
    INTO v_stock
    FROM Product
    WHERE Product_ID = p_product_id
    FOR UPDATE;

    IF v_stock < p_quantity THEN
        RAISE_APPLICATION_ERROR(-20002,
            'Insufficient stock for Product ID: ' || p_product_id);
    END IF;

    UPDATE Product
    SET Stock_Quantity = Stock_Quantity - p_quantity,
        Product_Status =
            CASE
                WHEN Stock_Quantity - p_quantity = 0
                THEN 'Out of Stock'
                ELSE 'Available'
            END CASE
    WHERE Product_ID = p_product_id;

    DBMS_OUTPUT.PUT_LINE(
        'Inventory updated for Product ID: ' || p_product_id);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003,
            'Product not found: ' || p_product_id);
END;
/


-- 3. PROCEDURE: Process Order
CREATE OR REPLACE PROCEDURE process_order (
    p_order_id IN NUMBER
)
IS
    v_customer_id Orders.Customer_ID%TYPE;
    v_total NUMBER(10,2);

    CURSOR order_items IS
        SELECT Product_ID, Quantity
        FROM Order_Details
        WHERE Order_ID = p_order_id;
BEGIN
    SELECT Customer_ID
    INTO v_customer_id
    FROM Orders
    WHERE Order_ID = p_order_id;

    FOR item IN order_items LOOP
        update_inventory(item.Product_ID, item.Quantity);
    END LOOP;

    v_total := calculate_order_total(p_order_id);

    UPDATE Orders
    SET Total_Amount = v_total,
        Order_Status = 'Confirmed'
    WHERE Order_ID = p_order_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Order ' || p_order_id || ' processed successfully.');
    DBMS_OUTPUT.PUT_LINE(
        'Customer ID: ' || v_customer_id);
    DBMS_OUTPUT.PUT_LINE(
        'Order Total: ' || v_total);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20004,
            'Order not found: ' || p_order_id);
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/


-- Test order processing
BEGIN
    process_order(501);
END;
/


-- 4. FUNCTION: Calculate Total Sales
CREATE OR REPLACE FUNCTION calculate_total_sales
RETURN NUMBER
IS
    v_total_sales NUMBER(12,2);
BEGIN
    SELECT NVL(SUM(Total_Amount), 0)
    INTO v_total_sales
    FROM Orders
    WHERE Order_Status <> 'Cancelled';

    RETURN v_total_sales;
END;
/


-- Test
SELECT calculate_total_sales() AS Total_Sales FROM dual;


-- 5. FUNCTION: Calculate Product Sales
CREATE OR REPLACE FUNCTION calculate_product_sales (
    p_product_id IN NUMBER
)
RETURN NUMBER
IS
    v_sales NUMBER(12,2);
BEGIN
    SELECT NVL(SUM(OD.Subtotal), 0)
    INTO v_sales
    FROM Order_Details OD
    JOIN Orders O
        ON OD.Order_ID = O.Order_ID
    WHERE OD.Product_ID = p_product_id
      AND O.Order_Status <> 'Cancelled';

    RETURN v_sales;
END;
/


-- Test
SELECT calculate_product_sales(401) AS Product_Sales FROM dual;


-- 6. Display Results
SELECT Order_ID, Customer_ID, Order_Date,
       Order_Status, Total_Amount
FROM Orders
ORDER BY Order_ID;

SELECT Product_ID, Product_Name,
       Stock_Quantity, Product_Status
FROM Product
ORDER BY Product_ID;

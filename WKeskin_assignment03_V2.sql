-- Q1b
DECLARE
    CURSOR product_cursor IS
        SELECT product_id, SUM(quantity * unit_price) AS total_amount
        FROM OT_ORDER_ITEMS
        GROUP BY product_id;

    v_product_id OT_ORDER_ITEMS.product_id%TYPE;
    v_total_amount NUMBER(10,2);
    v_category VARCHAR2(10);

BEGIN
    OPEN product_cursor;
    LOOP
        FETCH product_cursor INTO v_product_id, v_total_amount;
        EXIT WHEN product_cursor%NOTFOUND;
        -- category based on total amount
        IF v_total_amount BETWEEN 1000 AND 30000 THEN
            v_category := 'Low';
        ELSIF v_total_amount BETWEEN 30001 AND 50000 THEN
            v_category := 'Mid';
        ELSIF v_total_amount >= 50001 THEN
            v_category := 'High';
        ELSE
            v_category := 'N/A';
        END IF;
        -- Printing the result
        DBMS_OUTPUT.PUT_LINE('Product ID: ' || v_product_id || ', Total Amount: ' || v_total_amount || ', Category: ' || v_category);
    END LOOP;

    CLOSE product_cursor;
END;

-- Q2 Donor
DECLARE
    -- user input
    v_donor_type CHAR(1) := UPPER('&donor_type'); -- I, B, G
    v_pledge_amount NUMBER := &pledge_amount;
    v_matching_percent NUMBER;
BEGIN
    -- Individual Donor
    IF v_donor_type = 'I' THEN 
        IF v_pledge_amount BETWEEN 100 AND 249 THEN
            v_matching_percent := 50;
        ELSIF v_pledge_amount BETWEEN 250 AND 499 THEN
            v_matching_percent := 30;
        ELSIF v_pledge_amount >= 500 THEN
            v_matching_percent := 20;
        ELSE
            v_matching_percent := 0;
        END IF;
    -- Business Organization
    ELSIF v_donor_type = 'B' THEN
        IF v_pledge_amount BETWEEN 100 AND 499 THEN
            v_matching_percent := 20;
        ELSIF v_pledge_amount BETWEEN 500 AND 999 THEN
            v_matching_percent := 10;
        ELSIF v_pledge_amount >= 1000 THEN
            v_matching_percent := 5;
        ELSE
            v_matching_percent := 0;
        END IF;
    -- Grant Funds
    ELSIF v_donor_type = 'G' THEN
        IF v_pledge_amount >= 100 THEN
            v_matching_percent := 5;
        ELSE
            v_matching_percent := 0;
        END IF;
    ELSE
        v_matching_percent := 0;
    END IF;   
    -- Print the results
    DBMS_OUTPUT.PUT_LINE('Donor Type: ' || v_donor_type || 
                         ', Pledge Amount: ' || v_pledge_amount || 
                         ', Matching Percentage: ' || v_matching_percent || '%');
END;

-- Q3
CREATE OR REPLACE FUNCTION fn_finding_max_invoiceamount (
    p_employee_id IN NUMBER
) RETURN NUMBER IS
    v_max_invoice_amount NUMBER;
BEGIN
    SELECT MAX(inv_total)
    INTO v_max_invoice_amount
    FROM lginvoice
    WHERE employee_id = p_employee_id;
    RETURN v_max_invoice_amount;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE;
END fn_finding_max_invoiceamount;
-- TESTING
DECLARE
    v_result NUMBER;
BEGIN
    v_result := fn_finding_max_invoiceamount(84334);
    DBMS_OUTPUT.PUT_LINE('Max Invoice Amount for Employee 84334: ' || v_result);
END;
-- CHECKING
SELECT 
    i.INV_NUM, 
    i.INV_DATE, 
    i.CUST_CODE, 
    i.INV_TOTAL, 
    i.EMPLOYEE_ID, 
    MAX(i.INV_TOTAL) OVER (PARTITION BY i.EMPLOYEE_ID) AS MAX_INVOICE_AMOUNT
FROM LGINVOICE i
WHERE i.EMPLOYEE_ID = 84334
ORDER BY i.EMPLOYEE_ID, i.INV_TOTAL DESC;

-- Q4
CREATE OR REPLACE PROCEDURE sp_product_total (
    p_order_id   IN  NUMBER,
    p_product_id IN  NUMBER,
    p_total      OUT NUMBER,
    p_product_name OUT VARCHAR2
) AS
BEGIN
    -- Calculate total amount (quantity * unit_price)
    SELECT SUM(quantity * unit_price)
    INTO p_total
    FROM ot_order_items
    WHERE order_id = p_order_id
      AND product_id = p_product_id;
    -- Fetch the product name
    SELECT product_name
    INTO p_product_name
    FROM ot_products
    WHERE product_id = p_product_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_total := 0;
        p_product_name := NULL;
    WHEN OTHERS THEN
        RAISE;
END sp_product_total;
-- TESTING
DECLARE
    v_total NUMBER;
    v_product VARCHAR2(100);
BEGIN
    sp_product_total(60, 205, v_total, v_product);
    DBMS_OUTPUT.PUT_LINE('Total Amount: ' || v_total || ', Product Name: ' || v_product);
END;
-- CHECKING
SELECT 
o.order_id, o.product_id, o.quantity, o.unit_price, 
(o.quantity * o.unit_price) AS total_amount,
p.product_name
FROM OT_ORDER_ITEMS o
JOIN OT_PRODUCTS p ON o.product_id = p.product_id
WHERE o.order_id = 60 AND o.product_id = 205;





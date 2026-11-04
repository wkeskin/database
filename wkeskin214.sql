-- q01
DECLARE
    v_basket bb_basket.idBasket%TYPE;
    lv_qty_num bb_basket.quantity%TYPE;
    v_shipping_cost NUMBER(5,2);

BEGIN
    -- Prompt user for basket ID input
    v_basket := &v_basket;

    SELECT quantity INTO lv_qty_num
    FROM bb_basket
    WHERE idBasket = v_basket;

    -- shipping cost based on quantity
    IF lv_qty_num <= 3 THEN
        v_shipping_cost := 5.00;
    ELSIF lv_qty_num BETWEEN 4 AND 6 THEN
        v_shipping_cost := 7.50;
    ELSIF lv_qty_num BETWEEN 7 AND 10 THEN
        v_shipping_cost := 10.00;
    ELSE
        v_shipping_cost := 12.00;
    END IF;

    -- Display the shipping cost
    DBMS_OUTPUT.PUT_LINE('Basket ID: ' || v_basket || 
                         ' | Quantity: ' || lv_qty_num ||
                         ' | Shipping Cost: $' || v_shipping_cost);
                         
END;
/

-- Q02
CREATE OR REPLACE FUNCTION FN_TOTAL_SERVICE_MONTHS(P_EMP_ID IN NUMBER)
RETURN NUMBER
IS
    v_total_months NUMBER := 0;
    -- Cursor to fetch all job history records for the employee
    CURSOR c_job_history IS
        SELECT start_date, end_date
        FROM hr_job_history
        WHERE employee_id = P_EMP_ID;
BEGIN
    -- Check if the employee exists and get hire_date
    DECLARE
        v_hire_date DATE;
    BEGIN
        SELECT hire_date INTO v_hire_date
        FROM hr_employees
        WHERE employee_id = P_EMP_ID;
        -- Add current employment months
        v_total_months := v_total_months + MONTHS_BETWEEN(SYSDATE, v_hire_date);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN -1;  -- Employee not found
    END;
    -- Loop through all job history periods and accumulate months
    FOR rec IN c_job_history LOOP
        v_total_months := v_total_months + MONTHS_BETWEEN(rec.end_date, rec.start_date);
    END LOOP;
    RETURN ROUND(v_total_months);
END;
/
-- testing
BEGIN
  DBMS_OUTPUT.PUT_LINE('Employee 103 Total Months of Service: ' || FN_TOTAL_SERVICE_MONTHS(103));
  DBMS_OUTPUT.PUT_LINE('Employee 999 Total Months of Service: ' || FN_TOTAL_SERVICE_MONTHS(999));  -- invalid ID test
END;
/

--Q03
CREATE OR REPLACE FUNCTION FN_GET_CUSTOMER_RATING(P_SHOPPER_ID IN NUMBER)
RETURN VARCHAR2
IS
    lv_total_num NUMBER(6,2);
    v_rating     VARCHAR2(10);
BEGIN
    -- Get the total purchases for the shopper (only placed orders)
    SELECT NVL(SUM(total), 0) INTO lv_total_num
    FROM bb_basket WHERE idshopper = P_SHOPPER_ID
    AND orderplaced = 1;
    -- Determine the rating
    IF lv_total_num > 200 THEN
        v_rating := 'HIGH';
    ELSIF lv_total_num > 100 THEN
        v_rating := 'MID';
    ELSE
        v_rating := 'LOW';
    END IF;
    RETURN v_rating;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'LOW';  -- no orders at all
END;
/
--Testing
BEGIN
  DBMS_OUTPUT.PUT_LINE('Shopper 22 Rating: ' || FN_GET_CUSTOMER_RATING(22));
  DBMS_OUTPUT.PUT_LINE('Shopper 3 Rating: ' || FN_GET_CUSTOMER_RATING(3));
END;
/
--Verify
DECLARE
  v_rating     VARCHAR2(10);
  v_total      NUMBER(6,2);
  v_shopper_id NUMBER := 22;  -- You can test other shopper IDs too
BEGIN
  -- Get total amount directly
  SELECT NVL(SUM(total), 0)
  INTO v_total
  FROM bb_basket
  WHERE idshopper = v_shopper_id
    AND orderplaced = 1;

  -- Call the function to get the rating
  v_rating := FN_GET_CUSTOMER_RATING(v_shopper_id);

  -- Display the result
  DBMS_OUTPUT.PUT_LINE('Shopper ID: ' || v_shopper_id);
  DBMS_OUTPUT.PUT_LINE('Total Purchases: $' || TO_CHAR(v_total, '9990.00'));
  DBMS_OUTPUT.PUT_LINE('Customer Rating: ' || v_rating);
END;
/




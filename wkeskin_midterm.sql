-- Q 01 a)
DECLARE
  -- Defining a nested table type of NUMBER
  TYPE IntArray IS TABLE OF NUMBER;
  -- Declare array   named   number_array
  number_array IntArray := IntArray(5, 10, 15, 20, 25);  
  total_sum NUMBER := 0;
  avg_value NUMBER := 0;
BEGIN
  -- Loop the array, calculate the total sum
  FOR i IN 1 .. number_array.COUNT LOOP
    total_sum := total_sum + number_array(i);
  END LOOP;
  
  -- Calculate the average
  avg_value := total_sum / number_array.COUNT;
  
  -- Display the results
  DBMS_OUTPUT.PUT_LINE('Total Sum = ' || total_sum);
  DBMS_OUTPUT.PUT_LINE('Average = ' || avg_value);
END;
/

-- Q 01 b)
DECLARE
    v_country_record hr_countries%ROWTYPE;  
    v_countryid hr_countries.country_id%TYPE := 'US';
    
BEGIN
    SELECT * INTO v_country_record 
    FROM hr_countries 
    WHERE country_id = v_countryid;

    -- Display selected information
    DBMS_OUTPUT.PUT_LINE('Country Id: ' || v_country_record.country_id || 
                         ' Country Name: ' || v_country_record.country_name || 
                         ' Region: ' || v_country_record.region_id);
END;
/

-- Q 02
DECLARE
    v_job_record hr_jobs%ROWTYPE;
    v_job_id hr_jobs.job_id%TYPE := 'AD_VP';
    v_salary_gap NUMBER;
    
BEGIN
    -- job record from hr_jobs table
    SELECT * INTO v_job_record 
    FROM hr_jobs 
    WHERE job_id = v_job_id;
    
    -- salary calculation
    v_salary_gap := v_job_record.max_salary - v_job_record.min_salary;

    -- Display output based on the salary gap
    IF v_salary_gap > 8500 THEN
        DBMS_OUTPUT.PUT_LINE(v_job_record.job_id || ' ' || 
                             v_job_record.job_title || ' ' ||
                             v_salary_gap || ' Job salary gap is more than 8,500.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_job_record.job_id || ' ' || 
                             v_job_record.job_title || ' Job salary gap is less than 8,500.');
    END IF;
    
END;
/

SELECT * FROM HR_JOBS;

-- Q 03
DECLARE
    v_basket bb_basket.idBasket%TYPE;
    lv_qty_num bb_basket.quantity%TYPE;
    v_shipping_cost NUMBER;

BEGIN
    -- Prompt user for basket ID input
    v_basket := &v_basket;

    SELECT quantity INTO lv_qty_num
    FROM bb_basket
    WHERE idBasket = v_basket;

    -- shipping cost based on quantity
    IF lv_qty_num <= 6 THEN
        v_shipping_cost := 8;
    ELSIF lv_qty_num BETWEEN 7 AND 9 THEN
        v_shipping_cost := 10;
    ELSIF lv_qty_num BETWEEN 10 AND 12 THEN
        v_shipping_cost := 12;
    ELSE
        v_shipping_cost := 14;
    END IF;

    -- Display the shipping cost
    DBMS_OUTPUT.PUT_LINE('Basket ID: ' || v_basket || 
                         ' | Quantity: ' || lv_qty_num ||
                         ' | Shipping Cost: $' || v_shipping_cost);
                         
END;
/
-- UNDEFINE v_basket; -- resetting




-- Q1 Calculate the area of triangle
DECLARE
    h NUMBER; b NUMBER; s1 NUMBER; s2 NUMBER; s3 NUMBER;
    v_selection CHAR(2); A NUMBER; ST NUMBER;
BEGIN
    -- User input value
    h := &h; b := &b; s1 := &s1; s2 := &s2; s3 := &s3;
    v_selection := UPPER('&option');
    
    IF v_selection = 'A' THEN
        A := (h * b) / 2;
        DBMS_OUTPUT.PUT_LINE('User Input  h: ' || h || ', b: ' || b);
        DBMS_OUTPUT.PUT_LINE('Area of this triangle is ' || A);
    ELSIF v_selection = 'ST' THEN
        ST := s1 + s2 + s3;
        DBMS_OUTPUT.PUT_LINE('User Input  s1: ' || s1 || ', s2: ' || s2 || ', s3: ' || s3);
        DBMS_OUTPUT.PUT_LINE('Total of sides for this triangle is ' || ST);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid selection');
    END IF;
END;

-- Reset user input purposes
--UNDEFINE h UNDEFINE b UNDEFINE s1 UNDEFINE s2 UNDEFINE s3 UNDEFINE option

-- Q2 LOOP
-- a. 1 to 250 using a LOOP (Do-While equivalent)
DECLARE
    num NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(num);
        num := num + 1;
        EXIT WHEN num > 250;
    END LOOP;
END;

-- b. 250 to 1 using FOR loop
DECLARE
    num NUMBER;
BEGIN
    FOR num IN REVERSE 1..250 LOOP
        DBMS_OUTPUT.PUT_LINE(num);
    END LOOP;
END;

-- c. First 100 odd numbers using a LOOP
DECLARE
    num NUMBER := 1;
    cnt NUMBER := 0;
BEGIN
    LOOP
        IF MOD(num, 2) <> 0 THEN
            DBMS_OUTPUT.PUT_LINE(num);
            cnt := cnt + 1;
        END IF;
        num := num + 1;
        EXIT WHEN cnt = 100;
    END LOOP;
END;

-- d. First 100 even numbers using FOR loop
DECLARE
    num NUMBER := 2;
    cnt NUMBER := 0;
BEGIN
    FOR num IN 2..200 LOOP
        IF MOD(num, 2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(num);
            cnt := cnt + 1;
        END IF;
        EXIT WHEN cnt = 100;
    END LOOP;
END;

-- e. First 50 numbers divisible by 2 using a LOOP
DECLARE
    num NUMBER := 2;
    cnt NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(num);
        cnt := cnt + 1;
        num := num + 2;
        EXIT WHEN cnt >= 50;
    END LOOP;
END;

-- Alternative in one code block
DECLARE
    num NUMBER;
    cnt NUMBER;
BEGIN
    -- a. 1 to 250 using a LOOP (Do-While equivalent)
    num := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(num);
        num := num + 1;
        EXIT WHEN num > 250;
    END LOOP;

    -- b. 250 to 1 using FOR loop
    FOR num IN REVERSE 1..250 LOOP
        DBMS_OUTPUT.PUT_LINE(num);
    END LOOP;

    -- c. First 100 odd numbers using a LOOP
    num := 1;
    cnt := 0;
    LOOP
        IF MOD(num, 2) <> 0 THEN
            DBMS_OUTPUT.PUT_LINE(num);
            cnt := cnt + 1;
        END IF;
        num := num + 1;
        EXIT WHEN cnt = 100;
    END LOOP;

    -- d. First 100 even numbers using FOR loop
    cnt := 0;
    FOR num IN 2..200 LOOP
        IF MOD(num, 2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(num);
            cnt := cnt + 1;
        END IF;
        EXIT WHEN cnt = 100;
    END LOOP;

    -- e. First 50 numbers divisible by 2 using a LOOP
    num := 2;
    cnt := 0;
    LOOP
        DBMS_OUTPUT.PUT_LINE(num);
        cnt := cnt + 1;
        num := num + 2;
        EXIT WHEN cnt >= 50;
    END LOOP;
END;

-- Q4 Find min max of an array
DECLARE
    TYPE num_array IS VARRAY(5) OF NUMBER;
    numbers num_array := num_array(45, 89, 72, 63, 68);
    max_value NUMBER := numbers(1);
    min_value NUMBER := numbers(1);
    max_index NUMBER := 1;
BEGIN
    FOR i IN 2..numbers.COUNT LOOP
        IF numbers(i) > max_value THEN
            max_value := numbers(i);
            max_index := i;
        END IF;
        IF numbers(i) < min_value THEN
            min_value := numbers(i);
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Minimum Value: ' || min_value);
    DBMS_OUTPUT.PUT_LINE('Maximum Value: ' || max_value);
    DBMS_OUTPUT.PUT_LINE('Index of Maximum Value: ' || max_index);
END;

-- Q5 Unit converter
DECLARE
    input_value NUMBER; converted_value NUMBER;
    input_unit VARCHAR2(5); target_unit VARCHAR2(5);
        
BEGIN
    -- User inputs
    DBMS_OUTPUT.PUT_LINE('Enter the distance value to be converted:');
    input_value := &input_value;
    DBMS_OUTPUT.PUT_LINE(input_value);
    DBMS_OUTPUT.PUT_LINE('Enter the unit (mt, km, mi):');
    input_unit := LOWER('&input_unit'); 
    DBMS_OUTPUT.PUT_LINE(input_unit);
    DBMS_OUTPUT.PUT_LINE('Enter the unit you are converting to (mt, km, mi):');
    target_unit := LOWER('&target_unit');
    DBMS_OUTPUT.PUT_LINE(target_unit);
    -- Conversion Logic 
    IF input_unit = 'mt' AND target_unit = 'km' THEN
        converted_value := input_value / 1000; -- mt to km
        DBMS_OUTPUT.PUT_LINE(input_value || ' mt is ' || converted_value || ' km');
    ELSIF input_unit = 'km' AND target_unit = 'mt' THEN
        converted_value := input_value * 1000; -- km to mt
        DBMS_OUTPUT.PUT_LINE(input_value || ' km is ' || converted_value || ' mt');
    ELSIF input_unit = 'mi' AND target_unit = 'km' THEN
        converted_value := input_value * 1.60934; -- mi to km
        DBMS_OUTPUT.PUT_LINE(input_value || ' mi is ' || converted_value || ' km');
    ELSIF input_unit = 'km' AND target_unit = 'mi' THEN
        converted_value := input_value / 1.60934; -- km to mi
        DBMS_OUTPUT.PUT_LINE(input_value || ' km is ' || converted_value || ' mi');
    ELSIF input_unit = 'mt' AND target_unit = 'mi' THEN
        converted_value := input_value / 1609.34; -- mt to mi
        DBMS_OUTPUT.PUT_LINE(input_value || ' mt is ' || converted_value || ' mi');
    ELSIF input_unit = 'mi' AND target_unit = 'mt' THEN
        converted_value := input_value * 1609.34; -- mi to mt
        DBMS_OUTPUT.PUT_LINE(input_value || ' mi is ' || converted_value || ' mt');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid unit conversion! Please enter "mt", "km", or "mi".');
    END IF;
END;
-- for reset purposes
-- UNDEFINE input_value    UNDEFINE input_unit UNDEFINE target_unit

-- Q6 Unit converter ft to cm
DECLARE
    input_value NUMBER;
    from_unit VARCHAR2(5);
    converted_value NUMBER;
BEGIN
    -- Asking user inputs
    DBMS_OUTPUT.PUT_LINE('Enter the measurement value to be converted:');
    input_value := &input_value;
    DBMS_OUTPUT.PUT_LINE(input_value);
    DBMS_OUTPUT.PUT_LINE('Enter the unit you are converting from (ft, cm):');
    from_unit := LOWER('&from_unit');
    DBMS_OUTPUT.PUT_LINE(from_unit);
    -- Conversion Logic
    IF from_unit = 'ft' THEN
        converted_value := input_value * 30.48;
        DBMS_OUTPUT.PUT_LINE(input_value || ' ft is ' || converted_value || ' cm');
    ELSIF from_unit = 'cm' THEN
        converted_value := input_value / 30.48;
        DBMS_OUTPUT.PUT_LINE(input_value || ' cm is ' || converted_value || ' ft');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid unit! Please enter "ft" or "cm".');
    END IF;
END;

-- for reset purposes
--UNDEFINE input_value    UNDEFINE from_unit

-- Q7 Message table
CREATE TABLE messages
(RESULTS  NUMBER)

DECLARE
    i NUMBER;
BEGIN
    FOR i IN 1..10 LOOP
        IF i != 6 AND i != 8 THEN
            INSERT INTO messages (RESULTS) VALUES (i);
        END IF;
    END LOOP;   
    COMMIT;
    -- Inserted data
    DBMS_OUTPUT.PUT_LINE('Inserted values:');
    FOR rec IN (SELECT results FROM messages ORDER BY results) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.results);
    END LOOP;
END;

-- Check the table
SELECT * FROM messages ORDER BY results;

-- Q8 Grade
DECLARE
    mark NUMBER;
    grade VARCHAR2(2);
BEGIN
    -- Prompt user for input
    DBMS_OUTPUT.PUT_LINE('Enter the student mark:');
    mark := &mark;
    DBMS_OUTPUT.PUT_LINE(mark);
    -- Checking grade range
    IF mark > 100 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Marks cannot be more than 100.');
        RETURN;
    END IF;
    -- Grade scheme
    IF mark >= 75 THEN
        grade := 'A';
        DBMS_OUTPUT.PUT_LINE('Grade: ' || grade);
    END IF;
    IF mark >= 45 AND mark < 75 THEN
        grade := 'B';
        DBMS_OUTPUT.PUT_LINE('Grade: ' || grade);
    END IF;
    IF mark < 44 THEN
        grade := 'C';
        DBMS_OUTPUT.PUT_LINE('Grade: ' || grade);
    END IF;
    IF grade IS NULL THEN
        grade := 'F';
        DBMS_OUTPUT.PUT_LINE('Grade: ' || grade);
    END IF;
END;
--For reset purposes
UNDEFINE mark

-- Q9 Greatest number
DECLARE
    a NUMBER := &a; 
    b NUMBER := &b;
    c NUMBER := &c;
    greatest NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Program started.');
    DBMS_OUTPUT.PUT_LINE('User input: ' || a || ', ' || b || ', ' || c || '.');

    -- Check if all numbers are equal
    IF a = b AND b = c THEN
        DBMS_OUTPUT.PUT_LINE('All three numbers are equal: ' || a);
    ELSE
        IF a > b THEN
            IF a > c THEN
                greatest := a;
            ELSE
                greatest := c;
            END IF;
        ELSE
            IF b > c THEN
                greatest := b;
            ELSE
                greatest := c;
            END IF;
        END IF;
        DBMS_OUTPUT.PUT_LINE('The greatest number is: ' || greatest);
    END IF;
END;
-- for reset purposes
-- UNDEFINE a UNDEFINE b UNDEFINE c

-- Q10 Shape based on side using If then else
DECLARE
   v_side   NUMBER(5) := &side; -- User input for number of sides
   v_shape  VARCHAR2(20);
BEGIN
   DBMS_OUTPUT.PUT_LINE('User input: '||v_side);
   -- side and shape name
   IF v_side = 3 THEN
      v_shape := 'Triangle';
   ELSIF v_side = 4 THEN
      v_shape := 'Rectangle';
   ELSIF v_side = 5 THEN
      v_shape := 'Pentagon';
   ELSIF v_side = 6 THEN
      v_shape := 'Hexagon';
   ELSIF v_side = 8 THEN
      v_shape := 'Octagon';
   ELSE
      v_shape := 'No such shape';
   END IF;
   DBMS_OUTPUT.PUT_LINE('Side: ' || v_side || '   Shape: ' || v_shape);
END;
-- For reseting purposes
--UNDEFINE v_side

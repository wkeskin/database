--q01
WITH OrderTotals AS (
    SELECT order#, SUM(quantity * paideach) AS total_spent
    FROM JL_ORDERITEMS
    GROUP BY order#
)
SELECT oi.order# AS OrderId, 
       b.title AS Book_Title, 
       ot.total_spent
FROM JL_ORDERITEMS oi
JOIN JL_BOOKS b ON oi.isbn = b.isbn
JOIN OrderTotals ot ON oi.order# = ot.order#
WHERE ot.total_spent >= 100
ORDER BY oi.order#, b.title;

--q02
SELECT customer#, COUNT(*) AS total_orders 
FROM JL_ORDERS
WHERE shipdate - orderdate >= 1 --1 or more than 1
GROUP BY customer#
HAVING COUNT(*) >= 2;  --only 2 or more orders

--q03
SELECT isbn, SUM(quantity) AS total_sold
FROM JL_ORDERITEMS
WHERE isbn = '3437212490'
GROUP BY isbn;

--q04
SELECT TITLE
FROM JL_BOOKS
WHERE CATEGORY IN (
    SELECT DISTINCT B.CATEGORY
    FROM JL_BOOKS B
    JOIN JL_ORDERITEMS OI ON B.ISBN = OI.ISBN
    JOIN JL_ORDERS O ON O.ORDER# = OI.ORDER#
    WHERE O.CUSTOMER# = 1005
)
AND ISBN NOT IN (
    SELECT DISTINCT OI.ISBN
    FROM JL_ORDERITEMS OI
    JOIN JL_ORDERS O ON O.ORDER# = OI.ORDER#
    WHERE O.CUSTOMER# = 1005
);

--q05
SELECT SHIPCITY, SHIPSTATE
FROM JL_ORDERS
WHERE (SHIPDATE - ORDERDATE) = (
    SELECT MAX(SHIPDATE - ORDERDATE)
    FROM JL_ORDERS
);

--q06
SELECT DISTINCT C.CUSTOMER#, C.LASTNAME, C.FIRSTNAME
FROM JL_CUSTOMERS C
JOIN JL_ORDERS O ON C.CUSTOMER# = O.CUSTOMER#
JOIN JL_ORDERITEMS OI ON O.ORDER# = OI.ORDER#
JOIN JL_BOOKS B ON OI.ISBN = B.ISBN
WHERE B.RETAIL = (
    SELECT MIN(RETAIL)
    FROM JL_BOOKS
);

--q07
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.LOCATION_ID, L.STREET_ADDRESS, L.CITY, C.COUNTRY_NAME
FROM HR_DEPARTMENTS D
JOIN HR_LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
JOIN HR_COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID;

--q08
SELECT E.LAST_NAME, E.SALARY, E.JOB_ID, E.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_ID
FROM HR_EMPLOYEES E
JOIN HR_DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN HR_LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
JOIN HR_COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
WHERE C.COUNTRY_ID = 'US'
AND E.SALARY BETWEEN 3400 AND 9500;

-- q09
DECLARE
    v_myname VARCHAR2(20) := 'KESKIN';  -- OUTER BLOCK, Global variable 
BEGIN
    DBMS_OUTPUT.PUT_LINE('Global variable accessed from outer block: ' || v_myname);
    DECLARE
       v_myname VARCHAR2(20) := 'WARDATUL';  -- INNER BLOCK, Local variable 
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Local variable accessed from inner block: ' || v_myname);
        DBMS_OUTPUT.PUT_LINE('Global variable accessed from inner block (overrided): ' || v_myname); -- due to the same variable name
    END;
END;
/

-- q10
DECLARE
    v_emp_name HR_EMPLOYEES.LAST_NAME%TYPE;  -- Variable to store employee last name
    v_emp_salary HR_EMPLOYEES.SALARY%TYPE;  -- Variable to store employee salary
BEGIN
    SELECT LAST_NAME, SALARY 
    INTO v_emp_name, v_emp_salary
    FROM HR_EMPLOYEES
    WHERE EMPLOYEE_ID = 150;

    -- Display Output
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_emp_name);
    DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || v_emp_salary);
END;
/



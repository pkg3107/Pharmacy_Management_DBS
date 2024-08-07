CREATE OR REPLACE PROCEDURE calculate_total_spent(
        p_customer_id IN customer.custid%TYPE,
        p_total_spent OUT NUMBER
    )
    IS
        v_total NUMBER := 0;
    BEGIN
        FOR order_rec IN (SELECT total FROM orders WHERE customerid = p_customer_id)
        LOOP
           v_total := v_total + order_rec.total;
       END LOOP;
 
       p_total_spent := v_total;
   EXCEPTION
       WHEN NO_DATA_FOUND THEN
           p_total_spent := 0;
   END;
   /


SET SERVEROUTPUT ON

ACCEPT customer_id PROMPT 'Enter the customer ID: ';

DECLARE
    v_total_spent NUMBER;
    v_customer_id customer.custid%TYPE;
BEGIN
    v_customer_id := '&customer_id';

    calculate_total_spent(v_customer_id, v_total_spent);

    DBMS_OUTPUT.PUT_LINE('Total amount spent by customer: ' || v_total_spent);
END;
/

SET SERVEROUTPUT ON

ACCEPT customer_id PROMPT 'Enter the customer ID: ';

DECLARE
    v_total_spent NUMBER;
BEGIN
    calculate_total_spent(&customer_id, v_total_spent);

    DBMS_OUTPUT.PUT_LINE('Total amount spent by customer: ' || v_total_spent);
END;
/


SET SERVEROUTPUT ON
DECLARE
    v_total_spent NUMBER;
BEGIN
    calculate_total_spent(p_customer_id => 112, p_total_spent => v_total_spent);
    DBMS_OUTPUT.PUT_LINE('Total amount spent by customer: ' || v_total_spent);
END;
/

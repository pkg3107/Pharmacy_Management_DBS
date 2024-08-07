--Delivered orders

CREATE TABLE order_delivered (
    order_id NUMBER(38), 
    delivery_date DATE
);


CREATE OR REPLACE PROCEDURE mark_order_delivered(
    p_order_id IN orders.orderid%TYPE
)
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM order_delivered
    WHERE order_id = p_order_id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Order ID already exists in order_delivered table');
    END IF;

    INSERT INTO order_delivered (order_id, delivery_date)
    VALUES (p_order_id, SYSDATE);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

set SERVEROUTPUT on


DECLARE
    v_order_id orders.orderid%TYPE := &order_id;
BEGIN
    mark_order_delivered(p_order_id => v_order_id);
    COMMIT;
END;
/


select * from order_delivered;
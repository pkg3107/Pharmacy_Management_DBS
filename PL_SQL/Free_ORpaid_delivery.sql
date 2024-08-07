-- Free or paid delivery based on order value

select orderId, total from orders;

CREATE TABLE delivery_cost AS
SELECT 
    orderID,
    CASE 
        WHEN total >= 1000 THEN 'Free Delivery'
        ELSE 'Paid Delivery'
    END AS deliveryType,
    CASE 
        WHEN total >= 1000 THEN total
        ELSE total + 50
    END AS total
FROM orders;

DECLARE
    v_total orders.total%TYPE;
BEGIN
    FOR order_rec IN (SELECT orderID, total FROM orders)
    LOOP
        IF order_rec.total < 1000 THEN
            v_total := order_rec.total + 50;
        ELSE
            v_total := order_rec.total;
        END IF;

        UPDATE orders
        SET total = v_total
        WHERE orderID = order_rec.orderID;
    END LOOP;
END;
/

SELECT * FROM delivery_cost;

SELECT orderID, total FROM orders;


#Write a query to find 
#total business done by each store

select
store_id,
sum(p.amount) as total_sales
from payment p
join rental r ON r.rental_id = p.rental_id
join inventory i ON i.inventory_id = r.inventory_id
group by(store_id);

#Query to stored procedure.

DELIMITER //
CREATE PROCEDURE TotalBusinessByStore()
BEGIN
    SELECT store_id, SUM(p.amount) AS total_sales
    FROM payment p
    JOIN rental r ON r.rental_id = p.rental_id
    JOIN inventory i ON i.inventory_id = r.inventory_id
    GROUP BY store_id;
END //
DELIMITER ;

#Previous query converted into a stored procedure that 
#takes the input for store_id and displays the total sales for that store.

DELIMITER //
CREATE PROCEDURE TotalBusinessForSpecificStore(IN given_store_id INT)
BEGIN
    SELECT store_id, SUM(p.amount) AS total_sales
    FROM payment p
    JOIN rental r ON r.rental_id = p.rental_id
    JOIN inventory i ON i.inventory_id = r.inventory_id
    WHERE store_id = given_store_id
    GROUP BY store_id;
END //
DELIMITER ;

#Previous query updated with a variable total_sales_value 
#of float type

DELIMITER //
CREATE PROCEDURE TotalBusinessForStoreWithVariable(IN given_store_id INT, OUT total_sales_value FLOAT)
BEGIN
    SELECT SUM(p.amount) INTO total_sales_value
    FROM payment p
    JOIN rental r ON r.rental_id = p.rental_id
    JOIN inventory i ON i.inventory_id = r.inventory_id
    WHERE store_id = given_store_id;
END //
DELIMITER ;


#Previous query with another variable flag. 
DELIMITER //
CREATE PROCEDURE TotalBusinessForStoreWithFlag(IN given_store_id INT, OUT total_sales_value FLOAT, OUT flag VARCHAR(10))
BEGIN
    SELECT SUM(p.amount) INTO total_sales_value
    FROM payment p
    JOIN rental r ON r.rental_id = p.rental_id
    JOIN inventory i ON i.inventory_id = r.inventory_id
    WHERE store_id = given_store_id;

    IF total_sales_value > 30000 THEN
        SET flag = 'green_flag';
    ELSE
        SET flag = 'red_flag';
    END IF;
END //
DELIMITER ;



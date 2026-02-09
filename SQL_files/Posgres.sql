SELECT * FROM customer;
SELECT * FROM country;
SELECT * FROM city;
SELECT * FROM address;
-- ALTER TABLE customer ADD COLUMN country TEXT;
-- ALTER TABLE customer DROP COLUMN country;
-- ALTER TABLE customer RENAME COLUMN cust_active TO active;
-- ALTER TABLE customers RENAME TO customer;

-- UPDATE customer
-- SET first_name='Hiren',
-- last_name='Parejiya', 
-- email='hiren.parejiya@tatvasoft.com'
-- WHERE customer_id = 524;  

-- DELETE FROM customer WHERE customer_id=524;

-- SELECT c.customer_id as id,
-- 	   c.first_name || ' ' || c.last_name AS Name,
-- 	   c.email,
-- 	   a.address,
-- 	   a.district,
-- 	   a.postal_code,
-- 	   a.phone,
-- 	   city.city,
-- 	   country.country
-- FROM customer AS c 
-- INNER JOIN address a USING (address_id)
-- INNER JOIN city using (city_id)
-- INNER JOIN country using (country_id);


-- CREATE VIEW customer_master AS
-- SELECT c.customer_id as id,
-- 	   c.first_name || ' ' || c.last_name AS Name,
-- 	   c.email,
-- 	   a.address,
-- 	   a.district,
-- 	   a.postal_code,
-- 	   a.phone,
-- 	   city.city,
-- 	   country.country,
-- 	   CASE 
-- 	   	WHEN c.activebool THEN 'Active'
-- 		ELSE ''
-- 		END AS note,
-- 	   c.store_id as sid
-- FROM customer AS c 
-- INNER JOIN address a USING (address_id)
-- INNER JOIN city using (city_id)
-- INNER JOIN country using (country_id);

-- SELECT * FROM customer_master;
-- ALTER VIEW customer_info RENAME TO customer_master;
-- DROP VIEW IF EXISTS customer_master;

-- create function get_film_count(len_from int, len_to int) 
-- returns int 
-- language plpgsql as 
-- $$
-- declare
--    film_count integer;
-- begin
--    select count(*)
--    into film_count
--    from film
--    where length between len_from and len_to;

--    return film_count;
-- end;
-- $$;

-- select get_film_count(40,90);

-- UNION
-- SELECT language_id FROM film 
-- UNION
-- SELECT language_id FROM language;

-- JOIN
 
-- DATE/TIME
-- SELECT current_date;
-- SELECT current_time;
-- SELECT AGE('2023-09-01','2023-05-01');

-- select rental_date ,EXTRACT(QUARTER FROM rental_date) from rental; 
-- YEAR,DAY,QUARTER,

-- MATHEMATICAL FUNCTION
-- SELECT amount, amount+1 ,
-- ROUND(amount,2) as Round ,
-- TRUNC(amount,0) 
-- from payment LIMIT 20;

-- SELECT ABS(-11.23)
-- SELECT ROUND(8.5674,2);

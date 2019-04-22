USE sakila;

-- 1a.
SELECT first_name, last_name FROM actor;

-- 1b.
SELECT CONCAT(actor.first_name, ' ', actor.last_name) AS `Actor Name` FROM actor;

-- 2a.
SELECT * FROM actor WHERE actor.first_name = "Joe";

-- 2b.
SELECT * FROM actor WHERE actor.last_name LIKE "%GEN%";

-- 2c.
SELECT * FROM actor WHERE actor.last_name LIKE "%LI%" 
ORDER BY last_name ASC, first_name ASC;

-- 2d.
SELECT country_id, country FROM country 
WHERE country.country IN ("Afghanistan", "Bangladesh", "China");

-- 3a.
ALTER TABLE actor ADD COLUMN description BLOB;

-- 3b.
ALTER TABLE actor DROP COLUMN description; 

-- 4a.
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;

-- 4b.
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name
HAVING COUNT(last_name) > 2;

-- 4c.
SELECT * FROM actor WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";
UPDATE actor SET first_name = "HARPO" WHERE actor_id = 172; 

-- 4d.
UPDATE actor SET first_name = "GROUCHO" WHERE actor_id = 172;

-- 5a.
SHOW CREATE TABLE address;

-- 6a.
SELECT first_name, last_name, address 
FROM staff
INNER JOIN address ON staff.address_id = address.address_id; 

-- 6b.
SELECT first_name, last_name, SUM(payment.amount) 
FROM staff
INNER JOIN payment on staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '2005-08%'
GROUP BY staff.staff_id;

-- 6c.
SELECT title, COUNT(film_actor.actor_id) 
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.title;

-- 6d.
SELECT title, COUNT(inventory.inventory_id) 
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
WHERE film.title="Hunchback Impossible";

-- 6e.
SELECT first_name, last_name, SUM(payment.amount)
FROM customer
INNER JOIN payment on customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY last_name ASC;

-- 7a.
SELECT title 
FROM film
WHERE (title LIKE "%K" OR title LIKE "%Q")
AND language_id = (SELECT language_id FROM language where name = 'English');

-- 7b.
SELECT first_name, last_name 
FROM actor 
WHERE actor.actor_id IN (SELECT film_actor.actor_id FROM film_actor WHERE film_actor.film_id IN 
(SELECT film.film_id FROM film WHERE title = "Alone Trip"));

-- 7c.
SELECT first_name, last_name, email
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
WHERE country.country = "Canada";

-- 7d.
SELECT title, category
FROM film_list
WHERE category = "Family";

-- 7e. 
SELECT title, COUNT(film.title) AS "Total Rented"
FROM film
INNER JOIN inventory ON inventory.film_id = film.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY COUNT(film.title) DESC;

-- 7f.
SELECT store.store_id, SUM(payment.amount) AS "Revenue"
FROM store
INNER JOIN inventory ON store.store_id = inventory.store_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY store_id;

-- 7g.
SELECT store.store_id, city.city, country.country
FROM store
INNER JOIN address ON store.address_id = address.address_id
INNER JOIN city on address.city_id = city.city_id
INNER JOIN country on city.country_id = country.country_id
GROUP BY store.store_id;

-- 7h.
SELECT category.name, SUM(payment.amount) AS "Revenue"
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN inventory on film_category.film_id = inventory.film_id
INNER JOIN rental on inventory.inventory_id = rental.inventory_id
INNER JOIN payment on rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

-- 8a.
CREATE VIEW Top_Grossing_Genres AS 
SELECT category.name, SUM(payment.amount) AS "Revenue"
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN inventory on film_category.film_id = inventory.film_id
INNER JOIN rental on inventory.inventory_id = rental.inventory_id
INNER JOIN payment on rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

-- 8b.
SELECT * FROM Top_Grossing_Genres;

-- 8c.
DROP VIEW Top_Grossing_Genres;
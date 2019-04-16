USE sakila;

# 1a.
SELECT first_name, last_name FROM actor;

# 1b.
SELECT CONCAT(actor.first_name, ' ', actor.last_name) AS `Actor Name` FROM actor;

# 2a.
SELECT * FROM actor WHERE actor.first_name = "Joe";

# 2b.
SELECT * FROM actor WHERE actor.last_name LIKE "%GEN%";

# 2c.
SELECT * FROM actor WHERE actor.last_name LIKE "%LI%" 
ORDER BY last_name ASC, first_name ASC;

# 2d.
SELECT country_id, country FROM country WHERE country.country 
IN ("Afghanistan", "Bangladesh", "China");

# 3a.
ALTER TABLE actor ADD COLUMN description BLOB;
# Checking if Column was added 
DESCRIBE actor;

# 3b.
ALTER TABLE actor DROP COLUMN description; 
# Checking if Column was deleted
DESCRIBE actor;

# 4a.
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;

# 4b.
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name
HAVING COUNT(last_name) > 1;

# 4c.
SELECT * FROM actor WHERE first_name="GROUCHO" AND last_name="WILLIAMS";
UPDATE actor SET first_name="HARPO" WHERE actor_id=172; 
# Check to see if record was changed
SELECT * FROM actor WHERE actor_id=172;

# 4d.
UPDATE actor SET first_name="GROUCHO" WHERE actor_id=172;
# Check to see if record was changed
SELECT * FROM actor WHERE actor_id=172;

# 5a.
SHOW CREATE TABLE address;

# 6a.
SELECT first_name, last_name, address 
FROM staff
INNER JOIN address ON staff.address_id = address.address_id; 

# 6b.
SELECT first_name, last_name, SUM(payment.amount) 
FROM staff
INNER JOIN payment on staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '2005-08%'
GROUP BY staff.staff_id;

# 6c.
SELECT title, COUNT(film_actor.actor_id) 
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.title;

# 6d.
SELECT title, COUNT(inventory.inventory_id) 
FROM film
INNER JOIN inventory ON film.film_id=inventory.film_id
WHERE film.title="Hunchback Impossible";

# 6e.
SELECT first_name, last_name, SUM(payment.amount)
FROM customer
INNER JOIN payment on customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY last_name ASC;

# 7a.
SELECT title 
FROM film
INNER JOIN language on film.language_id = language.language_id
WHERE language.name =  "English" 
AND film.title LIKE "%K" OR film.title LIKE "%Q";

# 7b.
SELECT first_name, last_name
FROM actor
INNER JOIN film
# 7c.
# 7d.
# 7e.
# 7f.
# 7g.
# 7h.
# 8a.
# 8b.
# 8c.




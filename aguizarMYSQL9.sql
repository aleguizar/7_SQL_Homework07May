#-- aleguizar MYSQL HOMEWORK
USE sakila;
SELECT first_name,
last_name
FROM actor;

#2 -- upper cases, new column
SELECT upper(concat (first_name,' ', last_name)) as actor_name 
FROM actor;

######################################################## 2

#3 -- find Joe#
SELECT first_name
actor_id,
FROM actor
WHERE first_name = 'Joe'
;

#3 -- find GEN
SELECT * 
FROM actor 
WHERE locate("GEN",last_name);

#4 -- find LEN and order
SELECT *
FROM actor
WHERE locate('LI',last_name)
ORDER BY last_name, first_name;

#5 -- select country and find 3 AFGH BANG CH
SELECT country_id,
country
from country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

######################################################## 3

#6 -- description column + blob
ALTER TABLE actor
ADD COLUMN description BLOB NOT NULL;

#7 -- delete description column use drop
 ALTER TABLE actor
DROP COLUMN description;

######################################################## 4

#8 -- select last name and count
SELECT last_name, count(last_name)
FROM actor
group by last_name;

#9 -- select last name and count duplicated last names
SELECT last_name, count(last_name) AS total_lastName
FROM actor 
GROUP BY last_name
HAVING total_lastName >= 2;

#10 -- change names
SELECT *
FROM actor
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

UPDATE actor 
SET first_name = "HARPO"

#11 -- delete names again
SELECT *
FROM actor
WHERE first_name = "HARPO";

UPDATE actor 
SET first_name = "GROUCHO"
WHERE first_name = "HARPO"; 

######################################################## 5


#12 -- show table
SHOW CREATE TABLE address;

######################################################## 6 

#13 -- join staff and adress
SELECT staff.first_name, 
	   staff.last_name, 
       address.address
FROM staff
JOIN address ON staff.address_id = address.address_id; 

#14 -- join staff and adress
SELECT staff.first_name, 
	   staff.last_name, 
       sum(payment.amount) AS total_amount
FROM staff
JOIN payment ON staff.staff_id = payment.staff_id
WHERE year(payment.payment_date) = "2005" 
      AND month(payment.payment_date) = "8"
GROUP BY staff.staff_id;

#15 -- film and actors
SELECT film.title, 
	   count(film_actor.actor_id) AS number_actors
FROM film
INNER JOIN  film_actor ON film.film_id = film_actor.film_id
GROUP BY film.title;

#16 -- hunchback copies
SELECT film.title, 
       count(inventory.film_id) AS copies_film
FROM film
INNER JOIN inventory ON  film.film_id = inventory.film_id
WHERE film.title = "HUNCHBACK IMPOSSIBLE"
GROUP BY film.title;

#17 -- names payments ordered
SELECT customer.last_name, 
       customer.first_name, 
       sum(payment.amount) AS total_paid
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY customer.last_name;

######################################################## 7 
#18 -- film lang KQ
 SELECT film.title
FROM film, language
WHERE left(film.title,1) IN ("K", "Q")
	  AND film.language_id = language.language_id
      AND language.name = "ENGLISH";

#19 -- Alone Trip 
SELECT actor.first_name, 
       actor.last_name
FROM actor, film_actor, film
WHERE actor.actor_id = film_actor.actor_id
      AND film_actor.film_id = film.film_id
      AND film.title = "ALONE TRIP";
      
#20 -- canada names address joins
SELECT customer.first_name,
	   customer.last_name,
       customer.email,
       city.city
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = "CANADA"
ORDER BY customer.last_name;

#21 -- family films
SELECT film.title
FROM  film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "FAMILY";

#22 -- fimls recent ordered
SELECT film.title, 
       count(rental.inventory_id) AS most_rented
FROM film
JOIN inventory ON film.film_id = inventory.inventory_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY most_rented DESC, film.title;

############################################################### 8 

#top 5 gross rev|
CREATE VIEW top5_grossRevenue AS 
SELECT category.name,
       count(rental.rental_id) AS total_rentals,
       sum(payment.amount) AS income_byCategory,
       (count(rental.rental_id) * sum(payment.amount)) AS gross_revenue 
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY gross_revenue DESC
LIMIT 5;

#-- select top 5
SELECT * 
FROM top5_grossrevenue;

#-- drop trop 5 
DROP VIEW top5_grossrevenue;


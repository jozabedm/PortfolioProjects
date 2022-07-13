SELECT 
	first_name,
    last_name,
    email,
    store_id
FROM staff;

SELECT
	store_id,
    COUNT(inventory_id) AS inventory_items
FROM inventory
GROUP BY store_id;

SELECT
	store_id,
    COUNT(customer_id) AS active_customers
FROM customer
WHERE active = 1
GROUP BY store_id;

SELECT
	COUNT(email) AS emails
FROM customer;

SELECT 
	store_id,
    COUNT(DISTINCT film_id) AS unique_films
FROM inventory
GROUP BY store_id;

SELECT
	COUNT(DISTINCT name) AS unique_categories
FROM film_category;

SELECT
	MAX(replacement_cost) AS most_expensive_replacement,
    MIN(replacement_cost) AS cheapest_replacement_cost,
    AVG(replacement_cost) AS avg_replacement_cost
FROM film;

SELECT
	AVG(amount) AS avg_amount
    MAX(amount) AS max_amount
FROM payment;

SELECT
	customer_id,
    COUNT(rental_id) AS number_of_rentals
FROM rental
GROUP BY 
	customer_id
ORDER BY 
	COUNT(rental_id) DESC;
-- 1. In the table actor, which are the actors whose last names are not repeated? 
-- For example if you would sort the data in the table actor by last_name, 
-- you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the same last name. 
-- So we do not want to include this last name in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.

SELECT 
    *
FROM
    actor;

SELECT 
    first_name, last_name, COUNT(*)
FROM
    actor
GROUP BY last_name
HAVING COUNT(last_name) <= 1;

-- 2. Which last names appear more than once? We would use the same logic as in the previous question 
-- but this time we want to include the last names of the actors where the last name was present more than once

SELECT 
    first_name, last_name, COUNT(*)
FROM
    actor
GROUP BY last_name
HAVING COUNT(last_name) > 1
ORDER BY COUNT(*) DESC;

-- 3. Using the rental table, find out how many rentals were processed by each employee.

SELECT 
    *
FROM
    rental;

SELECT 
    staff_id, COUNT(*)
FROM
    rental
GROUP BY staff_id;

-- 4. Using the film table, find out how many films were released each year.

SELECT 
    *
FROM
    film;

SELECT 
    release_year, COUNT(*)
FROM
    film
GROUP BY release_year;

-- 5. Using the film table, find out for each rating how many films were there.

SELECT 
    *
FROM
    film;

SELECT 
    rating, COUNT(*) AS number_of_films
FROM
    film
GROUP BY rating;

-- 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

SELECT 
    rating, ROUND(AVG(length), 2) AS average_length
FROM
    film
GROUP BY rating;

-- 7. Which kind of movies (rating) have a mean duration of more than two hours?

SELECT 
    rating, ROUND(AVG(length), 2) AS average_length
FROM
    film
GROUP BY rating
HAVING AVG(length) > 120;

-- 8. Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.

SELECT 
    *
FROM
    film;

SELECT title,length,
RANK () OVER (ORDER BY length DESC)
AS ranks 
FROM film
WHERE length !=0 AND length IS NOT NULL
ORDER BY length DESC;

-- We first came out with this solution and I think is correct, but I dont like how the function Rank express the results
-- jumping from 1 to 11 due to the number of the row where the length changes so we came with this other solution:

SELECT 
    title,
    length,
    CASE
        WHEN length BETWEEN 1 AND 60 THEN 'Short'
        WHEN length BETWEEN 61 AND 120 THEN 'Medium'
        ELSE 'Long'
    END AS length_rating
FROM
    film
WHERE
    length IS NOT NULL
ORDER BY length DESC;

-- We found out that assigning a name to the length included in ranges with the case when "function" is more readable. 

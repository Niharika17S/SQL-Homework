use sakila;
#select * from actor
#1a. Display the first and last names of all actors from the table actor.
select 
first_name,
last_name
from actor
order by first_name ASC;

#1b. Display the first and last name of each actor in a single column
select
concat(first_name, '', last_name) as Actor_Name
#concat(upper(first_name),upper(last_name)) as Actor Name
from actor;

#2a. ID number, first name, and last name of an actor, with only the first name, "Joe." 
select 
actor_id,
first_name,
last_name
from actor where first_name = 'JOE'

#2b. Find all actors whose last name contain the letters GEN.
select 
actor_id,
first_name,
last_name
from actor where last_name LIKE '%GEN%';
*/
#2c. actors whose last names contain the letters LI. order the rows by last name and first name, in that order:

/*
select 
actor_id,
first_name,
last_name
from actor where last_name LIKE '%LI%'
order by last_name ASC;
#
#2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
select 
country_id,country
from country
where country in ('Afghanistan','Bangladesh','China'); 

#3a  so create a column in the table actor named description and use the data type BLOB
ALTER TABLE actor
ADD COLUMN description1 BLOB AFTER last_update;
# 3b Delete the description column.

ALTER TABLE actor
Drop description1 

#4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name, count(last_name) from actor group by last_name

#4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(last_name) as count1 from actor
group by last_name
having count(last_name) > 2

#4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
update actor
set first_name ='HARPO' 
where first_name ='GROUCHO' and last_name ='WILLIAMS';

#4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all!
# In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
update actor
set first_name ='GROUCHO' 
where actor_id = 172;

#5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE address

#6a. Use JOIN to display the first and last names, as well as the address, of each staff member.|
# Use the tables staff and address:
select 
first_name,
last_name,
address from staff s
inner join address a on s.address_id = a.address_id

#6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.

select 
s.staff_id,
sum(p.amount) as Total_Amount
from payment p
inner join staff s on p.staff_id = s.staff_id
where p.payment_date between'2005-08-01' and '2005-09-01'
group by staff_id

#6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
select
f.title as Title,
act.film_id as Film_id,
count(act.actor_id) as Actor_count
from film_actor act
inner join film f on act.film_id = f.film_id
group by act.film_id 

#6d. How many copies of the film Hunchback Impossible exist in the inventory system?
select 
sum(inv.inventory_id) as Copies,
f.title
from inventory inv
inner join film f on inv.film_id = f.film_id
where title='Hunchback Impossible'

#6e. Using the tables payment and customer and the JOIN command, list the total paid
# by each customer. List the customers alphabetically by last name:
select
c.first_name as First_Name,
c.last_name as Last_Name,
sum(p.amount) as 'Total Amonut Paid'
from customer c
inner join payment p on c.customer_id = p.customer_id
group by c.customer_id
order by last_name ASC
#7a. films starting with the letters K and Q have also soared in popularity. Use subqueries
# to display the titles of movies starting with the letters K and Q whose language is English.
select
f.title
from film f
where f.title like 'K%' OR f.title like 'Q%'and language_id in (select language_id from language where name ='English')

#7b. Use subqueries to display all actors who appear in the film Alone Trip.
select a.actor_id,a.first_name,a.last_name
from actor a
where a.actor_id in
(select fa.actor_id
from film_actor fa 
where fa.film_id in
	(select f.film_id from film f
     where f.title = 'Alone Trip')
 )
#7c. You want to run an email marketing campaign in Canada, for which you will need the names
# and email addresses of all Canadian customers. Use joins to retrieve this information.

select 
first_name,
last_name,
email,
c.country
from customer cust
inner join address a on cust.address_id = a.address_id
inner join city ci on a.city_id = ci.city_id
inner join country c on c.country_id = ci.country_id 
where c.country = 'Canada';

#7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select title
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id  = c.category_id
where c.name = 'Family';

#7e. Display the most frequently rented movies in descending order.
select f.title , count(r.rental_id) as 'Count' from film f
inner join inventory inv on f.film_id = inv.film_id
inner join rental r on inv.inventory_id = r.inventory_id
group by f.title
order by count(r.rental_id) desc

#7f. Write a query to display how much business, in dollars, each store brought in.
select 
s.store_id,
sum(amount)
from payment p
inner join staff st on p.staff_id = st.staff_id
inner join store s on st.store_id = s.store_id
group by s.store_id
*************************************************************************************
use sakila;
select s.store_id, sum(amount) AS 'Amount'
from payment p
inner join rental r
on p.rental_id = r.rental_id
inner join inventory i
on i.inventory_id = r.inventory_id
inner join store s
on s.store_id = i.store_id
group by s.store_id; 

#7g. Write a query to display for each store its store ID, city, and country.
select s.store_id,
c.city,
ct.country
from store s
inner join address a on a.address_id = s.address_id
inner join city c on a.city_id = c.city_id
inner join country ct on c.country_id = ct.country_id

#7h. List the top five genres in gross revenue in descending order.
#(Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select
c.name as Genre,
sum(p.amount) as 'Gross Revenue'
from category c
inner join film_category fc on c.category_id = fc.category_id
inner join inventory inv on fc.film_id = inv.film_id
inner join rental r on inv.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by c.name
order by sum(p.amount) desc limit 5

#8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. 
#Use the solution from the problem above to create a view. 

CREATE VIEW view_grossrevenue AS
select
c.name as Genre,
sum(p.amount) as 'Gross Revenue'
from category c
inner join film_category fc on c.category_id = fc.category_id
inner join inventory inv on fc.film_id = inv.film_id
inner join rental r on inv.inventory_id = r.inventory_id
inner join payment p on r.rental_id = p.rental_id
group by c.name
order by sum(p.amount) desc limit 5;

#8b. How would you display the view that you created in 8a?
SELECT * FROM view_grossrevenue;

#8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
DROP VIEW view_grossrevenue;

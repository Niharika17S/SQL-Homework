use sakila;
/*#select * from actor
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

#2b. Find all actors whose last name contain the letters GEN
select 
actor_id,
first_name,
last_name
from actor where last_name LIKE '%GEN%';
*/
#2c. actors whose last names contain the letters LI. order the rows by last name and first name, in that order:

select 
actor_id,
first_name,
last_name
from actor where last_name LIKE '%LI%'
order by last_name ASC;




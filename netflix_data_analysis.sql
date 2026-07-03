

 select * from netflix_titles_raw;
 use netflix_project;
 create database netflix_project;
 
create table shows(
show_id varchar(10) primary key, 
title text,
type varchar(100), 
release_year int,                        -- table shows 
rating varchar(20),
duration varchar(50),
description text) ;

 create table directors(director_id int auto_increment  primary key,             -- table directors
 director_name varchar(255));
 
 create table Show_director(show_id varchar(10) ,
 director_id int  ,                                         -- table show_director
 primary key (show_id , director_id),
 foreign key (show_id)
     references shows(show_id),
     foreign key (director_id) 
     references Directors(director_id));
     
 create  table actors (actor_id int auto_increment primary key,
 actor_name varchar(100) not null);                                     -- table actors
 
 
 create table  show_actor (show_id varchar(10), actor_id int,
 primary key( show_id , actor_id), 
 foreign key (show_id)                          -- table show_actor
 references shows(show_id),
 foreign key (actor_id)
 references actors(actor_id));
 
 create table genres (genre_id int auto_increment primary key ,
 genres_name varchar(50));                                          -- table genre
 
 create table show_genre(show_id varchar(10),
 genre_id int,                                                    
 primary key(show_id , genre_id),
 foreign key (show_id)                                              -- table show_genre
 references shows(show_id),
 foreign key (genre_id)
 references genres(genre_id));
 
 create table country(country_id int auto_increment primary key ,
 country_name varchar(50));                                      -- table country
 
 create table show_country(show_id varchar(10),
 country_id int,
 primary key(show_id, country_id),                           -- table show_country
 foreign key (show_id)
 references shows(show_id),
 foreign key (country_id)
 references country(country_id));
 

use netflix_project;
show tables; 
select database();                             -- random checking
select count(*) from netflix_titles_raw;

insert into Directors(director_name) 
select distinct director 
from netflix_titles_raw ;                   -- filling directors table


select version();

select show_id , director  
from netflix_titles_raw
where director is not null 
limit 10;

insert into  shows(show_id, title,type, release_year,rating, duration)
select show_id, title,type, release_year, rating, duration from           -- filling shows table 
 netflix_titles_raw;


insert into  directors(director_name)
with recursive  numbers  as (select 1 as n 
union all 
select n+1 from numbers                           -- filling directors table
where n<10 )
select distinct trim(substring_index(substring_index(director, ',' , n) ,',' , -1)) as director_name 
from netflix_titles_raw 
join numbers 
on n <= 1 + length(director)- length(replace(director,',', ''))
where director is not null;

  
     with recursive  numbers  as (select 1 as n 
     union all 
      select n+1 from numbers                  
       where n<10 ), split as (                                                                             -- cte for splitting data
select show_id ,   trim(substring_index(substring_index(director, ',' , n) ,',' , -1)) as director_name 
from netflix_titles_raw 
join numbers 
on n <= 1 + length(director)- length(replace(director,',', ''))
where director is not null) 
select * from split
limit 10 ;
 
 
     with recursive  numbers  as (select 1 as n 
     union all 
      select n+1 from numbers 
       where n<10 ), split as (                               
select show_id ,   trim(substring_index(substring_index(director, ',' , n) ,',' , -1)) as director_name 
from netflix_titles_raw 
join numbers 
on n <= 1 + length(director)- length(replace(director,',', ''))
where director is not null) 
select split.show_id , d.director_id from 
split
join directors d 
on split.director_name= d.director_name
limit 10;
 
 
 
 
insert into show_director(show_id , director_id) 
     with recursive  numbers  as (select 1 as n                          -- filling show_director
     union all 
      select n+1 from numbers 
       where n<10 ), split as (
select show_id ,   trim(substring_index(substring_index(director, ',' , n) ,',' , -1)) as director_name 
from netflix_titles_raw 
join numbers 
on n <= 1 + length(director)- length(replace(director,',', ''))
where director is not null) 
select distinct  split.show_id , d.director_id from 
split
join directors d 
on split.director_name= d.director_name
;


truncate table show_director;




use netflix_project;
show tables;
desc shows;

insert into  actors(actor_name)
select  cast from netflix_titles_raw;               -- filling actors table



     with recursive  numbers  as (select 1 as n 
     union all 
      select n+1 from numbers 
       where n<10 ), split as (
select show_id ,   trim(substring_index(substring_index(cast, ',' , n) ,',' , -1)) as actor_name           -- cte for splitting data
 from netflix_titles_raw 
join numbers 
on n <= 1 + length(cast)- length(replace(cast,',', ''))
where cast is not null) 
select * from split ;

insert into  actors(actor_name)
with recursive  numbers  as (select 1 as n 
union all                                                             -- filling actors table
select n+1 from numbers 
where n<10 )
select distinct trim(substring_index(substring_index(cast, ',' , n) ,',' , -1)) as actor_name 
from netflix_titles_raw 
join numbers 
on n <= 1 + length(cast)- length(replace(cast,',', ''))
where cast is not null;




insert into show_actor(show_id , actor_id) 
     with recursive  numbers  as (select 1 as n 
     union all                                                    -- filling show_actor table
      select n+1 from numbers 
       where n<10 ), split as (
select show_id ,   trim(substring_index(substring_index(director, ',' , n) ,',' , -1)) as actor_name 
from netflix_titles_raw 
join numbers 
on n <= 1 + length(cast)- length(replace(cast,',', ''))
where cast is not null) 
select distinct  split.show_id , c.actor_id from 
split
join actors c 
on split.actor_name = c.actor_name
;



     with recursive  numbers  as (select 1 as n 
     union all                                                        -- cte for splitting data
      select n+1 from numbers 
       where n<10 ), split as (
select show_id ,   trim(substring_index(substring_index(listed_in, ',' , n) ,',' , -1)) as genres_name  
from netflix_titles_raw 
join numbers 
on n <= 1 + length(listed_in)- length(replace( listed_in,',', ''))
where listed_in is not null) 
select * from split; 


insert into  genres(genres_name)
with recursive  numbers  as (select 1 as n 
union all 
select n+1 from numbers 
where n<10 )                                                                                     -- filling genres table
select distinct trim(substring_index(substring_index(listed_in, ',' , n) ,',' , -1)) as genres_name 
from netflix_titles_raw 
join numbers 
on n <= 1 + length(listed_in)- length(replace(listed_in,',', ''))
where listed_in is not null;


insert into show_genre(show_id , genre_id) 
     with recursive  numbers  as (select 1 as n 
     union all 
      select n+1 from numbers                            -- filling show_genre table
       where n<10 ), split as (
select show_id ,   trim(substring_index(substring_index(listed_in, ',' , n) ,',' , -1)) as genres_name 
from netflix_titles_raw 
join numbers 
on n <= 1 + length(listed_in)- length(replace(listed_in,',', ''))
where listed_in is not null) 
select distinct  split.show_id , c.genre_id from 
split
join genres c 
on split.genres_name = c.genres_name;


     with recursive  numbers  as (select 1 as n 
     union all 
      select n+1 from numbers 
       where n<10 ), split as(                                                                         -- cte for splitting data
select show_id,   trim(substring_index(substring_index(country, ',' , n) ,',' , -1)) as country_name  
from netflix_titles_raw 
join numbers 
on n <= 1 + length(country)- length(replace( country,',', ''))
where country  is not null) 
select * from split;

 
  insert into  country(country_name)
    with recursive  numbers  as (select 1 as n 
     union all                                                         -- filling country table
      select n+1 from numbers 
       where n<10 )
select  distinct   trim(substring_index(substring_index(country, ',' , n) ,',' , -1)) as country_name  
from netflix_titles_raw 
join numbers 
on n <= 1 + length(country)- length(replace( country,',', ''))
where country  is not null; 



insert into show_country(show_id , country_id) 
     with recursive  numbers  as (select 1 as n 
     union all                                                  -- filling show_country table
      select n+1 from numbers 
       where n<10 ), split as (
select show_id ,   trim(substring_index(substring_index(country, ',' , n) ,',' , -1)) as country_name 
from netflix_titles_raw 
join numbers 
on n <= 1 + length(country)- length(replace(country,',', ''))
where country is not null) 
select distinct  split.show_id , c.country_id from 
split
join country c 
on split.country_name = c.country_name;




use netflix_project;


select count(*) from shows;
select count(*) from directors;
select count(*) from show_director;
select count(*) from genres;
select count(*) from show_genre;
select count(*) from country;
select count(*) from show_country;
select count(*) from actors;
select count(*) from show_actor;

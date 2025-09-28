select * from netflix

select count(*) as total_count
from netflix

select distinct type from netflix

----count the number of Movies vs tv show


select count(*) as countt
from netflix
group by type

----find the most common rating for movies and Tv show 

select  
	type,
	rating,
	ranking
From
(
select 
	 type,  
	(rating),
	Count(*) ,
	Rank() Over(partition by type order by count(*) desc) as ranking
from netflix
group by  1,2 
) as t1
where 
	ranking=1

-----list the movies released in 2020------

select * from netflix
where type = 'Movie' and release_year= 2020


------Find top 5 Countries with most content on nefltix

select
	unnest(string_to_array(country ,','))as new_country,
	count(show_id) as total_content from netflix
group by new_country
order by 2 Desc



----- identify longest movie---


select * from netflix
where
	type= 'Movie'
	and 
	duration = (select max(duration) from netflix)

---- content added in last 5 years---

select *
	from netflix
where
	TO_DATE(date_added, 'MONTH DD, YYYY')>= current_date- interval '5 years'


-----FIND ALL THE MOVIES / TV SHOWS BY "RAJIV CHILAKA"

	select * from netflix
	where director Ilike'%Rajiv Chilaka%'

----List all Tv shows with more than 5 seasons

select *	
from netflix
where 
	type= 'TV Show' AND
	SPLIT_PART(duration,' ',1 )::numeric > 5 
	
-----count the number of items in each genre

select  
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
	COUNT(show_id ) as total_content
from netflix
group by 1


select * from netflix;

-----find each year and the avergae number of  content release by india on netflix 
-----return the top 5 

SELECT 
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year_added,
    COUNT(*) AS total_titles,
  ROUND((COUNT(*)::numeric * 100.0 / 
        (SELECT COUNT(*) FROM netflix WHERE country = 'India')
    )) AS avg_content
FROM netflix
WHERE country = 'India'
GROUP BY year_added
ORDER BY total_titles DESC;

----list all movies that are documentaries

select * from netflix
where listed_in Ilike 'documentaries%'


------ find all content withour director---

select count(*) as nulll from netflix 
where director is null


-----find all movies actor'salman khan'---

select * from netflix 
where casts ILike '%salman khan%' and release_year > extract(year from current_date) -10


---top 10 

select 
	unnest(STRING_TO_ARRAY(casts, ',')) as actors,
	count(* ) as total_content
from netflix 
where country ILIKE '%India%'
group by actors
order by total_content desc
limit 20



	
	
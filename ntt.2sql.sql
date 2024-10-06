SELECT
 DISTINCT type
FROM netflix;

-- 1.Count the Number of Movies vs Tv shows
SELECT
type, count(*) as total_content
FROM netflix GROUP BY TYPE

--2.Find the Most Common Ratting For Movies and TV shows
SELECT
type,
rating
FROM (
    SELECT
    type,
    rating,
	count(*),
	RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC)as ranking
	FROM netflix
	GROUP BY type, rating
) as t1
WHERE ranking=1 

--3.List all Movies Released in a Specific Year(2020)
SELECT *FROM netflix
WHERE
   type='Movie'
   AND
   release_year=2020

--4.Find the top 5 Countries with the Most Content on Netflix
SELECT
  UNNEST( STRING_TO_ARRAY(country,',')) as new_country,
 COUNT(show_id)  as total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--5.Identify the Longest Movie
SELECT * FROM netflix
WHERE
 tYPE ='Movie'
 AND
 duration=(SELECT MAX(duration) FROM netflix)

--6.Find Comtent added in the Last 5 Years
SELECT * FROM netflix
WHERE
  TO_DATE(date_added,'Month DD, YYYY')>= CURRENT_DATE-INTERVAL '5 years'

--7.Find All the Movies/ TV Shows by Director 'Rajiv Chilaka'	
SELECT * FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%'

--8.List ALL TV Shows which More then 5 Seasons
SELECT * FROM netflix
WHERE
   type ='TV Show'
   AND
   SPLIT_PART(duration,' ',1)::numeric>5

--9.List All Movies that are Documentries
SELECT * FROM netflix
WHERE 
listed_in ILIKE '%documentaries%'

--10.Find All the Content without a Director
SELECT * FROM netflix
WHERE 
director IS NULL
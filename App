--COMBINE TABLES

CREATE TABLE appleStore_description AS

SELECT * FROM appleStore_description1

UNION ALL

SELECT * FROM appleStore_description2

UNION ALL

SELECT * FROM appleStore_description3

UNION ALL

SELECT * FROM appleStore_description4

--VIEW TABLES

sELECT * FROM AppleStore

SELECT * FROM appleStore_description

--EXPLORATORY DATA ANALSIS

SELECT COUNT(DISTINCT id) AS UniaueAppID
FROM AppleStore

SELECT COUNT(DISTINCT id) AS UniaueAppID
FROM appleStore_description

--Check for missing values in key fields

SELECT COUNT(*) AS MissingValues
FROM AppleStore
WHERE track_name ISNULL OR user_rating ISNULL OR prime_genre ISNULL

SELECT COUNT(*) AS MissingValues
FROM appleStore_description
WHERE app_desc ISNULL 

--Find out the number of apps per genre

SELECT prime_genre, count(*) AS NumApp
from AppleStore
GROUP BY prime_genre
order by NumApp DESC

--Get an overview of the apps rating

SELECT min(user_rating) as MinRating,
	max(user_rating) as MinRating,
	avg(user_rating) as MinRating
FROM AppleStore
	
--Determine whether paid apps have higher rating than free apps

SELECT CASE
	when price > 0 THEN 'Paid'
    else 'Free'
    END as AppType,
    avg(user_rating) as AvgRating
from AppleStore
group by  AppType

--Check if apps that support more languages have higher ratingsAppleStore

SELECT CASE
	when lang_num < 10 THEN '<10 Lang'
    when lang_num BETWEEN 10 and 20 THEN '10-20 Lang'
    else '>20 Lang'
    END as Lang_Bracket,
    avg(user_rating) as AvgRating
from AppleStore
group by  Lang_Bracket
ORDER by  AvgRating desc

--Genre with low ratingsAppleStore

SELECT prime_genre,
	avg(user_rating) as Avg_Rating
FROM AppleStore
group by prime_genre
order by Avg_Rating
limit 10

--Check if there is correletion between description lenght and user rating

SELECT CASE
	when length(b.app_desc) < 500 THEN 'Short'
    when length(b.app_desc) BETWEEN 500 and 1000 THEN 'Medium'
    else 'Long'
    END as Desc_Leng_Bracket,
    avg(user_rating) as AvgRating

from 
	AppleStore as a
join
	appleStore_description as b 
ON
	a.id = b.id

group by  Desc_Leng_Bracket
ORDER by  AvgRating desc

--Check the top rated appp for each genre

SELECT
	prime_genre,
    track_name,
    user_rating
FROM (
	prime_genre,
    track_name,
    user_rating,
  	RANK() OVER (PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) AS rank
  FROM 
  AppleStore
  ) AS a
  WHERE 
  a.RANK = 1
  
  --Paid apps have better ratingsAppleStore
  
  --Apps with language between 10 and 20 have ratings
  
  --Finance and book app have low ratings
  
  --Apps with longer description have better ratings
  
  --A new app should aim for an average rating above 3.5
  
  --Games and entertainment have high competition
  
  
  
  







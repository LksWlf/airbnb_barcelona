-- create table
drop table if exists projects.airbnb_bcn;
use `projects`;
create table airbnb_bcn (
nr int,
id int,
host_id int,
host_is_superhost varchar(1),
host_listings_count int,
neighbourhood varchar(50),
zipcode int,
latitude double,
longitude double,
property_type varchar(50),
room_type varchar(50),
accommodates int,
bathrooms int,
bedrooms int,
beds int,
amenities varchar(200),
price varchar(50),
minimum_nights int,
has_availability varchar(1),
availability_30 int,
availability_60 int,
availability_90 int,
availability_365 int,
number_of_reviews_ltm int,
review_scores_rating int
);

-- load data from file into table
SET GLOBAL local_infile=1;
use `projects`;
LOAD DATA LOCAL INFILE  
'C:/Users/Lukas Wolf/Documents/projects/tableau/airbnb_bcn/Cleaned_airbnb_barcelona.csv'
INTO TABLE airbnb_bcn
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
IGNORE 1 ROWS;

-- first view at table and data
select *
from projects.airbnb_bcn
limit 100;

-- checking for duplicates
select count(*)
, count(distinct id)
from projects.airbnb_bcn;

with prep as (
select *
, row_number() over(partition by neighbourhood,latitude,longitude,accommodates,bedrooms) as dup
, count(*) over(partition by neighbourhood,latitude,longitude,accommodates,bedrooms) dup_cnt
from projects.airbnb_bcn
)
select *
from prep
where dup_cnt = 2;

-- checking for nulls and blank values
select 
	count(*)
    , count(distinct id)
    , sum(case when nullif(host_id,'') is null then 0 else 1 end)
    , sum(case when nullif(host_is_superhost,'') is null then 0 else 1 end)
    , sum(case when nullif(neighbourhood,'') is null then 0 else 1 end)
    , sum(case when nullif(zipcode,'') is null then 0 else 1 end)
    , sum(case when nullif(latitude,'') is null then 0 else 1 end)
    , sum(case when nullif(longitude,'') is null then 0 else 1 end)
    , sum(case when nullif(property_type,'') is null then 0 else 1 end)
    , sum(case when nullif(room_type,'') is null then 0 else 1 end) 
    , sum(case when nullif(accommodates,'') is null then 0 else 1 end) 
	, sum(case when nullif(bathrooms,'') is null then 0 else 1 end)
    , sum(case when nullif(bedrooms,'') is null then 0 else 1 end) 
    , sum(case when nullif(beds,'') is null then 0 else 1 end)
    , sum(case when nullif(price,'') is null then 0 else 1 end)
    , sum(case when nullif(minimum_nights,'') is null then 0 else 1 end)
    , sum(case when nullif(number_of_reviews_ltm,'') is null then 0 else 1 end) 
	, sum(case when nullif(review_scores_rating,'') is null then 0 else 1 end) 
from projects.airbnb_bcn
;

## transforming data types and selecting necessary columns only
with cte as (
select   
	id     
	, case            
        when host_is_superhost = 't' then 1         
        else 0   
	end as host_is_superhost  
    , host_id
    , count(*) over(partition by host_id) as host_listings_count # number of listings per host, column had errors before
    , neighbourhood    
    , zipcode   
    , concat(0,cast(zipcode as char(10))) as zipcode_adj # adjust wrong zipcodes 
    , latitude     
    , longitude     
    , property_type     
    , room_type     
    , accommodates     
    , bathrooms     
    , bedrooms     
    , beds     
    , price 
    , concat(substring_index(replace(price,',',''),'$',-1),substring_index(price,'.',1)) * 1 as price_adj  # converting price string into double
    , minimum_nights     
    , number_of_reviews_ltm      
    , review_scores_rating 
    from projects.airbnb_bcn
)
select *
from cte 
where 1 = 1 
and neighbourhood <> ''
;

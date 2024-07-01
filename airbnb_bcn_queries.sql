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
, count(*) over(partition by neighbourhood,latitude,longitude) dup_cnt
from projects.airbnb_bcn
)
select *
from prep
where dup_cnt = 2;

-- checking for nulls
select 
	count(*)
    , count(distinct id)
    , sum(case 
			when host_id is null then 0 
			when host_id = '' then 0
			else 1 end)
    , sum(case 
			when neighbourhood is null then 0 
            when neighbourhood = '' then 0
            else 1 end)
    , sum(case 
			when zipcode is null then 0 
            when zipcode = '' then 0 
            else 1 end)
    , sum(case 
			when latitude is null then 0 
            when latitude = '' then 0 
            else 1 end)
    , sum(case 
			when longitude is null then 0 
            when longitude = '' then 0 
            else 1 end)
    , sum(case 
			when property_type is null then 0 
            when property_type = '' then 0 
            else 1 end)
    , sum(case 
			when room_type is null then 0 
            when room_type = '' then 0 
            else 1 end)
    , sum(case 
			when accommodates is null then 0 
            when accommodates = '' then 0 
            else 1 end)
    , sum(case 
			when bathrooms is null then 0 
            when bathrooms = '' then 0 
            else 1 end)
    , sum(case 
			when bedrooms is null then 0 
            when bedrooms = '' then 0
            else 1 end)
    , sum(case 
			when beds is null then 0 
            when beds = '' then 0 
            else 1 end)
    , sum(case 
			when price is null then 0 
            when price = '' then 0 
            else 1 end)
    , sum(case 
			when minimum_nights is null then 0 
            when minimum_nights = '' then 0
            else 1 end)
    , sum(case 
			when number_of_reviews_ltm is null then 0 
            when number_of_reviews_ltm = '' then 0
            else 1 end)
    , sum(case 
			when review_scores_rating is null then 0 
            when review_scores_rating = '' then 0 
            else 1 end)
from projects.airbnb_bcn;


## transforming data types
with cte as (
select   
	id * 1.0 as id     
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

# Airbnb Barcelona

## Introduction and Problem Description
As one of the most visited cities in Europe, Barcelona is particularly affected by the negative consequences of mass tourism. Special attention is being paid to the increase in rents for residents, as well as a reduction in housing supply in general, as housing is being replaced by tourist use. As a result, Barcelona mayor Jaume Collboni announced plans to ban short term rentals in the city starting in November 2028.

In this context, I was curious to find out about the numbers behind Airbnb Listings in Barcelona, with Airbnb being one of the biggest and widely used short term rental platforms. 
I am particulary interest in questions like:

1. In which areas are most of Airbnb Listings located?
2. What kind of Listings are provided? Entire apartments or private rooms in a shared flat?
3. How many hosts do actually have several Listings?

## Dataset
I found the data on Kaggle, an Online-Community for Machine Learning and Data Science (https://www.kaggle.com/datasets/zakariaeyoussefi/barcelona-airbnb-listings-inside-airbnb/data). The original dataset is provided from the website "Inside Airbnb" https://insideairbnb.com/get-the-data/. The aim of this project is to provide data about Airbnb's impact on residential communities and cities.

## Method
First data loading and table creation: I have used MySQL to create the table and write the SQL queries. We start with understanding our dataset and checking for missing values as well as outliers.
We use **Tableau** public to create a Dashboard and visualize our data and findings in different graphs.

## Result
The Tableau dashboard shows that Airbnb Listings appear throughout the city, but the city center and tourist locations particularly are very crowded. 
Around half of all Listings actually rent out the entire apartment - long-term housing for inhabitants is clearly being displaced here. In the case of individual, private rooms, it may still be possible to argue that locals want (or need) to earn some extra money.
It is also noticeable that the maior proportion of Listings are marketed by hosts who have placed several Listings. This indicates a predominantly commercial use. This is particularly noticeable with Listings of entire apartments.

Unfortunately it was not easily possible to found out how many private rooms Listings are part of the same apartment, as the only source of combining are the provided geo-coordinates, which I am not sure how accurate they are. This would leave an opportunity for investigating in the future.

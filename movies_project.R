# Required components
# section that notes the required packages
# F9u69d8YyFxs7vSBybGmL8p0hCTGgN_t
# https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/day/2020-06-01/2020-06-17?apiKey=F9u69d8YyFxs7vSBybGmL8p0hCTGgN_t
# http://www.omdbapi.com/?t=Game of Thrones&Season=1
# http://www.omdbapi.com/?y=2019
#http://www.omdbapi.com/?apikey=[yourkey]&
#http://www.omdbapi.com/?i=tt3896198&apikey=8e93e9ad
#http://www.omdbapi.com/?plot=full
#https://www.boxofficemojo.com/year/openings/
#&apikey=c5b185bc6bb94e4b9cc7fe3a18647067 
#https://api.spoonacular.com/recipes/findByIngredients
#https://dkorver.github.io/food/
library(httr)
library(jsonlite)
library(tidyverse)
library(devtools)
install_github("mikeasilva/blsAPI")
response <- blsAPI('LAUCN040010000000005')
json <- fromJSON(response)

#stocks <- GET("https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/day/2020-06-01/2020-06-17?apiKey=F9u69d8YyFxs7vSBybGmL8p0hCTGgN_t")
stocks <- GET("https://api.polygon.io/v2/aggs/grouped/locale/us/market/stocks/2020-10-14?adjusted=true&apiKey=F9u69d8YyFxs7vSBybGmL8p0hCTGgN_t")
stocks
get_stocks_text <- content(stocks, "text")
get_stocks_text
get_stocks_json <- fromJSON(get_stocks_text, flatten = TRUE)
get_stocks_json
get_stocks_df <- as.data.frame(get_stocks_json)
get_stocks <- as_tibble(get_stocks_df) 
get_stocks
table(get_stocks$results.T)
write.csv(get_stocks,"/Users/danekorver/Documents/get_stocks.csv")




cooking <- GET("https://api.spoonacular.com/recipes/findByIngredients?ingredients=strawberries&number=2&apiKey=c5b185bc6bb94e4b9cc7fe3a18647067")
cooking
get_cooking_text <- content(cooking, "text")
get_cooking_text
get_cooking_json <- fromJSON(get_cooking_text, flatten = TRUE)
get_cooking_json
get_cooking_df <- as.data.frame(get_cooking_json)
#Select only the source, author, and title columns and print the tibble out
#str(get_cooking_df)
get_cooking <- as_tibble(get_cooking_df) 
get_cooking



movies <- GET("http://www.omdbapi.com/?y=2019&apikey=11e9acac")
movies
get_movies_text <- content(movies, "text")
get_movies_text
get_movies_json <- fromJSON(get_movies_text, flatten = TRUE)
get_movies_json
get_movies_df <- as.data.frame(get_movies_json)
#Select only the source, author, and title columns and print the tibble out
str(get_movies_df)
get_movies <- as_tibble(get_movies_df) 
get_movies


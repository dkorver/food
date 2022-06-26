Interacting with APIs: Example using the Financial data API
================
Dane Korver
2022-06-26

### Interacting with APIs: Example using the Financial data API

I am creating a vignette to show how to contact an API using functions
I’ve created to query, parse, and return well-structured data. Then
we’ll use them to do some exploratory data analysis.

## Requirements

To use the functions for interacting with the Financial data API, I used
the following packages:

-   httr
-   jsonlite
-   tidyverse
-   devtools

## API Interaction Function

The first challenge with this API was dealing with the variable names.
The default names are not preferable to work with when doing data
analysis, so I renamed some of the variables to make them readable. Once
I selected and renamed the variables to make them readable, I wanted to
calculate the percentage change between the stock’s open and close
price. Now that I have the stock’s percentage change, I wanted to output
the day’s best and worse performers. I then wanted to look at the
stock’s opening price at the start and its closing price of the stock at
the end of the month and see how many had a experienced a gain, no
change or loss for the month.

The `get_stocks` function grabs the daily open, high, low, and close for
the entire stocks/equities markets from the API given a date you entered
following the Year-Month-Day format, a boolean (true/or false) value for
whether you want the prices to be adjusted for splits, and the API key
that the service provides you.

``` r
get_stocks <- function(day,adjusted,apikey) {
# Set the baseURL, midpoint, endpoint, and combine them with day, adjusted and apikey inputs for the full url.
  baseURL <- "https://api.polygon.io/v2/aggs/grouped/locale/us/market/stocks/"
  midpoint <- "?adjusted="
  endpoint <- "&apiKey="
  fullURL <- paste0(baseURL,day,midpoint,adjusted,endpoint,apikey)
  stocks <- GET(fullURL)
  get_stocks_text <- content(stocks,"text",encoding="UTF-8")
  # Get the API output.
  get_stocks_json <- fromJSON(get_stocks_text, flatten = TRUE)
  # Convert to a dataframe 
  get_stocks_df <- as.data.frame(get_stocks_json)
  # Convert to a tibble
  output <- as_tibble(get_stocks_df)
  output$Date <- day
  # Return the output from the request.
  return(output)
}
```

## Data Exploration

I “pseudo-randomly” chose a month. I write, “pseudo-randomly” because
with a free account, you are only able to access certain time points.
For this exercise, I chose March, 2021. I grabbed the the March 1, 2021
and March 31, 2021 data from the API. I selected and renamed the
variables that I wanted to use for my analysis and also computed the
daily percentage change and outputted a table that lists out the best
and worse performers for that day.

``` r
stocks_dataD030121 <- get_stocksD030121 %>% 
  select(results.T,results.v,results.o,results.c,results.h,results.l,Date) %>%
  rename(ticker = results.T,volume01 = results.v,open01 = results.o,close01 = results.c,day_high01 = results.h,day_low01 = results.l) %>%
  mutate(daily_pct_change01 = ((close01-open01)/open01)*100) %>%
  arrange(daily_pct_change01)
worst0301<-filter(head(stocks_dataD030121,n=5))
best0301<-filter(tail(stocks_dataD030121,n=5))
best0301<-arrange(best0301,desc(daily_pct_change01))
```

For March 1, here are the top 5 best and worse performers by daily
percentage change:

``` r
#print out the best and worst performers for March 1, 2021
best0301
```

    ## # A tibble: 5 × 8
    ##   ticker volume01 open01 close01 day_high01 day_low01 Date      daily_pct_chang…
    ##   <chr>     <dbl>  <dbl>   <dbl>      <dbl>     <dbl> <chr>                <dbl>
    ## 1 MORF   12970204  45      84.8       93        42.9  2021-03-…             88.6
    ## 2 PRSRW    153574   1.4     2.06       3         1.4  2021-03-…             47.1
    ## 3 AMTX   45662532  11      14.9       16.4      10.9  2021-03-…             35.7
    ## 4 GNOGW   1080157   2.84    3.85       3.99      2.55 2021-03-…             35.6
    ## 5 OSS     2229710   6.55    8.87       9.5       6.55 2021-03-…             35.4

``` r
worst0301
```

    ## # A tibble: 5 × 8
    ##   ticker  volume01 open01 close01 day_high01 day_low01 Date     daily_pct_chang…
    ##   <chr>      <dbl>  <dbl>   <dbl>      <dbl>     <dbl> <chr>               <dbl>
    ## 1 ARTLW      38702   0.55    0.37       0.55      0.37 2021-03…            -32.7
    ## 2 BLTSW      73472   1.95    1.36       2         1.31 2021-03…            -30.3
    ## 3 REPX       80503  32.1    24.2       32.1      22.4  2021-03…            -24.6
    ## 4 CHPT.WS   118210  18.5    14         19.4      13.4  2021-03…            -24.3
    ## 5 MNKD    29156442   5.25    4.01       5.3       3.91 2021-03…            -23.6

Then for March 31, 2021, I did the same thing:

``` r
stocks_dataD033121 <- get_stocksD033121 %>% 
  select(results.T,results.v,results.o,results.c,results.h,results.l,Date) %>%
  rename(ticker = results.T,volume31 = results.v,open31 = results.o,close31 = results.c,day_high31 = results.h,day_low31 = results.l) %>%
  mutate(daily_pct_change31 = ((close31-open31)/open31)*100) %>%
  arrange(daily_pct_change31)
worst0331<-filter(head(stocks_dataD033121,n=5))
best0331<-filter(tail(stocks_dataD033121,n=5))
best0331<-arrange(best0331,desc(daily_pct_change31))
```

For March 31, here are the top 5 best and worse performers by daily
percentage change:

``` r
#print out the best and worst performers for March 31, 2021
best0331
```

    ## # A tibble: 5 × 8
    ##   ticker  volume31 open31 close31 day_high31 day_low31 Date     daily_pct_chang…
    ##   <chr>      <dbl>  <dbl>   <dbl>      <dbl>     <dbl> <chr>               <dbl>
    ## 1 DISCB    1324372 75.5   128         151.      75.4   2021-03…             69.5
    ## 2 ATMR.WS    21854  1.2     1.78        1.78     1.2   2021-03…             48.1
    ## 3 WAFU    75153265  8.56   12.5        16.0      8.2   2021-03…             46.0
    ## 4 CTXRW       1835  0.604   0.879       1        0.604 2021-03…             45.5
    ## 5 MVIS    56686153 13.0    18.6        19.4     12.8   2021-03…             43.1

``` r
worst0331
```

    ## # A tibble: 5 × 8
    ##   ticker  volume31 open31 close31 day_high31 day_low31 Date     daily_pct_chang…
    ##   <chr>      <dbl>  <dbl>   <dbl>      <dbl>     <dbl> <chr>               <dbl>
    ## 1 CRTDW      45255   2.98    1.96       2.98      1.92 2021-03…            -34.2
    ## 2 MILEW     137832   4.25    3.09       4.25      2.88 2021-03…            -27.3
    ## 3 DFHTW       9853   3.15    2.31       3.15      2.31 2021-03…            -26.7
    ## 4 TAOP    15734548  12.6     9.41      13.2       9.12 2021-03…            -25.3
    ## 5 CPUH.WS   298415   1.65    1.25       1.65      1.2  2021-03…            -24.2

Then I merged the data together by ticker and computed a monthly
percentage change variable and then also created a variable to indicate
if the stock had a gain, loss or experienced no change for the month.

``` r
combine<-inner_join(stocks_dataD030121,stocks_dataD033121,by="ticker")
combine$monthly_pct_change = ((combine$close31-combine$open01)/combine$open01)*100
combine<-arrange(combine,monthly_pct_change)
combine<-select(combine,ticker,volume01,volume31,open01,close31,monthly_pct_change)
combine <- combine %>% mutate(month_gain = if_else(monthly_pct_change>0,"Gain",
                                                   if_else(monthly_pct_change==0,"No     change","Loss")))
month_worst<-filter(head(combine,n=5))
month_best<-filter(tail(combine,n=5))
month_best<-arrange(month_best,desc(monthly_pct_change))
```

Then, for curiosity, I outputted the top 5 best and worse performers for
the month.

``` r
month_best
```

    ## # A tibble: 5 × 7
    ##   ticker volume01 volume31 open01 close31 monthly_pct_change month_gain
    ##   <chr>     <dbl>    <dbl>  <dbl>   <dbl>              <dbl> <chr>     
    ## 1 LEE      307152    44408   2.15    25.7              1095. Gain      
    ## 2 TKAT      67892  1297409   3.24    34                 949. Gain      
    ## 3 NRGD    1345653    85489   2.08    19.2               824. Gain      
    ## 4 BNKD     197827    14398   2.18    18.9               766. Gain      
    ## 5 TZA    46699613  8445049   4.37    34.0               679. Gain

``` r
month_worst
```

    ## # A tibble: 5 × 7
    ##   ticker volume01 volume31 open01 close31 monthly_pct_change month_gain
    ##   <chr>     <dbl>    <dbl>  <dbl>   <dbl>              <dbl> <chr>     
    ## 1 SOXL    1651409 25457211 609.    38.2                -93.7 Loss      
    ## 2 EDU      787089 14973464 181.    14                  -92.3 Loss      
    ## 3 RMO.WS   504284  4743362   1.89   0.185              -90.2 Loss      
    ## 4 TECL     232837  1696632 422.    41.3                -90.2 Loss      
    ## 5 ELP      984732 16122045  10.6    1.26               -88.1 Loss

Using my `month_gain` variable, I created a contingency table to see how
many stocks experienced a gain, loss, or no change during the month of
March, 2021.

``` r
table(combine$month_gain)
```

    ## 
    ##          Gain          Loss No     change 
    ##          4806          4784            43

As we can see by the table, the number of stocks that had a gain or loss
by monthly percentage change is almost even and very few had experienced
no percentage change for the month.

After investigating the number of stocks that experienced a gain, loss
or no change, I wanted to compare the trading volome for these stocks at
the start and end of the month.

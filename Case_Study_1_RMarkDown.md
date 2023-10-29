# Google Data Analytics Professional Certificate – Capstone Project

### Case Study 1: How Does a Bike-Share Navigate Speedy Success?

## Introduction

Founded in 2016, Cyclistic has established itself as a prominent
bike-share company in Chicago, operating a sizeable fleet of 5,824
bicycles across a network of 692 geotracked stations. The company’s
pricing model, offering single-ride passes, full-day passes, and annual
memberships, has attracted both **casual riders** (those who purchase
single-ride or full-day passes) and dedicated **Cyclistic members**
(those who purchase annual memberships), with the latter proving to be
significantly more profitable, as indicated by the company’s financial
analysts. Lily Moreno, the Director of Marketing aims to bolster future
growth by converting casual riders into annual members, prompting a
focused analysis by the marketing analyst team into the differing
behaviours of these two customer segments. This investigation also seeks
to uncover the motivations behind purchasing memberships and explore the
potential influence of digital media on Cyclistic’s marketing tactics,
utilising a comprehensive examination of the company’s historical bike
trip data to inform strategic decision-making.

## Background

As a junior data analyst within Cyclistic’s marketing analyst team, my
primary objective is to investigate the distinctions in the usage
patterns of casual riders and annual members, with the overarching aim
of devising a new marketing strategy focused on the conversion of casual
riders into loyal annual members. Guided by the director of marketing,
Lily Moreno, my role involves delving into the intricacies of how these
two customer segments utilise Cyclistic bikes differently, identifying
the motivations behind casual riders opting for annual memberships, and
exploring the potential impact of digital media on marketing tactics. In
order to accomplish this, my task at hand requires me to analyse the
Cyclistic historical bike trip data to identify trends.

## Data Analysis Process

In this case study, the six steps of the data analysis process will be
used in order to solve our problem. These 6 steps include:

1.  Ask
2.  Prepare
3.  Process
4.  Analyse
5.  Share
6.  Act

### Step 1: Ask

#### 1.1 Identify the Business Task:

Design marketing strategies aimed at converting casual riders into
annual members.

#### 1.2 Consider the Key Stakeholders:

-   *Lily Moreno*: The director of marketing and your manager. Moreno is
    responsible for the development of campaigns and initiatives to
    promote the bike-share program.
-   *Cyclistic Marketing Analytics Team*: A team of data analysts who
    are responsible for collecting, analysing, and reporting data that
    helps guide Cyclistic marketing strategy.
-   *Cyclistic Executive Team*: The notoriously detail-oriented
    executive team will decide whether to approve the recommended
    marketing program.

#### 1.3 Questions to Analyse:

1.  *How do annual members and casual riders use Cyclistic bikes
    differently?*
2.  *Why would casual riders buy Cyclistic annual memberships?*
3.  *How can Cyclistic use digital media to influence casual riders to
    become members?*

Moreno has assigned to me the first question to answer as part of this
project: How do annual members and casual riders use Cyclistic bikes
differently?

### Step 2: Prepare

This stage of the data analysis process will entail examining the
selected data source to be utilised in the analysis. This examination
will involve assessing the data’s organisation, evaluating its
credibility, determining the level of data security, and understanding
its overall structure.

#### 2.1 Data Source

The selected data source for the analysis encompasses Cyclistic’s
historical trip data spanning from January 2022 to December 2022. These
datasets were acquired in the form of 12 zipped files, with the data
being accessible and licensed by Motivate International Inc. Access to
the datasets can be found by following the [provided
link](https://divvy-tripdata.s3.amazonaws.com/index.html).

#### 2.2 Data Credibility

The datasets, collected by Lyft Bikes and Scooters, LLC (“Bikeshare”)
from the City of Chicago’s Divvy bicycle sharing service, are made
available to the public under specific terms and conditions of the
License Agreement. Our analysis qualifies as a “lawful purpose,”
permitting our use of the datasets. The involvement of Lyft Bikes and
the City of Chicago in data ownership contributes to the credibility of
the datasets. However, the Agreement grants Bikeshare the authority to
modify or terminate data provision without cause, warranting cautious
consideration. Despite this, we can reasonably consider the datasets
credible for our analysis.

#### 2.3 Data Security & Limitations

Rider’s personally identifiable information remains concealed in
adherence to data privacy regulations, ensuring the exclusion of any
personal data and credit card information from the datasets. Original
dataset files are securely backed up in a separate folder to preserve
the integrity of the initial data prior to processing and cleaning.
However, due to the anonymisation of personally identifiable
information, certain limitations arise, such as the inability to link
pass purchases to credit card numbers for insights into rider location
within the Cyclistic service area and the frequency of single pass
purchases.

#### 2.4 Data Information and Structure

The data source includes 12 csv files labelled as
*“YYYYMM-divvy-tripdata”*, each representing data for a particular
month. Each file comprises 13 columns containing specific ride-related
information, with the following corresponding column names:

-   ride\_id
-   rideable\_type
-   started\_at
-   ended\_at
-   start\_station\_name
-   start\_station\_id
-   end\_station\_name
-   end\_station\_id
-   start\_lat
-   start\_lng
-   end\_lat
-   end\_lng
-   member\_casual

### Step 3: Process

This phase of the data analysis process includes eliminating errors,
inaccuracies, and inconsistencies that might impact the analysis’s
validity. Additionally, I will modify the columns as necessary to
optimise the data format for the analysis.

#### 3.1 Tools To be Used

I’ve opted to use the R programming language for its capacity to handle
large data volumes and its diverse range of functions suitable for data
cleaning tasks. While Excel was initially considered, its limitations in
processing the consolidation of 12 months of bicycle data made it
unsuitable. While acknowledging the advantages of SQL, I chose to
prioritise enhancing my R skills, given the added flexibility provided
by the language’s extensive functions despite its relatively higher
complexity.

#### 3.2 Data Combination

Prior to processing and cleaning, the following libraries were loaded in
RStudio to equip the system with the essential tools for the required
operations. The code is as follows:

    library(tidyverse) #for calculations

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.3     ✔ readr     2.1.4
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.0
    ## ✔ ggplot2   3.4.3     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.3     ✔ tidyr     1.3.0
    ## ✔ purrr     1.0.2     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

    library(dplyr) #for managing data frames
    library(lubridate) #for manipulation of dates
    library(hms) #for manipulation of time

    ## 
    ## Attaching package: 'hms'
    ## 
    ## The following object is masked from 'package:lubridate':
    ## 
    ##     hms

    library(readr) #for uploading .csv files into R

The 12 monthly tripdata CSV files were uploaded into R Studio for
manipulation to form a comprehensive 2022 bicycle dataset. The code is
as follows:

    jan22_df <- read_csv("202201-divvy-tripdata.csv")

    ## Rows: 103770 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (9): ride_id, rideable_type, started_at, ended_at, start_station_name, s...
    ## dbl (4): start_lat, start_lng, end_lat, end_lng
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    feb22_df <- read_csv("202202-divvy-tripdata.csv")

    ## Rows: 115609 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...
    ## dbl  (4): start_lat, start_lng, end_lat, end_lng
    ## dttm (2): started_at, ended_at
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    mar22_df <- read_csv("202203-divvy-tripdata.csv")

    ## Rows: 284042 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...
    ## dbl  (4): start_lat, start_lng, end_lat, end_lng
    ## dttm (2): started_at, ended_at
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    apr22_df <- read_csv("202204-divvy-tripdata.csv")

    ## Rows: 371249 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...
    ## dbl  (4): start_lat, start_lng, end_lat, end_lng
    ## dttm (2): started_at, ended_at
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    may22_df <- read_csv("202205-divvy-tripdata.csv")

    ## Rows: 634858 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...
    ## dbl  (4): start_lat, start_lng, end_lat, end_lng
    ## dttm (2): started_at, ended_at
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    jun22_df <- read_csv("202206-divvy-tripdata.csv")

    ## Rows: 769204 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...
    ## dbl  (4): start_lat, start_lng, end_lat, end_lng
    ## dttm (2): started_at, ended_at
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    jul22_df <- read_csv("202207-divvy-tripdata.csv")

    ## Rows: 823488 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...
    ## dbl  (4): start_lat, start_lng, end_lat, end_lng
    ## dttm (2): started_at, ended_at
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    aug22_df <- read_csv("202208-divvy-tripdata.csv")

    ## Rows: 785932 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...
    ## dbl  (4): start_lat, start_lng, end_lat, end_lng
    ## dttm (2): started_at, ended_at
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    sep22_df <- read_csv("202209-divvy-tripdata.csv")

    ## Rows: 701339 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...
    ## dbl  (4): start_lat, start_lng, end_lat, end_lng
    ## dttm (2): started_at, ended_at
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    oct22_df <- read_csv("202210-divvy-tripdata.csv")

    ## Rows: 558685 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...
    ## dbl  (4): start_lat, start_lng, end_lat, end_lng
    ## dttm (2): started_at, ended_at
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    nov22_df <- read_csv("202211-divvy-tripdata.csv")

    ## Rows: 337735 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...
    ## dbl  (4): start_lat, start_lng, end_lat, end_lng
    ## dttm (2): started_at, ended_at
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    dec22_df <- read_csv("202212-divvy-tripdata.csv")

    ## Rows: 181806 Columns: 13
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...
    ## dbl  (4): start_lat, start_lng, end_lat, end_lng
    ## dttm (2): started_at, ended_at
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

Next, we need to make sure that all our data frames have consistent
variables. The dates in the `jan22_df` are represented as characters,
therefore we need to convert them into dates with the following code:

    jan22_df <- jan22_df %>%  mutate(ended_at = as_datetime(ended_at, format = "%d/%m/%Y %H:%M"), 
                                       started_at = as_datetime(started_at, format = "%d/%m/%Y %H:%M"))

The following syntax combines all 12 files into a single dataset,
creating a new data frame named `trip22_df` with the provided code:

    trip22_df <- rbind(jan22_df, feb22_df, mar22_df, apr22_df, may22_df, jun22_df, jul22_df, aug22_df, sep22_df, 
                       oct22_df, nov22_df, dec22_df)

#### 3.3 Data Exploration

To check our combined dataset we will use the `str` function to gain a
preview of our data:

    str(trip22_df)

    ## tibble [5,667,717 × 13] (S3: tbl_df/tbl/data.frame)
    ##  $ ride_id           : chr [1:5667717] "C2F7DD78E82EC875" "A6CF8980A652D272" "BD0F91DFF741C66D" "CBB80ED419105406" ...
    ##  $ rideable_type     : chr [1:5667717] "electric_bike" "electric_bike" "classic_bike" "classic_bike" ...
    ##  $ started_at        : POSIXct[1:5667717], format: "2022-01-13 11:59:00" "2022-01-10 08:41:00" ...
    ##  $ ended_at          : POSIXct[1:5667717], format: "2022-01-13 12:02:00" "2022-01-10 08:46:00" ...
    ##  $ start_station_name: chr [1:5667717] "Glenwood Ave & Touhy Ave" "Glenwood Ave & Touhy Ave" "Sheffield Ave & Fullerton Ave" "Clark St & Bryn Mawr Ave" ...
    ##  $ start_station_id  : chr [1:5667717] "525" "525" "TA1306000016" "KA1504000151" ...
    ##  $ end_station_name  : chr [1:5667717] "Clark St & Touhy Ave" "Clark St & Touhy Ave" "Greenview Ave & Fullerton Ave" "Paulina St & Montrose Ave" ...
    ##  $ end_station_id    : chr [1:5667717] "RP-007" "RP-007" "TA1307000001" "TA1309000021" ...
    ##  $ start_lat         : num [1:5667717] 42 42 41.9 42 41.9 ...
    ##  $ start_lng         : num [1:5667717] -87.7 -87.7 -87.7 -87.7 -87.6 ...
    ##  $ end_lat           : num [1:5667717] 42 42 41.9 42 41.9 ...
    ##  $ end_lng           : num [1:5667717] -87.7 -87.7 -87.7 -87.7 -87.6 ...
    ##  $ member_casual     : chr [1:5667717] "casual" "casual" "member" "casual" ...

From this, we can see that our bicycle data for the year 2022 has been
combined and that there are 5,667,717 rows/observations within our newly
combined data frame.

With the combination of our monthly datasets into a single data frame,
the individual monthly data frames are no longer necessary, prompting
their removal to reduce memory usage in R.

    rm(jan22_df, feb22_df, mar22_df, apr22_df, may22_df, jun22_df, jul22_df, aug22_df, sep22_df, oct22_df, nov22_df,
       dec22_df)

#### 3.4 Additional Data Columns

To prepare for analysis, additional columns are added to the data frame,
offering further insights to answer the overarching business question of
the distinct usage patterns of annual members and casual riders. The new
columns include:

-   ride\_length – duration of each ride
-   day\_of\_week – day of the week that each ride started
-   time – time that each ride started (converted to HH:MM:SS format)
-   month – month that each ride started
-   season – the season that each ride began (Spring, Summer, Winter and
    Autumn)
-   hour – hour of which each ride started
-   time\_of\_day – part of the day that each ride started (Morning:
    5am-12pm, Afternoon: 12-5pm, Evening: 5-9pm and Night: 9pm–4am)

<!-- -->

    #Calculate ride length and place in new column
    ride_length <- difftime(trip22_df$ended_at, trip22_df$started_at, units = "min")
    trip22_df$ride_length <- as.numeric(ride_length) #convert column values as numeric
    remove(ride_length) #remove unnecessary data frame

    #Calculate day of the week and place in new column
    trip22_df$day_of_week <- weekdays(trip22_df$started_at)

    #Calculate time that each ride started
    trip22_df$time <- format(trip22_df$started_at, format = "%H:%M:%S")

    #Calculate month that each ride started
    trip22_df$month <- format(trip22_df$started_at, format = "%B")

    #Determine the season that each ride started
    seasons <- function(x){
      if(x %in% 3:5){ 
        return("Spring")
      }
      if(x %in% 6:8){ 
        return("Summer")
      }
      if(x %in% 9:11){ 
        return("Autumn")
      }
      if(x %in% c(12,1,2)){ 
        return("Winter")
      }
    } #create a function that determines the season based on month
    trip22_df$date <- as.Date(trip22_df$started_at, format = "%Y/%m/%d") #create new column for the date
    trip22_df$season <- sapply(month(trip22_df$date), seasons)
    trip22_df <- select(trip22_df, -date) #remove date column

    #Create separate column for hour that each ride started
    trip22_df$hour <- hour(trip22_df$started_at)

    #Determine the time of day that each ride started
    timeofday <- function(x){
      if(x %in% 5:11){
        return("Morning")
      }
      if(x %in% 12:16){
        return("Afternoon")
      }
      if(x %in% 17:20){
        return("Evening")
      }
      if(x %in% c(21:24,0:4)){
        return("Night")
      }
    } #create a function that determines the time of day based on hour of the day
    trip22_df$time_of_day <- sapply(trip22_df$hour, timeofday)

#### 3.5 Data Cleaning

At this stage, we will clean our data of any duplicate rows, any rows
containing NA values (blank rows) and any rows where `ride_length` is 0
or negative, using the following code:

    trip22_df <- trip22_df %>% distinct() #remove duplicate rows
    trip22_df <- drop_na(trip22_df) #remove empty rows and NA values
    trip22_df <- trip22_df[trip22_df$ride_length > 0, ] #remove negative and zero values

After cleaning and manipulating the `trip22_df` data frame, we have
4,368,438 rows and 20 columns.

### Step 4: Analyse

We will use R to conduct an initial analysis of our cleaned data frame
to identify any trends, patterns or unusual aspects relating to the
customer behaviour of our casual riders and Cyclistic members. Our
analysis involved determining the following information:

-   Calculating total average ride length
-   Average ride length for each member type
-   Number of casual riders vs Cyclistic members
-   Number of riders for each bike type, grouped by member type
-   Average ride length for each bike type, separated by member type
-   Average ride length for each hour in a day, time classification of
    the day, day of the week, month, and season, separated by member
    type
-   Total rides for each hour, time of classification of the day, day of
    the week, month and season, separated by member type
-   Most popular starting stations, separated by member type

The above analysis is demonstrated through the following code:

    #Calculate total average ride length
    total_average_ride_length <- mean(trip22_df$ride_length)
    print(total_average_ride_length)

    ## [1] 17.09921

    #Calculate average ride length for each member type
    average_ride_length_membertype <- trip22_df %>% group_by(member_casual) %>% summarise(average_ride_length = 
                                                                                            mean(ride_length))
    print(average_ride_length_membertype)

    ## # A tibble: 2 × 2
    ##   member_casual average_ride_length
    ##   <chr>                       <dbl>
    ## 1 casual                       24.0
    ## 2 member                       12.5

    #Determine number of casual riders vs Cyclistic members
    number_of_rider_groupings <- trip22_df %>% group_by(member_casual) %>% count(member_casual)
    colnames(number_of_rider_groupings)[2] <- "number_of_riders"
    print(number_of_rider_groupings)

    ## # A tibble: 2 × 2
    ## # Groups:   member_casual [2]
    ##   member_casual number_of_riders
    ##   <chr>                    <int>
    ## 1 casual                 1757963
    ## 2 member                 2610475

    #Determine number of riders for each bike type, separated by member type
    bike_type_riders <- trip22_df %>% group_by(member_casual,rideable_type) %>% count(member_casual)
    colnames(bike_type_riders)[3] <- "number_of_riders"
    print(bike_type_riders)

    ## # A tibble: 5 × 3
    ## # Groups:   member_casual, rideable_type [5]
    ##   member_casual rideable_type number_of_riders
    ##   <chr>         <chr>                    <int>
    ## 1 casual        classic_bike            888687
    ## 2 casual        docked_bike             174848
    ## 3 casual        electric_bike           694428
    ## 4 member        classic_bike           1708213
    ## 5 member        electric_bike           902262

    #Calculate average ride length for each bike type, separated by member type
    bike_type_average_ride <- trip22_df %>% group_by(member_casual,rideable_type) %>% summarise(average_ride_length =
                                                                                                  mean(ride_length))

    ## `summarise()` has grouped output by 'member_casual'. You can override using the
    ## `.groups` argument.

    print(bike_type_average_ride)

    ## # A tibble: 5 × 3
    ## # Groups:   member_casual [2]
    ##   member_casual rideable_type average_ride_length
    ##   <chr>         <chr>                       <dbl>
    ## 1 casual        classic_bike                 24.4
    ## 2 casual        docked_bike                  50.7
    ## 3 casual        electric_bike                16.7
    ## 4 member        classic_bike                 13.2
    ## 5 member        electric_bike                11.0

    #Calculate average ride length for various categories of time
    average_ride_length_by_hour <- trip22_df %>% group_by(member_casual, hour) %>% 
      summarise(average_ride_length = mean(ride_length))

    ## `summarise()` has grouped output by 'member_casual'. You can override using the
    ## `.groups` argument.

    average_ride_length_by_timeofday <- trip22_df %>% group_by(member_casual, time_of_day) %>% 
      summarise(average_ride_length = mean(ride_length))

    ## `summarise()` has grouped output by 'member_casual'. You can override using the
    ## `.groups` argument.

    average_ride_length_by_dayofweek <- trip22_df %>% group_by(member_casual, day_of_week) %>% 
      summarise(average_ride_length = mean(ride_length))

    ## `summarise()` has grouped output by 'member_casual'. You can override using the
    ## `.groups` argument.

    average_ride_length_by_month <- trip22_df %>% group_by(member_casual, month) %>% 
      summarise(average_ride_length = mean(ride_length))

    ## `summarise()` has grouped output by 'member_casual'. You can override using the
    ## `.groups` argument.

    average_ride_length_by_season <- trip22_df %>% group_by(member_casual, season) %>% 
      summarise(average_ride_length = mean(ride_length))

    ## `summarise()` has grouped output by 'member_casual'. You can override using the
    ## `.groups` argument.

    print(average_ride_length_by_hour)

    ## # A tibble: 48 × 3
    ## # Groups:   member_casual [2]
    ##    member_casual  hour average_ride_length
    ##    <chr>         <int>               <dbl>
    ##  1 casual            0                21.2
    ##  2 casual            1                24.0
    ##  3 casual            2                22.4
    ##  4 casual            3                22.0
    ##  5 casual            4                19.7
    ##  6 casual            5                16.5
    ##  7 casual            6                17.1
    ##  8 casual            7                15.4
    ##  9 casual            8                17.9
    ## 10 casual            9                23.8
    ## # ℹ 38 more rows

    print(average_ride_length_by_timeofday)

    ## # A tibble: 8 × 3
    ## # Groups:   member_casual [2]
    ##   member_casual time_of_day average_ride_length
    ##   <chr>         <chr>                     <dbl>
    ## 1 casual        Afternoon                  26.6
    ## 2 casual        Evening                    22.4
    ## 3 casual        Morning                    23.6
    ## 4 casual        Night                      21.2
    ## 5 member        Afternoon                  12.7
    ## 6 member        Evening                    13.1
    ## 7 member        Morning                    11.6
    ## 8 member        Night                      12.4

    print(average_ride_length_by_dayofweek)

    ## # A tibble: 14 × 3
    ## # Groups:   member_casual [2]
    ##    member_casual day_of_week average_ride_length
    ##    <chr>         <chr>                     <dbl>
    ##  1 casual        Friday                     22.4
    ##  2 casual        Monday                     24.8
    ##  3 casual        Saturday                   26.8
    ##  4 casual        Sunday                     27.2
    ##  5 casual        Thursday                   21.4
    ##  6 casual        Tuesday                    21.4
    ##  7 casual        Wednesday                  20.7
    ##  8 member        Friday                     12.2
    ##  9 member        Monday                     12.0
    ## 10 member        Saturday                   14.0
    ## 11 member        Sunday                     13.9
    ## 12 member        Thursday                   12.0
    ## 13 member        Tuesday                    11.8
    ## 14 member        Wednesday                  11.8

    print(average_ride_length_by_month)

    ## # A tibble: 24 × 3
    ## # Groups:   member_casual [2]
    ##    member_casual month    average_ride_length
    ##    <chr>         <chr>                  <dbl>
    ##  1 casual        April                   25.9
    ##  2 casual        August                  23.3
    ##  3 casual        December                14.8
    ##  4 casual        February                24.8
    ##  5 casual        January                 27.5
    ##  6 casual        July                    25.1
    ##  7 casual        June                    25.0
    ##  8 casual        March                   28.4
    ##  9 casual        May                     27.7
    ## 10 casual        November                17.2
    ## # ℹ 14 more rows

    print(average_ride_length_by_season)

    ## # A tibble: 8 × 3
    ## # Groups:   member_casual [2]
    ##   member_casual season average_ride_length
    ##   <chr>         <chr>                <dbl>
    ## 1 casual        Autumn                20.6
    ## 2 casual        Spring                27.4
    ## 3 casual        Summer                24.5
    ## 4 casual        Winter                20.1
    ## 5 member        Autumn                11.9
    ## 6 member        Spring                12.4
    ## 7 member        Summer                13.4
    ## 8 member        Winter                10.4

    #Calculate total rides for various categories of time
    number_of_rides_hour <- trip22_df %>% group_by(member_casual, hour) %>% count(member_casual)
    number_of_rides_timeofday <- trip22_df %>% group_by(member_casual, time_of_day) %>% count(member_casual)
    number_of_rides_dayofweek <- trip22_df %>% group_by(member_casual, day_of_week) %>% count(member_casual)
    number_of_rides_month <- trip22_df %>% group_by(member_casual, month) %>% count(member_casual)
    number_of_rides_season <- trip22_df %>% group_by(member_casual,season) %>% count(member_casual)

    colnames(number_of_rides_hour)[3] <- "number_of_riders"
    colnames(number_of_rides_timeofday)[3] <- "number_of_riders"
    colnames(number_of_rides_dayofweek)[3] <- "number_of_riders"
    colnames(number_of_rides_month)[3] <- "number_of_riders"
    colnames(number_of_rides_season)[3] <- "number_of_riders"

    print(number_of_rides_hour)

    ## # A tibble: 48 × 3
    ## # Groups:   member_casual, hour [48]
    ##    member_casual  hour number_of_riders
    ##    <chr>         <int>            <int>
    ##  1 casual            0            33307
    ##  2 casual            1            21320
    ##  3 casual            2            12670
    ##  4 casual            3             7199
    ##  5 casual            4             4659
    ##  6 casual            5             8417
    ##  7 casual            6            21677
    ##  8 casual            7            37863
    ##  9 casual            8            52231
    ## 10 casual            9            54608
    ## # ℹ 38 more rows

    print(number_of_rides_timeofday)

    ## # A tibble: 8 × 3
    ## # Groups:   member_casual, time_of_day [8]
    ##   member_casual time_of_day number_of_riders
    ##   <chr>         <chr>                  <int>
    ## 1 casual        Afternoon             637784
    ## 2 casual        Evening               517244
    ## 3 casual        Morning               341856
    ## 4 casual        Night                 261079
    ## 5 member        Afternoon             831354
    ## 6 member        Evening               774838
    ## 7 member        Morning               753577
    ## 8 member        Night                 250706

    print(number_of_rides_dayofweek)

    ## # A tibble: 14 × 3
    ## # Groups:   member_casual, day_of_week [14]
    ##    member_casual day_of_week number_of_riders
    ##    <chr>         <chr>                  <int>
    ##  1 casual        Friday                248776
    ##  2 casual        Monday                210738
    ##  3 casual        Saturday              367296
    ##  4 casual        Sunday                301264
    ##  5 casual        Thursday              229981
    ##  6 casual        Tuesday               196359
    ##  7 casual        Wednesday             203549
    ##  8 member        Friday                359961
    ##  9 member        Monday                375078
    ## 10 member        Saturday              338177
    ## 11 member        Sunday                297659
    ## 12 member        Thursday              415763
    ## 13 member        Tuesday               411135
    ## 14 member        Wednesday             412702

    print(number_of_rides_month)

    ## # A tibble: 24 × 3
    ## # Groups:   member_casual, month [24]
    ##    member_casual month    number_of_riders
    ##    <chr>         <chr>               <int>
    ##  1 casual        April               91889
    ##  2 casual        August             270074
    ##  3 casual        December            31502
    ##  4 casual        February            15143
    ##  5 casual        January             12521
    ##  6 casual        July               311649
    ##  7 casual        June               292053
    ##  8 casual        March               67150
    ##  9 casual        May                220232
    ## 10 casual        November            73533
    ## # ℹ 14 more rows

    print(number_of_rides_season)

    ## # A tibble: 8 × 3
    ## # Groups:   member_casual, season [8]
    ##   member_casual season number_of_riders
    ##   <chr>         <chr>             <int>
    ## 1 casual        Autumn           445750
    ## 2 casual        Spring           379271
    ## 3 casual        Summer           873776
    ## 4 casual        Winter            59166
    ## 5 member        Autumn           759359
    ## 6 member        Spring           611762
    ## 7 member        Summer           994439
    ## 8 member        Winter           244915

    #Calculate most popular starting station, separated by member type
    popular_starting_station_casual <- trip22_df %>% group_by(start_station_name) %>% 
      filter(member_casual == "casual") %>% 
      count(start_station_name) %>% 
      arrange(desc(n))
    colnames(popular_starting_station_casual)[2] <- "number_of_rides"

    popular_starting_station_member <- trip22_df %>% group_by(start_station_name) %>% 
      filter(member_casual == "member") %>% 
      count(start_station_name) %>% 
      arrange(desc(n))
    colnames(popular_starting_station_member)[2] <- "number_of_rides"

    print(popular_starting_station_casual)

    ## # A tibble: 1,454 × 2
    ## # Groups:   start_station_name [1,454]
    ##    start_station_name                 number_of_rides
    ##    <chr>                                        <int>
    ##  1 Streeter Dr & Grand Ave                      55054
    ##  2 DuSable Lake Shore Dr & Monroe St            30260
    ##  3 Millennium Park                              23948
    ##  4 Michigan Ave & Oak St                        23760
    ##  5 DuSable Lake Shore Dr & North Blvd           22156
    ##  6 Shedd Aquarium                               19421
    ##  7 Theater on the Lake                          17332
    ##  8 Wells St & Concord Ln                        14832
    ##  9 Dusable Harbor                               13270
    ## 10 Clark St & Armitage Ave                      12777
    ## # ℹ 1,444 more rows

    print(popular_starting_station_member)

    ## # A tibble: 1,384 × 2
    ## # Groups:   start_station_name [1,384]
    ##    start_station_name           number_of_rides
    ##    <chr>                                  <int>
    ##  1 Kingsbury St & Kinzie St               23518
    ##  2 Clark St & Elm St                      20575
    ##  3 Wells St & Concord Ln                  19671
    ##  4 Clinton St & Washington Blvd           18823
    ##  5 Loomis St & Lexington St               18247
    ##  6 Clinton St & Madison St                17995
    ##  7 University Ave & 57th St               17572
    ##  8 Ellis Ave & 60th St                    17496
    ##  9 Wells St & Elm St                      17493
    ## 10 Streeter Dr & Grand Ave                16204
    ## # ℹ 1,374 more rows

### Step 5: Share

To enhance the comprehensibility of our analysis for stakeholders and a
broader audience, we will employ Tableau to create clear and engaging
data visualisations. The code snippet below demonstrates the extraction
of our processed data as a CSV file for integration into the Tableau
interface:

    #Create new data frame to export for use in Tableau
    trip22_df_tableau <- trip22_df

    #Clean the data of columns that will not be used
    trip22_df_tableau <- trip22_df_tableau %>% select(-c(ride_id, start_station_id, end_station_id, 
                                                         end_station_name, started_at, ended_at, time))

    #Export data as a csv file
    write.csv(trip22_df_tableau, file = "cyclistic_2022_tableau.csv", row.names = FALSE)

#### 5.1 Tableau Dashboard

To effectively communicate our analysis findings, I will export the
cleaned dataset to Tableau, creating a user-friendly dashboard that
highlights trends and patterns in casual and member rider behaviour. The
public [dashboard
link](https://public.tableau.com/views/GoogleCapstoneProjectCaseStudy1FinalVersion/TableauDashboard?:language=en-US&:display_count=n&:origin=viz_share_link)
directs audiences to my interactive data visualisation dashboard on
Tableau, enabling stakeholders to easily interpret the insights. A
screenshot of the dashboard is also provided below for quick reference.

![](Images/Tableau_Dashboard.png)

### Step 6: Act

In the final stage of the data analysis process, we will summarise our
key findings and present to our stakeholders our recommendations based
on our data analysis and visualisations.

#### 6.1 Key Findings

Members had the most rides at 59.76% of total rides. The average ride
length was fairly consistent throughout the week and year. On the other
hand, Casual riders had greater fluctuations in average ride lengths,
with peaks occurring on Saturdays and during the season of Summer.
Overall, casual riders nearly doubled the average ride length of
members.

The most popular bike type across both members and casual riders was the
Classic Bike, which accounted for nearly 60% of total rides.
Interestingly, only Casual riders used the Docked Bike, which only
accounted for 4% of total rides. Despite this, docked bikes had an
average ride length of 50.71 minutes per ride, which more than doubled
the total average ride length.

Both members and casual riders rode in the afternoons (12-5pm) most
frequently. 5-6pm was the busiest hour and 4am saw the least amount of
usage for Cyclistic bikes. Summer (June-August) was the busiest season
for both groups of riders, with July being the peak month. The winter
months saw the least amount of bike usage.

Lastly, Streeter Dr & Grand Ave was the most popular starting station
for all riders and for casual riders as well. Kingsbury St & Kinzie St
was the most popular starting station for member riders. Starting
station popularity also indicated that casual riders prefer riding along
the waterfront while member riders prefer riding within the inner CBD
area of Chicago.

#### 6.2 Recommendations

Upon analysing the data between the behaviours of casual and member
riders, several strategic opportunities have emerged to drive the
conversion of casual riders into Cyclistic members. The following
recommendations are proposed:

1.  Launch marketing campaigns tailored for casual riders in the prelude
    to summer.
2.  Introduce weekday membership discounts while adjusting weekend
    single-ride and single-day pass prices to incentivise casual riders
    to opt for subscriptions.
3.  Concentrate marketing efforts along the coastal regions, where
    casual riders are predominantly located.
4.  Introduce a new membership tier for summer and/or weekend year-long
    memberships to boost the conversion rate of casual riders to
    Cyclistic members.

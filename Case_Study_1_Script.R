# ---------------------------------------CODE SCRIPT FOR CASE STUDY 1 --------------------------------------------

#Install the necessary packages into RStudio
install.packages("tidyverse")

#Load the necessary Libraries into RStudio
library(tidyverse) #for calculations
library(dplyr) #for managing data frames
library(lubridate) #for manipulation of dates
library(hms) #for manipulation of time
library(readr) #for uploading .csv files into R

#Load original .csv bicycle data into R - from Jan 2022 to Dec 2022
jan22_df <- read_csv("202201-divvy-tripdata.csv")
feb22_df <- read_csv("202202-divvy-tripdata.csv")
mar22_df <- read_csv("202203-divvy-tripdata.csv")
apr22_df <- read_csv("202204-divvy-tripdata.csv")
may22_df <- read_csv("202205-divvy-tripdata.csv")
jun22_df <- read_csv("202206-divvy-tripdata.csv")
jul22_df <- read_csv("202207-divvy-tripdata.csv")
aug22_df <- read_csv("202208-divvy-tripdata.csv")
sep22_df <- read_csv("202209-divvy-tripdata.csv")
oct22_df <- read_csv("202210-divvy-tripdata.csv")
nov22_df <- read_csv("202211-divvy-tripdata.csv")
dec22_df <- read_csv("202212-divvy-tripdata.csv")

#Convert jan_df dates into a timestamp
jan22_df <- jan22_df %>%  mutate(ended_at = as_datetime(ended_at, format = "%d/%m/%Y %H:%M"), 
                                   started_at = as_datetime(started_at, format = "%d/%m/%Y %H:%M"))

#Combine monthly data frames into a new data frame
trip22_df <- rbind(jan22_df, feb22_df, mar22_df, apr22_df, may22_df, jun22_df, jul22_df, aug22_df, sep22_df, 
                   oct22_df, nov22_df, dec22_df)

#Preview new data frame
str(trip22_df)

#Remove monthly data frames
rm(jan22_df, feb22_df, mar22_df, apr22_df, may22_df, jun22_df, jul22_df, aug22_df, sep22_df, oct22_df, nov22_df,
   dec22_df)

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

#Clean data
trip22_df <- trip22_df %>% distinct() #remove duplicate rows
trip22_df <- drop_na(trip22_df) #remove empty rows and NA values
trip22_df <- trip22_df[trip22_df$ride_length > 0, ] #remove negative and zero values

#----------------------------ANALYSIS OF DATA----------------------------------------------------

#Calculate total average ride length
total_average_ride_length <- mean(trip22_df$ride_length)
print(total_average_ride_length)

#Calculate average ride length for each member type
average_ride_length_membertype <- trip22_df %>% group_by(member_casual) %>% summarise(average_ride_length = 
                                                                                        mean(ride_length))
print(average_ride_length_membertype)

#Determine number of casual riders vs Cyclistic members
number_of_rider_groupings <- trip22_df %>% group_by(member_casual) %>% count(member_casual)
colnames(number_of_rider_groupings)[2] <- "number_of_riders"
print(number_of_rider_groupings)

#Determine number of riders for each bike type, separated by member type
bike_type_riders <- trip22_df %>% group_by(member_casual,rideable_type) %>% count(member_casual)
colnames(bike_type_riders)[3] <- "number_of_riders"
print(bike_type_riders)

#Calculate average ride length for each bike type, separated by member type
bike_type_average_ride <- trip22_df %>% group_by(member_casual,rideable_type) %>% summarise(average_ride_length =
                                                                                              mean(ride_length))
print(bike_type_average_ride)

#Calculate average ride length for various categories of time
average_ride_length_by_hour <- trip22_df %>% group_by(member_casual, hour) %>% 
  summarise(average_ride_length = mean(ride_length))
average_ride_length_by_timeofday <- trip22_df %>% group_by(member_casual, time_of_day) %>% 
  summarise(average_ride_length = mean(ride_length))
average_ride_length_by_dayofweek <- trip22_df %>% group_by(member_casual, day_of_week) %>% 
  summarise(average_ride_length = mean(ride_length))
average_ride_length_by_month <- trip22_df %>% group_by(member_casual, month) %>% 
  summarise(average_ride_length = mean(ride_length))
average_ride_length_by_season <- trip22_df %>% group_by(member_casual, season) %>% 
  summarise(average_ride_length = mean(ride_length))

print(average_ride_length_by_hour)
print(average_ride_length_by_timeofday)
print(average_ride_length_by_dayofweek)
print(average_ride_length_by_month)
print(average_ride_length_by_season)

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
print(number_of_rides_timeofday)
print(number_of_rides_dayofweek)
print(number_of_rides_month)
print(number_of_rides_season)

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
print(popular_starting_station_member)

#----------------------------EXTRACT DATA FOR TABLEAU----------------------------------------------------

#Create new data frame to export for use in Tableau
trip22_df_tableau <- trip22_df

#Clean the data of columns that will not be used
trip22_df_tableau <- trip22_df_tableau %>% select(-c(ride_id, start_station_id, end_station_id, 
                                                     end_station_name, started_at, ended_at, time))

#Export data as a csv file
write.csv(trip22_df_tableau, file = "cyclistic_2022_tableau.csv", row.names = FALSE)

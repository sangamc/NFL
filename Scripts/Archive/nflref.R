# Library ----
require(XML)
require(stringr)
require(lme4)
require(dtplyr)
require(dplyr)
require(RCurl)
require(data.table)
require(rvest)
require(zoo)

# NFL Project ----
today <- Sys.Date()

# Load Schedule ----
url <- "http://www.pro-football-reference.com/years/2015/games.htm"

doc <- htmlParse(url)
links <- xpathSApply(doc, "//a/@href")
free(doc)
links <- Filter(function(x) grepl("boxscores/20", x), links)

url_base <- "http://www.pro-football-reference.com"
urls <-paste0(url_base, links)

bbref <-data.frame()
for(i in 1:length(links)){
  url <- paste0(url_base, links[i])
  print(url)
  tbl <- readHTMLTable(url)
  ## missing the rest
}

# New method -----
library(XML)
weeklystats=as.data.frame(matrix(ncol=14)) # Initializing our empty dataframe

names(weeklystats) = c("Week", "Day", "Date", "Blank", "Win.Team", "At", "Lose.Team", "Points.Win", "Points.Lose", "YardsGained.Win", "Turnovers.Win", "YardsGained.Lose","Turnovers.Lose","Year") # Naming columns

URLpart1="http://www.pro-football-reference.com/years/" 
URLpart3 ="/games.htm" 

#### Our workhorse function ####

getData=function(URLpart1,URLpart3){
  for (i in 2014:2015){
    URL=paste(URLpart1,as.character(i),URLpart3,sep="")
    tablefromURL = readHTMLTable(URL)
    table=tablefromURL[[1]]
    names(table) = c("Week", "Day", "Date", "Blank", "Win.Team", "At", "Lose.Team", 
                     "Points.Win", "Points.Lose", "YardsGained.Win", "Turnovers.Win", 
                     "YardsGained.Lose","Turnovers.Lose")
    table$Year=i # Inserting a value for the year 
    weeklystats=rbind(table,weeklystats)  # Appending happening here
  }
  return(weeklystats)
}
weeklystats=getData(URLpart1,URLpart3) # Calling on our workhorse to do its job and saving the raw data results in weeklystats
save(weeklystats,file="rawweeklystats.rda")
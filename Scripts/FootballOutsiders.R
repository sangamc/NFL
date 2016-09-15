# Libraries ----
require(XML)
require(RCurl)
require(data.table)
require(zoo)
require(plyr)
require(dplyr)

# TEAM ----
url <- "http://www.footballoutsiders.com/stats/teamoff"
tbl <- readHTMLTable(url)
team.off <- data.table()
team.off <- rbind(team.off,tbl[[1]])
team.off <- team.off[-c(1,18,19)]

url <- "http://www.footballoutsiders.com/stats/teameff"
tbl <- readHTMLTable(url)
team.eff <- data.table()
team.eff <- rbind(team.eff,tbl[[1]])
team.eff <- team.eff[-c(17)]

url <- "http://www.footballoutsiders.com/stats/teamdef"
tbl <- readHTMLTable(url)
team.def <- data.table()
team.def <- rbind(team.def,tbl[[1]])
team.def <- team.def[-c(1,18,19)]

url <- "http://www.footballoutsiders.com/stats/teamst"
tbl <- readHTMLTable(url)
team.st <- data.table()
team.st <- rbind(team.st,tbl[[1]])
team.st <- team.st[-c(18,19)]

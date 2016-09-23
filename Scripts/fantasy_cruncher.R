# Libraries ----
require(splitstackshape) # csplit command
require(XML)
require(RCurl)
require(zoo)
require(plyr)
require(dtplyr)

## WEEK 3 ##
index <- read.csv("index.csv")

url <- "https://www.fantasycruncher.com/lineup-rewind/draftkings/NFL/2016-week-3"
tbl <- readHTMLTable(getURL(url, ssl.verifyPeer=FALSE), stringsAsFactors = F)
stats <- data.frame()
stats <- tbl$ff
stats <- stats[,-c(12)]
colnames(stats)[1] <- "Player"
colnames(stats)[5] <- "DvP"
colnames(stats)[9] <- "Avg_2015"
colnames(stats)[12] <- "Cons"
colnames(stats)[14] <- "A.Score"
colnames(stats)[15] <- "A.Val"
stats$index <- index$playerId[match(stats$Player, index$FCName)]
stats <- subset(stats, select = c(16,1:15))
#write.csv(stats.preseason2, "Preseason/3stats.FC.csv", row.names = FALSE)

week3.own <- fread("data/ownership/week3/week3.csv", encoding = "UTF-8", select = (8:9))
week3.own[week3.own==""] <- NA
week3.own <- na.omit(week3.own)
week3.own$`%Drafted` <- as.numeric(gsub("%", "", as.matrix(week3.own$`%Drafted`)))
week3.own$index <- index$playerId[match(week3.own$Player, index$OwnName)]

fcrunch <- read.csv("data/fcruncher upload.csv", encoding = "UTF-8")

stats$Own <- week3.own$`%Drafted`[match(stats$index, week3.own$index)]
stats[,6] <- apply(stats[,6,drop = FALSE],2, function(x) gsub("rd","",x))
stats[,6] <- apply(stats[,6,drop = FALSE],2, function(x) gsub("st","",x))
stats[,6] <- apply(stats[,6,drop = FALSE],2, function(x) gsub("nd","",x))
stats[,6] <- apply(stats[,6,drop = FALSE],2, function(x) gsub("th","",x))
stats[,6] <- apply(stats[,6],2,as.numeric)

stats$`My Proj` <- fcrunch$FP[match(stats$index, fcrunch$index)]
write.csv(stats, "data/history/week3_final.csv", row.names = FALSE)

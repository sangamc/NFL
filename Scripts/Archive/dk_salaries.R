require(splitstackshape) # required for csplit
require(XML)
require(data.table)
require(dplyr)
require(RCurl)


#
## DK Salaries 
#
Salaries <- data.frame()
Salaries <- read.csv("DKSalaries.csv", encoding = "UTF-8")
colnames(Salaries)[1] <- "Pos"
colnames(Salaries)[4] <- "Game Time"
colnames(Salaries)[5] <- "Avg"
colnames(Salaries)[6] <- "Team"
Salaries <- cSplit(Salaries, c("Game Time"), c(" "))
Salaries <- subset(Salaries, select = -c(`Game Time_3`))
colnames(Salaries)[6] <- "Game"
colnames(Salaries)[7] <- "Time"
Salaries <- subset(Salaries, select = c("Name", "Salary", "Pos", "Team", "Avg", "Game", "Time"))


#df <- Salaries[Salaries$Avg >= 15,]

url <- "https://www.fantasycruncher.com/lineup-rewind/draftkings/NFL/2016-preseason-1"
tbl <- readHTMLTable(getURL(url, ssl.verifyPeer=FALSE), stringsAsFactors = F)
stats.preseason1 <- tbl$ff
colnames(stats.preseason1)[1] <- "Name"


df <- Salaries
stats.preseason1$`Actual Val` <- as.numeric(stats.preseason1$`Actual Val`)
df$Av <- stats.preseason1$`Actual Score`[match(df$Name, stats.preseason1$Name)]

qb2 <- data.frame()
qb2 <- qb %>% mutate_at(grep("^(`?!`Player|Team|`?!`Pos).*$",colnames(.)),funs(as.numeric))

qb[,-c(1:3)] <- apply(qb[,-c(1:3)], 2, function(x) gsub("--|T", "", x))
qb[,-c(1:3)] <- apply(qb[,-c(1:3)], 2, as.numeric)

statspre.1 <- stats.preseason1
statspre.1[,-c(1:5)] <- apply(statspre.1[,-c(1:5)], 2, function(x) gsub(" ", 0, x))
statspre.1[,-c(1:5)] <- apply(statspre.1[,-c(1:5)], 2, as.numeric)

qb2 <- qb %>% mutate_at(grep("^(Player|Team|Pos)",colnames(.)),funs(factor)) %>%
  mutate_at(grep("^(`?!`Player|Team|`?!`Pos).*$",colnames(.)),funs(as.numeric))
qb2$Team <- stats.qb$Team[match(qb2$Player, stats.qb$Player)]

merge(df, olympics.ownership,by=c("Player", by="game"),all.x = TRUE)

qb2 <- qb %>% mutate_at(grep("^(Player|Team|Pos)",colnames(.)),funs(factor)) %>%
  mutate_at(!grep("^(Player|Team|Pos)",colnames(.)),funs(as.numeric))



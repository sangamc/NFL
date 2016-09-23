# Libraries ----
require(splitstackshape) # csplit command
require(XML)
require(RCurl)
require(zoo)
require(plyr)
require(dtplyr)

# team.off STATS ----
url <- "http://www.footballoutsiders.com/stats/teamoff"
tbl <- readHTMLTable(getURL(url), as.factor = FALSE)
team.off <- data.table()
team.off <- rbind(team.off,tbl[[1]])
team.off <- team.off[-c(1,18,19),]
team.off <- as.data.frame(apply(team.off,2,function(x) gsub("%","",x)))
team.off[,-c(1,2)] <- apply(team.off[,-c(1,2)],2,as.numeric)

# team.eff STATS ---- # Need to split WIN/LOSS column ----
url <- "http://www.footballoutsiders.com/stats/teameff"
tbl <- readHTMLTable(url)
team.eff <- data.table()
team.eff <- rbind(team.eff,tbl[[1]])
team.eff <- team.eff[-c(17)]
team.eff <- as.data.frame(apply(team.eff,2,function(x) gsub("%","",x)))
team.eff[,-c(1,2,6)] <- apply(team.eff[,-c(1,2,6)],2,as.numeric)

# team.def STATS ----
url <- "http://www.footballoutsiders.com/stats/teamdef"
tbl <- readHTMLTable(url)
team.def <- data.table()
team.def <- rbind(team.def,tbl[[1]])
team.def <- team.def[-c(1,18,19)]
team.def <- as.data.frame(apply(team.def,2,function(x) gsub("%","",x)))
team.def[,-c(1,2)] <- apply(team.def[,-c(1,2)],2,as.numeric)

# team.st STATS ----
url <- "http://www.footballoutsiders.com/stats/teamst"
tbl <- readHTMLTable(url)
team.st <- data.table()
team.st <- rbind(team.st,tbl[[1]])
team.st <- team.st[-c(1,18,19),]
colnames(team.st) <- c("RNK","TEAM","S.T.DVOA","LAST WK","WDVOA","WRANK","FG/XP","KICK","KICK RET",
                       "PUNT","PUNT RET","HID PTS","HID RANK","WEA PTS","WEA RANK","NON-ADJ VOA")
team.st <- as.data.frame(apply(team.st,2,function(x) gsub("%","",x)))
team.st[,-c(2,4)] <- apply(team.st[,-c(2,4)],2,as.numeric)
#team.st <- team.st[-c(18,19)]

# qb STATS ----
url <- "http://www.footballoutsiders.com/stats/qb"
tbl <- readHTMLTable(url)
team.qbp <- data.table()
team.qbp <- rbind(team.qbp,tbl[[1]])
team.qbp <- team.qbp[-c(17)]
team.qbp <- as.data.frame(apply(team.qbp,2,function(x) gsub("%","",x)))
team.qbp[,-c(1,2)] <- apply(team.qbp[,-c(1,2)],2,as.numeric)
team.qbr <- data.table()
team.qbr <- rbind(team.qbr,tbl[[2]])
team.qbr <- team.qbr[-c(13)]
team.qbr <- as.data.frame(apply(team.qbr,2,function(x) gsub("%","",x)))
team.qbr[,-c(1,2)] <- apply(team.qbr[,-c(1,2)],2,as.numeric)

# rb STATS ----
url <- "http://www.footballoutsiders.com/stats/rb"
tbl <- readHTMLTable(url)
team.rb1 <- data.table()
team.rb1 <- rbind(team.rb1,tbl[[1]])
team.rb1 <- team.rb1[-c(13,26)]
team.rb1 <- as.data.frame(apply(team.rb1,2,function(x) gsub("%","",x)))
team.rb1[,-c(1,2)] <- apply(team.rb1[,-c(1,2)],2,as.numeric)
team.rb2 <- data.table()
team.rb2 <- rbind(team.rb2,tbl[[2]])
team.rb2 <- team.rb2[-c(16)]
team.rb2 <- as.data.frame(apply(team.rb2,2,function(x) gsub("%","",x)))
team.rb2[,-c(1,2)] <- apply(team.rb2[,-c(1,2)],2,as.numeric)
team.rbr <- data.table()
team.rbr <- rbind(team.rbr,tbl[[3]])
team.rbr <- team.rbr[-c(15)]
team.rbr <- as.data.frame(apply(team.rbr,2,function(x) gsub("%","",x)))
team.rbr[,-c(1,2)] <- apply(team.rbr[,-c(1,2)],2,as.numeric)
team.rbr2 <- data.table()
team.rbr2 <- rbind(team.rbr2,tbl[[4]])
team.rbr2 <- team.rbr2[-c(15)]
team.rbr2 <- as.data.frame(apply(team.rbr2,2,function(x) gsub("%","",x)))
team.rbr2[,-c(1,2)] <- apply(team.rbr2[,-c(1,2)],2,as.numeric)

# wr STATS ----
url <- "http://www.footballoutsiders.com/stats/wr"
tbl <- readHTMLTable(url)
team.wr1 <- data.table()
team.wr1 <- rbind(team.wr1,tbl[[1]])
team.wr1 <- team.wr1[-c(16,32,48,64)]
team.wr1 <- as.data.frame(apply(team.wr1,2,function(x) gsub("%","",x)))
team.wr1[,-c(1,2,13)] <- apply(team.wr1[,-c(1,2,13)],2,as.numeric)
team.wr2 <- data.table()
team.wr2 <- rbind(team.wr2,tbl[[2]])
team.wr2 <- team.wr2[-c(16)]
team.wr2 <- as.data.frame(apply(team.wr2,2,function(x) gsub("%","",x)))
team.wr2[,-c(1,2,11)] <- apply(team.wr2[,-c(1,2,11)],2,as.numeric)
team.wrr <- data.table()
team.wrr <- rbind(team.wrr,tbl[[3]])
team.wrr <- as.data.frame(apply(team.wrr,2,function(x) gsub("%","",x)))
team.wrr[,-c(1,2)] <- apply(team.wrr[,-c(1,2)],2,as.numeric)

# te STATS ----
url <- "http://www.footballoutsiders.com/stats/te"
tbl <- readHTMLTable(url)
team.te1 <- data.table()
team.te1 <- rbind(team.te1,tbl[[1]])
team.te1 <- team.te1[-c(14)]
team.te1 <- as.data.frame(apply(team.te1,2,function(x) gsub("%","",x)))
team.te1[,-c(1,2,13)] <- apply(team.te1[,-c(1,2,13)],2,as.numeric)
team.te2 <- data.table()
team.te2 <- rbind(team.te2,tbl[[2]])
team.te2 <- as.data.frame(apply(team.te2,2,function(x) gsub("%","",x)))
team.te2[,-c(1,2,11)] <- apply(team.te2[,-c(1,2,11)],2,as.numeric)

# oline STATS 2015 (will be updated after week 2) ----
url <- "http://www.footballoutsiders.com/stats/ol"
tbl <- readHTMLTable(url)
team.ol1 <- data.table()
team.ol1 <- rbind(team.ol1,tbl[[1]])
team.ol1 <- team.ol1[-c(1,18,19),]
colnames(team.ol1)  <- c("RNK","Team","Adj.Line Yards","RB Yards","Power Success","Power Rank","Stuffed","Stuffed Rank",
                         "2nd Level Yards","2nd Level Rank","Open Field Yards","Open Field Rank",
                         "PASS Team","PASS Rank","Sacks","Adjusted Sack Rate")
team.ol1 <- as.data.frame(apply(team.ol1,2,function(x) gsub("%","",x)))
team.ol1[,-c(1,2,13)] <- apply(team.ol1[,-c(1,2,13)],2,as.numeric)
team.ol2 <- data.table()
team.ol2 <- rbind(team.ol2,tbl[[2]])
team.ol2 <- team.ol2[-c(1,18,19),]
colnames(team.ol2)  <- c("RNK","TEAM","LE-ALY","LE-Rank","LT-ALY","LT-Rank","M/G-ALY","M/G-Rank","RT-ALY","RT-Rank","RE-ALY","RE-Rank")
team.ol2 <- as.data.frame(apply(team.ol2,2,function(x) gsub("%","",x)))
team.ol2[,-c(1,2)] <- apply(team.ol2[,-c(1,2)],2,as.numeric)
team.ol3 <- data.table()
team.ol3 <- rbind(team.ol3,tbl[[3]])
team.ol3 <- team.ol3[-c(17),]
team.ol3 <- as.data.frame(apply(team.ol3,2,function(x) gsub("%","",x)))
team.ol3[,-c(1,2)] <- apply(team.ol3[,-c(1,2)],2,as.numeric)

# dline STATS 2015 (will be updated after week 2) ----
url <- "http://www.footballoutsiders.com/stats/dl"
tbl <- readHTMLTable(url)
team.dl1 <- data.table()
team.dl1 <- rbind(team.dl1,tbl[[1]])
team.dl1<- team.dl1[-c(1,18,19),]
colnames(team.dl1)  <- c("RNK","Team","Adj.Line Yards","RB Yards","Power Success","Power Rank","Stuffed","Stuffed Rank",
                         "2nd Level Yards","2nd Level Rank","Open Field Yards","Open Field Rank",
                         "PASS Team","PASS Rank","Sacks","Adjusted Sack Rate")
team.dl1<- as.data.frame(apply(team.dl1,2,function(x) gsub("%","",x)))
team.dl1[,-c(1,2,13)] <- apply(team.dl1[,-c(1,2,13)],2,as.numeric)
team.dl2 <- data.table()
team.dl2 <- rbind(team.dl2,tbl[[2]])
team.dl2 <- team.dl2[-c(1,18,19),]
colnames(team.dl2)  <- c("RNK","TEAM","LE-ALY","LE-Rank","LT-ALY","LT-Rank","M/G-ALY","M/G-Rank","RT-ALY","RT-Rank","RE-ALY","RE-Rank")
team.dl2 <- as.data.frame(apply(team.dl2,2,function(x) gsub("%","",x)))
team.dl2[,-c(1,2)] <- apply(team.dl2[,-c(1,2)],2,as.numeric)
team.dl3 <- data.table()
team.dl3 <- rbind(team.dl3,tbl[[3]])
team.dl3 <- team.dl3[-c(17),]
team.dl3 <- as.data.frame(apply(team.dl3,2,function(x) gsub("%","",x)))
team.dl3[,-c(1,2)] <- apply(team.dl3[,-c(1,2)],2,as.numeric)






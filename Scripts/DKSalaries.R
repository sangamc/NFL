require(splitstackshape) # required for csplit
require(XML)
require(dtplyr)
require(RCurl)

index <- read.csv("index.csv")

#
## DK Salaries ----
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
Salaries$Team <- sapply(Salaries$Team, function(x) toupper(x))
Salaries <- subset(Salaries, select = c("Name", "Salary", "Pos", "Team", "Avg", "Game", "Time"))
Salaries$index <- as.factor(index$playerId[match(Salaries$Name, index$DKNAME)])

#
## RotoWorld Injury report ----
#
injuryURL <- "http://www.rotoworld.com/teams/injuries/nfl/all/"
injuryTable <- readHTMLTable(getURL(injuryURL),stringsAsFactors=FALSE,header=TRUE)
injuryTable <- injuryTable[!unlist(lapply(injuryTable,is.null))]
injuryTable <- Reduce(rbind, injuryTable)
injuryTable <- injuryTable[,-c(2:6)]

#
## FFanalytics Projections ----
#
projections <- data.frame()
projections <- read.csv("data/FFA_Projections.csv", encoding = "UTF-8", row.names = NULL)
projections <- subset(projections[ ,c(1,3:5,9,13,16,20:22)])
colnames(projections) <- c("index","Name","Pos","Team","FP","Rnk","Drop","Ceiling","Floor","Risk")
#projections$Name <- index$DKNAME[match(projections$ID, index$playerId)]
projections[,4] <- apply(projections[,4,drop = FALSE],2, function(x) gsub("JAC","JAX",x))
projections <- projections[!projections$Team == 'FA',]
#projections <- projections[!projections$FP < 1,]
df <- merge(Salaries, projections, by=c("index" ), all.x = TRUE)
df <- subset(df, select= c(2,12,4,5,3,6:8,13:17,1))
df <- na.omit(df)
colnames(df)[1] <- "Name"
colnames(df)[3] <- "Pos"
colnames(df)[4] <- "Team"
write.csv(df, "data/fcruncher upload.csv", row.names = FALSE)

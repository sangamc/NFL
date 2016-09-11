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
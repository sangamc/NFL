### This file scrapes and processes data from rotoguru.net. 
### Specifically, weekly salary and fantasy point results 
### for DraftKings in 2014


library(XML)

rotoGuruProcess <- function(weekResults, weekNumber){
    ### The table that comes from RotoGuru is separated out by position - that's dealt with
    ### Also add variables for position and week so all data can be combined
    ### Lastly, the salary column needs reformatted so it can be used as a number
    
    weekResults$position <- 'd'
    weekResults$week <- weekNumber
    qb <- weekResults$V1 == 'Quarterbacks'
    
    rb <- weekResults$V1 == 'Running Backs'
    
    wr <- weekResults$V1 == 'Wide Receivers'
    te <- weekResults$V1 == 'Tight Ends'
    k <- weekResults$V1 == 'Kickers'
    d <- weekResults$V1 == 'Defenses'
    names(weekResults) <- c('name', 'team', 'opp', 'points', 'salary', 'position', 'week')
    
    weekResults$position[which(qb):which(rb)] <- 'qb'
    weekResults$position[which(rb):which(wr)] <- 'rb'
    weekResults$position[which(wr):which(te)] <- 'wr'
    weekResults$position[which(te):which(k)] <- 'te'
    
    playerRows <- weekResults$team !="Team"
    
    weekResults <- weekResults[playerRows,]
    weekResults$salary <- gsub('$', "", weekResults$salary, fixed=TRUE)
    weekResults$salary <- gsub(',', "", weekResults$salary, fixed=TRUE)
    head(weekResults)
    weekResults$salary <- as.numeric(weekResults$salary)
    
    return (weekResults)
}

week1 <- readHTMLTable('http://rotoguru1.com/cgi-bin/fyday.pl?week=1&game=dk', stringsAsFactors = FALSE)


nfl1 <- week1[[7]]

final2015 <- rotoGuruProcess(nfl1,1)

# Once we have a base, loop through the remaining weeks, process them and rbind to the master

for (i in 2:17){
    url <- paste0('http://rotoguru1.com/cgi-bin/fyday.pl?week=', i, '&game=dk')
    thisWeek <- readHTMLTable(url, stringsAsFactors = FALSE)
    thisWeek <- thisWeek[[7]]
    processWeek <- rotoGuruProcess(thisWeek, i)
    final2015 <- rbind(final2015, processWeek)
}

# Cleaning up names of players and eliminating NA values

final2015$name <- gsub(',', '', final2015$name)

final2015 <- final2015[complete.cases(final2015),]

write.table(final2015, file='draftKingsSalaryResults.csv', sep = ',', row.names = FALSE)

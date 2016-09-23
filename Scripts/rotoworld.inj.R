require(splitstackshape) # required for csplit
require(XML)
require(dtplyr)
require(RCurl)

injuryURL <- "http://www.rotoworld.com/teams/injuries/nfl/all/"
injuryTable <- readHTMLTable(getURL(injuryURL),stringsAsFactors=FALSE,header=TRUE)
injuryTable <- injuryTable[!unlist(lapply(injuryTable,is.null))]
injuryTable <- Reduce(rbind, injuryTable)
injuryTable <- injuryTable[,-c(2:6)]
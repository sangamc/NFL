url <- "https://www.fantasycruncher.com/lineup-rewind/draftkings/NFL/2016-preseason-3"
tbl <- readHTMLTable(getURL(url, ssl.verifyPeer=FALSE), stringsAsFactors = F)
stats.preseason2 <- tbl$ff
colnames(stats.preseason2)[1] <- "Name"

write.csv(stats.preseason2, "Preseason/3stats.FC.csv", row.names = FALSE)


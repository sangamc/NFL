require(XML)
require(data.table)
require(dplyr)


#
## Quaterbacks
#
qburl <- c("http://www.nfl.com/stats/categorystats?archive=false&conference=null&statisticPositionCategory=QUARTERBACK&season=2016&seasonType=PRE&experience=&tabSeq=1&qualified=true",
           "http://www.nfl.com/stats/categorystats?tabSeq=1&season=2016&seasonType=PRE&d-447263-p=2&statisticPositionCategory=QUARTERBACK&qualified=true",
           "http://www.nfl.com/stats/categorystats?tabSeq=1&season=2016&seasonType=PRE&d-447263-p=3&statisticPositionCategory=QUARTERBACK&qualified=true")

stats.qb <- data.frame()
for(i in 1:length(qburl)){
  url <- qburl[i]
  print(url)
  tbl <- readHTMLTable(getURL(url, ssl.verifyPeer=FALSE), stringsAsFactors = F)
  stats.qb <- rbind(stats.qb, tbl[[1]])
}
stats.qb <- stats.qb[,-1]
#
## Running Backs
#
rburl <- c("http://www.nfl.com/stats/categorystats?archive=false&conference=null&statisticPositionCategory=RUNNING_BACK&season=2016&seasonType=PRE&experience=&tabSeq=1&qualified=true",
           "http://www.nfl.com/stats/categorystats?tabSeq=1&season=2016&seasonType=PRE&Submit=Go&experience=&archive=false&d-447263-p=2&conference=null&statisticPositionCategory=RUNNING_BACK&qualified=true",
           "http://www.nfl.com/stats/categorystats?tabSeq=1&season=2016&seasonType=PRE&experience=&Submit=Go&archive=false&conference=null&d-447263-p=3&statisticPositionCategory=RUNNING_BACK&qualified=true",
           "http://www.nfl.com/stats/categorystats?tabSeq=1&season=2016&seasonType=PRE&experience=&Submit=Go&archive=false&conference=null&d-447263-p=4&statisticPositionCategory=RUNNING_BACK&qualified=true")

stats.rb <- data.frame()
for(i in 1:length(rburl)){
  url <- rburl[i]
  print(url)
  tbl <- readHTMLTable(getURL(url, ssl.verifyPeer=FALSE), stringsAsFactors = F)
  stats.rb <- rbind(stats.rb, tbl[[1]])
}
stats.rb <- stats.rb[,-1]
#
## Wide Recievers
#
wrurl <- c("http://www.nfl.com/stats/categorystats?archive=false&conference=null&statisticPositionCategory=WIDE_RECEIVER&season=2016&seasonType=PRE&experience=&tabSeq=1&qualified=true",
           "http://www.nfl.com/stats/categorystats?tabSeq=1&season=2016&seasonType=PRE&experience=&Submit=Go&archive=false&d-447263-p=2&conference=null&statisticPositionCategory=WIDE_RECEIVER&qualified=true",
           "http://www.nfl.com/stats/categorystats?tabSeq=1&season=2016&seasonType=PRE&experience=&Submit=Go&archive=false&conference=null&d-447263-p=3&statisticPositionCategory=WIDE_RECEIVER&qualified=true",
           "http://www.nfl.com/stats/categorystats?tabSeq=1&season=2016&seasonType=PRE&experience=&Submit=Go&archive=false&conference=null&d-447263-p=4&statisticPositionCategory=WIDE_RECEIVER&qualified=true",
           "http://www.nfl.com/stats/categorystats?tabSeq=1&season=2016&seasonType=PRE&experience=&Submit=Go&archive=false&conference=null&d-447263-p=5&statisticPositionCategory=WIDE_RECEIVER&qualified=true",
           "http://www.nfl.com/stats/categorystats?tabSeq=1&season=2016&seasonType=PRE&experience=&Submit=Go&archive=false&d-447263-p=6&conference=null&statisticPositionCategory=WIDE_RECEIVER&qualified=true",
           "http://www.nfl.com/stats/categorystats?tabSeq=1&season=2016&seasonType=PRE&Submit=Go&experience=&archive=false&conference=null&d-447263-p=7&statisticPositionCategory=WIDE_RECEIVER&qualified=true")

stats.wr <- data.frame()
for(i in 1:length(wrurl)){
  url <- wrurl[i]
  print(url)
  tbl <- readHTMLTable(getURL(url, ssl.verifyPeer=FALSE), stringsAsFactors = F)
  stats.wr <- rbind(stats.wr, tbl[[1]])
}
stats.wr <- stats.wr[,-1]
#
## Tight Ends
#
teurl <- c("http://www.nfl.com/stats/categorystats?archive=false&conference=null&statisticPositionCategory=TIGHT_END&season=2016&seasonType=PRE&experience=&tabSeq=1&qualified=true",
           "http://www.nfl.com/stats/categorystats?tabSeq=1&season=2016&seasonType=PRE&Submit=Go&experience=&archive=false&d-447263-p=2&conference=null&statisticPositionCategory=TIGHT_END&qualified=true",
           "http://www.nfl.com/stats/categorystats?tabSeq=1&season=2016&seasonType=PRE&experience=&Submit=Go&archive=false&conference=null&d-447263-p=3&statisticPositionCategory=TIGHT_END&qualified=true")

stats.te <- data.frame()
for(i in 1:length(teurl)){
  url <- teurl[i]
  print(url)
  tbl <- readHTMLTable(getURL(url, ssl.verifyPeer=FALSE), stringsAsFactors = F)
  stats.te <- rbind(stats.te, tbl[[1]])
}
stats.te <- stats.te[,-1]



write.csv(stats.wr, "Preseason/3stats.wr.csv", row.names = FALSE)
write.csv(stats.te, "Preseason/3stats.te.csv", row.names = FALSE)
write.csv(stats.rb, "Preseason/3stats.rb.csv", row.names = FALSE)
write.csv(stats.qb, "Preseason/3stats.qb.csv", row.names = FALSE)


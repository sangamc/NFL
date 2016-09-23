# Load the stattleshipR package ----
require(stattleshipR)
require(dplyr)
require(ggplot2)
source("scripts/stattleship_token.r")

# Players ----
sport <- 'football'  
league <- 'nfl'  
ep <- 'players'  
q_body <- list(interval_type='regular season')
pls <- ss_get_result(sport=sport, league=league, ep=ep, query=q_body, walk=TRUE)  
players<-do.call('rbind', lapply(pls, function(x) x$players))
players <- players[ ,-c(2,3,5:11,13:17,23:26,28:30,32,34)]
colnames(players)[1] <- 'player_id' 

# Teams ----
sport <- 'football'  
league <- 'nfl'  
ep <- 'teams'  
q_body <- list(interval_type='regular season')
tms <- ss_get_result(sport=sport, league=league, ep=ep, query=q_body, walk=TRUE)  
teams<-do.call('rbind', lapply(tms, function(x) x$teams))
colnames(teams)[1] <- 'team_id'
teams <- teams[ ,-c(2:8,11,12)]

# Scheduled games  ----
# Needs correct documentation
sport <- 'football'
league <- 'nfl'
ep <- 'games'
q_body <- list()
gms  <- ss_get_result(sport=sport, league=league, ep=ep, query=q_body, walk=TRUE) 
games <-do.call('rbind', lapply(gms, function(x) x$games)) 
 

# Player game logs ----
sport <- 'football'  
league <- 'nfl'  
ep <- 'game_logs' 
q_body <- list(interval_type='regular season') 
gls <- ss_get_result(sport=sport, league=league, ep=ep, query=q_body, walk=TRUE) 
length(gls)
game_logs<-do.call('rbind', lapply(gls, function(x) x$game_logs))  
colnames(game_logs)  # check available column names
game_logs <- merge(players, game_logs, by='player_id') 

# Team game logs ----
sport <- 'football'
league <- 'nfl'
ep <- 'team_game_logs'
q_body <- list()
tls  <- ss_get_result(sport=sport, league=league, ep=ep, query=q_body, walk=TRUE) 
team_game_logs <-do.call('rbind', lapply(tls, function(x) x$team_game_logs)) 
team_game_logs <- merge(teams, team_game_logs, by='team_id')

# Graphing Running backs ----
RB <- data.frame()
RB <-  game_logs %>%
  #filter(game_played == TRUE) %>%
  filter(position_abbreviation == "RB") %>%
  group_by(name) %>%
  summarise(Attempts=sum(rushes_attempts), Yards=sum(rushes_yards), TD=sum(rushes_touchdowns),
            `2pt`=sum(rushing_2pt_conversions_succeeded), Tgt=sum(receptions_looks), Rec=sum(receptions_total),
            RecYds=sum(receptions_yards), RecTD=sum(receptions_touchdowns),Fum=sum(fumbles_lost))

ggplot(RB, aes(x=Attempts, y=Yards, size=TD, label=name, color=TD)) + geom_text()
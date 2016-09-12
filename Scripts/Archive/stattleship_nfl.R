## Load the stattleshipR package
require(stattleshipR)
require(dplyr)
require(ggplot2)

set_token("1fcd74340384cb432a8157b7fdccef07")

# Player game logs ----
sport <- 'football'  
league <- 'nfl'  
ep <- 'game_logs' 
q_body <- list(interval_type='preseason') 

gls <- ss_get_result(sport=sport, league=league, ep=ep, query=q_body, walk=TRUE) 
length(gls)
game_logs<-do.call('rbind', lapply(gls, function(x) x$game_logs))  
colnames(game_logs)  # check available column names

## Players ----
sport <- 'football'  
league <- 'nfl'  
ep <- 'players'  
q_body <- list()

pls <- ss_get_result(sport=sport, league=league, ep=ep, query=q_body, walk=TRUE)  
players<-do.call('rbind', lapply(pls, function(x) x$players)) 

colnames(players)[1] <- 'player_id'  
game_logs <- merge(players, game_logs, by='player_id') 

# Scheduled games  ----
sport <- 'football'
league <- 'nfl'
ep <- 'games'
q_body <- list()

gms  <- ss_get_result(sport=sport, league=league, ep=ep, query=q_body, walk=TRUE) 
games <-do.call('rbind', lapply(gms, function(x) x$games)) 


# Team game logs ----
sport <- 'football'
league <- 'nfl'
ep <- 'team_game_logs'
q_body <- list()

tls  <- ss_get_result(sport=sport, league=league, ep=ep, query=q_body, walk=TRUE) 
team_game_logs <-do.call('rbind', lapply(tls, function(x) x$team_game_logs)) 

# Teams ----
sport <- 'football'
league <- 'nfl'
ep <- 'teams'
q_body <- list()

tms  <- ss_get_result(sport=sport, league=league, ep=ep, query=q_body, walk=TRUE) 
teams <-do.call('rbind', lapply(tls, function(x) x$teams))

colnames(teams)[1] <- 'team_id'
team_game_logs <- merge(teams, team_game_logs, by='team_id')

## Graphing Running backs ----
RB <- data.frame()
RB <-  game_logs %>%
  #filter(game_played == TRUE) %>%
  filter(position_abbreviation == "RB") %>%
  group_by(name) %>%
  summarise(Attempts=sum(rushes_attempts), Yards=sum(rushes_yards), TD=sum(rushes_touchdowns),
            `2pt`=sum(rushing_2pt_conversions_succeeded), Tgt=sum(receptions_looks), Rec=sum(receptions_total),
            RecYds=sum(receptions_yards), RecTD=sum(receptions_touchdowns),Fum=sum(fumbles_lost))

ggplot(RB, aes(x=Attempts, y=Yards, size=TD, label=name, color=TD)) + geom_text()
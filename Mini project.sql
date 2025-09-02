show databases;
create DATABASE cric_stats;
use cric_stats
create table matches (
    season int,
    team1 varchar(100),
    team2 varchar(1000),
    match_date date,
    match_number int,
     venue varchar(1000),
     city varchar(1000),
     toss_winner varchar(1000),
     toss_decision varchar(50),
     player_of_match varchar(100),
     umpire1 varchar(100),
     umpire2 varchar(100),
     reserve_umpire varchar(100),
     match_referee varchar(100),
     winner varchar(100),
     winner_runs int,
     winner_wickets int,
     match_type varchar(50)
);
show variables like 'secure_file_priv';
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/matches.csv'
INTO TABLE matches
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
truncate TABLE matches;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/matches.csv'
INTO TABLE matches
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
  season,
  team1,
  team2,
  match_date,
  match_number,
  venue,
  city,
  toss_winner, 
  toss_decision,
  player_of_match,
  umpire1,
  umpire2,
  reserve_umpire,
  match_referee,
  winner,
  @winner_runs,
  @winner_wickets,
  match_type
)
SET
  match_date     = NULLIF(STR_TO_DATE(match_date,'%d-%m-%y'), '00-00-0000'),
  winner_runs    = NULLIF(NULLIF(@winner_runs,''),'NULL'),
  winner_wickets = NULLIF(NULLIF(@winner_wickets,''),'NULL');
set @match_date = STR_TO_DATE(@match_date,'%d-%m-%y')

---date error solved but again empty values error coming so i'll using describe ;
describe matches;
--after known of using describe column winner runs & winner wickets have so many empty values.so I'll using again load data but this time specific columns of empty values will be set as null;
LOAD DATA INFILE'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/matches.csv'
INTO TABLE matches
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(season, team1, team2, match_date, match_number, venue, city, toss_winner, toss_decision, player_of_match, umpire1, umpire2, reserve_umpire, match_referee, winner, @winner_runs, @winner_wickets, match_type)
SET 
winner_runs = NULLIF(@winner_runs,''),
winner_wickets = NULLIF(@winner_wickets,'');
select * from matches limit 10;
SELECT count(*) from matches;

----matches file uploaded successfully.nxt deliveries file;
create TABLE deliveries(
    match_id INT,
    season INT,
    start_date date,
    venue varchar(1000),
    innings int,
    ball float,
    batting_team varchar(1000),
    bowling_team varchar(1000),
    striker varchar (100),
    non_striker varchar(100),
    bowler varchar(100),
    run_off_bat int,
    extras int,
    noballs int null,
    byes int null,
    legbyes int null,
    penalty int null,
    wicket_type varchar(1000) null,
    player_dismissed varchar(100) null,
    other_wicket_type varchar(100) null,
    other_player_dismissed varchar(1000) null
);
---successfully table deliveries created .
load data infile  'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/deliveries.csv'
into table deliveries
FIELDS TERMINATED by ','
ENCLOSED by '"'
lines terminated by '\n'
ignore 1 ROWS
(match_id,season,start_date,venue,innings,ball,batting_team,bowling_team,striker,non_striker,bowler,run_off_bat,extras,@noballs,
@byes,@legbyes,@penalty,@wicket_type,@player_dismissed,@other_wicket_type,@other_player_dismissed)

----data's are loaded successfully.
select count(*) from deliveries
---11472
select * from deliveries limit 10;
select * from matches;
select team1,team2,toss_winner,toss_decision,player_of_match,winner from matches;
SELECT * from matches where match_type = "final";
select * from matches where winner_runs >= '100';
select * from matches where player_of_match = 'Rg sharma' or player_of_match = 'v kohli';
select * from matches where winner = 'india' and match_type = 'final';
select * from matches where (team1 = 'india' or team2 = 'india') and  winner <> 'india';
----used where, arithmetic,comparitive,logical operators are used.
select * from matches ORDER BY match_date DESC LIMIT 10;
select * from matches ORDER BY match_date asc LIMIT 10;
select DISTINCT winner_wickets from matches;
select * from matches where venue like 'b%';
select * from matches where venue like '%l';
select * from matches where toss_decision = 'bat'; 
select * from matches where match_number in (25,5,6);
select * from matches where match_number between 40 and 52;
---used sorting & limiting,distinct for only unique values ,pattern matching operatorrs.
--aggregate functions
--sum
--count
--max
--min
--avg
select count(match_number) from matches;
select winner,max(winner_runs) from matches GROUP BY winner limit 10;
select winner,min(winner_runs)  from matches GROUP BY winner limit 1 ;
select avg(winner_runs) from matches ;
select sum(winner_wickets) from matches;
---aggregate functions used shortly .
select winner ,count(*) from matches where season = '2024' group BY winner having count(*) > 3;
select city,group_concat(DISTINCT venue) ,group_concat( DISTINCT team1),group_concat(DISTINCT team2) from matches GROUP BY city;

---groupby,having used .
select count(*) from deliveries
select * from deliveries

select * from matches
select * from deliveries

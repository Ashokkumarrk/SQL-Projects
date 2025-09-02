create DATABASE worldcup_2024;
use worldcup_2024
-- 1. Teams Table
CREATE TABLE Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50) UNIQUE NOT NULL,
    captain VARCHAR(50),
    coach VARCHAR(50),
    group_name CHAR(1) CHECK (group_name IN ('A', 'B'))
);

-- 2. Players Table
CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(50) NOT NULL,
    age INT CHECK (age > 15),
    role VARCHAR(20) CHECK (role IN ('Batsman', 'Bowler', 'All-rounder', 'Wicketkeeper')),
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

-- 3. Matches Table
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    match_date DATE,
    venue VARCHAR(100),
    team1_id INT,
    team2_id INT,
    winner_team_id INT,
    FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES Teams(team_id),
    FOREIGN KEY (winner_team_id) REFERENCES Teams(team_id)
);

-- 4. Scorecards Table
CREATE TABLE Scorecards (
    scorecard_id INT PRIMARY KEY,
    match_id INT,
    team_id INT,
    runs INT,
    wickets INT,
    overs DECIMAL(4,1),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

-- 5. Player Stats Table
CREATE TABLE Player_Stats (
    stat_id INT PRIMARY KEY,
    match_id INT,
    player_id INT,
    runs_scored INT,
    wickets_taken INT,
    catches INT,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);
INSERT INTO Teams (team_id, team_name, captain, coach, group_name) VALUES
(1, 'India', 'Rohit Sharma', 'Dravid', 'A'),
(2, 'Australia', 'Pat Cummins', 'Andrew McDonald', 'A'),
(3, 'England', 'Jos Buttler', 'Matthew Mott', 'B'),
(4, 'Pakistan', 'Babar Azam', 'Gary Kirsten', 'B'),
(5, 'South Africa', 'Aiden Markram', 'Rob Walter', 'A');

INSERT INTO Players (player_id, player_name, age, role, team_id) VALUES
(101, 'Virat Kohli', 35, 'Batsman', 1),
(102, 'Jasprit Bumrah', 30, 'Bowler', 1),
(103, 'David Warner', 37, 'Batsman', 2),
(104, 'Mitchell Starc', 34, 'Bowler', 2),
(105, 'Jos Buttler', 33, 'Wicketkeeper', 3),
(106, 'Shaheen Afridi', 25, 'Bowler', 4),
(107, 'Quinton de Kock', 32, 'Wicketkeeper', 5);

INSERT INTO Matches (match_id, match_date, venue, team1_id, team2_id, winner_team_id) VALUES
(201, '2024-06-05', 'Mumbai', 1, 2, 1),
(202, '2024-06-06', 'Sydney', 3, 4, 3),
(203, '2024-06-07', 'Cape Town', 5, 1, 5);

INSERT INTO Scorecards (scorecard_id, match_id, team_id, runs, wickets, overs) VALUES
(301, 201, 1, 185, 5, 20.0),
(302, 201, 2, 160, 8, 20.0),
(303, 202, 3, 190, 6, 20.0),
(304, 202, 4, 170, 10, 19.5),
(305, 203, 5, 200, 4, 20.0),
(306, 203, 1, 180, 7, 20.0);

INSERT INTO Player_Stats (stat_id, match_id, player_id, runs_scored, wickets_taken, catches) VALUES
(401, 201, 101, 75, 0, 1),   -- Kohli
(402, 201, 102, 10, 3, 0),   -- Bumrah
(403, 201, 103, 55, 0, 0),   -- Warner
(404, 201, 104, 5, 2, 0),    -- Starc
(405, 202, 105, 80, 0, 1),   -- Buttler
(406, 202, 106, 15, 4, 0),   -- Afridi
(407, 203, 107, 90, 0, 2);   -- De Kock

select * from teams
select * from players
select * from matches
select * from scorecards
select * from player_stats

select * from teams where captain = 'rohit sharma';
select * from teams where group_name = 'a';
select * from teams where group_name = 'b';
select * from players where age = '35' or  player_name = 'virat_kohli';
select * from players where age > 35;
select * from players where role = 'batsman' and age = '37';
select * from players where role = 'batsman' and age BETWEEN 30 and 37;
select * from teams where not captain = 'rohit sharma';

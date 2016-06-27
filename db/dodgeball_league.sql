DROP TABLE fixtures;
DROP TABLE matches;
DROP TABLE teams;

CREATE TABLE matches(
  id SERIAL4 primary key,
  home_team_id INT2 not null,
  away_team_id INT2 not null,
  home_team_score INT2 not null,
  away_team_score INT not null
);

CREATE TABLE teams(
  id SERIAL4 primary key,
  name VARCHAR(255) not null
);

CREATE TABLE fixtures(
  id SERIAL4 primary key,
  match_id INT2 REFERENCES matches(id),
  team_id INT2 REFERENCES teams(id)
);
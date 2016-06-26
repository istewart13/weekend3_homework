require_relative( 'models/match' )
require_relative( 'models/team' )
require_relative( 'models/fixture' )
require_relative( 'db/sql_runner' )
require( 'pry-byebug' )

runner = SqlRunner.new({dbname: 'dodgeball_league', host: 'localhost'})

Fixture.delete_all(runner)
Match.delete_all(runner)
Team.delete_all(runner)

team1 = Team.new( {"name" => "Reds"}, runner )
team1.save()

team2 = Team.new( {"name" => "Blues"}, runner )
team2.save()

match1 = Match.new( {"home_team_id" => 1, "away_team_id" => 2, "home_team_score" => 3, "away_team_score" => 4}, runner )
match1.save

match2 = Match.new( {"home_team_id" => 2, "away_team_id" => 1, "home_team_score" => 0, "away_team_score" => 2}, runner )
match2.save

fixture1 = Fixture.new( {"match_id" => match1.id, "team_id" => team1.id }, runner )
fixture1.save()

fixture2 = Fixture.new( {"match_id" => match2.id, "team_id" => team2.id }, runner )
fixture2.save()

team1.matches()
match1.teams()

binding.pry
nil
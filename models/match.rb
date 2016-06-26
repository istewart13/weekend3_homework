require_relative('../db/sql_runner')
require_relative('team')

class Match

  attr_reader :id, :home_team_id, :away_team_id, :home_team_score, :away_team_score

  def initialize( options, runner )
    @id = options['id'].to_i
    @home_team_id = options['home_team_id']
    @away_team_id = options['away_team_id']
    @home_team_score = options['home_team_score']
    @away_team_score = options['away_team_score']
    @runner = runner
  end

  def save()
    sql = "INSERT INTO matches (home_team_id, away_team_id, home_team_score, away_team_score) VALUES ('#{@home_team_id}', '#{@away_team_id}', '#{@away_team_score}', '#{@home_team_score}') RETURNING *"
    team_data = @runner.run(sql)
    @id = team_data.first['id'].to_i
  end

  def self.delete_all(runner)
    sql = "DELETE FROM matches"
    runner.run(sql)
  end

  def self.all(runner)
    sql = "SELECT * FROM matches"
    match_data = runner.run(sql)
    matches = match_data.map { |match_data| Match.new(match_data, runner) }
    return matches
  end

  def teams()
    sql = "SELECT teams.* FROM teams INNER JOIN fixtures ON fixtures.team_id = teams.id WHERE match_id = #{@id};"
    team_data = @runner.run(sql)
    team = team_data.map { |team_data| Team.new(team_data, @runner) }
    return team
  end

end
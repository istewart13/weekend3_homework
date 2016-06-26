require_relative('../db/sql_runner')
require_relative('match')

class Team 

  attr_reader :id, :name

  def initialize( options, runner )
    @id = options['id'].to_i
    @name = options['name']
    @runner = runner
  end

  def save()
    sql = "INSERT INTO teams (name) VALUES ('#{ @name }') RETURNING *"
    team_data = @runner.run(sql)
    @id = team_data.first['id'].to_i
  end

  def matches()
    sql = "SELECT matches.* FROM matches INNER JOIN fixtures ON fixtures.match_id = matches.id WHERE team_id = #{@id};"
    match_data = @runner.run(sql)
    match = match_data.map { |match_data| Match.new(match_data, @runner) }
    return match
  end

  def self.delete_all(runner)
    sql = "DELETE FROM teams"
    runner.run(sql)
  end

  def self.all(runner)
    sql = "SELECT * FROM teams"
    team_data = runner.run(sql)
    teams = team_data.map { |team_data| Team.new(team_data, runner) }
    return teams
  end

end
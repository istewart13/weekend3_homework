# Use inner joins if models need to be able to request date from one another
# - Create instance methods and/or class methods for the required CRUD operations - .save(), .find(), .update(), .delete()

class Fixture
  attr_reader :id, :match_id, :team_id

  def initialize( options, runner )
    @id = options['id'].to_i
    @match_id = options['match_id'].to_i
    @team_id = options['team_id'].to_i
    @runner = runner
  end

  def save()
    sql = "INSERT INTO fixtures (
      match_id,
      team_id) 
      VALUES (
        #{ @match_id }, 
        #{ @team_id }
      ) RETURNING *"
    fixture_data = @runner.run(sql)
    @id = fixture_data.first['id'].to_i
  end

  def self.delete_all(runner)
    sql = "DELETE FROM fixtures"
    runner.run(sql)
  end

  def self.all(runner)
    sql = "SELECT * FROM fixtures"
    fixture_data = runner.run(sql)
    fixtures = fixture_data.map { |fixture_data| Fixture.new(fixture_data, runner) }
    return fixtures
  end

end
require('pg')

class SqlRunner

  def initialize(options)
    @dbname = options[:dbname]
    @host = options[:host]
  end

  def run( sql )
    db = PG.connect({ dbname: @dbname, host: @host })
    result = db.exec( sql )
    db.close
    return result
  end

end
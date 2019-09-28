class Screening

  attr_reader(:id)
  attr_accessor(:showtime, :capacity)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @showtime = options['showtime']
    @capacity = options['capacity'].to_i
  end

  def save()
    sql = "INSERT INTO screenings
    (showtime, capacity) VALUES ($1, $2)
    RETURNING id"
    values = [@showtime, @capacity]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def update()
    sql = "UPDATE screenings SET (showtime, capacity) = ($1, $2) WHERE id = $3"
    values = [@showtime, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    screening_data = SqlRunner.run(sql)
    return Screening.map_items(screening_data)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    result = data.map{|screening| Screening.new(screening)}
    return result
  end

end

require_relative("../db/sql_runner")

class Ticket

  attr_reader(:id)
  attr_accessor(:customer_id, :film_id, :screening_id)

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (
    customer_id,
    film_id,
    screening_id
    )
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@customer_id, @film_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def update()
    sql = "UPDATE tickets SET
    (customer_id, film_id, screening_id) = ($1, $2, $3)
    WHERE id = $4"
    values = [@customer_id, @film_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    ticket_data = SqlRunner.run(sql)
    return Ticket.map_items(ticket_data)
  end

  def self.most_tickets()
    ###--> sort tickets to find most popular <-- ###
    # sql = "SELECT films.title, screenings.showtime
    # FROM tickets
    # INNER JOIN screenings
    # ON screenings.id = tickets.screening_id
    # INNER JOIN films
    # ON films.id = tickets.film_id"
    tickets = all()
    multiple_tickets_hash = Hash.new(0)
    ### --> find duplicate screenings
    tickets.each{ |ticket| multiple_tickets_hash[ticket.screening_id] += 1 }
    # most_popular_screening_id = multiple_tickets.max[0]
    ### --> sort by amount of duplicates
    most_popular_screening_sorted = multiple_tickets_hash.sort {|ticket_a , ticket_b| ticket_b[1] <=> ticket_a[1]}
    most_popular_screening_id = most_popular_screening_sorted[0][0]
    ### --> find ticket with most_popular_screening_id <-- ###
    sql = "SELECT tickets.*
    FROM tickets WHERE screening_id = $1"
    values = [most_popular_screening_id]
    ticket_data = SqlRunner.run(sql, values)
    # return ticket_data ### <-- check ticket
    ticket = Ticket.map_items(ticket_data)[0]
    # return ticket ### <-- check ticket
    most_popular_film_id = ticket.film_id
    ### --> find film title using film_id <-- ###
    sql = "SELECT films.*
    FROM films WHERE id = $1"
    values = [most_popular_film_id]
    film_data = SqlRunner.run(sql, values)
    film = Film.map_items(film_data)[0]
    ### --> find screeing showtime using screening_id <-- ###
    sql = "SELECT screenings.*
    FROM screenings WHERE id = $1"
    values = [most_popular_screening_id]
    screening_data = SqlRunner.run(sql, values)
    screening = Screening.map_items(screening_data)[0]
    ### --> return film title and showtime <-- ###
    return "The most popular film is #{film.title} at #{screening.showtime}"
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.map_items(data)
    result = data.map { |ticket| Ticket.new(ticket)  }
    return result
  end

end

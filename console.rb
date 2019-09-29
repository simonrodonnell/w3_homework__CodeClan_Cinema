require_relative("models/ticket")
require_relative("models/customer")
require_relative("models/film")
require_relative("models/screening")

require("pry")

Ticket.delete_all()
Screening.delete_all()
Film.delete_all()
Customer.delete_all()

#set up films

film1 = Film.new({
  "title" => "Blade Runner",
  "price" => "5"
  })
film1.save()

film2 = Film.new({
  "title" => "2001",
  "price" => "2"
  })
film2.save()
#
# film3 = Film.new({
#   "title" => "Alien",
#   "price" => "3"
#   })
# film3.save()
#
# film4 = Film.new({
#   "title" => "Old Boy",
#   "price" => "6"
#   })
# film4.save()

#set up customers

customer1 = Customer.new({
  "name" => "Bob",
  "funds" => 50
  })
customer1.save()

customer2 = Customer.new({
  "name" => "Sally",
  "funds" => 77
  })
customer2.save()

customer3 = Customer.new({
  "name" => "Frank",
  "funds" => 21
  })
customer3.save()

customer4 = Customer.new({
  "name" => "Alice",
  "funds" => 45
  })
customer4.save()

# set up screenings

screening1 = Screening.new({
  "showtime" => "17.00",
  "capacity" => 1
  })
screening1.save()

screening2 = Screening.new({
  "showtime" => "13.30",
  "capacity" => 1
  })
screening2.save()

# screening3 = Screening.new({
#   "showtime" => "19.45",
#   "capacity" => 1
#   })
# screening3.save()

# screening4 = Screening.new({
#   "showtime" => "13.30",
#   "capacity" => 1
#   })
# screening4.save()
#
# screening5 = Screening.new({
#   "showtime" => "21.15",
#   "capacity" => 1
#   })
# screening5.save()

#set up tickets
ticket1 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film1.id,
  "screening_id" => screening1.id
  })
ticket1.save()
ticket2 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film1.id,
  "screening_id" => screening2.id
  })
ticket2.save()
ticket3 = Ticket.new({
  "customer_id" => customer3.id,
  "film_id" => film2.id,
  "screening_id" => screening1.id
  })
ticket3.save()
ticket4 = Ticket.new({
  "customer_id" => customer4.id,
  "film_id" => film2.id,
  "screening_id" => screening2.id
  })
ticket4.save()
# ticket5 = Ticket.new({
#   "customer_id" => customer1.id,
#   "film_id" => film2.id,
#   "screening_id" => screening1.id
#   })
# ticket5.save()

binding.pry
nil

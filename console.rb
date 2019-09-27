require_relative("models/ticket")
require_relative("models/customer")
require_relative("models/film")

require("pry")

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

#set up films

film1 = Film.new({
  "title" => "Big Trouble in Little China",
  "price" => "5"
  })
film1.save()

film2 = Film.new({
  "title" => "The Exorcist",
  "price" => "7"
  })
film2.save()

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
#set up tickets

binding.pry
nil

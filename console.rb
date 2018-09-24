require("pry")
require_relative("./models/ticket")
require_relative("./models/film")
require_relative("./models/customer")

Ticket.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new("name" => "Holly Williams", "funds" => 40)
customer2 = Customer.new("name" => "Kate Rusby", "funds" => 20)
customer3 = Customer.new("name" => "Joni Mitchell", "funds" => 15)
customer4 = Customer.new("name" => "Miranda Lambert", "funds" => 40)


customer1.save
customer2.save
customer3.save
customer4.save

film1 = Film.new("title" => "Crazy Rich Asians", "price" => 6)
film2 = Film.new("title" => "Predator", "price" => 5)
film3 = Film.new("title" => "A Simple Favour", "price" => 6)
film4 = Film.new("title" => "A Star is Born", "price" => 6)

film1.save
film2.save
film3.save
film4.save

ticket1 = Ticket.new("customer_id" => customer3.id, "film_id" => film1.id)
ticket2 = Ticket.new("customer_id" => customer3.id, "film_id" => film4.id)
ticket3 = Ticket.new("customer_id" => customer1.id, "film_id" => film2.id)
ticket4 = Ticket.new("customer_id" => customer2.id, "film_id" => film2.id)

ticket1.save
ticket2.save
ticket3.save
ticket4.save



binding.pry
nil

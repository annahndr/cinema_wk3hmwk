require('pg')
require_relative('../db/sql_runner')
require_relative('./ticket')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @funds = options['funds'].to_i
end

def save
  sql = "INSERT INTO customers(name, funds) VALUES ($1, $2) RETURNING id"
  values = [@name, @funds]
  customer = SqlRunner.run(sql, values).first
  @id = customer['id'].to_i
end

def update_customer
  sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
  values = [@name, @funds, @id]
  SqlRunner.run(sql, values)
end

def buy_ticket(film)
  #get customer funds & film.price
  new_funds = @funds - film.price
  #
end

#copied
def buy_ticket(film)
  if @funds >= film.price
    @funds -= film.price
    new_ticket = Ticket.new({'customer_id' => @id, "film_id" => film.id})
    new_ticket.save
  end
end

def delete_customer
  sql = "DELETE FROM customers WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

#bring back all films customer has watched
def films
  sql = "SELECT films.*
  FROM films INNER JOIN tickets
  ON tickets.film_id = films.id
  WHERE customer_id = $1"
  #select all films from a table made of films and tickets joined togther where the film ids match. Pass in the customer_id
  values = [@id]#the customer_id
  films = SqlRunner.run(sql, values)
  return films.map {|film_hash| Film.new(film_hash)}
end

#how many tickets bought by a customer
def how_many_tickets
  sql = "SELECT * FROM tickets WHERE tickets.customer_id = $1 "
  values = [@id]
  tickets = SqlRunner.run(sql, values)
  return tickets.map {|ticket_hash| Ticket.new(ticket_hash)}.length
end

def self.all
  sql = "SELECT * FROM customers;"
  customers = SqlRunner.run(sql)
  return customers.map {|customer_hash| Customer.new(customer_hash)}
end

def self.delete_all
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)
end


##
end

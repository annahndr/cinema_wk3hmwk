require('pg')
require_relative('../db/sql_runner')
require_relative('./customer')


class Ticket

  attr_accessor :customer_id, :film_id
  attr_reader :id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @customer_id = options['customer_id']
  @film_id = options['film_id'].to_i
end

def save
  sql = "INSERT INTO tickets(customer_id, film_id) VALUES ($1, $2) RETURNING id"
  values = [@customer_id, @film_id]
  ticket = SqlRunner.run(sql, values).first
  @id = ticket['id'].to_i
end

def update_ticket
  sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
  values = [@customer_id, @film_id, @id]
  SqlRunner.run(sql, values)
end

def delete_ticket
  sql = "DELETE FROM tickets WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def film_price
  #get the price of the film
  sql = "SELECT price from films WHERE films.id = $1"

  # "SELECT price FROM tickets INNER JOIN films ON tickets.film_id = films.id WHERE film_id = $1"
  values = [@film_id]
  return SqlRunner.run(sql, values)[0]['price'].to_i
end

  #get the customer's funds (by id)
def customer_funds
  sql = "SELECT funds FROM customers WHERE customers.id = $1"
  # "SELECT funds FROM tickets INNER JOIN customers ON tickets.customer_id = customers.id WHERE customer_id = $1"
  values = [@customer_id]
  return SqlRunner.run(sql, values)[0]['funds'].to_i
end


#not working
def buy_ticket
  #how to update the database? posible to use update_customer method?
  # update_customer(new_funds)

  new_funds = customer_funds - film_price    #this bit seems to work
  update_customer(new_funds)
  # sql = "UPDATE customers SET funds = $1 WHERE id = $2"
  # values = [new_funds, @customer_id]
  # SqlRunner.run(sql, values)
end

def self.all
  sql = "SELECT * FROM tickets"
  tickets = SqlRunner.run(sql)
  return tickets.map {|ticket_hash| Ticket.new(ticket_hash)}
end

def self.delete_all
  sql = "DELETE FROM tickets"
  SqlRunner.run(sql)
end

#
end

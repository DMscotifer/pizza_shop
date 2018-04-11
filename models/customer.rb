require("pg")
require_relative("pizza_order.rb")
require_relative("../db/sql_runner.rb")

class Customer

  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i()
    @first_name = options["first_name"]
    @last_name = options["last_name"]
  end

  def save()
    sql = "INSERT INTO customers (first_name, last_name) VALUES ($1, $2) RETURNING id;"
    values = [@first_name, @last_name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.delete()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

 def self.delete_all()
   sql = "DELETE FROM customers;"
   SqlRunner.run(sql)
 end

 def orders()
   sql = "SELECT * FROM pizza_orders WHERE customer_id = $1"
   values = [@id]
   orders = SqlRunner.run(sql, values)
   return orders.map{|order_hash| PizzaOrder.new(order_hash)}
 end

end

require('pg')
require_relative("customer.rb")
require_relative("../db/sql_runner.rb")

class PizzaOrder
  attr_reader :id
  attr_writer :topping, :quantity

  def initialize(options)
    @id = options["id"].to_i()
    @topping = options['topping']
    @quantity = options['quantity'].to_i()
    @customer_id = options["customer_id"].to_i()
  end


  def save()
    sql = "INSERT INTO pizza_orders (topping, quantity, customer_id) VALUES ($1, $2, $3) RETURNING id;"
    values = [@topping, @quantity, @customer_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i()
  end

  def PizzaOrder.all()
    sql = "SELECT * FROM pizza_orders;"
    orders = SqlRunner.run(sql)
    return orders.map{|order| self.new(order)}
  end

  def PizzaOrder.delete_all()
    sql = "DELETE FROM pizza_orders;"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM pizza_orders WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE pizza_orders SET (topping, quantity, customer_id) = ($1, $2, $3) WHERE id = $4;"
    values = [@topping, @quantity, @customer_id, @id]
    SqlRunner.run(sql, values)
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [@customer_id]
    customers = SqlRunner.run(sql, values)
    customer_hash = customers[0]
    return Customer.new(customer_hash)
  end


end

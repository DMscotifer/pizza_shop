require_relative('models/customer.rb')
require_relative('models/pizza_order.rb')
require('pry-byebug')

PizzaOrder.delete_all()
Customer.delete()

customer1 = Customer.new(
  {
    "first_name" => "Daniel",
    "last_name" => "Childs"
  }
)

customer1.save()

order1 = PizzaOrder.new(
  {
    "topping" => "Pepperoni",
    "quantity" => 3,
    "customer_id" => customer1.id()
  }
)

order1.save()

order2 = PizzaOrder.new(
  {
    "topping" => "Veg Supreme, no mushrooms",
    "quantity" => 2,
    "customer_id" => customer1.id

  }
)

order2.save()



binding.pry

nil

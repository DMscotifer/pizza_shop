DROP TABLE IF EXISTS pizza_orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE pizza_orders(
  id SERIAL PRIMARY KEY,
  topping VARCHAR(255),
  quantity INT,
  customer_id INT REFERENCES customers(id)
)

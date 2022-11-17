USE northwind;

#1. Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.

SELECT customers.customer_id AS ID_cliente, customers.company_name AS nombre_empresa, COUNT(orders.customer_id) AS num_pedidos
FROM customers
CROSS JOIN orders
WHERE customers.customer_id = orders.customer_id
GROUP BY orders.customer_id;

#2
SELECT customers.company_name AS nombre_empresa, YEAR(orders.order_date) AS año, SUM(order_details.quantity)
FROM orders
INNER JOIN order_details
ON orders.order_id = order_details.order_id
INNER JOIN customers
ON customers.customer_id = orders.customer_id
WHERE orders.ship_country = "UK"
GROUP BY customers.company_name, YEAR(orders.order_date)
ORDER BY customers.company_name;


#3
SELECT customers.company_name AS nombre_empresa, YEAR(orders.order_date) AS año, SUM(order_details.quantity) AS num_objetos, (order_details.unit_price*order_details.quantity) - ((order_details.unit_price*order_details.quantity)*order_details.discount) AS Dinero_total
FROM orders
INNER JOIN order_details
ON orders.order_id = order_details.order_id
INNER JOIN customers
ON customers.customer_id = orders.customer_id
WHERE orders.ship_country = "UK"
GROUP BY customers.company_name, YEAR(orders.order_date)
ORDER BY customers.company_name;














 

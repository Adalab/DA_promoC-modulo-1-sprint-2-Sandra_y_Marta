USE northwind;

# 1. Pedidos por empresa en UK
# Desde las oficinas de UK nos piden con urgencia que realicemos una consulta con la que podamos contener cuántos pedidos ha realizado cada empresa cliente de UK.
# Nos piden el ID del cliente y el nombre de la empresa y número de pedidos.

SELECT customers.customer_id AS Identificador, customers.company_name AS NombreEmpresa, COUNT(orders.customer_id) AS NumeroPedidos
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
WHERE orders.ship_country = "UK"
GROUP BY orders.customer_id;

# 2. Productos pedidos por empresa en UK por año.
# Consulta que sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año.
# Quieren conocer el nombre de la empresa, el año y la cantidad de objetos que han pedido.

SELECT customers.company_name AS NombreEmpresa, YEAR(orders.order_date) AS Año, SUM(order_details.quantity) AS NumObjetos
FROM orders
INNER JOIN order_details
ON orders.order_id = order_details.order_id
INNER JOIN customers
ON customers.customer_id = orders.customer_id
WHERE orders.ship_country = "UK"
GROUP BY customers.company_name, YEAR(orders.order_date)
ORDER BY customers.company_name;

# 3. Nos han pedido la misma consulta anteior pero con el importe total, teniendo en cuenta los descuentos.

SELECT customers.company_name AS nombre_empresa, YEAR(orders.order_date) AS año, SUM(order_details.quantity) AS num_objetos, (order_details.unit_price*order_details.quantity) - ((order_details.unit_price*order_details.quantity)*order_details.discount) AS Dinero_total
FROM orders
INNER JOIN order_details
ON orders.order_id = order_details.order_id
INNER JOIN customers
ON customers.customer_id = orders.customer_id
WHERE orders.ship_country = "UK"
GROUP BY customers.company_name, YEAR(orders.order_date)
ORDER BY customers.company_name;

# 4. Pedidos que han realizado cada compañia y su fecha.
# Consulta que indique el nombre de cada compañía cliente junto con cada pedido que han realizado y su fecha. 

SELECT order_id AS OrderID, company_name AS CompanyName, order_date AS OrderDate
FROM customers
NATURAL JOIN orders;

# 5. Tipos de producto vendidos:
# Lista con cada tipo de producto que se ha vendido, sus categorías, nombre de la categoría y nombre del producto, y el total del dinero por el que se ha vendido cada producto, teniendo en cuenta los descuentos.

SELECT categories.category_id AS CategoryID, categories.category_name AS CategoryName, products.product_name AS ProductName, SUM(ROUND((order_details.unit_price*order_details.quantity)-((order_details.unit_price*order_details.quantity)*order_details.discount),2)) AS ProductSales
FROM products
INNER JOIN order_details
ON products.product_id = order_details.product_id
INNER JOIN categories
ON categories.category_id = products.category_id
GROUP BY ProductName;












 

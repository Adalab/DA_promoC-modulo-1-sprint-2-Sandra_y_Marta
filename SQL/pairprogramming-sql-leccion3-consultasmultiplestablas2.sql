USE northwind;

/* 1. Obtener una consulta que nos devuelva el nombre de las empresas cliente, los ID de sus pedidos y las fechas*/
SELECT orders.order_id AS OrderID, customers.company_name AS CompanyName, orders.order_date AS OrderDate
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
ORDER BY CompanyName;

/* 2. Desde la oficina de UK nos solicitan información acerca del número de pedidos que ha realizado cada cliente de UK para conocerlos mejor. Piden el número de clientes y nº de pedidos*/
SELECT customers.company_name AS NombreCliente, COUNT(orders.order_id) AS NumeroPedidos
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
WHERE customers.country = "UK"
GROUP BY customers.customer_id;

/* 3. Nos piden que obtengamos todos los nombres de los clientes de UK, tengan pedido o no, junto con los ID de todos los pedidos realizados, nombre de contacto y fecha de pedido*/
SELECT customers.company_name AS NombreCliente, customers.contact_name AS NombreContacto, orders.order_id AS NumPedido, orders.order_date AS FechaPedido
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
WHERE customers.country = "UK";

/* 4. Hacemos una consulta que muestre los datos de las empleadas y sus supervisoras que sean de la misma ciudad*/
SELECT A.city AS city, CONCAT(A.first_name, " ", A.last_name) AS NombreEmpleado, B.city AS city, CONCAT(B.first_name, " ", B.last_name) AS NombreJefe
FROM employees AS A, employees AS B
WHERE A.reports_to = B.employee_id
AND A.city = B.city;

/* BONUS. Selecciona todos los pedidos, tenga empresa asociada o no, y todas las empresas, tengan pedidos asociados o no, que sean del Reino Unido.*/
SELECT orders.order_id AS OrderID, customers.company_name AS NombreCliente, orders.order_date AS FechaPedido
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
WHERE customers.country = "UK"
UNION
SELECT orders.order_id AS OrderID, customers.company_name AS NombreCliente, orders.order_date AS FechaPedido
FROM orders
RIGHT JOIN customers
ON orders.customer_id = customers.customer_id
WHERE customers.country = "UK";
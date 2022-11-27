/* 1. Queremos obtener los id y nombres de las compañías de nuestros clientes mediante una CTE */
WITH consulta_clientes AS(
SELECT customer_id AS CustomerID, company_name AS CompanyName
FROM customers)
SELECT CustomerID, CompanyName
FROM consulta_clientes;

/* 2. Mediante una CTE obtenemos los id y nombres de los clientes que vienen de "Germany" */
WITH consulta_clientes_alemania AS(
SELECT customer_id AS CustomerID, company_name AS CompanyName
FROM customers
WHERE country = "Germany")
SELECT CustomerID, CompanyName
FROM consulta_clientes_alemania;

/*3. Obtener los datos de las facturas que se han emitido a un cliente, su fecha y la compañia a la que pertenece*/
WITH factura_fecha AS(
SELECT orders.customer_id AS CustomerID, customers.company_name AS CompanyName, orders.order_id AS OrderID, orders.order_date AS OrderDate
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
ORDER BY orders.customer_id)
SELECT CustomerID, CompanyName, OrderID, OrderDate
FROM factura_fecha;

/* 4. En esta consulta obtenemos el número de facturas emitidas por cada cliente. */
WITH Numfactura_cliente AS(
SELECT orders.customer_id AS CustomerID, customers.company_name AS CompanyName, COUNT(orders.order_id) AS NumFacturas
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY orders.customer_id
ORDER BY orders.customer_id)
SELECT CustomerID, CompanyName, NumFacturas
FROM Numfactura_cliente;

/* 5. Con la suma de los productos realizados por pedido, realizar la media de los productos pedidos*/
WITH media_productos AS (
SELECT products.product_name AS Producto, SUM(order_details.quantity) AS CantidadPedida
FROM order_details
LEFT JOIN products
ON products.product_id = order_details.product_id
GROUP BY order_details.order_id)
SELECT Producto, ROUND(AVG(CantidadPedida),2) AS Media
FROM media_productos
GROUP BY Producto
ORDER BY Producto;

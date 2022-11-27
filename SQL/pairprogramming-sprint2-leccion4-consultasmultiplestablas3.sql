USE northwind;

#1- Extraer toda la información sobre las compañias que tengamos en la BBDD
#Nos han pedido que creemos una query que nos devuelva los clientes y proveedores de la BBDD. Mostrad ciudad a la 
#que pertenecen, nombre de la empresa y del contacto, además de la relación (Proveedor o Cliente). 
#Pero es importante que no haya duplicados.
#La columna Relationship no existe y debe ser creada como columna temporal.

SELECT city AS City, company_name AS CompanyName, contact_name AS ContactName, 'Customers' AS Relationship
FROM customers
UNION
SELECT city AS City, company_name AS CompanyName, contact_name AS ContactName, 'Suppliers' AS Relationship
FROM suppliers;


#2- Extraer todos los pedidos gestinados por "Nancy Davolio"
# En este caso, nuestro jefe quiere saber cuantos pedidos ha 
# gestionado "Nancy Davolio", una de nuestras empleadas. Nos pide todos los detalles tramitados por ella.

SELECT *
FROM orders
WHERE employee_id IN(
                     SELECT employee_id
                     FROM employees
                     WHERE first_name = 'Nancy' AND last_name = 'Davolio'); 
                     

#3.Extraed todas las empresas que no han comprado en el año 1997.
# Para extraer el año de una fecha, podemos usar el estamento year.

SELECT company_name AS CompanyName, country AS Country
FROM customers
WHERE customer_id NOT IN(
                         SELECT customer_id
                         FROM orders
                         WHERE YEAR(order_date) = 1997);
				
                
#4- Extraed toda la información de los pedidos donde tengamos "Konbu"
# Nuestro jefe nos pide que nos muestre todos los pedidos que contengan "Konbu".
# En esta query tendremos que combinar conocimientos adquiridos en las lecciones 
# anteriores como por ejemplo el INNER JOIN.

SELECT * 
FROM orders
INNER JOIN order_details 
ON orders.order_id = order_details.order_id
WHERE order_details.product_id IN (
                                   SELECT product_id 
                                   FROM products 
                                   WHERE product_name = 'Konbu');
			
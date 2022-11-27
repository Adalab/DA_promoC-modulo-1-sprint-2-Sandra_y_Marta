USE northwind;

/* 1. Consulta para extraer la fecha de los pedidos más recientes realizados por cada empleado, mediante una query correlacionada*/
SELECT order_id AS OrderID, customer_id AS CustomerID, employee_id AS EmployeeID, order_date AS OrderDate, required_date AS RequiredDate
FROM orders AS A1
WHERE order_date >= ALL(
		SELECT max(order_date)
        FROM orders AS A2
        WHERE A1.employee_id = A2.employee_id
        ORDER BY order_date DESC)
GROUP BY employee_id;

/* 2. Consulta para obtener un informe de los productos vendidos y su precio unitario */
SELECT product_id AS ProductID, unit_price AS MaxUnitPrice
FROM products AS A1
WHERE unit_price >= (
					SELECT unit_price
                    FROM products AS A2
                    WHERE A1.product_id = A2.product_id
                    GROUP BY product_id);
 
 /* 3. Consulta que nos devuelve el nombre de las compañias situadas en ciudades que comienzan por "A" o "B"*/
SELECT city AS City, company_name AS CompanyName, contact_name AS ContactName
FROM customers
WHERE city LIKE "A%" OR city LIKE "B%";

/* 4. Consulta que nos devuelve el nombre de las compañias situadas en ciudades que comienzan por "L"*/
SELECT city AS City, company_name AS CompanyName, contact_name AS ContactName
FROM customers
WHERE city LIKE "L%";

/* 5. Consulta para extraer los clientes que no tienen "Sales" en ContactTitle*/
SELECT contact_name AS ContactName, contact_title AS ContactTitle, company_name AS CompanyName 
FROM customers
WHERE contact_title NOT LIKE "%Sales%"
ORDER BY company_name;

/* 6. Consulta que devuelve los nombres de los clientes que no tengan una "A" en segunda posición del nombre de contacto*/
SELECT contact_name AS ContactName 
FROM customers
WHERE contact_name NOT LIKE "_a%";
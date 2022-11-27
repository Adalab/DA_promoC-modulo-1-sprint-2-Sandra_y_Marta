USE northwind;

/* 1. Relacionar el número de pedidos con la máxima carga por empleado (id_empleado */
SELECT employee_id AS NumEmpleado, MAX(freight) AS CargaMaxima, COUNT(order_id) AS NumPedidos
FROM orders
GROUP BY employee_id;

/* 2. Descartar pedidos sin fecha sobre el ejercicio anterior y ordenarlos según id_empleado */
SELECT employee_id AS NumEmpleado, MAX(freight) AS CargaMaxima, COUNT(order_id) AS NumPedidos
FROM orders
WHERE shipped_date <> "0000-00-00 00:00:00"
GROUP BY employee_id;

/* 3. Generar una consulta que nos devuelva el número de pedidos por día, mostrando por separado el día, el mes y el año */
SELECT COUNT(order_id) AS NumPedidos, DAY(order_date) AS Dia, MONTH(order_date) AS Mes, YEAR(order_date) AS Año
FROM orders
GROUP BY order_date;

/* 4. Modificar la consulta anterior para que los agrupe por meses */
SELECT COUNT(order_id) AS NumPedidos, MONTH(order_date) AS Mes, YEAR(order_date) AS Año
FROM orders
GROUP BY MONTH(order_date);

 /* 5. Seleccionad las ciudades con 4 o más empleadas */
 SELECT COUNT(DISTINCT employee_id) AS NoEmpleadas, city
 FROM employees
 GROUP BY city
 HAVING NoEmpleadas >= 4;
 
 /* 6. Realizar una consulta que clasifique los pedidos en dos categorías (Alto y Bajo): por encima o por debajo de 2000€ */
 SELECT (unit_price * quantity) - (unit_price * quantity)*discount AS totalfactura, order_id,
 CASE WHEN (unit_price * quantity) - (unit_price * quantity)*discount >= 2000 THEN "Alto" ELSE "Bajo" END AS CategoriaPedido
 FROM order_details
 GROUP BY order_id;
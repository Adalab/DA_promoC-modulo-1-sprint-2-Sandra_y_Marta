USE northwind;

# 1-
# Extraed toda la información necesaria para identificar productos con categoría "Beverages". 
# Devuelve el ID del producto, el nombre del producto y su ID de categoría.

SELECT product_id AS ProductID, product_name AS ProductName, category_id AS CategoryID
FROM products
WHERE category_id IN (
                      SELECT category_id 
                      FROM categories
                      WHERE category_name = "Beverages");
                      

#2-
# Extraed la lista de países donde viven los clientes pero no hay ningún proveedor ubicado.


SELECT DISTINCT country
FROM customers
WHERE country NOT IN (
                      SELECT country 
                      FROM suppliers);
         
         
         
#3-
# Extraer los clientes que compraron mas de 20 articulos del producto "Grandma's Boysenberry Spread" (ProductID 6)
# en un solo pedido.


SELECT order_id AS OrderID, customer_id AS CustomerID
FROM orders
WHERE order_id IN (
		SELECT order_id 
		FROM order_details 
		WHERE product_id = 6 AND quantity > 20);
    
    

# 4-
# Debemos realizar más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.


SELECT product_name AS Ten_Most_Expensive_Products, unit_price AS UnitPrice
FROM products
WHERE unit_price > ANY (
                        SELECT unit_price 
                        FROM products)
ORDER BY unit_price DESC                        
LIMIT 10;                        
  
  
  
  
# 5 - Bonus
# Extraed cuál es el producto que más ha sido comprado y en qué cantidad se compró.

SELECT product_name AS ProductName, SUM(order_details.quantity)
FROM products
INNER JOIN order_details
ON products.product_id = order_details.product_id
GROUP BY order_details.product_id
HAVING SUM(order_details.quantity) >= ALL(
SELECT SUM(quantity)
FROM order_details
GROUP BY product_id
ORDER BY SUM(quantity) DESC);
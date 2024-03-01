CREATE SCHEMA northwind;

-- Productos más baratos y caros de nuestra BBDD:

USE northwind;

SELECT MAX(unit_price) AS highestPrice, Min(unit_price) AS lowestPrice
FROM products; 

-- Conociendo el numero de productos y su precio medio:

SELECT AVG(unit_price) AS media_precio, COUNT(product_id) AS total_productos
FROM products;

-- Sacad la máxima y mínima carga de los pedidos de UK:

SELECT MAX(freight) AS carga_max, MIN(freight) AS carga_min, ship_country
FROM orders 
GROUP BY ship_country 
HAVING ship_country = "UK";

-- Qué productos se venden por encima del precio medio:

SELECT AVG(unit_price) AS media_precio
FROM products;

SELECT *
FROM products 
WHERE unit_price > (SELECT AVG(unit_price) FROM products)
ORDER BY unit_price DESC;

 -- Qué productos se han descontinuado: 
 
SELECT product_id, discontinued
FROM products 
WHERE discontinued = 1;

-- Detalles de los productos de la query anteriores: 

SELECT product_id, product_name, discontinued
FROM products 
WHERE discontinued = 0
ORDER BY product_id DESC 
LIMIT 10;

-- Relación entre número de pedidos y máxima carga:

SELECT COUNT(order_id) AS total_pedidos, MAX(freight) AS maxima_carga, employee_id
FROM orders 
GROUP BY employee_id;

-- Descartar pedidos sin fecha y ordénalos:

SELECT COUNT(order_id) AS total_pedidos, MAX(freight) AS maxima_carga, employee_id
FROM orders
WHERE shipped_date IS NOT NULL
GROUP BY employee_id
ORDER BY MAX(freight) DESC;

-- Números de pedidos por día:
SELECT DAY(order_date) AS día, MONTH(order_date) AS mes, YEAR(order_date) AS año, COUNT(order_id) AS numero_pedidos
FROM orders
GROUP BY DAY(order_date), MONTH(order_date),YEAR(order_date);

-- Número de pedidos por mes y año:

SELECT MONTH(order_date) AS mes, YEAR(order_date) AS año, COUNT(order_id) AS numero_pedidos
FROM orders
GROUP BY MONTH(order_date),YEAR(order_date);

-- Seleccionad las ciudades con 4 o más empleadas:
SELECT city, COUNT(employee_id)
FROM employees
GROUP BY city HAVING COUNT(employee_id) >= 4;

-- Cread una nueva columna basándonos en la cantidad monetaria:

SELECT unit_price * quantity AS total_pedido, 
CASE WHEN unit_price * quantity > 2000 THEN "Alto" ELSE "Bajo" END AS "categoria_monetaria"
FROM order_details;

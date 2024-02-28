CREATE SCHEMA northwind;

USE northwind;

-- Explora la estructura de la base de datos
-- Explorado con EER Diagram

-- Consulta datos sobre empleados
SELECT `employee_id`, `last_name` , `first_name`
FROM employees;

-- Conocer los productos más baratos
SELECT *
FROM products
WHERE `unit_price` <= 5;

-- Conocer los productos que no tienen precio
SELECT *
FROM products
WHERE `unit_price` IS NULL;

-- Comparando productos
SELECT *
FROM products
WHERE `unit_price` <= 15 AND `product_id` < 10;

-- Cambiando de operadores
SELECT *
FROM products
WHERE NOT `unit_price` <= 15 AND NOT `product_id` < 10;

-- Conociendo los países a los que vendemos
SELECT DISTINCT `ship_country`
FROM orders;

-- Conociendo el tipo de productos que vendemos
SELECT *
FROM products
ORDER BY `product_id`
LIMIT 10;

-- Ordenando los resultados
SELECT *
FROM products
ORDER BY `product_id` DESC
LIMIT 10;

-- Qué pedidos tenemos en la BBDD
SELECT DISTINCT `order_id`
FROM order_details;

-- Qué pedidos han gastado más
SELECT `order_id`, SUM(`unit_price` * `quantity`) AS `ImporteTotal`
FROM order_details
GROUP BY `order_id`
ORDER BY `ImporteTotal` DESC
LIMIT 3;

-- Pedidos en posición 5 y 10 del ranking (hemos incluido ambas posiciones)
SELECT `order_id`, SUM(`unit_price` * `quantity`) AS `ImporteTotal`
FROM order_details
GROUP BY `order_id`
ORDER BY `ImporteTotal` DESC
LIMIT 6
OFFSET 4;

-- Categorias que tenemos en la Base de Datos
SELECT od.order_id, p.category_id AS `NombreDeCategoria`
FROM order_details od
INNER JOIN products p ON od.product_id = p.product_id;

-- Selecciona envíos con retraso
SELECT `shipped_date` , DATE_ADD(`shipped_date`, INTERVAL 5  DAY) AS `FechaRetrasada`
FROM orders;





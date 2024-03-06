USE northwind;

-- 1. Extraer en una CTE todos los nombres de las compañias y los id de los clientes.

SELECT *
	FROM customers;

WITH tabla_clientes
	AS (SELECT customer_id AS custID, company_name AS CompanyName FROM customers) 
    SELECT custID, CompanyName
    FROM tabla_clientes;
    
-- 2. Selecciona solo los de que vengan de "Germany"
WITH tabla_clientes
	AS (SELECT customer_id AS custID, company_name AS CompanyName 
		FROM customers
		WHERE country = "Germany") 
    SELECT custID, CompanyName
    FROM tabla_clientes;

-- 3. Extraed el id de las facturas y su fecha de cada cliente.

WITH tabla_clientes
	AS (SELECT customer_id AS custID, company_name AS CompanyName FROM customers) 
    SELECT custID, CompanyName, orders.order_id AS orderID , orders.order_date AS OrderDate
    FROM tabla_clientes
    INNER JOIN orders
    ON custID = orders.customer_id;

-- 4. Contad el número de facturas por cliente

WITH tabla_clientes
	AS (SELECT customer_id AS custID, company_name AS CompanyName FROM customers) 
    SELECT custID, CompanyName, COUNT(orders.order_id) AS numero_facturas
    FROM tabla_clientes
    INNER JOIN orders
    ON custID = orders.customer_id
    GROUP BY custID;

-- 5. Cuál la cantidad media pedida de todos los productos ProductID.

WITH media AS (SELECT product_id AS ProdID, AVG(quantity) AS media_pedida
    FROM order_details
    GROUP BY ProdID)
SELECT products.product_name AS ProdName, media_pedida
FROM media
INNER JOIN products
ON ProdID = products.product_id;

-- 6. Usando una CTE, extraer el nombre de las diferentes categorías de productos, con su precio medio, máximo y mínimo

WITH categorias_precios AS (SELECT AVG(unit_price) AS precio_medio, MAX(unit_price) AS precio_max, MIN(unit_price) AS precio_min, category_id AS CatID
							FROM products
                            GROUP BY CatID) 
							SELECT categories.category_name, precio_medio, precio_max, precio_min
                            FROM categorias_precios
                            INNER JOIN categories
                            ON CatID = categories.category_id;

-- 7. La empresa nos ha pedido que busquemos el nombre de cliente, su teléfono y el número de pedidos que ha hecho cada uno de ellos.

WITH datos_cliente AS (SELECT company_name AS EmpresaCliente, phone AS telefono, customer_id AS CustID
						FROM customers)
					SELECT EmpresaCliente, telefono, COUNT(orders.order_id) AS pedidos_totales
                    FROM datos_cliente 
                    INNER JOIN orders
                    ON CustID = orders.customer_id
                    GROUP BY CustID;

-- 8. Modifica la consulta anterior para obtener los mismos resultados pero con los pedidos por año que ha hecho cada cliente.

WITH datos_cliente AS (SELECT company_name AS EmpresaCliente, phone AS telefono, customer_id AS CustID
						FROM customers)
					SELECT EmpresaCliente, telefono, COUNT(orders.order_id) AS pedidos_totales, YEAR(orders.order_date) AS anio_pedido
                    FROM datos_cliente 
                    INNER JOIN orders
                    ON CustID = orders.customer_id
                    GROUP BY CustID, YEAR(orders.order_date)
                    ;

-- 9. Modifica la cte del ejercicio anterior, úsala en una subconsulta para saber el nombre del cliente y su teléfono, para aquellos clientes que hayan hecho más de 6 pedidos en el año 1998.


WHERE company_name IN (WITH datos_cliente AS (SELECT company_name AS EmpresaCliente, phone AS telefono, customer_id AS CustID
						FROM customers)
					SELECT EmpresaCliente
                    FROM datos_cliente 
                    INNER JOIN orders
                    ON CustID = orders.customer_id
                    GROUP BY CustID, YEAR(orders.order_date)
                    HAVING YEAR(orders.order_date) = 1998 pedidos_1998)
                    WHERE pedidos_1998 > 6;
                    
                    
WITH datos_cliente AS (
  SELECT company_name AS EmpresaCliente,
         phone AS telefono,
         customer_id AS CustID,
         (
           SELECT COUNT(*)
           FROM orders
           WHERE orders.customer_id = CustID
             AND YEAR(orders.order_date) = 1998
         ) AS pedidos_1998
  FROM customers
)
SELECT EmpresaCliente, telefono
FROM datos_cliente
WHERE pedidos_1998 > 6;





                            



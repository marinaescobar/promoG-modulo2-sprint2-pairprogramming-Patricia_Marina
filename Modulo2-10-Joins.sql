USE northwind;

-- Pedidos por empresa en UK
-- ID cliente, NombreEmpresa, NumPedidos
SELECT orders.customer_id AS Identificador, COUNT(orders.order_id) AS NumeroPedidos, customers.company_name AS NombreEmpresa
FROM orders
NATURAL JOIN customers
WHERE orders.ship_country = "UK"
GROUP BY orders.customer_id;

-- Productos pedidos por empresa en UK por año
-- Saber objetos / año , NombreEmpresa , Año , CantidadObjetos
SELECT customers.company_name AS NombreEmpresa , YEAR(orders.order_date) AS Año , SUM(order_details.quantity) AS CantidadObjetos
FROM orders
NATURAL JOIN customers
NATURAL JOIN order_details
WHERE orders.ship_country = "UK"
GROUP BY orders.customer_id , Año;

-- Mejorad la query anterior
-- Cantidad de dinero, teniendo en cuenta descuentos
SELECT 
	customers.company_name AS NombreEmpresa , 
	YEAR(orders.order_date) AS Año , 
    SUM(order_details.quantity) AS CantidadObjetos , 
    SUM((order_details.quantity * order_details.unit_price) * (1 - order_details.discount)) AS DineroTotal
FROM orders
NATURAL JOIN customers
NATURAL JOIN order_details
WHERE orders.ship_country = "UK"
GROUP BY orders.customer_id , Año;

-- Qué empresas tenemos en la BBDD Northwind
-- CompanyName , OrderID , OrderDate
SELECT customers.company_name AS NombreEmpresa , orders.order_date AS OrderDate , orders.order_id
FROM orders
NATURAL JOIN customers;

-- Pedidos por cliente de UK
-- CompanyName , NumeroPedidos
SELECT customers.company_name AS NombreEmpresa , COUNT(orders.order_id) AS NumeroPedidos
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id
WHERE orders.ship_country = "UK"
GROUP BY customers.customer_id;

-- Empresas de UK y sus pedidos
SELECT customers.company_name AS NombreEmpresa , orders.order_date AS OrderDate , orders.order_id
FROM orders
NATURAL JOIN customers
WHERE orders.ship_country = "UK";

-- Empleadas que sean de la misma ciudad
-- Empleadas: Ubicacion, Nombre, Apellido / Jefes: Ubicacion, Nombre, Apellido
SELECT 
	A.city AS Ciudad,
    A.last_name AS Apellido,
    A.first_name AS Nombre,
    B.city AS CiudadJefe,
    B.last_name AS ApellidoJefe,
    B.first_name AS NombreJefe
FROM employees AS A, employees AS B
WHERE A.employee_id <> B.employee_id
AND A.reports_to = B.employee_id;

-- El director de la empresa es:
SELECT last_name , first_name
FROM employees
WHERE reports_to IS NULL;

-- BONUS: NombreCompañia , PedidoRealizado, Fecha
SELECT customers.company_name AS NombreEmpresa , orders.order_date AS OrderDate , orders.order_id
FROM orders
NATURAL JOIN customers;

-- BONUS: Tipos de productos vendidos
-- CategoryID , CategoryName , ProductName , ProductSales
SELECT 
	categories.category_id AS CategoryID, 
    categories.category_name AS CategoryName,
    products.product_name AS ProductName,
    SUM((order_details.quantity * order_details.unit_price) * (1 - order_details.discount)) AS ProductSales
FROM products
INNER JOIN categories
	ON products.category_id = categories.category_id
INNER JOIN order_details
	ON products.product_id = order_details.product_id
GROUP BY categories.category_id , categories.category_name, products.product_name;
    
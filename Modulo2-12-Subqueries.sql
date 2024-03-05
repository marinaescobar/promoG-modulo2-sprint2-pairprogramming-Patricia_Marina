USE northwind;

-- 1. Extraed los pedidos con el máximo "order_date" para cada empleado.
-- OrderID , CustomerID, EmployeeID, OrderDate, RequiredDate
SELECT order_id AS OrderID, customer_id AS CustomerID, employee_id AS EmployeeID, order_date AS OrderDate, required_date AS RequiredDate
FROM orders AS o
WHERE order_date = (
    SELECT MAX(order_date)
    FROM orders
    WHERE employee_id = o.employee_id
);

-- 2. Extraer el precio unitario máximo de cada producto vendido.
-- ProductID, Max_unit_price_sold
SELECT product_id AS ProductID, unit_price AS Max_unit_price_sold
FROM order_details AS od
WHERE unit_price = (
	SELECT MAX(unit_price)
    FROM order_details
    WHERE product_id = od.product_id
)
GROUP BY product_id;

-- 3. Extraer información de los productos beverage.
-- ProductID, ProductName, CategoryID
SELECT product_id AS ProductID, product_name AS ProductName, category_id AS CategoryID
FROM products AS pd
WHERE pd.category_id = 
	(SELECT category_id
	FROM categories
    WHERE category_id = 1);

-- 4. Extraer la lsita de países donde viven los clientes, pero sin proveedor en el país.
-- country
SELECT country 
FROM customers
WHERE country NOT IN
	(SELECT country
	FROM suppliers)
GROUP BY country;

-- 5. Extraer los clientes que compraron más de 20 articulos "Grandma's Boysenberry Spread"
-- +20 articulos en un mismo OrderID, OrderID, CustomerID
SELECT order_id AS OrderID, customer_id AS CustomerID
FROM orders
WHERE order_id IN 
	(SELECT order_id
	FROM order_details AS od
    WHERE order_id = od.order_id 
    AND od.product_id = 6 
    AND od.quantity > 20)
GROUP BY order_id;

-- 6. Extraer los 10 productos más caros.
-- Ten_Most_Expensive_Products , UnitPrice
SELECT product_name AS Ten_Most_Expensive_Products, unit_price AS UnitPrice
FROM products
WHERE unit_price IN (
	SELECT unit_price
    FROM products AS pd)
ORDER BY unit_price DESC
LIMIT 10;

-- 7. BONUS: Que producto es más popular.
-- ProductName, Max(SumQuantity)
SELECT products.product_name AS ProductName, SUM(order_details.quantity)
FROM products
INNER JOIN order_details
ON products.product_id = order_details.product_id
GROUP BY products.product_name
HAVING SUM(order_details.quantity) = (
	SELECT MAX(SUM(order_details.quantity))
    FROM order_details AS od
    WHERE od.product_id = od.product_id
)
ORDER BY SUM(order_details.quantity) DESC
LIMIT 1;



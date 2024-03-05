USE northwind;

-- Ejemplo para crear columna temporal: 

SELECT  'Hola!'  AS tipo_nombre
FROM customers;

-- Ciudades que empiezan con "A" o "B".

SELECT city AS City, company_name AS CompanyName, contact_name AS ContactName
FROM customers
WHERE city LIKE 'A%' OR city LIKE  'B%';

-- Número de pedidos que han hecho en las ciudades que empiezan con L.

SELECT customers.city AS City, customers.company_name AS CompanyName, customers.contact_name AS ContactName, COUNT(orders.order_id) AS NumeroPedidos
FROM customers 
INNER JOIN orders ON orders.customer_id = customers.customer_id
WHERE customers.city LIKE 'L%'
GROUP BY  customers.customer_id;

-- Todos los clientes cuyo "contact_title" no incluya "Sales".

SELECT company_name AS CompanyName, contact_name AS ContactName, contact_title AS ContactTitle
FROM customers 
WHERE contact_title NOT IN ("Sales");

-- Todos los clientes que no tengan una "A" en segunda posición en su nombre. 
SELECT contact_name AS ContactName
FROM customers 
WHERE contact_name NOT LIKE ("_a%");

-- Extraer toda la información sobre las compañias que tengamos en la BBDD

SELECT city AS City,  company_name AS Company, contact_name AS ContactName, 'Customers' AS Relationship
FROM customers
UNION ALL
SELECT city AS City,  company_name AS Company, contact_name AS ContactName, 'Suppliers' AS Relationship
FROM suppliers;

-- Extraer todas las categorías de la tabla categories que contengan en la descripción "sweet" o "Sweet".

SELECT `description` AS `Description`
FROM categories 
WHERE `description` LIKE '%sweet%';

-- con regex 
SELECT `description` AS `Description`
FROM categories 
WHERE `description` REGEXP 'sweet|Sweet';
 -- 'sweet' OR `description` REGEXP 'Sweet';

-- Extraed todos los nombres y apellidos de los clientes y empleados que tenemos en la BBDD:
SELECT contact_name AS NombreaApellido, 'Customers' AS Relationship
FROM customers
UNION 
SELECT CONCAT(first_name, " ", last_name) AS NombreApellido, 'Employee' AS Relationship
FROM employees;



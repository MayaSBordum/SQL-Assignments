



SELECT * FROM products
ORDER BY unitprice;

SELECT * FROM customers 
WHERE country = 'UK' OR country = 'Spain';

SELECT * FROM products
WHERE unitsinstock > 100 AND unitprice >= 25;

SELECT DISTINCT shipcountry FROM Orders;

SELECT * FROM orders
WHERE orderDate >= '1996-10-01'
AND orderDate < '1996-11-01';

SELECT * FROM orders
WHERE shipcountry = 'Germany' 
AND orderDate >= '1996-01-01'
AND orderDate <= '1996-12-31'
AND employeeid = 1
AND freight > 100;

SELECT * FROM orders
WHERE shippeddate > requireddate;

SELECT * FROM orders
WHERE shipcountry = 'Canada' 
AND orderDate >= '1997-01-01'
AND orderDate <= '1997-04-30';
 
SELECT * FROM orders
WHERE employeeid IN (2, 5, 8)
AND shipregion IS NOT NULL
AND shipvia IN (1, 3)
ORDER BY Employeeid ASC, shipvia ASC;


SELECT * FROM employees
WHERE region IS NULL 
AND birthdate > '1960-01-01';


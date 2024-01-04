/*
Scale Model Cars - Customers and Products Analysis

This project will attempt to answer the following questions:

1. Which products should we order more of or less of? 
   We will do this by understanding which stock is depleting versus which stock has the highest number of orders.
   This will make it easy to target which products need to be prioritised for restocking
   
2. How should we tailor marketing and communication strategies to customer behaviours?
   
   
3. How much can we spend on acquiring new customers?
*/


/*
Explore Scale Model Cars Database

There are 8 tables in this database for recording all aspects on the business:
	Customers: customer data. Contains sensitive information such as name, address and contact details
	Employees: employee name, contacts, manager, position
	Offices: sales office locations
	Orders: customers' sales orders
	OrderDetails: sales order line for each sales order
	Payments: customers' payment records
	Products: a list of scale model cars
	ProductLines: a list of product line categories
*/

-- Let's look at the number of attributes and number of rows in each table
SELECT 'Customers' AS table_name,
	   (SELECT COUNT(*)
	      FROM pragma_table_info('customers')
	   ) AS number_of_attributes,
       COUNT(*) AS number_of_rows
  FROM customers

 UNION ALL
 
SELECT 'Products' AS table_name,
	   (SELECT COUNT(*)
	      FROM pragma_table_info('products')
	   ) AS number_of_attributes,
       COUNT(*) AS number_of_rows
  FROM products

 UNION ALL
 
SELECT 'ProductLines' AS table_name,
	   (SELECT COUNT(*)
	      FROM pragma_table_info('productlines')
	   ) AS number_of_attributes,
       COUNT(*) AS number_of_rows
  FROM productlines

 UNION ALL
 
SELECT 'Orders' AS table_name,
	   (SELECT COUNT(*)
	      FROM pragma_table_info('orders')
	   ) AS number_of_attributes,
       COUNT(*) AS number_of_rows
  FROM orders

 UNION ALL
 
SELECT 'OrderDetails' AS table_name,
	   (SELECT COUNT(*)
	      FROM pragma_table_info('orderdetails')
	   ) AS number_of_attributes,
       COUNT(*) AS number_of_rows
  FROM orderdetails
  
 UNION ALL
 
SELECT 'Payments' AS table_name,
	   (SELECT COUNT(*)
	      FROM pragma_table_info('payments')
	   ) AS number_of_attributes,
       COUNT(*) AS number_of_rows
  FROM payments
  
 UNION ALL
 
SELECT 'Employees' AS table_name,
	   (SELECT COUNT(*)
	      FROM pragma_table_info('employees')
	   ) AS number_of_attributes,
       COUNT(*) AS number_of_rows
  FROM employees
		
 UNION ALL
 
SELECT 'Offices' AS table_name,
	   (SELECT COUNT(*)
	      FROM pragma_table_info('offices')
	   ) AS number_of_attributes,
       COUNT(*) AS number_of_rows
  FROM offices
/*
Observations:
1. There are fewer payments than orders, suggesting some orders haven't yet been paid or some orders are free. We can explore this later.
2. There are 23 employees and 7 offices, suggesting there may only suggesting there may only be 3 - 4 employees in each office. This can also be explored later, but isn't directly relevant for the purpose of this analysis. 
3. OrderDetails has the most records as it appears to hold information about each individual product purchased within all orders.
*/

-- 1. Which Products Should We Order More of or Less of?
-- i.e. low stock(i.e. product in demand) and product performance				
WITH
low_stock_products AS (
  SELECT od.productCode, p.productName, p.productLine,
         ROUND( SUM(od.quantityOrdered) * 1.00 / (SELECT quantityInStock
                                                    FROM products AS p
                                                   WHERE od.productCode = p.productCode
                                                 ),2) AS low_stock_score
    FROM orderdetails AS od
    LEFT JOIN products AS p
      ON p.productCode = od.productCode
GROUP BY 1, 2, 3
ORDER BY low_stock_score DESC
LIMIT 10
)

  SELECT od.productCode, p.productName, p.productLine,
	     SUM(od.quantityOrdered * od.priceEach) AS product_performance
    FROM orderdetails AS od
    LEFT JOIN products AS p
	  ON p.productCode = od.productCode
   WHERE od.productCode IN (SELECT productCode
							  FROM low_stock_products)
GROUP BY 1, 2, 3
ORDER BY product_performance DESC
   LIMIT 10;

   
-- 2. How Should We Match Marketing and Communication Strategies to Customer Behavior?
-- Top 5 VIP customers 
WITH
vip_customer AS (
  SELECT o.customerNumber,
	     SUM(od.quantityOrdered * (od.priceEach - p.buyPrice)) AS profit
    FROM orderdetails AS od
    JOIN products AS p
      ON od.productCode = p.productCode
    JOIN orders AS o
      ON o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY 2 DESC
   LIMIT 5
)

SELECT c.contactLastName, c.contactFirstName, c.city, c.country,
       vc.profit
  FROM vip_customer  AS vc
  JOIN customers AS c
    ON vc.customerNumber = c.customerNumber;
 
-- Top 5 least engaged customers
WITH
vip_customer AS (
SELECT o.customerNumber,
	     SUM(od.quantityOrdered * (od.priceEach - p.buyPrice)) AS profit
    FROM orderdetails AS od
    JOIN products AS p
      ON od.productCode = p.productCode
    JOIN orders AS o
	  ON o.orderNumber = od.orderNumber
GROUP BY 1
ORDER BY profit
   LIMIT 5
)

SELECT c.contactLastName, c.contactFirstName, c.city, c.country,
       vc.profit
  FROM vip_customer  AS vc
  JOIN customers AS c
    ON vc.customerNumber = c.customerNumber;

-- 3. How Much Can We Spend on Acquiring New Customers?
-- average of customer profits

WITH
customer_profits AS (
  SELECT o.customerNumber, SUM(quantityOrdered * (priceEach - buyPrice)) AS profit
    FROM products p
    JOIN orderdetails od
      ON p.productCode = od.productCode
    JOIN orders o
      ON o.orderNumber = od.orderNumber
GROUP BY o.customerNumber
)
 
 SELECT AVG(profit) AS _avg_customer_profits
   FROM customer_profits

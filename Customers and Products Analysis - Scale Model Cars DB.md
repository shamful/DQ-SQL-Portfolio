# Scale Model Cars - Customers and Products Analysis

This project will attempt to answer the following questions:

1. Which products should we order more of or less of? 
   We will do this by understanding which stock is depleting versus which stock has the highest number of orders.
   This will make it easy to target which products need to be prioritised for restocking
   
2. How should we tailor marketing and communication strategies to customer behaviours?
   
3. How much can we spend on acquiring new customers?

## Explore Scale Model Cars Database

There are 8 tables in this database for recording all aspects on the business:
- Customers: Customer data including sensitive information such as name, address and contact details
- Employees: Employee name, contacts, manager, position
- Offices: Sales office locations
- Orders: Customers' sales orders
- OrderDetails: Sales order line for each sales order
- Payments: Customers' payment records
- Products: A list of scale model cars
- ProductLines: A list of product line categories

### First let's look at the number of attributes and number of rows in each table
```sql
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
```

### Observations:
1. There are fewer payments than orders, suggesting some orders haven't yet been paid or some orders are free. We can explore this later.
2. There are 23 employees and 7 offices, suggesting there may only suggesting there may only be 3 - 4 employees in each office. This can also be explored later but isn't directly relevant to this analysis. 
3. OrderDetails has the most records as it appears to hold information about each product purchased within all orders.

| table_name   | number_of_attributes | number_of_rows |
|--------------|----------------------|----------------|
| Customers    | 13                   | 122            |
| Products     | 9                    | 110            |
| ProductLines | 4                    | 7              |
| Orders       | 7                    | 326            |
| OrderDetails | 5                    | 2996           |
| Payments     | 4                    | 273            |
| Employees    | 8                    | 23             |
| Offices      | 9                    | 7              |

### Question 1. Which Products Should We Order More of or Less of?
low stock(i.e. product in demand) and product performance
```sql
WITH
low_stock_products AS (
  SELECT od.productCode,
         p.productName, p.productLine,
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

  SELECT od.productCode,
         p.productName, p.productLine,
         SUM(od.quantityOrdered * od.priceEach) AS product_performance
    FROM orderdetails AS od
    LEFT JOIN products AS p
	  ON p.productCode = od.productCode
   WHERE od.productCode IN (SELECT productCode
                              FROM low_stock_products)
GROUP BY 1, 2, 3
ORDER BY product_performance DESC
   LIMIT 10;
```
| productCode | productName              | productLine  | product_performance |
|-------------|--------------------------|--------------|---------------------|
| S12_1099    | 1968 Ford Mustang        | Classic Cars | 161531.48           |
| S18_2795    | 1928 Mercedes-Benz SSK   | Vintage Cars | 132275.98           |
| S32_1374    | 1997 BMW F650 ST         | Motorcycles  | 89364.89            |
| S700_3167   | F/A 18 Hornet 1/72       | Planes       | 76618.4             |
| S50_4713    | 2002 Yamaha YZR M1       | Motorcycles  | 73670.64            |
| S700_1938   | The Mayflower            | Ships        | 69531.61            |
| S24_2000    | 1960 BSA Gold Star DBD34 | Motorcycles  | 67193.49            |
| S32_4289    | 1928 Ford Phaeton Deluxe | Vintage Cars | 60493.33            |
| S72_3212    | Pont Yacht               | Ships        | 47550.4             |
| S18_2248    | 1911 Ford Town Car       | Vintage Cars | 45306.77            |

### 2. How Should We Match Marketing and Communication Strategies to Customer Behavior?
#### Let's identify the top 5 VIP customers
```sql
WITH
vip_customer AS (
  SELECT o.customerNumber,
         SUM(od.quantityOrdered * (od.priceEach - p.buyPrice)) AS profit
    FROM orderdetails AS od
    JOIN products AS p
      ON od.productCode = p.productCode
    JOIN orders AS o
      ON o.orderNumber = od.orderNumber
GROUP BY o.customerNumber
ORDER BY profit DESC
   LIMIT 5
)

SELECT c.contactLastName, c.contactFirstName, c.city, c.country,
       vc.profit
  FROM vip_customer  AS vc
  JOIN customers AS c
    ON vc.customerNumber = c.customerNumber;
```
| contactLastName | contactFirstName | city       | country   | profit    |
|-----------------|------------------|------------|-----------|-----------|
| Freyre          | Diego            | Madrid     | Spain     | 326519.66 |
| Nelson          | Susan            | San Rafael | USA       | 236769.39 |
| Young           | Jeff             | NYC        | USA       | 72370.09  |
| Ferguson        | Peter            | Melbourne  | Australia | 70311.07  |
| Labrune         | Janine           | Nantes     | France    | 60875.3   |

#### Now let's identify the top 5 least engaged customers
```sql
WITH
vip_customers AS (
SELECT o.customerNumber,
	     SUM(od.quantityOrdered * (od.priceEach - p.buyPrice)) AS profit
    FROM orderdetails AS od
    JOIN products AS p
      ON od.productCode = p.productCode
    JOIN orders AS o
	  ON o.orderNumber = od.orderNumber
GROUP BY o.customerNumber
ORDER BY profit
   LIMIT 5
)

SELECT c.contactLastName, c.contactFirstName, c.city, c.country,
       vc.profit
  FROM vip_customers  AS vc
  JOIN customers AS c
    ON vc.customerNumber = c.customerNumber;
```
| contactLastName | contactFirstName | city       | country | profit   |
|-----------------|------------------|------------|---------|----------|
| Young           | Mary             | Glendale   | USA     | 2610.87  |
| Taylor          | Leslie           | Brickhaven | USA     | 6586.02  |
| Ricotti         | Franco           | Milan      | Italy   | 9532.93  |
| Schmitt         | Carine           | Nantes     | France  | 10063.8  |
| Smith           | Thomas           | London     | UK      | 10868.04 |

### 3. How Much Can We Spend on Acquiring New Customers?
Average of customer profits - think this needs more work
``` sql
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
   FROM customer_profits;
```
| avg_customer_profits |
|----------------------|
| 39039.5943877551     |

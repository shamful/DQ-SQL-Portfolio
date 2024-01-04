# Scale Model Cars - Customers and Products Analysis

This project will attempt to answer the following questions:

1. Which products should we order more of or less of? 
   We will do this by understanding which stock is depleting versus which stock has the highest number of orders.
   This will make it easy to target which products need to be prioritised for restocking
   
2. How should we tailor marketing and communication strategies to customer behaviours?
   
3. How much can we spend on acquiring new customers?

## Explore Scale Model Cars Database

There are 8 tables in this database for recording all aspects on the business:
- Customers: customer data. Contains sensitive information such as name, address and contact details
- Employees: employee name, contacts, manager, position
- Offices: sales office locations
- Orders: customers' sales orders
- OrderDetails: sales order line for each sales order
- Payments: customers' payment records
- Products: a list of scale model cars
- ProductLines: a list of product line categories

### Let's look at the number of attributes and number of rows in each table
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

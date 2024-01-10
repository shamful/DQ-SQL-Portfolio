# Guided Project: SQL Window Functions for Northwind Traders

## Objective

Northwind Taders is an international gourmet food distributor. Management would like insights to make strategic decisions in several aspects of the business. The projects focus is on:

1. Evaluating employee performance to boost productivity,
2. Understanding product sales and category performance to optimize inventory and marketing strategies,
3. Analyzing sales growth to identify trends, monitor company progress, and make more accurate forecasts,
4. And evaluating customer purchase behavior to target high-value customers with promotional incentives.

## Getting to Know the Data

![alt text](https://github.com/pthom/northwind_psql/blob/master/ER.png?raw=true)

### Tables, data types and number of columns


```sql
%%sql
  SELECT table_name, data_type,
         COUNT(column_name) AS num_of_columns
    FROM information_schema.columns
   WHERE table_schema = 'public'
GROUP BY table_name, data_type
ORDER BY table_name, data_type
```

     * postgresql://postgres:***@localhost:5432/northwind
    36 rows affected.
    




<table>
    <thead>
        <tr>
            <th>table_name</th>
            <th>data_type</th>
            <th>num_of_columns</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>categories</td>
            <td>bytea</td>
            <td>1</td>
        </tr>
        <tr>
            <td>categories</td>
            <td>character varying</td>
            <td>1</td>
        </tr>
        <tr>
            <td>categories</td>
            <td>smallint</td>
            <td>1</td>
        </tr>
        <tr>
            <td>categories</td>
            <td>text</td>
            <td>1</td>
        </tr>
        <tr>
            <td>customer_customer_demo</td>
            <td>character varying</td>
            <td>2</td>
        </tr>
        <tr>
            <td>customer_demographics</td>
            <td>character varying</td>
            <td>1</td>
        </tr>
        <tr>
            <td>customer_demographics</td>
            <td>text</td>
            <td>1</td>
        </tr>
        <tr>
            <td>customers</td>
            <td>character varying</td>
            <td>11</td>
        </tr>
        <tr>
            <td>employee_territories</td>
            <td>character varying</td>
            <td>1</td>
        </tr>
        <tr>
            <td>employee_territories</td>
            <td>smallint</td>
            <td>1</td>
        </tr>
        <tr>
            <td>employees</td>
            <td>bytea</td>
            <td>1</td>
        </tr>
        <tr>
            <td>employees</td>
            <td>character varying</td>
            <td>12</td>
        </tr>
        <tr>
            <td>employees</td>
            <td>date</td>
            <td>2</td>
        </tr>
        <tr>
            <td>employees</td>
            <td>smallint</td>
            <td>2</td>
        </tr>
        <tr>
            <td>employees</td>
            <td>text</td>
            <td>1</td>
        </tr>
        <tr>
            <td>order_details</td>
            <td>real</td>
            <td>2</td>
        </tr>
        <tr>
            <td>order_details</td>
            <td>smallint</td>
            <td>3</td>
        </tr>
        <tr>
            <td>orders</td>
            <td>character varying</td>
            <td>7</td>
        </tr>
        <tr>
            <td>orders</td>
            <td>date</td>
            <td>3</td>
        </tr>
        <tr>
            <td>orders</td>
            <td>real</td>
            <td>1</td>
        </tr>
        <tr>
            <td>orders</td>
            <td>smallint</td>
            <td>3</td>
        </tr>
        <tr>
            <td>products</td>
            <td>character varying</td>
            <td>2</td>
        </tr>
        <tr>
            <td>products</td>
            <td>integer</td>
            <td>1</td>
        </tr>
        <tr>
            <td>products</td>
            <td>real</td>
            <td>1</td>
        </tr>
        <tr>
            <td>products</td>
            <td>smallint</td>
            <td>6</td>
        </tr>
        <tr>
            <td>region</td>
            <td>character varying</td>
            <td>1</td>
        </tr>
        <tr>
            <td>region</td>
            <td>smallint</td>
            <td>1</td>
        </tr>
        <tr>
            <td>shippers</td>
            <td>character varying</td>
            <td>2</td>
        </tr>
        <tr>
            <td>shippers</td>
            <td>smallint</td>
            <td>1</td>
        </tr>
        <tr>
            <td>suppliers</td>
            <td>character varying</td>
            <td>10</td>
        </tr>
        <tr>
            <td>suppliers</td>
            <td>smallint</td>
            <td>1</td>
        </tr>
        <tr>
            <td>suppliers</td>
            <td>text</td>
            <td>1</td>
        </tr>
        <tr>
            <td>territories</td>
            <td>character varying</td>
            <td>2</td>
        </tr>
        <tr>
            <td>territories</td>
            <td>smallint</td>
            <td>1</td>
        </tr>
        <tr>
            <td>us_states</td>
            <td>character varying</td>
            <td>3</td>
        </tr>
        <tr>
            <td>us_states</td>
            <td>smallint</td>
            <td>1</td>
        </tr>
    </tbody>
</table>



### Order Details

- Discount appears to be a percentage


```sql
%%sql
SELECT *
  FROM order_details
 LIMIT 10;
```

     * postgresql://postgres:***@localhost:5432/northwind
    10 rows affected.
    




<table>
    <thead>
        <tr>
            <th>order_id</th>
            <th>product_id</th>
            <th>unit_price</th>
            <th>quantity</th>
            <th>discount</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>10248</td>
            <td>11</td>
            <td>14.0</td>
            <td>12</td>
            <td>0.0</td>
        </tr>
        <tr>
            <td>10248</td>
            <td>42</td>
            <td>9.8</td>
            <td>10</td>
            <td>0.0</td>
        </tr>
        <tr>
            <td>10248</td>
            <td>72</td>
            <td>34.8</td>
            <td>5</td>
            <td>0.0</td>
        </tr>
        <tr>
            <td>10249</td>
            <td>14</td>
            <td>18.6</td>
            <td>9</td>
            <td>0.0</td>
        </tr>
        <tr>
            <td>10249</td>
            <td>51</td>
            <td>42.4</td>
            <td>40</td>
            <td>0.0</td>
        </tr>
        <tr>
            <td>10250</td>
            <td>41</td>
            <td>7.7</td>
            <td>10</td>
            <td>0.0</td>
        </tr>
        <tr>
            <td>10250</td>
            <td>51</td>
            <td>42.4</td>
            <td>35</td>
            <td>0.15</td>
        </tr>
        <tr>
            <td>10250</td>
            <td>65</td>
            <td>16.8</td>
            <td>15</td>
            <td>0.15</td>
        </tr>
        <tr>
            <td>10251</td>
            <td>22</td>
            <td>16.8</td>
            <td>6</td>
            <td>0.05</td>
        </tr>
        <tr>
            <td>10251</td>
            <td>57</td>
            <td>15.6</td>
            <td>15</td>
            <td>0.05</td>
        </tr>
    </tbody>
</table>




```sql
%%sql
SELECT *
  FROM orders
LIMIT 3;
```

     * postgresql://postgres:***@localhost:5432/northwind
    3 rows affected.
    




<table>
    <thead>
        <tr>
            <th>order_id</th>
            <th>customer_id</th>
            <th>employee_id</th>
            <th>order_date</th>
            <th>required_date</th>
            <th>shipped_date</th>
            <th>ship_via</th>
            <th>freight</th>
            <th>ship_name</th>
            <th>ship_address</th>
            <th>ship_city</th>
            <th>ship_region</th>
            <th>ship_postal_code</th>
            <th>ship_country</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>10248</td>
            <td>VINET</td>
            <td>5</td>
            <td>1996-07-04</td>
            <td>1996-08-01</td>
            <td>1996-07-16</td>
            <td>3</td>
            <td>32.38</td>
            <td>Vins et alcools Chevalier</td>
            <td>59 rue de l&#x27;Abbaye</td>
            <td>Reims</td>
            <td>None</td>
            <td>51100</td>
            <td>France</td>
        </tr>
        <tr>
            <td>10249</td>
            <td>TOMSP</td>
            <td>6</td>
            <td>1996-07-05</td>
            <td>1996-08-16</td>
            <td>1996-07-10</td>
            <td>1</td>
            <td>11.61</td>
            <td>Toms Spezialitäten</td>
            <td>Luisenstr. 48</td>
            <td>Münster</td>
            <td>None</td>
            <td>44087</td>
            <td>Germany</td>
        </tr>
        <tr>
            <td>10250</td>
            <td>HANAR</td>
            <td>4</td>
            <td>1996-07-08</td>
            <td>1996-08-05</td>
            <td>1996-07-12</td>
            <td>2</td>
            <td>65.83</td>
            <td>Hanari Carnes</td>
            <td>Rua do Paço, 67</td>
            <td>Rio de Janeiro</td>
            <td>RJ</td>
            <td>05454-876</td>
            <td>Brazil</td>
        </tr>
    </tbody>
</table>




```sql
%%sql
SELECT *
  FROM products
 LIMIT 3;
```

     * postgresql://postgres:***@localhost:5432/northwind
    3 rows affected.
    




<table>
    <thead>
        <tr>
            <th>product_id</th>
            <th>product_name</th>
            <th>supplier_id</th>
            <th>category_id</th>
            <th>quantity_per_unit</th>
            <th>unit_price</th>
            <th>units_in_stock</th>
            <th>units_on_order</th>
            <th>reorder_level</th>
            <th>discontinued</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>Chai</td>
            <td>8</td>
            <td>1</td>
            <td>10 boxes x 30 bags</td>
            <td>18.0</td>
            <td>39</td>
            <td>0</td>
            <td>10</td>
            <td>1</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Chang</td>
            <td>1</td>
            <td>1</td>
            <td>24 - 12 oz bottles</td>
            <td>19.0</td>
            <td>17</td>
            <td>40</td>
            <td>25</td>
            <td>1</td>
        </tr>
        <tr>
            <td>3</td>
            <td>Aniseed Syrup</td>
            <td>1</td>
            <td>2</td>
            <td>12 - 550 ml bottles</td>
            <td>10.0</td>
            <td>13</td>
            <td>70</td>
            <td>25</td>
            <td>0</td>
        </tr>
    </tbody>
</table>




```sql
%%sql
SELECT *
  FROM employees
 LIMIT 3;
```

     * postgresql://postgres:***@localhost:5432/northwind
    3 rows affected.
    




<table>
    <thead>
        <tr>
            <th>employee_id</th>
            <th>last_name</th>
            <th>first_name</th>
            <th>title</th>
            <th>title_of_courtesy</th>
            <th>birth_date</th>
            <th>hire_date</th>
            <th>address</th>
            <th>city</th>
            <th>region</th>
            <th>postal_code</th>
            <th>country</th>
            <th>home_phone</th>
            <th>extension</th>
            <th>photo</th>
            <th>notes</th>
            <th>reports_to</th>
            <th>photo_path</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>Davolio</td>
            <td>Nancy</td>
            <td>Sales Representative</td>
            <td>Ms.</td>
            <td>1948-12-08</td>
            <td>1992-05-01</td>
            <td>507 - 20th Ave. E.\nApt. 2A</td>
            <td>Seattle</td>
            <td>WA</td>
            <td>98122</td>
            <td>USA</td>
            <td>(206) 555-9857</td>
            <td>5467</td>
            <td>None</td>
            <td>Education includes a BA in psychology from Colorado State University in 1970.  She also completed The Art of the Cold Call.  Nancy is a member of Toastmasters International.</td>
            <td>2</td>
            <td>http://accweb/emmployees/davolio.bmp</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Fuller</td>
            <td>Andrew</td>
            <td>Vice President, Sales</td>
            <td>Dr.</td>
            <td>1952-02-19</td>
            <td>1992-08-14</td>
            <td>908 W. Capital Way</td>
            <td>Tacoma</td>
            <td>WA</td>
            <td>98401</td>
            <td>USA</td>
            <td>(206) 555-9482</td>
            <td>3457</td>
            <td>None</td>
            <td>Andrew received his BTS commercial in 1974 and a Ph.D. in international marketing from the University of Dallas in 1981.  He is fluent in French and Italian and reads German.  He joined the company as a sales representative, was promoted to sales manager in January 1992 and to vice president of sales in March 1993.  Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.</td>
            <td>None</td>
            <td>http://accweb/emmployees/fuller.bmp</td>
        </tr>
        <tr>
            <td>3</td>
            <td>Leverling</td>
            <td>Janet</td>
            <td>Sales Representative</td>
            <td>Ms.</td>
            <td>1963-08-30</td>
            <td>1992-04-01</td>
            <td>722 Moss Bay Blvd.</td>
            <td>Kirkland</td>
            <td>WA</td>
            <td>98033</td>
            <td>USA</td>
            <td>(206) 555-3412</td>
            <td>3355</td>
            <td>None</td>
            <td>Janet has a BS degree in chemistry from Boston College (1984).  She has also completed a certificate program in food retailing management.  Janet was hired as a sales associate in 1991 and promoted to sales representative in February 1992.</td>
            <td>2</td>
            <td>http://accweb/emmployees/leverling.bmp</td>
        </tr>
    </tbody>
</table>



### Type Error Occurred with the employees table
Employees table had a photo column which seemed to be causing an error with the table visualisation. Updated photo column in database to remove the BMP images from this column.

```Update employees SET photo = null;```


```python

```


```sql
%%sql
SELECT *
  FROM information_schema.columns
 WHERE column_name = 'photo'
 LIMIT 5;
```

     * postgresql://postgres:***@localhost:5432/northwind
    1 rows affected.
    




<table>
    <thead>
        <tr>
            <th>table_catalog</th>
            <th>table_schema</th>
            <th>table_name</th>
            <th>column_name</th>
            <th>ordinal_position</th>
            <th>column_default</th>
            <th>is_nullable</th>
            <th>data_type</th>
            <th>character_maximum_length</th>
            <th>character_octet_length</th>
            <th>numeric_precision</th>
            <th>numeric_precision_radix</th>
            <th>numeric_scale</th>
            <th>datetime_precision</th>
            <th>interval_type</th>
            <th>interval_precision</th>
            <th>character_set_catalog</th>
            <th>character_set_schema</th>
            <th>character_set_name</th>
            <th>collation_catalog</th>
            <th>collation_schema</th>
            <th>collation_name</th>
            <th>domain_catalog</th>
            <th>domain_schema</th>
            <th>domain_name</th>
            <th>udt_catalog</th>
            <th>udt_schema</th>
            <th>udt_name</th>
            <th>scope_catalog</th>
            <th>scope_schema</th>
            <th>scope_name</th>
            <th>maximum_cardinality</th>
            <th>dtd_identifier</th>
            <th>is_self_referencing</th>
            <th>is_identity</th>
            <th>identity_generation</th>
            <th>identity_start</th>
            <th>identity_increment</th>
            <th>identity_maximum</th>
            <th>identity_minimum</th>
            <th>identity_cycle</th>
            <th>is_generated</th>
            <th>generation_expression</th>
            <th>is_updatable</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>northwind</td>
            <td>public</td>
            <td>employees</td>
            <td>photo</td>
            <td>15</td>
            <td>None</td>
            <td>YES</td>
            <td>bytea</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>northwind</td>
            <td>pg_catalog</td>
            <td>bytea</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>15</td>
            <td>NO</td>
            <td>NO</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>None</td>
            <td>NO</td>
            <td>NEVER</td>
            <td>None</td>
            <td>YES</td>
        </tr>
    </tbody>
</table>




```sql
%%sql
-- Combine orders and customers tables to get more detailed information about each order.

SELECT *
  FROM orders AS o
  JOIN customers AS c
    ON o.customer_id = c.customer_id 
 LIMIT 5;


```

     * postgresql://postgres:***@localhost:5432/northwind
    5 rows affected.
    




<table>
    <thead>
        <tr>
            <th>order_id</th>
            <th>customer_id</th>
            <th>employee_id</th>
            <th>order_date</th>
            <th>required_date</th>
            <th>shipped_date</th>
            <th>ship_via</th>
            <th>freight</th>
            <th>ship_name</th>
            <th>ship_address</th>
            <th>ship_city</th>
            <th>ship_region</th>
            <th>ship_postal_code</th>
            <th>ship_country</th>
            <th>customer_id_1</th>
            <th>company_name</th>
            <th>contact_name</th>
            <th>contact_title</th>
            <th>address</th>
            <th>city</th>
            <th>region</th>
            <th>postal_code</th>
            <th>country</th>
            <th>phone</th>
            <th>fax</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>10248</td>
            <td>VINET</td>
            <td>5</td>
            <td>1996-07-04</td>
            <td>1996-08-01</td>
            <td>1996-07-16</td>
            <td>3</td>
            <td>32.38</td>
            <td>Vins et alcools Chevalier</td>
            <td>59 rue de l&#x27;Abbaye</td>
            <td>Reims</td>
            <td>None</td>
            <td>51100</td>
            <td>France</td>
            <td>VINET</td>
            <td>Vins et alcools Chevalier</td>
            <td>Paul Henriot</td>
            <td>Accounting Manager</td>
            <td>59 rue de l&#x27;Abbaye</td>
            <td>Reims</td>
            <td>None</td>
            <td>51100</td>
            <td>France</td>
            <td>26.47.15.10</td>
            <td>26.47.15.11</td>
        </tr>
        <tr>
            <td>10249</td>
            <td>TOMSP</td>
            <td>6</td>
            <td>1996-07-05</td>
            <td>1996-08-16</td>
            <td>1996-07-10</td>
            <td>1</td>
            <td>11.61</td>
            <td>Toms Spezialitäten</td>
            <td>Luisenstr. 48</td>
            <td>Münster</td>
            <td>None</td>
            <td>44087</td>
            <td>Germany</td>
            <td>TOMSP</td>
            <td>Toms Spezialitäten</td>
            <td>Karin Josephs</td>
            <td>Marketing Manager</td>
            <td>Luisenstr. 48</td>
            <td>Münster</td>
            <td>None</td>
            <td>44087</td>
            <td>Germany</td>
            <td>0251-031259</td>
            <td>0251-035695</td>
        </tr>
        <tr>
            <td>10250</td>
            <td>HANAR</td>
            <td>4</td>
            <td>1996-07-08</td>
            <td>1996-08-05</td>
            <td>1996-07-12</td>
            <td>2</td>
            <td>65.83</td>
            <td>Hanari Carnes</td>
            <td>Rua do Paço, 67</td>
            <td>Rio de Janeiro</td>
            <td>RJ</td>
            <td>05454-876</td>
            <td>Brazil</td>
            <td>HANAR</td>
            <td>Hanari Carnes</td>
            <td>Mario Pontes</td>
            <td>Accounting Manager</td>
            <td>Rua do Paço, 67</td>
            <td>Rio de Janeiro</td>
            <td>RJ</td>
            <td>05454-876</td>
            <td>Brazil</td>
            <td>(21) 555-0091</td>
            <td>(21) 555-8765</td>
        </tr>
        <tr>
            <td>10251</td>
            <td>VICTE</td>
            <td>3</td>
            <td>1996-07-08</td>
            <td>1996-08-05</td>
            <td>1996-07-15</td>
            <td>1</td>
            <td>41.34</td>
            <td>Victuailles en stock</td>
            <td>2, rue du Commerce</td>
            <td>Lyon</td>
            <td>None</td>
            <td>69004</td>
            <td>France</td>
            <td>VICTE</td>
            <td>Victuailles en stock</td>
            <td>Mary Saveley</td>
            <td>Sales Agent</td>
            <td>2, rue du Commerce</td>
            <td>Lyon</td>
            <td>None</td>
            <td>69004</td>
            <td>France</td>
            <td>78.32.54.86</td>
            <td>78.32.54.87</td>
        </tr>
        <tr>
            <td>10252</td>
            <td>SUPRD</td>
            <td>4</td>
            <td>1996-07-09</td>
            <td>1996-08-06</td>
            <td>1996-07-11</td>
            <td>2</td>
            <td>51.3</td>
            <td>Suprêmes délices</td>
            <td>Boulevard Tirou, 255</td>
            <td>Charleroi</td>
            <td>None</td>
            <td>B-6000</td>
            <td>Belgium</td>
            <td>SUPRD</td>
            <td>Suprêmes délices</td>
            <td>Pascale Cartrain</td>
            <td>Accounting Manager</td>
            <td>Boulevard Tirou, 255</td>
            <td>Charleroi</td>
            <td>None</td>
            <td>B-6000</td>
            <td>Belgium</td>
            <td>(071) 23 67 22 20</td>
            <td>(071) 23 67 22 21</td>
        </tr>
    </tbody>
</table>




```sql
%%sql
-- Combine order_details, products, and orders tables to get detailed order information, including the product name and quantity

SELECT *
  FROM orders AS o
  JOIN order_details AS od
    ON o.order_id = od.order_id
  JOIN products AS p
    ON p.product_id = od.product_id
 LIMIT 5;
    
```

     * postgresql://postgres:***@localhost:5432/northwind
    5 rows affected.
    




<table>
    <thead>
        <tr>
            <th>order_id</th>
            <th>customer_id</th>
            <th>employee_id</th>
            <th>order_date</th>
            <th>required_date</th>
            <th>shipped_date</th>
            <th>ship_via</th>
            <th>freight</th>
            <th>ship_name</th>
            <th>ship_address</th>
            <th>ship_city</th>
            <th>ship_region</th>
            <th>ship_postal_code</th>
            <th>ship_country</th>
            <th>order_id_1</th>
            <th>product_id</th>
            <th>unit_price</th>
            <th>quantity</th>
            <th>discount</th>
            <th>product_id_1</th>
            <th>product_name</th>
            <th>supplier_id</th>
            <th>category_id</th>
            <th>quantity_per_unit</th>
            <th>unit_price_1</th>
            <th>units_in_stock</th>
            <th>units_on_order</th>
            <th>reorder_level</th>
            <th>discontinued</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>10248</td>
            <td>VINET</td>
            <td>5</td>
            <td>1996-07-04</td>
            <td>1996-08-01</td>
            <td>1996-07-16</td>
            <td>3</td>
            <td>32.38</td>
            <td>Vins et alcools Chevalier</td>
            <td>59 rue de l&#x27;Abbaye</td>
            <td>Reims</td>
            <td>None</td>
            <td>51100</td>
            <td>France</td>
            <td>10248</td>
            <td>11</td>
            <td>14.0</td>
            <td>12</td>
            <td>0.0</td>
            <td>11</td>
            <td>Queso Cabrales</td>
            <td>5</td>
            <td>4</td>
            <td>1 kg pkg.</td>
            <td>21.0</td>
            <td>22</td>
            <td>30</td>
            <td>30</td>
            <td>0</td>
        </tr>
        <tr>
            <td>10248</td>
            <td>VINET</td>
            <td>5</td>
            <td>1996-07-04</td>
            <td>1996-08-01</td>
            <td>1996-07-16</td>
            <td>3</td>
            <td>32.38</td>
            <td>Vins et alcools Chevalier</td>
            <td>59 rue de l&#x27;Abbaye</td>
            <td>Reims</td>
            <td>None</td>
            <td>51100</td>
            <td>France</td>
            <td>10248</td>
            <td>42</td>
            <td>9.8</td>
            <td>10</td>
            <td>0.0</td>
            <td>42</td>
            <td>Singaporean Hokkien Fried Mee</td>
            <td>20</td>
            <td>5</td>
            <td>32 - 1 kg pkgs.</td>
            <td>14.0</td>
            <td>26</td>
            <td>0</td>
            <td>0</td>
            <td>1</td>
        </tr>
        <tr>
            <td>10248</td>
            <td>VINET</td>
            <td>5</td>
            <td>1996-07-04</td>
            <td>1996-08-01</td>
            <td>1996-07-16</td>
            <td>3</td>
            <td>32.38</td>
            <td>Vins et alcools Chevalier</td>
            <td>59 rue de l&#x27;Abbaye</td>
            <td>Reims</td>
            <td>None</td>
            <td>51100</td>
            <td>France</td>
            <td>10248</td>
            <td>72</td>
            <td>34.8</td>
            <td>5</td>
            <td>0.0</td>
            <td>72</td>
            <td>Mozzarella di Giovanni</td>
            <td>14</td>
            <td>4</td>
            <td>24 - 200 g pkgs.</td>
            <td>34.8</td>
            <td>14</td>
            <td>0</td>
            <td>0</td>
            <td>0</td>
        </tr>
        <tr>
            <td>10249</td>
            <td>TOMSP</td>
            <td>6</td>
            <td>1996-07-05</td>
            <td>1996-08-16</td>
            <td>1996-07-10</td>
            <td>1</td>
            <td>11.61</td>
            <td>Toms Spezialitäten</td>
            <td>Luisenstr. 48</td>
            <td>Münster</td>
            <td>None</td>
            <td>44087</td>
            <td>Germany</td>
            <td>10249</td>
            <td>14</td>
            <td>18.6</td>
            <td>9</td>
            <td>0.0</td>
            <td>14</td>
            <td>Tofu</td>
            <td>6</td>
            <td>7</td>
            <td>40 - 100 g pkgs.</td>
            <td>23.25</td>
            <td>35</td>
            <td>0</td>
            <td>0</td>
            <td>0</td>
        </tr>
        <tr>
            <td>10249</td>
            <td>TOMSP</td>
            <td>6</td>
            <td>1996-07-05</td>
            <td>1996-08-16</td>
            <td>1996-07-10</td>
            <td>1</td>
            <td>11.61</td>
            <td>Toms Spezialitäten</td>
            <td>Luisenstr. 48</td>
            <td>Münster</td>
            <td>None</td>
            <td>44087</td>
            <td>Germany</td>
            <td>10249</td>
            <td>51</td>
            <td>42.4</td>
            <td>40</td>
            <td>0.0</td>
            <td>51</td>
            <td>Manjimup Dried Apples</td>
            <td>24</td>
            <td>7</td>
            <td>50 - 300 g pkgs.</td>
            <td>53.0</td>
            <td>20</td>
            <td>0</td>
            <td>10</td>
            <td>0</td>
        </tr>
    </tbody>
</table>




```sql
%%sql
-- Combine employees and orders tables to see who is responsible for each order.

SELECT e.employee_id, e.first_name, e.last_name,
       o.*
  FROM orders AS o
  LEFT JOIN employees AS e
    ON o.employee_id = e.employee_id
 LIMIT 5;
```

     * postgresql://postgres:***@localhost:5432/northwind
    5 rows affected.
    




<table>
    <thead>
        <tr>
            <th>employee_id</th>
            <th>first_name</th>
            <th>last_name</th>
            <th>order_id</th>
            <th>customer_id</th>
            <th>employee_id_1</th>
            <th>order_date</th>
            <th>required_date</th>
            <th>shipped_date</th>
            <th>ship_via</th>
            <th>freight</th>
            <th>ship_name</th>
            <th>ship_address</th>
            <th>ship_city</th>
            <th>ship_region</th>
            <th>ship_postal_code</th>
            <th>ship_country</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>5</td>
            <td>Steven</td>
            <td>Buchanan</td>
            <td>10248</td>
            <td>VINET</td>
            <td>5</td>
            <td>1996-07-04</td>
            <td>1996-08-01</td>
            <td>1996-07-16</td>
            <td>3</td>
            <td>32.38</td>
            <td>Vins et alcools Chevalier</td>
            <td>59 rue de l&#x27;Abbaye</td>
            <td>Reims</td>
            <td>None</td>
            <td>51100</td>
            <td>France</td>
        </tr>
        <tr>
            <td>6</td>
            <td>Michael</td>
            <td>Suyama</td>
            <td>10249</td>
            <td>TOMSP</td>
            <td>6</td>
            <td>1996-07-05</td>
            <td>1996-08-16</td>
            <td>1996-07-10</td>
            <td>1</td>
            <td>11.61</td>
            <td>Toms Spezialitäten</td>
            <td>Luisenstr. 48</td>
            <td>Münster</td>
            <td>None</td>
            <td>44087</td>
            <td>Germany</td>
        </tr>
        <tr>
            <td>4</td>
            <td>Margaret</td>
            <td>Peacock</td>
            <td>10250</td>
            <td>HANAR</td>
            <td>4</td>
            <td>1996-07-08</td>
            <td>1996-08-05</td>
            <td>1996-07-12</td>
            <td>2</td>
            <td>65.83</td>
            <td>Hanari Carnes</td>
            <td>Rua do Paço, 67</td>
            <td>Rio de Janeiro</td>
            <td>RJ</td>
            <td>05454-876</td>
            <td>Brazil</td>
        </tr>
        <tr>
            <td>3</td>
            <td>Janet</td>
            <td>Leverling</td>
            <td>10251</td>
            <td>VICTE</td>
            <td>3</td>
            <td>1996-07-08</td>
            <td>1996-08-05</td>
            <td>1996-07-15</td>
            <td>1</td>
            <td>41.34</td>
            <td>Victuailles en stock</td>
            <td>2, rue du Commerce</td>
            <td>Lyon</td>
            <td>None</td>
            <td>69004</td>
            <td>France</td>
        </tr>
        <tr>
            <td>4</td>
            <td>Margaret</td>
            <td>Peacock</td>
            <td>10252</td>
            <td>SUPRD</td>
            <td>4</td>
            <td>1996-07-09</td>
            <td>1996-08-06</td>
            <td>1996-07-11</td>
            <td>2</td>
            <td>51.3</td>
            <td>Suprêmes délices</td>
            <td>Boulevard Tirou, 255</td>
            <td>Charleroi</td>
            <td>None</td>
            <td>B-6000</td>
            <td>Belgium</td>
        </tr>
    </tbody>
</table>



## Ranking Employee Sales Performance

Northwind Traders would like to comprehensively review the company's sales performance from an employee perspective. The objective is twofold:

- First, the management team wants to recognize and reward top-performing employees, fostering a culture of excellence within the organization.
- Second, they want to identify employees who might be struggling so that they can offer the necessary training or resources to help them improve.


```sql
%%sql
-- calculate total sales minus discount for each employee
WITH
employee_sales AS (
  SELECT e.employee_id, 
         e.first_name ||' '|| e.last_name AS employee_name,
         ROUND(SUM( (unit_price * quantity) - Unit_Price * Quantity * discount)::decimal,2) AS total_sales
    FROM employees AS e
    JOIN orders AS o
      ON e.employee_id = o.employee_id
    JOIN order_details AS od
      ON o.order_id = od.order_id
GROUP BY e.employee_id
)

-- use CTE to rank each employee by total sales
SELECT *,
       RANK() OVER(ORDER BY total_sales DESC) AS rank
  FROM employee_sales;
```

     * postgresql://postgres:***@localhost:5432/northwind
    9 rows affected.
    




<table>
    <thead>
        <tr>
            <th>employee_id</th>
            <th>employee_name</th>
            <th>total_sales</th>
            <th>rank</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>4</td>
            <td>Margaret Peacock</td>
            <td>232890.85</td>
            <td>1</td>
        </tr>
        <tr>
            <td>3</td>
            <td>Janet Leverling</td>
            <td>202812.84</td>
            <td>2</td>
        </tr>
        <tr>
            <td>1</td>
            <td>Nancy Davolio</td>
            <td>192107.60</td>
            <td>3</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Andrew Fuller</td>
            <td>166537.76</td>
            <td>4</td>
        </tr>
        <tr>
            <td>8</td>
            <td>Laura Callahan</td>
            <td>126862.28</td>
            <td>5</td>
        </tr>
        <tr>
            <td>7</td>
            <td>Robert King</td>
            <td>124568.23</td>
            <td>6</td>
        </tr>
        <tr>
            <td>9</td>
            <td>Anne Dodsworth</td>
            <td>77308.07</td>
            <td>7</td>
        </tr>
        <tr>
            <td>6</td>
            <td>Michael Suyama</td>
            <td>73913.13</td>
            <td>8</td>
        </tr>
        <tr>
            <td>5</td>
            <td>Steven Buchanan</td>
            <td>68792.28</td>
            <td>9</td>
        </tr>
    </tbody>
</table>



## Running Total of Monthly Sales
Visualize the progress of the sales and identify trends that might shape the company's future strategies.

Visualize the company's sales progress over time on a monthly basis. This will involve aggregating the sales data at a monthly level and calculating a running total of sales by month. This visual will provide the management team with a clear depiction of sales trends and help identify periods of high or low sales activity.


```sql
%%sql
-- calculate total sales minus discount for each month
WITH
total_monthly_sales AS (
  SELECT DATE_TRUNC('month', order_date)::date AS order_month,
         ROUND(SUM( (unit_price * quantity) - Unit_Price * Quantity * discount)::decimal,2) AS total_sales
    FROM orders AS o
    JOIN order_details AS od
      ON o.order_id = od.order_id
GROUP BY order_month
)

-- calculate running total of sales by month
SELECT order_month AS "Month", total_sales AS "Total Sales",
       SUM(total_sales) OVER(ORDER BY order_month) AS "Running Total Sales"
  FROM total_monthly_sales;
```

     * postgresql://postgres:***@localhost:5432/northwind
    23 rows affected.
    




<table>
    <thead>
        <tr>
            <th>Month</th>
            <th>Total Sales</th>
            <th>Running Total Sales</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1996-07-01</td>
            <td>27861.90</td>
            <td>27861.90</td>
        </tr>
        <tr>
            <td>1996-08-01</td>
            <td>25485.28</td>
            <td>53347.18</td>
        </tr>
        <tr>
            <td>1996-09-01</td>
            <td>26381.40</td>
            <td>79728.58</td>
        </tr>
        <tr>
            <td>1996-10-01</td>
            <td>37515.72</td>
            <td>117244.30</td>
        </tr>
        <tr>
            <td>1996-11-01</td>
            <td>45600.05</td>
            <td>162844.35</td>
        </tr>
        <tr>
            <td>1996-12-01</td>
            <td>45239.63</td>
            <td>208083.98</td>
        </tr>
        <tr>
            <td>1997-01-01</td>
            <td>61258.07</td>
            <td>269342.05</td>
        </tr>
        <tr>
            <td>1997-02-01</td>
            <td>38483.63</td>
            <td>307825.68</td>
        </tr>
        <tr>
            <td>1997-03-01</td>
            <td>38547.22</td>
            <td>346372.90</td>
        </tr>
        <tr>
            <td>1997-04-01</td>
            <td>53032.95</td>
            <td>399405.85</td>
        </tr>
        <tr>
            <td>1997-05-01</td>
            <td>53781.29</td>
            <td>453187.14</td>
        </tr>
        <tr>
            <td>1997-06-01</td>
            <td>36362.80</td>
            <td>489549.94</td>
        </tr>
        <tr>
            <td>1997-07-01</td>
            <td>51020.86</td>
            <td>540570.80</td>
        </tr>
        <tr>
            <td>1997-08-01</td>
            <td>47287.67</td>
            <td>587858.47</td>
        </tr>
        <tr>
            <td>1997-09-01</td>
            <td>55629.24</td>
            <td>643487.71</td>
        </tr>
        <tr>
            <td>1997-10-01</td>
            <td>66749.23</td>
            <td>710236.94</td>
        </tr>
        <tr>
            <td>1997-11-01</td>
            <td>43533.81</td>
            <td>753770.75</td>
        </tr>
        <tr>
            <td>1997-12-01</td>
            <td>71398.43</td>
            <td>825169.18</td>
        </tr>
        <tr>
            <td>1998-01-01</td>
            <td>94222.11</td>
            <td>919391.29</td>
        </tr>
        <tr>
            <td>1998-02-01</td>
            <td>99415.29</td>
            <td>1018806.58</td>
        </tr>
        <tr>
            <td>1998-03-01</td>
            <td>104854.16</td>
            <td>1123660.74</td>
        </tr>
        <tr>
            <td>1998-04-01</td>
            <td>123798.68</td>
            <td>1247459.42</td>
        </tr>
        <tr>
            <td>1998-05-01</td>
            <td>18333.63</td>
            <td>1265793.05</td>
        </tr>
    </tbody>
</table>



## Month-Over-Month Sales Growth

The management team would like to analyze the month-over-month sales growth rate. Understanding the rate at which sales are increasing or decreasing from month to month will help the management team identify significant trends.

### Observations

- May 1998's highest drop in sales should be ignored as this is due to a lack of data for the orders in this month, with records only covering four days.
- The highest month-over-month growth was in December 1997 with an increase of 64%, although this was after a 34.8% drop in the previous month. After this significant increase sales continued to grow by at least 5%, with a maximum of 32% for the next four months.


```sql
%%sql
-- calculate total sales minus discount for each month
WITH
total_monthly_sales AS (
  SELECT DATE_TRUNC('month', order_date)::date AS order_month,
         ROUND(SUM( (unit_price * quantity) - unit_price * quantity * discount)::decimal,2) AS total_sales
    FROM orders AS o
    JOIN order_details AS od
      ON o.order_id = od.order_id

GROUP BY order_month
),

-- create column with previous months sales
prev_month_sales AS (
SELECT *,
       LAG(total_sales, 1) OVER(ORDER BY order_month) AS prev_month_sales
  FROM total_monthly_sales
)

-- calculate month over month sales change
SELECT order_month AS "Month", total_sales AS "Total Sales",
       total_sales - prev_month_sales AS "# Growth Rate",
       ROUND(((total_sales - prev_month_sales) / prev_month_sales ) * 100,2) || '%' AS "% Growth Rate"
FROM prev_month_sales
```

     * postgresql://postgres:***@localhost:5432/northwind
    23 rows affected.
    




<table>
    <thead>
        <tr>
            <th>Month</th>
            <th>Total Sales</th>
            <th># Growth Rate</th>
            <th>% Growth Rate</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1996-07-01</td>
            <td>27861.90</td>
            <td>None</td>
            <td>None</td>
        </tr>
        <tr>
            <td>1996-08-01</td>
            <td>25485.28</td>
            <td>-2376.62</td>
            <td>-8.53%</td>
        </tr>
        <tr>
            <td>1996-09-01</td>
            <td>26381.40</td>
            <td>896.12</td>
            <td>3.52%</td>
        </tr>
        <tr>
            <td>1996-10-01</td>
            <td>37515.72</td>
            <td>11134.32</td>
            <td>42.21%</td>
        </tr>
        <tr>
            <td>1996-11-01</td>
            <td>45600.05</td>
            <td>8084.33</td>
            <td>21.55%</td>
        </tr>
        <tr>
            <td>1996-12-01</td>
            <td>45239.63</td>
            <td>-360.42</td>
            <td>-0.79%</td>
        </tr>
        <tr>
            <td>1997-01-01</td>
            <td>61258.07</td>
            <td>16018.44</td>
            <td>35.41%</td>
        </tr>
        <tr>
            <td>1997-02-01</td>
            <td>38483.63</td>
            <td>-22774.44</td>
            <td>-37.18%</td>
        </tr>
        <tr>
            <td>1997-03-01</td>
            <td>38547.22</td>
            <td>63.59</td>
            <td>0.17%</td>
        </tr>
        <tr>
            <td>1997-04-01</td>
            <td>53032.95</td>
            <td>14485.73</td>
            <td>37.58%</td>
        </tr>
        <tr>
            <td>1997-05-01</td>
            <td>53781.29</td>
            <td>748.34</td>
            <td>1.41%</td>
        </tr>
        <tr>
            <td>1997-06-01</td>
            <td>36362.80</td>
            <td>-17418.49</td>
            <td>-32.39%</td>
        </tr>
        <tr>
            <td>1997-07-01</td>
            <td>51020.86</td>
            <td>14658.06</td>
            <td>40.31%</td>
        </tr>
        <tr>
            <td>1997-08-01</td>
            <td>47287.67</td>
            <td>-3733.19</td>
            <td>-7.32%</td>
        </tr>
        <tr>
            <td>1997-09-01</td>
            <td>55629.24</td>
            <td>8341.57</td>
            <td>17.64%</td>
        </tr>
        <tr>
            <td>1997-10-01</td>
            <td>66749.23</td>
            <td>11119.99</td>
            <td>19.99%</td>
        </tr>
        <tr>
            <td>1997-11-01</td>
            <td>43533.81</td>
            <td>-23215.42</td>
            <td>-34.78%</td>
        </tr>
        <tr>
            <td>1997-12-01</td>
            <td>71398.43</td>
            <td>27864.62</td>
            <td>64.01%</td>
        </tr>
        <tr>
            <td>1998-01-01</td>
            <td>94222.11</td>
            <td>22823.68</td>
            <td>31.97%</td>
        </tr>
        <tr>
            <td>1998-02-01</td>
            <td>99415.29</td>
            <td>5193.18</td>
            <td>5.51%</td>
        </tr>
        <tr>
            <td>1998-03-01</td>
            <td>104854.16</td>
            <td>5438.87</td>
            <td>5.47%</td>
        </tr>
        <tr>
            <td>1998-04-01</td>
            <td>123798.68</td>
            <td>18944.52</td>
            <td>18.07%</td>
        </tr>
        <tr>
            <td>1998-05-01</td>
            <td>18333.63</td>
            <td>-105465.05</td>
            <td>-85.19%</td>
        </tr>
    </tbody>
</table>



## Identifying High-Value Customers

Management now want to identify high-value customers to whom they can offer targeted promotions and special offers, which could drive increased sales, improve customer retention, and attract new customers.

To do this, they've asked you to identify customers with above-average order values. These customers might be businesses buying in bulk or individuals purchasing high-end products.


```sql
%%sql

--customer identification and calculates the value of each of their orders.
WITH
customer_orders AS (
SELECT o.customer_id, o.order_id,
       ROUND(SUM( unit_price * quantity * (1 - discount))::decimal, 2) AS order_value
  FROM orders AS o
  JOIN order_details AS od
    ON o.order_id = od.order_id
GROUP BY o.customer_id, o.order_id
)

SELECT *,
       CASE
       WHEN order_value > (SELECT AVG(order_value) AS avg_value FROM customer_orders) THEN 'Above Average'
       ELSE 'Below Average'
       END AS "Average Compare"
  FROM customer_orders
 LIMIT 10;


```

     * postgresql://postgres:***@localhost:5432/northwind
    10 rows affected.
    




<table>
    <thead>
        <tr>
            <th>customer_id</th>
            <th>order_id</th>
            <th>order_value</th>
            <th>Average Compare</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>SUPRD</td>
            <td>11038</td>
            <td>732.60</td>
            <td>Below Average</td>
        </tr>
        <tr>
            <td>CACTU</td>
            <td>10782</td>
            <td>12.50</td>
            <td>Below Average</td>
        </tr>
        <tr>
            <td>FAMIA</td>
            <td>10725</td>
            <td>287.80</td>
            <td>Below Average</td>
        </tr>
        <tr>
            <td>GOURL</td>
            <td>10423</td>
            <td>1020.00</td>
            <td>Below Average</td>
        </tr>
        <tr>
            <td>TORTU</td>
            <td>10518</td>
            <td>4150.05</td>
            <td>Above Average</td>
        </tr>
        <tr>
            <td>WANDK</td>
            <td>10356</td>
            <td>1106.40</td>
            <td>Below Average</td>
        </tr>
        <tr>
            <td>FURIB</td>
            <td>10963</td>
            <td>57.80</td>
            <td>Below Average</td>
        </tr>
        <tr>
            <td>WHITC</td>
            <td>10596</td>
            <td>1180.88</td>
            <td>Below Average</td>
        </tr>
        <tr>
            <td>ROMEY</td>
            <td>10282</td>
            <td>155.40</td>
            <td>Below Average</td>
        </tr>
        <tr>
            <td>QUICK</td>
            <td>10658</td>
            <td>4464.60</td>
            <td>Above Average</td>
        </tr>
    </tbody>
</table>



### How many orders are 'Above Average' for each customer?


```sql
%%sql

--customer identification and calculates the value of each of their orders.
WITH
customer_orders AS (
SELECT o.customer_id, o.order_id,
       SUM( (od.unit_price * quantity) - (od.unit_price * quantity * discount)) AS order_value
  FROM orders AS o
  JOIN order_details AS od
    ON o.order_id = od.order_id
GROUP BY o.customer_id, o.order_id
),
above_or_below_avg AS (
SELECT *,
       CASE
       WHEN order_value > (SELECT AVG(order_value) AS avg_value FROM customer_orders) THEN 'Above Average'
       ELSE 'Below Average'
       END AS "Above or Below Average"
  FROM customer_orders
)

SELECT customer_id,
       (SELECT COUNT(*)
          FROM above_or_below_avg AS a
         WHERE a.customer_id = c.customer_id AND a."Above or Below Average" = 'Above Average'
       ) AS "Orders Above Average",
       (SELECT COUNT(*)
          FROM above_or_below_avg AS a
         WHERE a.customer_id = c.customer_id AND a."Above or Below Average" <> 'Above Average'
       ) AS "Orders Below Average"
  FROM customers AS c
 LIMIT 10;

```

     * postgresql://postgres:***@localhost:5432/northwind
    10 rows affected.
    




<table>
    <thead>
        <tr>
            <th>customer_id</th>
            <th>Orders Above Average</th>
            <th>Orders Below Average</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>ALFKI</td>
            <td>0</td>
            <td>6</td>
        </tr>
        <tr>
            <td>ANATR</td>
            <td>0</td>
            <td>4</td>
        </tr>
        <tr>
            <td>ANTON</td>
            <td>2</td>
            <td>5</td>
        </tr>
        <tr>
            <td>AROUT</td>
            <td>3</td>
            <td>10</td>
        </tr>
        <tr>
            <td>BERGS</td>
            <td>5</td>
            <td>13</td>
        </tr>
        <tr>
            <td>BLAUS</td>
            <td>0</td>
            <td>7</td>
        </tr>
        <tr>
            <td>BLONP</td>
            <td>4</td>
            <td>7</td>
        </tr>
        <tr>
            <td>BOLID</td>
            <td>1</td>
            <td>2</td>
        </tr>
        <tr>
            <td>BONAP</td>
            <td>8</td>
            <td>9</td>
        </tr>
        <tr>
            <td>BOTTM</td>
            <td>4</td>
            <td>10</td>
        </tr>
    </tbody>
</table>



## Percentage of Sales for Each Category

Provide the management team with an understanding of sales composition across different product categories. By knowing the percentage of total sales for each product category, they can gain insights into which categories drive most of the company's sales.

Note: BMP / Image column in categories causing issues with loading table so removed images with 

```UPDATE categories SET picture = null;```



```sql
%%sql

-- total sales for each product category
WITH
category_sales AS (
SELECT c.category_id, category_name,
       SUM( (p.unit_price * quantity) - (od.unit_price * quantity * discount)) AS total_sales
  FROM categories AS c
  JOIN products AS p
    ON c.category_id = p.category_id
  JOIN order_details AS od
    ON od.product_id = p.product_id
GROUP BY c.category_id, c.category_name
)

-- percentage of total sales for each product category
SELECT category_id AS "Category ID", category_name AS "Category",
       total_sales AS "Total Sales",
       total_sales / (SELECT SUM(total_sales) FROM category_sales) * 100 AS "Sales Percentage"
  FROM category_sales

-- Note to self: Could have used SUM(total_sales) OVER () * 100 instead of a subquery for "Sales Percentage";
```

     * postgresql://postgres:***@localhost:5432/northwind
    8 rows affected.
    




<table>
    <thead>
        <tr>
            <th>Category ID</th>
            <th>Category</th>
            <th>Total Sales</th>
            <th>Sales Percentage</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>8</td>
            <td>Seafood</td>
            <td>138698.17620495398</td>
            <td>10.195420973128957</td>
        </tr>
        <tr>
            <td>7</td>
            <td>Produce</td>
            <td>106110.97892306349</td>
            <td>7.8000023474916125</td>
        </tr>
        <tr>
            <td>1</td>
            <td>Beverages</td>
            <td>290923.4796905943</td>
            <td>21.385193573347074</td>
        </tr>
        <tr>
            <td>5</td>
            <td>Grains/Cereals</td>
            <td>101865.78743011087</td>
            <td>7.487946950899802</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Condiments</td>
            <td>114390.33561090878</td>
            <td>8.408601026500474</td>
        </tr>
        <tr>
            <td>4</td>
            <td>Dairy Products</td>
            <td>252305.0841197348</td>
            <td>18.546433822318214</td>
        </tr>
        <tr>
            <td>6</td>
            <td>Meat/Poultry</td>
            <td>175516.2492710619</td>
            <td>12.901842676711414</td>
        </tr>
        <tr>
            <td>3</td>
            <td>Confections</td>
            <td>180586.66500423528</td>
            <td>13.274558629602454</td>
        </tr>
    </tbody>
</table>



## Top Products Per Category

The management team wants to know the top three items sold in each product category. This will allow them to identify star performers and ensure that these products are kept in stock and marketed prominently.


```sql
%%sql

-- total sales for each product
--WITH
--product_sales AS (
    
    
SELECT p.product_id, p.category_id product_name,
       SUM( (p.unit_price * quantity) - (od.unit_price * quantity * discount)) AS total_sales
  FROM products AS p
  JOIN order_details AS od
    ON od.product_id = p.product_id
GROUP BY p.product_id, product_name
LIMIT 10
--)
```

     * postgresql://postgres:***@localhost:5432/northwind
    10 rows affected.
    




<table>
    <thead>
        <tr>
            <th>product_id</th>
            <th>product_name</th>
            <th>total_sales</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>74</td>
            <td>7</td>
            <td>2836.4999990463257</td>
        </tr>
        <tr>
            <td>54</td>
            <td>6</td>
            <td>5231.987357609347</td>
        </tr>
        <tr>
            <td>29</td>
            <td>6</td>
            <td>84979.61260879139</td>
        </tr>
        <tr>
            <td>71</td>
            <td>4</td>
            <td>21400.02497317195</td>
        </tr>
        <tr>
            <td>4</td>
            <td>2</td>
            <td>9109.099985733628</td>
        </tr>
        <tr>
            <td>68</td>
            <td>3</td>
            <td>9338.999996185303</td>
        </tr>
        <tr>
            <td>34</td>
            <td>1</td>
            <td>6756.399993702769</td>
        </tr>
        <tr>
            <td>51</td>
            <td>7</td>
            <td>44035.04992691204</td>
        </tr>
        <tr>
            <td>52</td>
            <td>5</td>
            <td>3349.149998380989</td>
        </tr>
        <tr>
            <td>70</td>
            <td>1</td>
            <td>11455.649988468736</td>
        </tr>
    </tbody>
</table>




```sql
%%sql

-- total sales for each product
WITH
product_sales AS ( 
SELECT p.product_id, product_name,  p.category_id,
       SUM( (p.unit_price * quantity) - (od.unit_price * quantity * discount)) AS total_sales,
       ROW_NUMBER() OVER(
                      PARTITION BY category_id
                      ORDER BY SUM( (p.unit_price * quantity) - (od.unit_price * quantity * discount)) DESC
                    ) AS sales_ranking
  FROM products AS p
  JOIN order_details AS od
    ON od.product_id = p.product_id
GROUP BY p.product_id, product_name,  p.category_id
ORDER BY p.category_id
)
 
SELECT p.category_id, category_name, product_id, product_name, sales_ranking
  FROM product_sales AS p
  JOIN categories AS c
    ON p.category_id = c.category_id
WHERE sales_ranking <= 3
```

     * postgresql://postgres:***@localhost:5432/northwind
    24 rows affected.
    




<table>
    <thead>
        <tr>
            <th>category_id</th>
            <th>category_name</th>
            <th>product_id</th>
            <th>product_name</th>
            <th>sales_ranking</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>Beverages</td>
            <td>38</td>
            <td>Côte de Blaye</td>
            <td>1</td>
        </tr>
        <tr>
            <td>1</td>
            <td>Beverages</td>
            <td>43</td>
            <td>Ipoh Coffee</td>
            <td>2</td>
        </tr>
        <tr>
            <td>1</td>
            <td>Beverages</td>
            <td>2</td>
            <td>Chang</td>
            <td>3</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Condiments</td>
            <td>63</td>
            <td>Vegie-spread</td>
            <td>1</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Condiments</td>
            <td>61</td>
            <td>Sirop d&#x27;érable</td>
            <td>2</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Condiments</td>
            <td>65</td>
            <td>Louisiana Fiery Hot Pepper Sauce</td>
            <td>3</td>
        </tr>
        <tr>
            <td>3</td>
            <td>Confections</td>
            <td>62</td>
            <td>Tarte au sucre</td>
            <td>1</td>
        </tr>
        <tr>
            <td>3</td>
            <td>Confections</td>
            <td>20</td>
            <td>Sir Rodney&#x27;s Marmalade</td>
            <td>2</td>
        </tr>
        <tr>
            <td>3</td>
            <td>Confections</td>
            <td>26</td>
            <td>Gumbär Gummibärchen</td>
            <td>3</td>
        </tr>
        <tr>
            <td>4</td>
            <td>Dairy Products</td>
            <td>59</td>
            <td>Raclette Courdavault</td>
            <td>1</td>
        </tr>
        <tr>
            <td>4</td>
            <td>Dairy Products</td>
            <td>60</td>
            <td>Camembert Pierrot</td>
            <td>2</td>
        </tr>
        <tr>
            <td>4</td>
            <td>Dairy Products</td>
            <td>72</td>
            <td>Mozzarella di Giovanni</td>
            <td>3</td>
        </tr>
        <tr>
            <td>5</td>
            <td>Grains/Cereals</td>
            <td>56</td>
            <td>Gnocchi di nonna Alice</td>
            <td>1</td>
        </tr>
        <tr>
            <td>5</td>
            <td>Grains/Cereals</td>
            <td>64</td>
            <td>Wimmers gute Semmelknödel</td>
            <td>2</td>
        </tr>
        <tr>
            <td>5</td>
            <td>Grains/Cereals</td>
            <td>42</td>
            <td>Singaporean Hokkien Fried Mee</td>
            <td>3</td>
        </tr>
        <tr>
            <td>6</td>
            <td>Meat/Poultry</td>
            <td>29</td>
            <td>Thüringer Rostbratwurst</td>
            <td>1</td>
        </tr>
        <tr>
            <td>6</td>
            <td>Meat/Poultry</td>
            <td>17</td>
            <td>Alice Mutton</td>
            <td>2</td>
        </tr>
        <tr>
            <td>6</td>
            <td>Meat/Poultry</td>
            <td>53</td>
            <td>Perth Pasties</td>
            <td>3</td>
        </tr>
        <tr>
            <td>7</td>
            <td>Produce</td>
            <td>51</td>
            <td>Manjimup Dried Apples</td>
            <td>1</td>
        </tr>
        <tr>
            <td>7</td>
            <td>Produce</td>
            <td>28</td>
            <td>Rössle Sauerkraut</td>
            <td>2</td>
        </tr>
        <tr>
            <td>7</td>
            <td>Produce</td>
            <td>7</td>
            <td>Uncle Bob&#x27;s Organic Dried Pears</td>
            <td>3</td>
        </tr>
        <tr>
            <td>8</td>
            <td>Seafood</td>
            <td>18</td>
            <td>Carnarvon Tigers</td>
            <td>1</td>
        </tr>
        <tr>
            <td>8</td>
            <td>Seafood</td>
            <td>10</td>
            <td>Ikura</td>
            <td>2</td>
        </tr>
        <tr>
            <td>8</td>
            <td>Seafood</td>
            <td>40</td>
            <td>Boston Crab Meat</td>
            <td>3</td>
        </tr>
    </tbody>
</table>




```python

```

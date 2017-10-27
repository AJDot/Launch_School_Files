# Working with a Single Table

## Write a SQL statement that will create the following table, **people**:
| name | age | occupation |
| ---- | --- | ---------- |
| Abby | 34  | biologist  |
| Mirabelle | 40 | contractor |

```sql
CREATE TABLE people (
name varchar(255),
age integer,
occupation varchar(255)
);
``` 

## Write SQL statements to insert the data shown in #1 into the table.
```sql
```

Write 3 SQL queries that can be used to retrieve the second row of the table shown in #1 and #2.
```sql
SELECT * FROM people WHERE age = 26;
SELECT * FROM people WHERE occupation IS NULL;
```

## Write a SQL statement that will create a table name birds that can hold the following values:
| name | length | wingspan | family | extinct |
| ---- | ------ | -------- | ------ | ------- |
| Spotted Towhee | 21.6 | 26.7 | Emberizidae | f |
| American Robin | 25.5 | 36.0 | Turdidae | f |
| Greater Koa Finch | 19.0 | 24.0 | Fringillidae | t |
| Carolina Parakeet | 33.0 | 55.8 | Psittacidae | t |
| Common Kestrel | 35.5 | 73.5 | Falconidae | f |
```sql
CREATE TABLE birds (
    name character varying(255),
    length numeric(4,1),
    wingspan numeric(4,1),
    family text,
    extinct boolean
);
```

## Using the table created in #4, write the SQL statements to insert the data as shown in the listing.
```sql
```


```sql
SELECT name, family FROM birds WHERE extinct=false ORDER BY length DESC;
```
```
      name      |   family    
----------------+-------------
 Common Kestrel | Falconidae
 American Robin | Turdidae
 Spotted Towhee | Emberizidae
(3 rows)
```

## Use SQL to determine the average, minimum, and maximum wingspan for the birds shown in the table.
```sql
SELECT round(avg(wingspan), 1), min(wingspan), max(wingspan) FROM birds;
```
```
 round | min  | max  
-------+------+------
  43.2 | 24.0 | 73.5
(1 row)
```

## Write a SQL statement to create the table shown below, **menu_items**:
| item | prep_time | ingredient_cost | sales | menu_price |
| ---- | --------- | --------------- | ----- | ---------- |
| omelette | 10 | 1.50 | 182 | 7.99 |
| tacos | 5 | 2.00 | 254 | 8.99 |
| oatmeal | 1 | 0.50 | 79 | 5.99 |
```sql
CREATE TABLE menu_items (
    item text,
    prep_time integer,
    ingredient_cost numeric(4,2),
    sales integer,
    menu_price numeric(4,2)
);
```

## Write SQL statements to insert the data shown in #8 into the table.
```sql
```

## Using the table and data from #8 and #9, write a SQL query to determine which menu item is the most profitable based on the cost of its ingredients, returning the name of the item and its profit. Keep in mind that `prep_time` is represented in minutes and `ingredient_cost` and `menu_price` are in dollars and cents.
```sql
SELECT item, menu_price - ingredient_cost AS profit FROM menu_items ORDER BY profit DESC LIMIT 1;
```

## Write a SQL query to determine how profitable each item on the menu is based on the amount of time it takes to prepare. Assume that whoever is preparing the food is being paid $13 an hour. List the most profitable items first.
```sql
SELECT item, menu_price, ingredient_cost,
       round(prep_time/60.0 * 13.0, 2) AS labor,
       menu_price - ingredient_cost - round(prep_time/60.0 * 13.0, 2) AS profit
  FROM menu_items
  ORDER BY profit DESC;
```
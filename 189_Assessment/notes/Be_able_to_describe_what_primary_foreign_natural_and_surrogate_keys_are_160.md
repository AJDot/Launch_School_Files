# Be able to describe what primary, foreign, natural, and surrogate keys are.
## Primary Key
The unique identifier for a row of data. Anything can be a primary key as long as it is unique. However, a column `id` is usually created to assume this role. This is the column that is used to link data in one table with another. 

Here are two ways to declare a primary key.
```sql
CREATE TABLE <table name> (
  id serial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE <table name> (
  id serial,
  name text NOT NULL,
  PRIMARY KEY (id)
);
```
Using this method will make `id` an `integer` and will sequentially increment every time a row is added.

## Foreign Key
```sql
CREATE TABLE <table name> (
  id serial PRIMARY KEY,
  name text NOT NULL,
  user_id integer NOT NULL REFERENCES <table with primary key> (id)
);
```

## Natural Key

## Surrogate Key
Surrogate keys solve this uncertainty problem. They are created solely to act as the unique identifier for a row in a table. Most commonly this will be an auto-incrementing integer. The `TYPE serial` part used when creating a column will make sure this value is auto-incrementing and NOT NULL.

## Programming Convention
1. All tables should have a primary key column called id.
2. The id column should automatically be set to a unique value as new rows are inserted into the table.
3. The id column will often be an integer, but there are other data types (such as UUIDs) that can provide specific benefits.
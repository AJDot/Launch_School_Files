# Schema, Data, and SQl - Summary

* *SQL* is a *special-purpose, declarative* language used to manipulate the structure and values of datasets stored in a relational database.
* SQL is comprised of three sublanguages:
  | sub-language | controls | SQL Constructs |
  | ------------ | -------- | -------------- |
  | DDL or data definition language | relation structure and rules | `CREATE`, `DROP`, `ALTER` |
  | DML or data manipulation language | values stored within relations | `SELECT`, `INSERT`, `UPDATE`, `DELETE` |
  | DCL or data control language | who can do what | `GRANT` |
  
* SQL code is made up of statements, which must be terminated by a semicolon.
  | Data Type | Type | Value | Example Values |
  | --------- | ---- | ----- | -------------- |
  | varchar(length) | character | length characters of text, up to 255 | canoe |
  | text | character | unlimited length of text | a long string of text |
  | integer | numeric | whole numbers | 42, -1423290 |
  | numeric | numeric | floating-point numbers | 24.563, -14924.3515 |
  | decimal(precision, scale) | numeric | arbitrary precision numbers | 123.45, -567.89 |
  | timestamp | date/time | date and time | 1999-01-08 04:05:06 |
  | date | date/time | only a date | 1999-01-08 |
  | boolean | boolean | true or false | true, false |
  | sub-language | controls | SQL Constructs |

* `NULL` is a special value that represents the absence of any other value.
* `NULL` values must be compared using `IS NULL` or `IS NOT NULL`.
* Database dumps can be loaded using `psql -d database_name < file_to_import.sql`.
* Table columns can have default values, which are specified using `SET DEFAULT`.
* Table columns can be disallowed from storing `NULL` values using `SET NOT NULL`.
* `CHECK` constraints are rules that must be met by the data stored in a table.
* A *natural key* is an existing value in a dataset that can be used to uniquely identify each rowof data in that dataset.
* A *surrogate key* is a vlaue that is created solely for the purposeof identifying a row of data in a database table.
* A *primary key* is a vlaue that is used to uniquely identify the rows in a table. It cannot be `NULL` and must be unique within a table. They are created using `PRIMARY KEY`.
* `serial` columns are typically used to create auto-incrementing columns in PostgreSQL.
* `AS` is used to rename tables and columns within a SQL statement.
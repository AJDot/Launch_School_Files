# Define a default value for a column.
```sql
CREATE TABLE <table name> (
  number integer DEFAULT 0
);
```
The column `number` will have a default value of 0.

If the table has already been created, a default value may be added:
```sql
ALTER TABLE <table name> 
  ALTER COLUMN <column name> 
    SET DEFAULT 0;
```
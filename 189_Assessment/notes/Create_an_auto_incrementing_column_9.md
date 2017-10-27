# Create an auto-incrementing column.

If a table is being created and you want the sequence to be the unique identifier of each row, then make it the primary key.
```sql
CREATE TABLE <table name> (
  id serial PRIMARY KEY,
  <column name> <column type> <column modifications>
);
```

If a table has already been created then the sequence itself must first be created and then the next value of that sequence must be set to the default value for a column.
```sql
CREATE SEQUENCE <sequence_name_seq>
```
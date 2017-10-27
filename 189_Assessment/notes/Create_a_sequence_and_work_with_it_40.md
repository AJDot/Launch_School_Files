# Create a sequence and work with it.
```sql
CREATE SEQUENCE counter;
```

Retrieve the next value from the sequence.
```sql
```

Remove the sequence
```sql
DROP SEQUENCE counter;
```

Create a sequenct that returns only even numbers.
```sql
CREATE SEQUENCE even_counter START 2 INCREMENT BY 2;
```

Add an auto-incrementing integer primary key to a column.
```sql
ALTER TABLE films ADD COLUMN id serial PRIMARY KEY;
```

Remove the PRIMARY KEY without removing the `id` column.
```sql
ALTER TABLE films DROP CONSTRAINT films_pkey;
```
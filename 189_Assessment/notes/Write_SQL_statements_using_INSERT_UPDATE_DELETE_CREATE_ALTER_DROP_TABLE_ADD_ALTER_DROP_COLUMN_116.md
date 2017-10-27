# Write SQL statements using INSERT, UPDATE, DELETE, CREATE/ALTER/DROP TABLE, ADD/ALTER/DROP COLUMN.

## CREATE TABLE
The following code creates three tables, `owners`, `pets`, and `furniture`.
```sql
CREATE TABLE owners (
  id serial PRIMARY KEY,
  name text NOT NULL 
);
CREATE TABLE pets (
  id serial PRIMARY KEY,
  name text NOT NULL,
  owner_id integer REFERENCES owners (id)
);
CREATE TABLE furniture (
  id serial PRIMARY KEY,
  name text
);
```

## ALTER TABLE
The following code renames the table `pets` to `animals`.
```sql
ALTER TABLE pets RENAME TO animals;
```

## DROP TABLE
The following query deletes the table `furniture` from the database.
```sql
DROP TABLE furniture;
```

## ADD COLUMN
The following code adds a column `type` to the table `pets`.
```sql
ALTER TABLE pets ADD COLUMN type text NOT NULL;
```

## ALTER COLUMN
The following code alters the column `name` in the table `pets` to have a different type.
```sql
ALTER TABLE pets ALTER COLUMN name TYPE char(25);
```

## DROP COLUMN
The following code deletes the column `type` in the table `pets`.
```sql
ALTER TABLE pets DROP COLUMN type;
```

## INSERT
The following code inserts some rows into the `owners` and `pets` tables.
```sql
```

## UPDATE
```sql
UPDATE pets
  SET owner_id = 3
```

## DELETE
```sql
```
# Create and remove foreign key constraints from a column.
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
-- OR --
CREATE TABLE pets (
  id serial PRIMARY KEY,
  name text NOT NULL,
  owner_id integer,
  FOREIGN KEY (owner_id) REFERENCES owners (id)
);
```

```sql
ALTER TABLE pets DROP CONSTRAINT pets_owner_id_fkey;
```
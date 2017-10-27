# Create and remove CHECK constraints from a column.

```sql
ALTER TABLE owners ADD CONSTRAINT owners_name
```

```sql
ALTER TABLE owners DROP CONSTRAINT owners_name;
```

```sql
ALTER TABLE pets ADD CONSTRAINT name_unique UNIQUE (name);
```

```sql
ALTER TABLE pets DROP CONSTRAINT name_unique;
```
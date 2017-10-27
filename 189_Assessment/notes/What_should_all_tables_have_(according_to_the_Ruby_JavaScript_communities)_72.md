# What should all tables have (according to the Ruby, JavaScript communities)?
* a primary key column called `id`.
* The `id` column should automatically be set to a unique value as new rows are inserted into the table.
* The `id` column will often be an integer, but there are other data types (such as UUIDs) that can provide specific benefits.
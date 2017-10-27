# Interacting with a Database in Code
## Summary
* use the `pg` gem to interact with a PostgreSQL database from Ruby
  * Creating a new `PG::Connection` object
  * Executing SQL statements using `#exec` and `#exec_params`
  * Accessing query results contained in `PG::Result` objects
* Build a small command-line Ruby application
* Automatically create tables if they do not exist
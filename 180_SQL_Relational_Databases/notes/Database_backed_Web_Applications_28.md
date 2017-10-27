# Database-backed Web Applications
## Summary

* Extract the session-specific functionality into the `SessionPersistence` class.
* Replace our use of `SessionPersistence` with `DatabasePersistence` to store data in a different location without making other changes to the application.
* Safely handle inserting parameters into SQL statements with `PG::Connection#exec_params`.
* Use a `configure(:development)` block for environment-specific setting.
* Reload our code in development using `sinatra/reloader`.
* Log database queries made by our application.

We also saw how extracting code into a `SessionPersistence` class exposed an API that defined the functionality of the application.
# What is the session? Where it is stored? How is it used?

The session is a place where information can persist from one request to the next because the information is sent with each request and can be updated with each response.

The session is stored on the server. It could be stored in memory or in a database. The `session id` is stored on the client and serves as a key to access the session data on the server. 

Using Sinatra, a session is enabled using the following:
```ruby
configure do
  enable :sessions
  set :session_secret, "super_secret"
```
The above code also manually sets a session secret. This is not secure but is useful for apps in development because a server can restarted and the same session will persist. 

Once enabled, a session is simply a hash where data can be stored.

In Sinatra, the session is stored in a cookie (configurable - not the case with all web frameworks).

**Note:** The session secret should never be set manually in a real application. Always make the secret a randomly generated string of at least 32 characters.
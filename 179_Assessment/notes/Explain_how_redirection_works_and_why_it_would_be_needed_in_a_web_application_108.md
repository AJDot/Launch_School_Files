# Explain how redirection works and why it would be needed in a web application.

A redirect is executed by providing a `Location` header in the response. Browsers will see this and automatically issue a new request. A redirect is performed easily in Sinatra using the `redirect` method:
```ruby
get "/" do
  # some optional code
  redirect "/another_path"
end
```
Here, when the `/` route is requested, the optional code will be executed and the response will include a `Location` header. This will be followed to the route `/another_path` and the code for that route will be run.

A status code of `302` tells the browser that the resource has moved and to follow the `Location` header. 

Redirects are useful for several reasons. 
1. After users submit information using a form, that information needs to be processed and then the application most likely needs to be updated. A redirect can be used for this. Ex: After a user pays for an item, a redirect can be used to bring the user to the confirmation/receipt page.
3. Redirect a user to a signin page. Then redirect the user back to the page where signin was required.
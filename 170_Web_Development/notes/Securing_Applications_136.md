# Securing Applications
## Introduction

The problem is it may require you to do some things manually that a larger framework may do automatically. For example, escaping HTML.

### Keeping HTML Safe
When pages are created dynamically like in our Sinatra todo app it allows someone to modify the code (through inputs, etc). If they can modify the code, they may have access to steal data or potentially, credentials.

### An Example
Our todo app is vulnerable. Add a Todo with the following name:
```html
<script>alert("This code was injected!");</script>Pizza
```
1. The JavaScript code in the scripttag is being evaluated.
2. When you click OK, the page goes back to looking normal.


## Sanitizing HTML
The script that was injected in out code is literally inserted into the code and executed as if it were placed there by us. Here is the code after the insertion.
```html
  <form action="/lists/<%= @list_id %>/todos/<%= index %>" method="post" class="check">
    <input type="hidden" name="completed" value="<%= !todo[:completed] %>" />
    <button type="submit">Complete</button>
  </form>

  <h3><script>alert("This code was injected!");</script>Pizza</h3>
  <form action="/lists/<%= @list_id %>/todos/<%= index %>/destroy" method="post" class="delete">
    <button type="submit">Delete</button>
  </form>
</li>
```

### Escaping HTML

The Rack library, which Sinatra is built on top of, has a built in method call `Rack::Utils.escape_html`:
```irb
>> require "rack"
=> true
>> Rack::Utils.escape_html "test"
=> "test"
>> Rack::Utils.escape_html %{<script>alert("This code was injected!");</script>Pizza}
=> "&lt;script&gt;alert(&quot;This code was injected!&quot;);&lt;&#x2F;script&gt;Pizza"
```

this method is available anywhere within a Sinatra application but a helper method is nice to use:
```ruby
helpers do
  def h(content)
    Rack:Utils.escape_html(content)
  end
end
```
We can use it easily like so:
```html
<h3><%=h todo[:name] %></h3>
```

Now it will be escaped when rendered.

### A More Thorough Approach

Add the following code to `todo.rb` in our app:
```ruby
configure do
  set :erb, :escape_html => true
end
```

Now the problem is _everything_ is escaped. To disable the auto-escape, replace `<%=` with `<%==`

In our code we need to change two locations in `views/layout.erb`
```html
...
<%= yield_content :header_links %>
...
<%= yield %>
...
```
Change to...
```html
...
<%== yield_content :header_links %>
...
<%== yield %>
...
```

## Handling Bad Input
Open the application and go to the following url:
```
http://localhost:4567/lists/15
```

To fix the issue:

## HTTP Methods and Security

Any data sent as a GET request can be seen if code can be viewed as plain text, for http. https helps to fix this.

For a POST request, no parameters are in the url but they do go in the body. The parameters however are still visible as plain text in the body instead of the path, not much different. No real security is added and anyone a little skilled in the ways of the web can still access them.

The build a secure application, build it and make it hosted to use the https protocol.

### Practice Problems
1. Is using POST as the HTTP method for a request more secure than GET? Why or why not?
2. How can a web applications be secured so that any data being sent between the client and server can not be viewed by other parties?


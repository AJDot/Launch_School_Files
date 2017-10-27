# Why is user-entered content a security risk? Be aware of how to mitigate this risk.

User-entered content is a security risk because users may have the ability to enter harmful HTML or JavaScript code into the applicaiton code. If these inputs are not handled properly, then the browser may interpret them as code and execute them. Cleverly crafted code could be designed to steal information from every user that logs in or any other numbers of things.

There are a few ways to mitigate this risk:

* Escape all user input so the client will not interpret it as code.
In an application using Rack, can use `Rack::Utils.escape_html(content)` to escape any content. This can be put into a helper method like so:
  ```ruby
  helpers do
    def h(content)
      Rack::Utils.escape_html(content)
    end
  end
  ```
  ```erb
  <h3><%=h todo[:name] %></h3>
  ```
  The problem now is that the developer must remember to use the at every potential threat input and is bound to forget to do it every time.

  In a Sinatra application, do this:
  ```ruby
  configure do
    set :erb, :escape_html => true
  end
  ```
  
  Then switch `<%=` to `<%==` wherever you want this disabled.

* Do not allow key tags to be entered by users, such as `<script>` tags.
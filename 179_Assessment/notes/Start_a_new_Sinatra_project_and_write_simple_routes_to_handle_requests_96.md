# Start a new Sinatra project and write simple routes to handle requests.

1. Create a Gemfile and add `sinatra` and `sinatra-contrib` as gem dependencies.
2. Create a main application ruby file.
4. Start the application using `ruby <APP NAME>` or `bundle exec ruby <APP NAME>`. To follow a stricter setup, place main ruby files in a folder called `lib` and test files in `test`.
  This will load in Sinatra and allow it to restart the server on every refresh.
6. Create a simple route with:
  ```ruby
    "Hello World"
  end
  ```
7. Add a template called `layout.erb` in the folder `views` in the top directory of the application.
  ```erb
  <doctype! html>
  <html>
  <head>
    <meta charset="utf-8">
    <title>My App</title>
  </head>
  <body>
    <%= yield %>
  </body>
  <html>
  ```
  And change route in `my_app.rb` to:
  ```ruby
    erb "Hello World", layout: :layout
  end
  ```
  
# What are the benefits of using view templates? Be able to use an ERB template in a Sinatra route.

View templates are another way to keep code DRY and less prone to error. Often, different paths of a webpage will contain a lot of the same setup/information such as titles, menu bars, footers, etc. Utilizing view templates allows the developer to code this information one time and reuse it on multiple pages.

Here is a basic template, call this file `/views/layout.erb`:
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

View templates are used in Sinatra routes like this:
```ruby
  erb :index
  # or
  # erb :index, layout: :layout
end
```
This code instructs Sinatra to use the view template located at `./views/layout` and to insert the code from the `./views/index` template into it where it sees the code `<%= yield %>`.

```ruby
  erb "Hello World"
end
```

If the template at `views/layout.erb` exists, it will be used and `Hello World` will be inserted into the page.
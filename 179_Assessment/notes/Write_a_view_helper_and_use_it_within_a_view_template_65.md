# Write a view helper and use it within a view template.

A view helper is simple a bit of code used to help format the output for html. For example, a helper can be used to place all items of an array into a list. These helpers should be organized into a block for the `helpers` Sinatra method and located in the main application Ruby file:

```ruby
# main application Ruby file
helpers do
  def in_list(array)
    array.map do |item|
      "<li>#{item}</li>"
    end.join("\\n")
  end
end
```

```erb
# view template
<ul>
  <%= in_list(@array_of_items_to_display) %>
</ul>
```
# Give an example to demonstrate closure

## Example 1
One of the best case uses for closures is sandwiching code. You do this when you want to perform some action before and some action after an arbitrary chunk of code is executed. The following example is a bit contrived, but still:

```ruby
def display_table(data)
  puts "Awesomeness Table"
  puts "-----------------"
  data.each_with_index { |item, idx| puts yield(item, idx) }
  puts "-----------------"
end

data = [
  "Bananas",
  "Apples",
  "Orange",
  "Kiwi"
]

display_table(data) { |item, idx| "#{idx + 1}: #{item}" }
display_table(data) { |item, _| "[ ] #{item}"}
```
The output will look like this:
```
Awesomeness Table
-----------------
1: Bananas
2: Apples
3: Orange
4: Kiwi
-----------------

Awesomeness Table
-----------------
[ ] Bananas
[ ] Apples
[ ] Orange
[ ] Kiwi
-----------------
```
We can use a closure (in this case implemented by the block) to tweak the output of the awesomeness table. A whole, we want to display the data, but we may want to tweak it a bit each time for different purposes - a numbered list, a checklist, etc.

## Example 2
Another use case for sandwich coding is to time a process. 
```ruby
def time_it
  start = Time.now
  yield
  stop = Time.now
  puts "This process took #{stop - start} seconds to complete."
end

time_it do
  sleep 5
end
```
this code will time how long it takes to run whatever code is in the block.

## Example 3
The other main-use case is when you may tweak a method in a bunch of different little ways depending on the immediate circumstances. You may want to select strings based on their value but other times maybe the selection is based on the string length or any other property a String object may possess. Closures are perfect for this last-minute tweak.

```ruby
def select(data)
  result = []
  data.each do |item|
    result << item if yield(item)
  end
  result
end

end

p selection # => ["ccc", "dddd", "eeeee"]

  text.length < 4
end

p selection # => ["a", "bb", "ccc"]
```
Now we have to ability to perform a selection on an array but the criteria that selects the items is implemented at the end. The details on how the implementation in Ruby is completed is behind the scenes; the user of the method only needs to know what criteria he/she wants to use to perform that selection.
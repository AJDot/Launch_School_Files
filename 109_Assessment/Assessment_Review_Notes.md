# 109 Assessment Review
## Beginning Ruby - Part 1
### Outline
- Reading Ruby's syntactical sugar
- Where does the code come from?
- Variable scope

### Syntactical Sugar
Method Invocation - parentheses are optional
Ex: `puts "hello"` vs `puts("hello")`
They mean the same thing.

A method will invoke a method after a local variable. The local variable will take precedence.
```ruby
str = "string"
def str
  "method"
end
p str   # => will output local variable ("string")
p(str)  # => will output the method ("method")
```
### Where does code come from?
ruby-doc.org - official ruby documentation
- core API
- standard API
- external libraries (gems) (use `require`)
- your own external files (use `require_relative`)

### Local Variable Scope
```ruby
arr = [1, 2, 3, 4]

counter = 0
sum = 0
loop do
  sum += arr[counter]
  counter += 1
  break if counter == arr.size
end

puts "your total is #{sum}"
```
3 local variables used (`arr`, `counter`, `sum`)
are they accessible in the loop? Are they accessible for the `puts` method?

Yes. The loop constitutes a block which allows local variables to be accessible.

If `new_var = 'something'` is located on the last line of the loop then it will not be accessible outside of the loop.

Initialized outside a loop, accessible inside loop.
Initialize inside a loop, not accessible outside loop.

## Beginning Ruby - Part 2
### Outline
- pass by reference vs pass by value
- variables as pointers
- method side-effects vs return value

#### Pass By Reference vs Pass By value
```ruby
def amethod(param)

end

str = "hello"
amethod(str)

p str # => str remains "hello"
```
```ruby
def amethod(param)
  str += " world"
end

str = "hello"
amethod(str) # => returns error because str does not exist inside method

p str
```
```ruby
def amethod(param)
  param += " world"
end

str = "hello"
amethod(str) # => returns new string object with no effect on str

p str # => str remains "hello"
```
```ruby
def amethod(param)
  param << " world"
end

str = "hello"
amethod(str) # => str is modified because << mutates the caller

p str # => str is now "hello world"
```
```ruby
def amethod(param)
  param += " world" # => param = param + " world" (no mutation)
  param + " world"  # => string concatenation - param.+(" world")
  param << " world" # => (mutation)
end
```
There is a huge difference between `+=` and `+` when used with strings.
```ruby
def amethod(param)
  param + " universe"  # => string concatenation - param.+(" world")
  param << " world" # => (mutation)
end
p str
```
This prints "hello world"
```ruby
def amethod(param)      # param = str
  param += " universe"  # => param = param + " universe" (no mutation) - This is reassignment, creates as a new object
  # => param is no longer pointing to the same object that str is pointing to
  param << " world"     # => (mutation)
end
p str
```
This will output "hello". This is because param is now reassigned to a new object. It is now pointing to a new location in memory. Then on the next line, `param << " world"` is adds " world" to the new location, a new string object. But the original object was not mutated.

### Variables as Pointers
```ruby
a = "hello"
b = a
b << " world"

# ---- 2 variables; 1 object

puts a  # => "hello, world"
puts b  # => "hello, world"

a = "hey" # a is now reassigned to a new object
# ---- 2 variables; 2 objects
b << " universe"

puts a  # => "hey" - This is reassignment
puts b  # => "hello, world universe"

```
![Variables as Pointers 1](https://d2aw5xe2jldque.cloudfront.net/books/ruby/images/variables_pointers1.jpg)
![Variables as Pointers 2](https://d2aw5xe2jldque.cloudfront.net/books/ruby/images/variables_pointers2.jpg)
### Method Side-Effects vs Return Value
```ruby
def prefix(str)
  "Mr. " + str  # => this is reassignment, returns a new string that is not captured
end

name = 'joe'
prefix(name)

puts name   # => 'joe'
```
One fix
```ruby
def prefix(str)
  "Mr. " + str  # => this is reassignment, returns a new string that is not captured
end

name = 'joe'
name prefix(name)

puts name   # => 'joe'
```
Another fix
```ruby
def prefix!(str)
  "Mr. " << str  # => this is mutation
end

name = 'joe'
prefix!(name)

puts name   # => 'joe'
```
__Do not__ create a method that makes a permanent change to a variable ( a side-effect) and has an important return value.

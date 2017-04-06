# Specific Topics of Interest
## Be able to explain clearly the following topics:
### Local Variable Scope
especially how local variables interact with method invocations with blocks and method definitions
### Answer
#### For blocks
Local variables in general can be accessed by blocks if they have been declared in a higher scope. For example:
```ruby
a = 'outside block'
loop do
  puts a    # => 'outer scope'
  break
end
```
In this code `a` is accessible by the loop method through the use of the do..end block
```ruby
loop do
  a = 'inside block'
  break
end

puts a  # => NameError: undefined local variable or method 'a'
```
A NameError will pop up here because `a` was defined inside a block but was being accessed at a higher scope. This is not possible.

Another Example:
```ruby
a = 'outside block'

loop do
  a = 'inside block'
  break
end

puts a  # => 'inside block'
```
Here a was modified inside the block, this is not the declaration of a new variable, it is reassignment of the variable declared in the outer scope.
#### For methods
Methods define their own scope. This means they cannot access local variables outside of the method. For example
```ruby
def a_method
  a = 'inside method'
end
puts a  # => NameError: undefined local variable or method 'a'
```
The following code still won't work.
```ruby
def a_method(string)
  string = 'inside method'
end

a = 'outside method'
a_method(a)
puts a  # => 'outside method'
```
### How passing an object into a method definition can or cannot permanently change the object
When an object is passed as an argument into a method, any actions on that object that do not mutate the caller will have no effect on the object that was passed in.

If you want to alter the object passed into a method, a method must be called the mutates the caller. For example
```ruby
def a_method(string)
  string.upcase!
end

a = 'outside method'
a_method(a)
puts a  # => 'OUTSIDE METHOD'
```
`#upcase!` mutates the caller so the object that `a` points to was altered permanently.
The following example will not alter the variable.
```ruby
def a_method(string)
  string.upcase
end

a = 'outside method'
a_method(a)
puts a  # => 'outside method'
```
`#upcase` does not mutate the caller, so the object that `a` points to was not altered permanently.
There is an interesting situation when it comes to collections where the array/hash elements can be altered and this change is reflected outside of the method. For example
```ruby
def a_method(array)
  array.each { |n| n.upcase! }
end
a = 'a'
b = 'b'
c = 'c'
arr = [a, b, c]
a_method(arr)
p arr   # => ['A', 'B', 'C']
p a     # => 'A'
```
This should look peculiar. Even though we are not explicitly calling `#upcase!` on `a`, `b`, and `c`, it will still modify them. This is because `a`, `b`, and `c` simply point to the same objects that array[0], array[1], and array[2] point to. When `#upcase!` mutated each element in the array, the local variables were altered as well since they point to the same objects. We must be very aware of which object a mutating method is being called by. In this case, `#upcase!` is being called by the each object in the array, not the array itself.
If `a`, `b`, and `c` were not meant to be alter, we must call the mutating method on the array itself.
```ruby
def a_method(array)
  array.map! { |n| n.upcase }  
end
a = 'a'
b = 'b'
c = 'c'
arr = [a, b, c]
a_method(arr)
p arr   # => ['A', 'B', 'C']
p a     # => 'a'
```
`a`, `b`, and `c` now remain the same but the elements inside the `arr` were altered.
### Working with collections (Array, Hash, String), and popular collection methods (each, map, select, etc). Review the two lessons on these topics thoroughly
#### Common Array methods
- include?
- flatten
- each_index
- each_with_index
- sort
- product
#### Common Hash methods
- has_key?
- select
- fetch
- to_a
- keys and values
### Variables as Pointers
#### Variable reassignment using `=`
![Variables as Pointers 1](https://d2aw5xe2jldque.cloudfront.net/books/ruby/images/variables_pointers1.jpg)
#### Object Mutation using `<<`
![Variables as Pointers 2](https://d2aw5xe2jldque.cloudfront.net/books/ruby/images/variables_pointers2.jpg)

Some operations will mutate the actual address space in memory, thereby affecting all variables that point to that address space. Some operations will not mutate the address space in memory, and instead will re-point the variable to a new address space in memory.
```ruby
a = [1, 2, 3, 3]
b = a
c = a.uniq!
```
In this code, `a.uniq!` changes the object itself therefore any variable pointing to that object will change. This means `c = [1, 2, 3]`, `a = [1, 2, 3]`, and also `b = [1, 2, 3]` since `b` is pointing to the same object `a` is pointing to.

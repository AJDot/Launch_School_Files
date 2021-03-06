# Blocks

## Closures and scope
Closures give the ability to save a section of code and execute it at a later time. It binds its surround artifacts (variables, methods, objects, etc) and "encloses" it so that everything can be referenced when the closure is executed later.

A __closure__ is a block of code that can be run at a later time.
* an "enclosure" is built around it to surround its artifacts.
* kind of like a method without a name.

In Ruby, a closure is implemented through a `proc` object.

__Remember:__ the `Proc` object retains references to its surrounding artifacts - its binding. This is how it understands its surroundings and carries the information to its place of execution.

Three ways to work with closures in Ruby
1. Instantiating an object from the `Proc` class
2. Using __lambdas__
3. Using __blocks__

When one of these ways is used, the artifacts that are surrounded will be accessible in places they normally would be. Example:

## How blocks work, and when we want to use them.
Blocks are written using `do...end` or `{...}`. Blocks are actually _passed into_ a method called on an object. Here are a few examples of using blocks.
```ruby
[1, 2, 3].each do |num|
  puts num
end
=> [1, 2, 3]

5.times do { |num| puts num }
=> 5

end
=> 34 # number of characters in string
```
The code inside each block will run as expected and each block has a return value. Exactly how a block will be treated is defined in the method that block is being passed into. The return value, however, works just the same as for methods; it is the last line of the block unless explicitly specified using the `return` reserved word.

### When would we want to use blocks?
1. Defer some implementation code to method invocation time. 
  Sometimes a method may need a little tweaking when called but that tweak could be something a little different every time it is called. This is a prime case for the use of a block. 
    ```ruby
    def compare(num, compare_value, compare_type)
      result = case compare_type
      when :>
      num > compare_value
      when :<
      num < compare_value
      when :==
      num == compare_value
      end
      result ? "This is true!" : "This is false!"
    end
    ```
    ```ruby
    def compare(num)
      yield(num) ? "This is true!" : "This is false!"
    end
    ```
    If you find you need a method in multiple places __with only a tweak to each call__, then a block maybe be a good idea.
    

2. Methods that need some "before" and "after" actions - sandwich code.
  If you need to run some code before and after _anything_ then a block is probably for you. One easy example is timing code execution. Example
    ```ruby
    def time_it
      time_before = Time.now
      yield
      time_after = Time.now
      
      puts "it took #{time_after - time_before} seconds."
    end
    
    time_it { sleep(3) }
    
    time_it { "hello world" }
    ```
    Common uses of sandwich code:
    1. timing
    2. logging
    3. notification systems
    4. opening/closing files
  
## Blocks and variable scope
### Closure and binding
Where the `chunk_of_code` is instantiated is what the chunk will keep track of. If a `Proc` object is defined outside of a method, it can be called inside that method when passed into it, even if the `Proc` contains information the method itself does not explicitly see. Example:
```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}

call_me(chunk_of_code)
```
The output is:
```bash
hi Robert
=> nil
```

The `Proc` keeps track of its surrounding context and drags it around with it. Even if the surrounding context changes after the `Proc` was defined, it will be kept up-to-date. Example:
```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Bill"

call_me(chunk_of_code)
```
And the output is...
```bash
hi Bill
=> nil
```
This not only includes local variables, but method references, constants, and others. This is the core reason behind scoping rules in Ruby. This is why "inner scopes can access outer scopes".

## Write methods that use blocks and procs
There are two ways to write a method that uses a block.
1. Use `yield` inside the method. The block will be called everytime this keyword is used.
2. Use `&` before the last argument of the method. Now the block can be passed around like a variable.

### Using `yield`
Here is an example of an implementation of the `Array#map` method.
```ruby
def map(array)
  iterator = 0

  result = []
  while iterator < array.size
    result << yield(array[iterator])
    iterator += 1
  end
  result
end

p map([1, 2, 3, 4, 5]) { |item| item + 2 }
```

This is a basic implementation of the `#map` method. Be care though, with this code a block is actually _required_ or else a `LocalJumpError` will be thrown.

We can handle this by using `block_given?` to handle when a block is not given. Revised code is:
```ruby
def map(array)
  iterator = 0

  result = []
  while iterator < array.size
    result << yield(array[iterator])
    iterator += 1
  end
  result
end

p map([1, 2, 3, 4, 5]) { |item| item + 2 }
p map([1, 2, 3, 4, 5])
```
Now we can handle when a block is not supplied. In this case, the string `Block was not given.` is returned instead of the typical `#map` return value.

## Arguments and return values with blocks
Yielding with an argument is easy to do. See above for an example. Basically you treat the block variable inside the method as a method you can pass arguments to.

Every block has a return value as well. In this sense, they behave just like methods.


## When can you pass a block to a method
You can always pass a block to a method. The key is when will the block actually be utilized and when will it be ignored. It will be utilized when there is a `yield` or an argument with `&` prefixed that is called using something like `block.call`.

## &:symbol
This is a way to convert a symbol to a proc as a short-hand way to pass a block (without an argument) into a method.
Example:
```ruby
[1, 2, 3, 4, 5].select(&:odd?) # => [1, 3, 5]
```
This code gets converted to:
```ruby
[1, 2, 3, 4, 5].select { |num| num.odd? } # => [1, 3, 5]
```

Here is a breakdown of what this code is doing:
```ruby
def my_method
  yield(2)
end

a_proc = :to_s.to_proc    # explicitly call to_proc on the symbol
my_method(&a_proc)        # convert Proc into block, then pass block in. Returns "2"
```
# Lesson 1 - Blocks
### Closures
A __closure__ is a block of code that can be run at a later time.
* an "enclosure" is built around it to surround its artifacts.
* kind of like a method without a name.

In Ruby, a closure is implemented through a `proc` object.

__Remember:__ the `Proc` object retains references to its surrounding artifacts - its binding.

Three ways to work with closures in Ruby
1. Instantiating an object from the `Proc` class
2. Using __lambdas__
3. Using __blocks__

### Calling Methods with Blocks
I have used block many times. Any code written with a `do...end` or `{...}` is a block. For example:
```ruby
[1, 2, 3].each do |num|
  puts num
end
```
```ruby
[1, 2, 3]
```
A method is called on this object `Array#each`:
```ruby
.each
```
The __block__ part is the `do...end` part:
```ruby
do |num|
  puts num
end
```
The block is an _argument_ to the method call `Array#each`. So the block is being passed into the `Array#each` method.

#### What can you do within a block?
Here are some examples:
```ruby
# Examples 1: passing in a block to the `Integer#times` method.

3.times do |num|
  puts num
end

=> 3

# Example 2: passing in a block to the `Array#map` method.

[1, 2, 3].map do |num|
  num + 1
end
=> [2, 3, 4]

# Example 3: passing in a block to the `File::open` class method.

end
=> 11
```

In each of these examples, focus on the following:
1. the code written in the blocks
2. the return value of the method invocations
    * in Example 1, the return value is 3 (ignores what is in the block)
    * in Example 2, the return is a new array
    * in Example 3, the return is the size of the string

Essentially it is up to the method to decide what to do with a block. In most cases, studying the documentation will reveal how a method will handle a block.

### Writing Methods that take Blocks
Every method you have ever written in Ruby already takes a block.
```ruby
def hello
  "hello!"
end         # => "hello!"
```
As expected, an error will be thrown is the `hello` method is called with an argument.
```ruby
hello("hi")     # => ArgumentError: ...
```
Yet somehow if we called it will a block...
```ruby
```
It worked but not as you might have expected. In Ruby, every method can take an optional block as an implicit parameter. Just tack it onto the end of the method invocation. The method will always require the correct number of arguments it was defined to take; a block can be attached to the end of that list.
```ruby
def echo(str)
  str
end

echo                                          # => ArgumentError: wrong number of arguments (0 for 1)
echo("hello!")                                # => "hello!"
echo("hello", "world!")                       # => ArgumentError: wrong number of arguments (2 for 1)

# this time, called with an implicit block
echo { puts "world" }                         # => ArgumentError: wrong number of arguments (0 for 1)
echo("hello!") { puts "world" }               # => "hello!"
echo("hello", "world!") { puts "world" }      # => ArgumentError: wrong number of arguments (2 for 1)
```
In the example above, the block was essentially ignored. How can we make sure that the block is executed?

#### Yielding
One way to invoke a block is by using the `yield` keyword.
```ruby
def echo_with_yield(str)
  yield
  str
```
With `yield`, the block will be executed.
```ruby
echo_with_yield { puts "world" }      # => ArgumentError: ...
echo_with_yield("hello!") { puts "world" }    # world
                                              # => "hello!"
echo_with_yield("hello", "world!") { puts "world" } # => ArgumentError: ...
```
Notice these two observations:
1. The number of arguments need to match the method definition.
2. The `yield` keyword executes the block.

The first is known already, the second is very interesting. What this means is that a developer using your method can come in after this method is fully implemented and inject additional code in the middle of your method (without modifying the method implementation).

What if we call a method that contains the `yield` keyword but do not pass in a block:
```ruby
echo_with_yield("hello!")     # => LocalJumpError: no block given (yield)
```
To fix this, allow the method to be called with or without a block. `yield` can be wrapped in a conditional that will evaluated to true when a block is passed in. Use `Kernel#block_given?`
```ruby
def echo_with_yield(str)
  yield if block_given?
  str
end
```
Now we can call `echo_with_yield` with or without a block.

#### Passing execution to the block
New example:
```ruby
# method implementation
def say(word)
  yield if block_given?
  puts "> " + words
end

# method invocation
say("hi there") do
end                     # clears screen first, then outputs "> hi there"
```

#### Yielding with an argument
```ruby
3.times do |num|
  puts num
end
```
* This is a special type of local variable where the scope is constrained to the block.

To start, write a method that return a number incremented by one.
```ruby
# method implementation
def increment(number)
  number + 1
end

# method invocation
increment(5)        # => 6
```
Take a look at the following code. It will allow users to do whatever they want with this return value.
```ruby
# method implementation
def increment(number)
  if block_given?
    yield(number + 1)
  else
    number + 1
  end
end

# method invocation
increment(5) do |num|
  puts num
end
```

What if we pass in the wrong number of arguments to a block?
* If more arguments are passed in than expected, Ruby will just ignore the extras.
* If less arguments are passed in that expected, Ruby will assign the missing arguments to `nil`. And `nil` will be treated depending on the context as it normally would.

The rules around enforcing the number of arguments you can call on a closure in Ruby is called its _arity_.
* blocks - lenient arity rules

#### Return value of yielding to the block

```ruby

# Output:
# Before: hi
# After: HI
```

```ruby
def compare(str)
  puts "Before: #{str}"
  after = yield(str)
  puts "After: #{after}"
end

# method invocation
compare('hello') { |word| word.upcase }

# Output:
# Before: hello
# After: HELLO
# => nil
```
What we see here is that _blocks have a return value_. This implies that blocks (like method) can mutate the argument with a destructive method call or return a value. Keep this is mind when trying to write good code - have your block do one or the other, not both.

This block allows us the flexibility to see the before and after of any implementation
```ruby
compare('hello') { |word| word.slice(1..2) }

# Before: hello
# After: el
# => nil
```

Here is a slightly trickier example
```ruby
compare('hello') { |word| puts "hi" }

# Before: hello
# hi
# After:
# => nil
```

`puts` inside the block returns `nil` which is used as the `after` variable. `nil` in string interpolation evaluates to an empty string.

#### When to use blocks in your own methods
1. Defer some implementation code to method invocation decision.

    ```ruby
    def compare(str, flag)
      after = case flag
              when :upcase
                str.upcase
              when :capitalize
                str.capitalize
              end

      puts "Before: #{str}"
      puts "After: #{after}"
    end

    compare("hello", :upcase)

    # Before: hello
    # After: HELLO
    # => nil
    ```
    This is not flexible, by allowing a block, the __method caller__ can choose whatever flag he/she wants without changing the code for everyone.

    \\*\\* If you find yourself calling a method from multiple places, with one little tweak in each case, it may be a good idea to try implementing the method in a generic way by yielding to a block.


2. Methods that need to perform some "before" and "after" actions - sandwich code.

    ```ruby
    def time_it
      time_before = Time.now
      yield                   # => execute the implicit block
      time_after = Time.now

      puts "It took #{time_after - time_before} seconds."
    end

    time_it { sleep(3) }          # It took 3.003767 seconds.
                                  # => nil

    time_it { "hello world" }     # It took 3.0e-06 seconds.
                                  # => nil
    ```
    Some common uses for "sandwich code":
    * timing
    * logging
    * notification systems

    Resource management or interfacing with the operating system is another use of before/after actions.
    ```ruby
    my_file = File.open("some_file.txt", "w+")
    # write to this file using my_file.write
    my_file.close
    ```
    The last line closes the file and releases the `my_file` object from hanging onto system resources (the "some_file.txt" file). Since was always want to close files, `File::open` can also take a block and will automatically close the file after the block is executed. With block syntax, the above code is written as follows:
    ```ruby
    File.open("some_file.txt", "w+") do |file|
      # write to this file using file.write
    end
    ```

#### Methods with an explicit block parameter
What if you want to require a block to be passed into a method? Do the following:
```ruby
def test(&block)
end
```
This will take a block pass implicitly to the method and convert it into a `Proc` object. Also, drop the `&` when using the parameter in the method implementation.
```ruby
test { sleep(1) }

```
So the block become a `Proc` object. This gives the block a handle. If we want, we can _pass the block to another method_.

If this is done, you can invoke the block with the `call` method (`block.call` for the example above) or pass the block into another method.

#### Summary
* blocks are one way that Ruby implements closures. closures are a way to pass around an unnamed "chunk of code" to be executed later.
* blocks return a value, just like normal methods.
* blocks are a way to defer some implementation decisions to method invocation time. It allows method callers to refine a method at invocation time for a specific use case. It allows method implementors to build generic methods that can be used in a variety of ways.
* blocks are a good use case for "sandwich code" scenarios, like closing a `File` automatically.

## Blocks and Variable Scope
#### Refresher
Local variable scope was defined in terms of _inner_ and _outer_ scope, determined by where the local variable was initialized. A block creates a new scope for local variables.
```ruby
level_1 = "outer-most variable"

[1, 2, 3].each do |n|                     # block creates a new scope
  level_2 = "inner variable"

    level_3 = "inner-most variable"

    # all three level_X variables are accessible here
  end

  # level_1 is accessible here
  # level_2 is accessible here
  # level_3 is not accessible here

end

# level_1 is accessible here
# level_2 is not accessible here
# level_3 is not accessible here
```
This is only for _local variables_.
* Always look at where the local variable was initialized to determine its scope.
* Verify that is it indeed  local variable and not a method.
* If it is a method, it does not follow this rule.

#### Closure and binding
A block implements the idea of a _closure_. In order for this chunk of code to be executed anywhere else, it must understand the surrounding context from when it was initialized. This is represented as a `Proc` object. Example:
```ruby
chunk_of_code = Proc.new {puts "hi #{name}"}
```
`chunk_of_code` can now be passed around and executed whenever.
```ruby
def call_me(some_code)
  some_code.call        # => call will execute the "chunk of code" that gets passed in
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}

call_me(chunk_of_code)

# Output:
# hi Robert
# => nil
```
So the `chunk_of_code` knew how to handle `#{name}`. How? Variables must be passed explicitly into a method for it to be used. Take a look at the following:
```ruby
def call_me(some_code)
  some_code.call        # => call will execute the "chunk of code" that gets passed in
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin III"
call_me(chunk_of_code)

# Output:
# hi Griffin III
# => nil
```
Hmm. So even re-assigning the variable after the `Proc` is initialized update the `chunk_of_code`. So the `Proc` keeps track of its surrounding context, and drags it around wherever the chunk of code is passed. This is a __binding__ (surrounding environment/context) in Ruby. This includes local variable _and_ method references, constants and other artifacts. Everything the `Proc` needs gets dragged around. Essentially, this is why "inner scopes can access outer scopes".

## Symbol to proc
Sometimes we want to transform all item in a collection. This is so common there is a shortcut for it.
Before:
```ruby
[1, 2, 3, 4, 5].map do |num|
  num.to_s
end

# => ["1", "2", "3", "4", "5"]
```
After:
```ruby
[1, 2, 3, 4, 5].map(&:to_s)     # => ["1", "2", "3", "4", "5"]
```
This shortcut...
* works with any collect method that takes a block

#### Symbol#to_proc
Essentially this...
```ruby
(&:to_s)
```
... gets converted to this...
```ruby
{ |n| n.to_s }
```
* The `&` tells Ruby to try to convert the object into a block, which requires a `Proc` object. If the object passed in is not a `Proc` object, it will call `to_proc` on the object to make it one.
* If successful, the `&` will turn the `Proc` object into a block.


Here is one more example:
```ruby
def my_method
  yield(2)
end

# turns the symbol into a Proc, then & turns the Proc into a block
my_method(&:to_s)       # => "2"
```
In two steps, the code is written below:
```ruby
def my_method
  yield(2)
end

a_proc = :to_s.to_proc          # explicitly call to_proc on the symbol
my_method(&a_proc)              # convert Proc into block, then pass block in. Returns "2"
```

## Summary
* block, Procs and lambdas are ways to implement closures.
* closures drag their surrounding context/environment around. This is how variable scope works.
* blocks push some decisions to method invocation time
* blocks wrap logic - allows for before/after actions
* use `yield` in custom methods to utilize blocks
* blocks can take arguments
* blocks have a return value
* common Ruby methods in the standard library can be reimplemented in our own classes.
* `Symbol#to_proc` is a shortcut when working with collections.

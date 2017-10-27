# Blocks, Procs, and Lambdas
## Arity
```ruby
# Group 1
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc
puts my_proc.class
my_proc.call

# Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}" }
my_second_lambda = -> (thing) { puts "This is a #{thing}" }
puts my_lambda
puts my_second_lambda
puts my_lambda.class
my_lambda.call
my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}" }

# Group 3
def block_method_1(animal)
  yield
end


# Group 4
def block_method_2(animal)
  yield(animal)
end

  puts "This is a #{turtle} and a #{seal}."
end
```

### Solution
#### Group 1
1. A new `Proc` object can be created with a call of `proc` instead of `  Proc.new`
2. A `Proc` is an object of class `Proc`
3. a `Proc` object does not require that the correct number of arguments are passed to it. If nothing is passed, then `nil` is assigned to the block variable.

#### Group 2
1. A new `Lambda` object can be created with a call to `lambda` or `->`. We cannot create a new Lambda object with `Lambda.new`
2. A `Lambda` is actually a different variety of `Proc`
3. While a Lambda is a Proc, it maintains a separate identity from a plain Proc. this can be seen when displaying a Lambda: the string displayed contains an extra "(lambda)" that is not present for regular Procs.
4. A lambda enfores the number of arguments. If the expected number of arguments are not passed to it, then an error is thrown.

#### Group 3
1. A block passed to a method does not require the correct number of arguments. If a block variable is defined, and no value is passed to it, then `nil` will be assigned to that block variable.
2. If we have a `yield` and no block is passed, then an error is thrown.

#### Group 4
1. If we pass too few arguments to a block, then the remaining ones are assigned a `nil` value.

#### Comparison
1. Lambdas are types of Procs. Technically they are both `Proc` objects. An implicit block is a grouping of code, a type of closure, it is not an Object.
2. Lambdas enfore the number of arguments passed to them. Implicit block and Procs do not enforce the number of arguments passed in.

## Returning
```ruby
# Group 1
def check_return_with_proc
  my_proc = proc { return }
  my_proc.call
  puts "This will never output to screen."
end

check_return_with_proc

# Group 2
my_proc = proc { return }

def check_return_with_proc_2(my_proc)
  my_proc.call
end

check_return_with_proc_2(my_proc)

# Group 3
def check_return_with_lambda
  my_lambda = lambda { return }
  my_lambda.call
  puts "This will be output to screen."
end

check_return_with_lambda

# Group 4
my_lambda = lambda { return }
def check_return_with_lambda(my_lambda)
  my_lambda.call
  puts "This will be output to screen."
end

check_return_with_lambda(my_lambda)

# Group 5
def block_method_3
  yield
end

block_method_3 { return }
```

### Solution
#### Group 1
If we `return` from within a `Proc`, and that `Proc` is defined within a method, then we will immediately exit that method (we `return` from the method).

#### Group 2
If we `return` from within a `Proc` and that `Proc` is defined outside of a method, then an error will be thrown when we call that `Proc`. This occurs because program execution jumps to where the `Proc` was defined when we call that `Proc`. We cannot `return` from the top level of the program.

#### Group 3
If we `return` from within a `Lambda`, and that `Lambda` is defined within a method, then program execution jumps to where the `Lambda` code is defined. After that, code execution then proceeds to the next line of the method after the `#call` to that lambda.

#### Group 4
If we `return` from within a `Lambda` and that `Lambda` is defined outside a method, then program execution continues to the next line after the call the that `Lambda`. This is the same effect as the code in group 3.

#### Group 5

#### Comparison

If we try to `return` from within a `Proc` that is defined within a method, then we immediately exit the method.

If we try to `return` from a `Lambda`, the same _outcome_ occurs, regardless of whether the `Lambda` is defined outside a method or inside of it. Eventually, program execution will proceed to the next line after the `#call` to that lambda.
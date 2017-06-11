# Group 1
# my_proc = proc { |thing| puts "This is a #{thing}." }
# puts my_proc
# puts my_proc.class
# my_proc.call
# my_proc.call('cat')

# ANSWER
# puts my_proc gives a representation of the Proc object just like it would for any other object. Interestingly, the object id encoding is followed by what file it came from, which is different than for other objects.
# Proc is the class, proc is the keyword used to make a Proc and it takes a block.
# can `call` and proc using .call. If you don't have a block or argument for it, then it will use `nil` to as a placeholder.

# Group 2
# my_lambda = lambda { |thing| puts "This is a #{thing}" }
# my_second_lambda = -> (thing) { puts "This is a #{thing}" }
# puts my_lambda
# puts my_second_lambda
# puts my_lambda.class
# my_lambda.call('dog')
# my_lambda.call
# my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}" }

# ANSWER
# A lambda is also a Proc object and can be defined using the two formats above.
# a lambda must have the arguments listed. Without them an error will be thrown.
# Lambda.new is not a valid was to create a lambda object. makes sense considering lambdas are really proc objects.

# # Group 3
# def block_method_1(animal)
#   yield
# end

# block_method_1('seal') { |seal| puts "This is a #{seal}."}
# block_method_1('seal')

# ANSWER
# If a block is not given the required arguments, nil is used for those arguments.
# If a method is yielding to a block, then a block is required.

# # Group 4
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."}

# ANSWER
# a block will use all the arguments provided and the rest will be nil or ignored.
# # a block must specify every variable inside it, even if when that block is called, arguments aren't passed into it.

# COMPARISON
# Lambdas are types of Proc's. Technically they are both Proc objects. An implicit block is a grouping of code, a type of closure, it is not an Object.
# Lambdas enforce the number of arguments passed to them. Implicit block and Procs do not enforce the number of arguments passed in.

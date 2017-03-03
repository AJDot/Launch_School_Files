# Greeting Through Methods (Part 2)
#
# Write a method named greet that invokes the following methods:
#
# def hello
#   'Hello'
# end
#
# def world
#   'World'
# end
# When greet is invoked with #puts, it should output the following:
#
# Hello World
# Make sure you add a space between "Hello" and "World", however,
# you're not allowed to modify hello or world.

# ANSWER

def hello
  'Hello'
end

def world
  'World'
end

def greeting
  "#{hello} #{world}"
end

puts greeting

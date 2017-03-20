# repeat_yourself.rb

# Understand the problem
#   Write a method that takes two arguments, a string and a positive integer,
#   and prints out the string as many times as the integer indicates
#   Input:
#     A string and an integer
#   Output:
#     The string is printed an integer number of times
#
# Examples / Test Cases
#   repeat('Hello', 3)
#     => Hello
#     => Hello
#     => Hello
#   repeat('', 2)
#     =>
#     =>
#   repeat('A + B', 0)
#     => NO OUTPUT
#
# Data Structures
#   a string and an number
#
# Algorithm / Abstraction
#   - input string and integer
#   - print the string integer.times

# Program
def repeat(string, integer)
  integer.times { |_| puts string}
end

repeat('Hello', 3)
repeat('', 2)
repeat('A + B', 0)

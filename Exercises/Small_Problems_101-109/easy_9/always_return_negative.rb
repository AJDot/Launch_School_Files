# always_return_negative.rb

#Understand the problem
#  Write a method that takes a number as an argument. If the argument is a
#  positive number, return the negative of that number. If the number is 0 or
#  negative, return the original number.
#
#Examples / Test Cases
#  negative(5) == -5
#  negative(-3) == -3
#  negative(0) == 0      # There's no such thing as -0 in ruby

#Data Structures
#  - Input:
#  - Intermediate:
#  - Output:
#  - Return:
#
#Algorithm / Abstraction
#  -

# Program
puts "\n-------"
puts "Program"
puts "-------"
def negative(number)
  -number.abs
end

puts negative(5) == -5
puts negative(-3) == -3
puts negative(0) == 0      # There's no such thing as -0 in ruby

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

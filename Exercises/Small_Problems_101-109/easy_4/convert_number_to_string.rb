# convert_number_to_string.rb

#Understand the problem
# Write a method that take a positive integer or zero, and converts it to a
# string representation.
# You may not use any of the standard conversion methods available in Ruby,
# such as Integer#to_s, String(), Kernel#format, etc.
#  - Input: integer, 0 or greater
#  - Output:
#  - Return: string representing the integer
#
#Examples / Test Cases
#  integer_to_string(4321) == '4321'
#  integer_to_string(0) == '0'
#  integer_to_string(5000) == '5000'
#
#Data Structures
#  - Input: integer
#  - Intermediate: array of characters
#  - Output:
#  - Return: string
#
#Algorithm / Abstraction
#  - int = input integer
#  - digits = int.digits.reverse # since #digits sorts them in reverse
#  - use hash to map integers to characters
#  - join characters

# Program
DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
def integer_to_string(integer)
  digits_arr = integer.digits.reverse
  str = digits_arr.map { |digit| DIGITS[digit]}.join
end

puts integer_to_string(4321) == '4321'
puts integer_to_string(0) == '0'
puts integer_to_string(5000) == '5000'

# A more brute force method
puts '-----------------------'
puts 'A more brute for method'
puts '-----------------------'
def integer_to_string_brute(integer)
  result = ''
  loop do
    integer, remainder = integer.divmod(10)
    result.prepend(DIGITS[remainder])
    break if integer == 0
  end
  result
end

puts integer_to_string_brute(4321) == '4321'
puts integer_to_string_brute(0) == '0'
puts integer_to_string_brute(5000) == '5000'

# Further Exploration
# The #<<, #replace, #insert, and #prepend methods mutate the string but do
# not have the '!' at the end of their names. No methods do the opposite (have
# the '!' but don't mutate)

# For arrays, the #concat, #delete [#delete_at, etc...], #fill, #insert, #push,
# #replace, #shift, and #unshift mutate the array but don't have '!'. No methods
# do the converse.

# For hashes, I bet it's very similar.
# Most of the methods where the name obviously is meant to change the original
# object WILL change the original object. 

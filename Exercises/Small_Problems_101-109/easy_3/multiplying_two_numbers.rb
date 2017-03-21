# multiplying_to_numbers.rb

#Understand the problem
#  - create a method that takes two arguments, multiplies them together, and
#  - returns the result
#  - Input: 2 number
#  - Output: the product of the 2 numbers
#
#Examples / Test Cases
#  - multiply(5, 3) == 15
#
#Data Structures
#  - Input: integers
#  - Output: integer
#
#Algorithm / Abstraction
#  - input 2 integers
#  - return product of 2 integers

# Program
def multiply(num1, num2)
  num1 * num2
end

puts multiply(5, 3) == 15
puts multiply([1, 2, 3, 4], 3).inspect

# multiplying an array by an integer will add the array elements to the array
# so that there are integer sets of the original array

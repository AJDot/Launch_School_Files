# average_array.rb

# Understand the problem
#   take an array of integers and return the average of all numbers in array
#   the array will never be empty and numbers will always be positive
#   Input: array of integers
#   Output: (integer) average of integers in array
#
# Examples / Test Cases
#   puts average([1, 5, 87, 45, 8, 8]) == 25
#   puts average([9, 47, 23, 95, 16, 52]) == 40
#   The tests above should print true.
#
# Data Structures
#   Input: array of integers
#   Output: integer
#
# Algorithm / Abstraction
#   sum integers
#   divide by number of integers - use float

# Program
def average(arr)
  sum = arr.reduce(:+)
  sum / arr.size
end

puts average([1, 5, 87, 45, 8, 8]) == 25
puts average([9, 47, 23, 95, 16, 52]) == 40

# Further Exploration
def average(arr)
  sum = arr.reduce(:+)
  sum.to_f / arr.size
end

puts average([1, 5, 87, 45, 8, 8])
puts average([9, 47, 23, 95, 16, 52])

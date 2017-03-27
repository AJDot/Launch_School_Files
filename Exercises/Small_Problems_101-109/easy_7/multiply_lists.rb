# multiply_lists.rb

#Understand the problem
#  Write a method that takes two Array arguments in which each Array contains a
#  list of numbers, and returns a new Array that contains the product of each
#  pair of numbers from the arguments that have the same index. You may assume
#  that the arguments contain the same number of elements.
#  - Input: two arrays of integers of same length
#  - Output:
#  - Return: array with same index multiplication from 2 arrays
#
#Examples / Test Cases
#  multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]

#Data Structures
#  - Input: (numbers1, numbers2) arrays of integers
#  - Intermediate:
#  - Output:
#  - Return: (products)
#
#Algorithm / Abstraction
#  - products = []
#  - numbers1.each_with_index { |number| products += number * numbers2[index] }
#  -

# Program
puts "\n-------"
puts "Program"
puts "-------"
def multiply_list(numbers1, numbers2)
  products = []
  numbers1.each_with_index { |number, index| products << number * numbers2[index] }
  products
end

puts multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def multiply_list_further(numbers1, numbers2)
  numbers1.zip(numbers2).map { |arr| arr.inject(&:*) }
end
puts multiply_list_further([3, 5, 7], [9, 10, 11]) == [27, 50, 77]

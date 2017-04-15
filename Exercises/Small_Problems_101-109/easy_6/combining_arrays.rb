# combining_arrays.rb

#Understand the problem
# Write a method that takes two Arrays as arguments, and returns an Array that
# contains all of the values from the argument Arrays. There should be no
# duplication of values in teh return array, even if there are duplicates in
# the original Arrays
#  - Input: arrays
#  - Output:
#  - Return: 1 combined array without duplicates.
#
#Examples / Test Cases
#  merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9]

#Data Structures
#  - Input: (array1, array2)
#  - Intermediate:
#  - Output:
#  - Return: combined array without duplicates
#
#Algorithm / Abstraction
#  - array1 + array2.select { |element| array1.include?(element)}
# Program
def merge(array1, array2)
  # array1 | array2
  result = []
  (array1 + array2).each do |element|
    result << element if !result.include?(element)
  end
  result
end

puts merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9]
puts merge([1, 1, 2], [2, 2, 3]) == [1, 2, 3]


puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

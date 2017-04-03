# merge_sorted_lists.rb

#Understand the problem
# Write a method that takes two sorted Arrays as arguments, and returns a new
# Array that contains all elements from borth arguments in sorted order.

# You may not provide any solution that requires you to sort teh result array.
# You must build the result array one element at a time in the proper order.
# Your solution should not mutate the input arrays.

#Examples / Test Cases
# merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
# merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
# merge([], [1, 4, 5]) == [1, 4, 5]
# merge([1, 4, 5], []) == [1, 4, 5]


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
require 'pry'
def merge(array1, array2)
  iterator = array1.size + array2.size
  index1, index2 = 0, 0

  return array1 + array2 if array1.empty? || array2.empty?
  result = []

  (0...iterator).each do
    case array1[index1] <=> array2[index2]
    when -1, 0
      result << array1[index1]
      index1 += 1
    when 1
      result << array2[index2]
      index2 += 1
    end
  end
  
  result << (array1[-1] > array2[-1] ? array1[-1] : array2[-1])
  result
end

puts merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
puts merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
puts merge([], [1, 4, 5]) == [1, 4, 5]
puts merge([1, 4, 5], []) == [1, 4, 5]

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def merge(array1, array2)
  index2 = 0
  result = []

  array1.each do |value|
    while index2 < array2.size && array2[index2] <= value
      result << array2[index2]
      index2 += 1
    end
    result << value
  end

  result.concat(array2[index2..-1])
end

puts merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
puts merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
puts merge([], [1, 4, 5]) == [1, 4, 5]
puts merge([1, 4, 5], []) == [1, 4, 5]

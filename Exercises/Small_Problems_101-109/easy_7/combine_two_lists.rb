# combine_two_lists.rb

#Understand the problem
# Write a method that combines two Arrays passed in as arguments, and returns a
# new Array that contains all elements from borth Array arguments, with teh
# elements taken in alternation. You may assume that both input Arrays are
# non-empty, and that they have the same number of elements.
#  - Input: two arrays
#  - Output:
#  - Return:
#
#Examples / Test Cases
#  interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']

#Data Structures
#  - Input: (array1, array2) = two arrays to interleave
#  - Intermediate:
#  - Output:
#  - Return: array1 & array2 interleaved
#
#Algorithm / Abstraction
#  -

# Program
puts "\n-------"
puts "Program"
puts "-------"
def interleave(array1, array2)
  # array1.zip(array2).flatten
  result = []
  array1.each_with_index do |element, index|
    result << element << array2[index]
  end
  result
end

puts interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

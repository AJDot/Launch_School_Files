# sequence_count.rb

#Understand the problem
#  Create a method that takes two integers as arguments. The first argument is
#  a count, and the second is the first number of a sequence that your method
#  will create. The method should return an Array that contains the same
#  number of elements as the count argument, while the values of each element
#  will be multiples of the starting number.
#
#  You may assume that the count argument will always have a value of 0 or
#  greater, while the starting number can be any integer value. If the count
#  is 0, an empty list should be returned.
#
#Examples / Test Cases
#  sequence(5, 1) == [1, 2, 3, 4, 5]
#  sequence(4, -7) == [-7, -14, -21, -28]
#  sequence(3, 0) == [0, 0, 0]
#  sequence(0, 1000000) == []

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
def sequence(count, multiple)
  result = []
  1.upto(count) { |index| result << index * multiple }
  result
end

puts sequence(5, 1) == [1, 2, 3, 4, 5]
puts sequence(4, -7) == [-7, -14, -21, -28]
puts sequence(3, 0) == [0, 0, 0]
puts sequence(0, 1000000) == []

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

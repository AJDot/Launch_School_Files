# counting_up.rb

#Understand the problem
#  Write a method that takees an integer argument, and returns an Array of all
#  integers, in sequence, between 1 and teh argument.
#  You may assume that the argument will always be a valid integer that is
#  greater
#  than 0.
#
#Examples / Test Cases
#  sequence(5) == [1, 2, 3, 4, 5]
#  sequence(3) == [1, 2, 3]
#  sequence(1) == [1]

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
def sequence(number)
  (1..number).to_a
end

def sequence(number)
  Array.new(number) { |n| n + 1 }
end

puts sequence(5) == [1, 2, 3, 4, 5]
puts sequence(3) == [1, 2, 3]
puts sequence(1) == [1]

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def sequence_further(number)
  if number > 0
    Array.new(number) { |n| n + 1 }
  elsif number < 0
    Array.new(-number) { |n| number + n }
  end
end

puts sequence_further(5) == [1, 2, 3, 4, 5]
puts sequence_further(3) == [1, 2, 3]
puts sequence_further(1) == [1]
puts sequence_further(-5) == [-5, -4, -3, -2, -1]

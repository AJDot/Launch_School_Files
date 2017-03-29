# rotation_part_1.rb

#Understand the problem
#  Write a method that rotates an array b y moving the first element to the end
#  of the array. The original array should not be modified.
#  Do not use the method Array#rotate or Array#rotate! for your implementation

#Examples / Test Cases
#  rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
#  rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
#  rotate_array(['a']) == ['a']
#
#  x = [1, 2, 3, 4]
#  rotate_array(x) == [2, 3, 4, 1]   # => true
#  x == [1, 2, 3, 4]                 # => true

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
def rotate_array(array)
  new_array = []
  array.each { |element| new_array << element }
  new_array << new_array.shift
end

def rotate_array(array)
  array[1..-1] + [array[0]]
end

puts rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
puts rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
puts rotate_array(['a']) == ['a']

x = [1, 2, 3, 4]
puts rotate_array(x) == [2, 3, 4, 1]   # => true
x == [1, 2, 3, 4]                 # => true

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

def rotate_string(string)
  chars = string.chars
  rotate_array(chars).join
end

puts rotate_string('abcdefg') == 'bcdefga'

def rotate_integer(integer)
  digit_str = integer.to_s.chars
  rotate_array(digit_str).join.to_i
end

puts rotate_integer(123456) == 234561

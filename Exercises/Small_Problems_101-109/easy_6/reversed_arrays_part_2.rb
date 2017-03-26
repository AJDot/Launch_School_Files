# reversed_arrays_part_2.rb

#Understand the problem
# Write a method that takes an Array, and returns a new Array with the elements
# of the original list in reverse order. Do not modify the original list.
#  - Input: array
#  - Output:
#  - Return: different array with elements in reverse order
#
#Examples / Test Cases
#  reverse([1,2,3,4]) == [4,3,2,1]          # => true
#  reverse(%w(a b c d e)) == %w(e d c b a)  # => true
#  reverse(['abc']) == ['abc']              # => true
#  reverse([]) == []                        # => true
#
#  list = [1, 2, 3]                      # => [1, 2, 3]
#  new_list = reverse(list)              # => [3, 2, 1]
#  list.object_id != new_list.object_id  # => true
#  list == [1, 2, 3]                     # => true
#  new_list == [3, 2, 1]                 # => true

#Data Structures
#  - Input: (array)
#  - Intermediate:
#  - Output:
#  - Return: reversed_array = new array in reverse order
#
#Algorithm / Abstraction
#  - new_array = []
#  - array.each { |element| new_array.shift(element)}
#  - new_array
# Program
def reverse(array)
  new_array = []
  array.each { |element| new_array.unshift(element)}
  new_array
end

p reverse([1,2,3,4]) == [4,3,2,1]          # => true
p reverse(%w(a b c d e)) == %w(e d c b a)  # => true
p reverse(['abc']) == ['abc']              # => true
p reverse([]) == []                        # => true

p list = [1, 2, 3]                      # => [1, 2, 3]
p new_list = reverse(list)              # => [3, 2, 1]
p list.object_id != new_list.object_id  # => true
p list == [1, 2, 3]                     # => true
p new_list == [3, 2, 1]                 # => true

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def reverse_further(array)
  # array.each_with_object([]) { |element, new_arr| new_arr.unshift(element)}
  array.inject([], :unshift)
end

p reverse_further([1,2,3,4]) == [4,3,2,1]          # => true
p reverse_further(%w(a b c d e)) == %w(e d c b a)  # => true
p reverse_further(['abc']) == ['abc']              # => true
p reverse_further([]) == []                        # => true

p list = [1, 2, 3]                      # => [1, 2, 3]
p new_list = reverse_further(list)              # => [3, 2, 1]
p list.object_id != new_list.object_id  # => true
p list == [1, 2, 3]                     # => true
p new_list == [3, 2, 1]                 # => true

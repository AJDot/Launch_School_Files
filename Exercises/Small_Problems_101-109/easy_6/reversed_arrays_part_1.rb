# reversed_arrays_part_1.rb

#Understand the problem
# Write a method that takes an Array as an argument and reverses its elements
# in place; that is, mutate the Array passed in to this method. the return
# value should be the same Array object
#  - Input: array
#  - Output:
#  - Return: mutated array with elements in reverse order
#
#Examples / Test Cases
#  list = [1,2,3,4]
#  result = reverse!(list) # => [4,3,2,1]
#  list == [4, 3, 2, 1]
#  list.object_id == result.object_id
#
#  list = %w(a b c d e)
#  reverse!(list) # => ["e", "d", "c", "b", "a"]
#  list == ["e", "d", "c", "b", "a"]
#
#  list = ['abc']
#  reverse!(list) # => ["abc"]
#  list == ["abc"]
#
#  list = []
#  reverse!([]) # => []
#  list == []
#
#Data Structures
#  - Input: (array)
#  - Intermediate: a temporary array equal to original array
#  - Output:
#  - Return: mutated array
#
#Algorithm / Abstraction
#  - temp_array = {}
#  - array.each { |element| temp_array.shift(element)}
#  - temp_array.each_with_index { |element, index| array[index] = element }

# Program
def reverse!(array)
  left_index = 0
  right_index = -1

  while left_index < array.size / 2
    array[left_index], array[right_index] = array[right_index], array[left_index]
    left_index += 1
    right_index -= 1
  end

  array
end

list = [1,2,3,4]
p result = reverse!(list) # => [4,3,2,1]
puts list == [4, 3, 2, 1]
puts list.object_id == result.object_id

list = %w(a b c d e)
p reverse!(list) # => ["e", "d", "c", "b", "a"]
puts list == ["e", "d", "c", "b", "a"]

list = ['abc']
p reverse!(list) # => ["abc"]
puts list == ["abc"]

list = []
p reverse!([]) # => []
puts list == []

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

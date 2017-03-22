# odd_lists.rb

#Understand the problem
#  - write a method that returns an Array that contains every other element
#  - of an Array that is passed in as an argument, starting with the 1st
#  - element
#  - Input: list of elements
#  - Output: smaller list of element, containing every other element
#
#Examples / Test Cases
#  - oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
#  - oddities(['abc', 'def']) == ['abc']
#  - oddities([123]) == [123]
#  - oddities([]) == []
#
#Data Structures
#  - Input: array
#  - Output: array
#
#Algorithm / Abstraction
#  - input array of elements
#  - select array elements with even index

# Program
def oddities_1(array)
  array.select { |element| array.index(element) % 2 == 0 }
end

puts oddities_1([2, 3, 4, 5, 6]) == [2, 4, 6]
puts oddities_1(['abc', 'def']) == ['abc']
puts oddities_1([123]) == [123]
puts oddities_1([]) == []

#Further Exploration
def evenities(array)
  array.select { |element| array.index(element) % 2 == 1 }
end

puts evenities([2, 3, 4, 5, 6]) == [3, 5]
puts evenities(['abc', 'def']) == ['def']
puts evenities([123]) == []
puts evenities([]) == []

def oddities_2(array)
  index = 0
  odd_array = []
  while index < array.size
    odd_array << array[index]
    index += 2
  end
  odd_array
end

puts oddities_2([2, 3, 4, 5, 6]) == [2, 4, 6]
puts oddities_2(['abc', 'def']) == ['abc']
puts oddities_2([123]) == [123]
puts oddities_2([]) == []

def oddities_3(array)
  odd_array = []
  (0...array.size).step(2) { |index| odd_array << array[index] }
  odd_array
end

puts oddities_3([2, 3, 4, 5, 6]) == [2, 4, 6]
puts oddities_3(['abc', 'def']) == ['abc']
puts oddities_3([123]) == [123]
puts oddities_3([]) == []

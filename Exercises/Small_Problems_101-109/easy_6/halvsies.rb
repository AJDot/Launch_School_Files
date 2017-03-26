# halvsies.rb

#Understand the problem
# Write a method that takes an Array as an arguments, and returns two Arrays
# that contain the first half and second half of the original Array,
# respectively. If the original array contains an odd number of elements, the
# middle element should be placed in teh first half Array.
#  - Input: array
#  - Output:
#  - Return: Array of 2 arrays, split down the middle
#
#Examples / Test Cases
#  halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
#  halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
#  halvsies([5]) == [[5], []]
#  halvsies([]) == [[], []]

#Data Structures
#  - Input: (items) array
#  - Intermediate:
#  - Output:
#  - Return: split array
#
#Algorithm / Abstraction
#  - index = 0
#  - switch = -1
#  - items.each_with_object([[], []]) do |item, object|
#    - object[index] = items.shift
#    - switch *= -1
#    - index += switch
#  - end
# Program
def halvsies(items)
  split_arr = [[], []]
  half = (items.length - 1) / 2
  items.each_with_index do |item, index|
    split_index = index <= half ? 0 : 1
    split_arr[split_index] << items[index]
  end
  split_arr
end

puts halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
puts halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
puts halvsies([5]) == [[5], []]
puts halvsies([]) == [[], []]

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

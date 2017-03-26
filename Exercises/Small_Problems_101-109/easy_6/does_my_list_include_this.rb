# does_my_list_include_this.rb

#Understand the problem
# Write a method named include? that takes an Array and a search value as
# arguments. This method should return true if the search value is in the
# array, false, if it is not. You many not use the Array#include? method in
# yor solution.
#  - Input: an array of values and a search value
#  - Output:
#  - Return: boolean
#
#Examples / Test Cases
#  include?([1,2,3,4,5], 3) == true
#  include?([1,2,3,4,5], 6) == false
#  include?([], 3) == false
#  include?([nil], nil) == true
#  include?([], nil) == false

#Data Structures
#  - Input: (array) = items to look through
#    - (target) = item to look for
#  - Intermediate:
#  - Output:
#  - Return: boolean - true if found, false if not
#
#Algorithm / Abstraction
#  - array.find(false) { |element| element == target }

# Program
puts "\n-------"
puts "Program"
puts "-------"

def ifnone
  false
end
def include?(array, target)
  array.each { |element| return true if target == element }
  false
  # !!array.find_index(target)
end

puts include?([1,2,3,4,5], 3) == true
puts include?([1,2,3,4,5], 6) == false
puts include?([], 3) == false
puts include?([nil], nil) == true
puts include?([], nil) == false


puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

def include_further?(array, target)
  array.select { |item| item == target} != [] ? true : false
end

puts include_further?([1,2,3,4,5], 3) == true
puts include_further?([1,2,3,4,5], 6) == false
puts include_further?([], 3) == false
puts include_further?([nil], nil) == true
puts include_further?([], nil) == false

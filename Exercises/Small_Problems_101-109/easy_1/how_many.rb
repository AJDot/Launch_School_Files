# how_many.rb

# Understand the problem
#   Count the number of occurrences of each element in given array.
#   Input: array of elements
#   Output: a count of each occurence, puts each one
#
# Examples / Test Cases
#
#   vehicles = ['car', 'car', 'truck', 'car', 'SUV', 'truck', 'motorcycle', 'motorcycle', 'car', 'truck']
#   car => 4
#   truck => 3
#   SUV => 1
#   motorcycle => 2
#
# Data Structures
#   Input: array
#   Output: puts element => integer
#
# Algorithm / Abstraction
#   find all unique elements (arr.unique)
#   arr.unique.each do puts count of each element

# Program

def count_occurrences(arr)
  unique_elements = arr.uniq
  unique_elements.each { |element| puts "#{element} => #{arr.count(element)}"}
end

vehicles = ['car', 'car', 'truck', 'car', 'SUV', 'truck', 'motorcycle', 'motorcycle', 'car', 'truck']

count_occurrences(vehicles)

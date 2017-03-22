# running_totals.rb

#Understand the problem
# Write a method that takes an Array of numbers, and returns an Array with the
# same number of elements, and each element has the running total from the
# original array
#  - Input: array of numbers
#  - Output:
#  - Return: array of numbers with length of input
#
#Examples / Test Cases
#  running_total([2, 5, 13]) == [2, 7, 20]
#  running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
#  running_total([3]) == [3]
#  running_total([]) == []
#
#Data Structures
#  - Input: array of numbers
#  - Intermediate: array of numbers of running total
#  - Output:
#  - Return: array of numbers
#
#Algorithm / Abstraction
#  - numbers = input array of numbers
#  - sum = 0
#  - numbers.map { |num| sum += num}

# Program
def running_total(numbers)
  sum = 0
  numbers.map { |num| sum += num }
end

puts running_total([2, 5, 13]) == [2, 7, 20]
puts running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
puts running_total([3]) == [3]
puts running_total([]) == []

# Further Exploration
puts "-------------------"
puts "Further Exploration"
puts "-------------------"
def running_total_further1(numbers)
  sum = 0
  numbers.each_with_object([]) { |num, arr| arr << sum += num }
end

puts running_total_further1([2, 5, 13]) == [2, 7, 20]
puts running_total_further1([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
puts running_total_further1([3]) == [3]
puts running_total_further1([]) == []

require 'pry'
def running_total_further2(numbers)
  totals = []
  numbers.each_index do |index|
    totals << numbers.take(index + 1).inject(0, :+)
  end
  totals
end

puts running_total_further2([2, 5, 13]) == [2, 7, 20]
puts running_total_further2([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
puts running_total_further2([3]) == [3]
puts running_total_further2([]) == []
puts running_total_further2([1, -1, 1, -1, 1, -1]) == [1, 0, 1, 0, 1, 0]

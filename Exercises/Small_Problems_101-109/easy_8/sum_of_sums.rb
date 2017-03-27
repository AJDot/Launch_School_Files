# sum_of_sums.rb

#Understand the problem
#  Write a method that takes an Aray of numbers and then returns the sum of the
#  sums of each leading subsequence for that Array. You may assume that the
#  Array always contains at least one number
#  - Input: array of numbers
#  - Output:
#  - Return: sum of sums
#
#Examples / Test Cases
#  sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
#  sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) #
#  -> (36)
#  sum_of_sums([4]) == 4
#  sum_of_sums([1, 2, 3, 4, 5]) == 35

#Data Structures
#  - Input: (numbers)
#  - Intermediate:
#  - Output:
#  - Return:
#
#Algorithm / Abstraction

# Program
puts "\n-------"
puts "Program"
puts "-------"
def sum_of_sums(numbers)
  sums = 0
  1.upto(numbers.size) do |count|
    sums += numbers.take(count).inject(:+)
  end
  sums
end

puts sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
puts sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) # -> (36)
puts sum_of_sums([4]) == 4
puts sum_of_sums([1, 2, 3, 4, 5]) == 35

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

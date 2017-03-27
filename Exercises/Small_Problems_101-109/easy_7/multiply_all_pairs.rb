# multiply_all_pairs.rb

#Understand the problem
#  Write a method that takes two Array arguments in which each Array contains a
#  list of numbers, and returns a new Array that contains the product of every
#  pair of numbers that can be formed between the elements of the two Arrays,
#  The results should be sorted by increasing value.
#  You may assume that neither argument is an empty Array.
#  - Input: 2 arrays of numbers
#  - Output:
#  - Return: product of all combinations
#
#Examples / Test Cases
#  multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]

#Data Structures
#  - Input: (numbers1, numbers2) arrays of integers
#  - Intermediate:
#  - Output:
#  - Return: (products) = all permutations of products
#
#Algorithm / Abstraction
#  - products = []
#  - numbers1.each { |number| products << multiply_list([number], numbers2)}
#  - products.sort

# Program
puts "\n-------"
puts "Program"
puts "-------"
def multiply_all_pairs(numbers1, numbers2)
  products = []
  numbers1.each do |n1|
    products << numbers2.map { |n2| n1 * n2 }
  end
  products.flatten.sort
end

puts multiply_all_pairs([2, 4], [4, 3, 1, 2]).inspect
puts multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]



puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

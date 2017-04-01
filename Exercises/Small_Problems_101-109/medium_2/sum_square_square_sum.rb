# sum_square_square_sum.rb

#Understand the problem
#  Write a method that computes the difference between the square of the sum
#  of the first n positive integers and the sum of the squares of the first n
#  positive integers.

#Examples / Test Cases
#  sum_square_difference(3) == 22
   # -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
#  sum_square_difference(10) == 2640
#  sum_square_difference(1) == 0
#  sum_square_difference(100) == 25164150

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
def sum_square_difference(n)
  sum_square = (1..n).inject(:+) ** 2
  square_sum = (1..n).map { |int| int ** 2 }.inject(:+)
  sum_square - square_sum
end

puts sum_square_difference(3)
puts sum_square_difference(10)
puts sum_square_difference(1)
puts sum_square_difference(100)

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

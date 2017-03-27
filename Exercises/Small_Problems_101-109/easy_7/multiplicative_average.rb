# multiplicative_average.rb

#Understand the problem
#  Write a method that takes an Array of integers as input, multiplies all of
#  the numbers together, divides the result by the number of entries in teh
#  Array, and then prints the result rounded to 3 decimal places.
#  - Input: array of integers
#  - Output:
#  - Return: average of the integers
#
#Examples / Test Cases
#  show_multiplicative_average([3, 5])
#  The result is 7.500
#
#  show_multiplicative_average([2, 5, 7, 11, 13, 17])
#  The result is 28361.667

#Data Structures
#  - Input: (numbers) array of integers
#  - Intermediate:
#  - Output:
#  - Return: (average) of the numbers
#
#Algorithm / Abstraction
#  - (sum) = add all numbers together
#  - divide sum.to_f by numbers.size
#  -

# Program
puts "\n-------"
puts "Program"
puts "-------"
def show_multiplicative_average(numbers)
  sum = numbers.inject(&:*).to_f
  average = sum / numbers.size
  puts "The result is #{format("%.3f", average)}"
end

show_multiplicative_average([3, 5])
show_multiplicative_average([2, 5, 7, 11, 13, 17])

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

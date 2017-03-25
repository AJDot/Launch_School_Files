# fibonacci_number_location_by_length.rb

#Understand the problem
# Write a method that calculates and returns the index of the first Fibonacci
# number that has the number of digits specified as an argument. (The first
# Fibonacci number has index 1)
#  - Input: integer representing the number of digits in the Fibonacci number
#  - Output:
#  - Return: integer representing the index of that Fibonacci number
#
#Examples / Test Cases
#  find_fibonacci_index_by_length(2) == 7
#  find_fibonacci_index_by_length(10) == 45
#  find_fibonacci_index_by_length(100) == 476
#  find_fibonacci_index_by_length(1000) == 4782
#  find_fibonacci_index_by_length(10000) == 47847
#
#Data Structures
#  - Input: (digits) = integer number of digits in Fib number
#  - Intermediate: index = current Fib number
#  - Output:
#  - Return: (index) = index of the Fib number
#
#Algorithm / Abstraction
#  - use recursion to calculate Fib numbers
#  - keep counting until number % 10**digits < 10
#  - return index of that number

# Program
def find_fibonacci_index_by_length(length)
  index = 2
  first = 1
  second = 1
  fibonacci = 0
  while fibonacci.to_s.size < length do
    index += 1
    fibonacci = first + second
    first = second
    second = fibonacci
  end
  index
end

puts find_fibonacci_index_by_length(2) == 7
puts find_fibonacci_index_by_length(10) == 45
puts find_fibonacci_index_by_length(100) == 476
puts find_fibonacci_index_by_length(1000) == 4782
puts find_fibonacci_index_by_length(10000) == 47847

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

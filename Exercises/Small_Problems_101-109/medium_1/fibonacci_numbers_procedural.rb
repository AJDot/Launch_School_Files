# fibonacci_numbers_procedural.rb

#Understand the problem
#  In this exercise, you are going to compute a method that returns the last
#  digit of the nth Fibonacci number.

#Examples / Test Cases
#  fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
#  fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
#  fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is
#  354224848179261915075)
#  fibonacci_last(100_001)   # -> 1 (this is a 20899 digit number)
#  fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
#  fibonacci_last(123456789) # -> 4

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
def fibonacci(nth)
  last_2 = [1, 1]
  3.upto(nth) do
    last_2 = [last_2.last, last_2.first + last_2.last]
  end
  last_2
end

puts fibonacci(15)
puts fibonacci(20)
puts fibonacci(100)
puts fibonacci(100_001)

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

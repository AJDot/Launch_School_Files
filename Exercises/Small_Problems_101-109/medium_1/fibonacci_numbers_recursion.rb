# fibonacci_numbers_recursion.rb

#Understand the problem
#  A good recursive method has 3 main qualities:

#  it calls itself at least once
#  it has an ending condition (if n == 1 above)
#  the results of each recursion are used in each step (n + sum(n - 1) uses sum(
#  n - 1)).
#  Write a recursive method that computes the nth Fibonacci number, where nth
#  is an argument to the method.

#Examples / Test Cases
#  fibonacci(1) == 1
#  fibonacci(2) == 1
#  fibonacci(3) == 2
#  fibonacci(4) == 3
#  fibonacci(5) == 5
#  fibonacci(12) == 144
#  fibonacci(20) == 6765

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
def fibonacci(n)

  if n <= 2
    1
  else
    fibonacci(n - 1) + fibonacci(n - 2)
  end
end

def fibonacci(n)
  return 1 if n <= 2
  fibonacci(n - 1) + fibonacci(n - 2)
end

puts fibonacci(1) == 1
puts fibonacci(2) == 1
puts fibonacci(3) == 2
puts fibonacci(4) == 3
puts fibonacci(5) == 5
puts fibonacci(12) == 144
puts fibonacci(20) == 6765

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def fibonacci_tail(nth, acc1, acc2)
  if nth == 1
    acc1
  elsif nth == 2
    acc2
  else
    fibonacci_tail(nth - 1, acc2, acc2 + acc1)
  end
end

def fibonacci_further(nth)
  fibonacci_tail(nth, 1, 1)
end

puts fibonacci_further(1) == 1
puts fibonacci_further(2) == 1
puts fibonacci_further(3) == 2
puts fibonacci_further(4) == 3
puts fibonacci_further(5) == 5
puts fibonacci_further(12) == 144
puts fibonacci_further(20) == 6765
puts fibonacci_further(45)
puts fibonacci_further(8000)
puts fibonacci_further(10000)
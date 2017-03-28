# fizzbuzz.rb

#Understand the problem
#  Write a method that takes two arguments: the first is the starting number,
#  and the second is the ending number. Print out all numbers between the two
#  numbers, except if a number is divisible by 3, print "Fizz", if a number is
#  divisible by 5, print "Buzz", and finally if a number is divisible by 3 and
#  5, print "FizzBuzz".
#
#Examples / Test Cases
#  fizzbuzz(1, 15) # -> 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz,
#  13, 14, FizzBuzz


#Data Structures
#  - Input: integers
#  - Intermediate:
#  - Output:
#  - Return: all numbers but with multiples of 3 and 5 replaced by Fizz and Buzz
#    and when of both, replaced by FizzBuzz
#
#Algorithm / Abstraction
#  - use divisiblity rules to solve this

# Program
puts "\n-------"
puts "Program"
puts "-------"
def fizzbuzz(start, stop)
  result = []
  (start..stop).each do |number|
    result << fizzbuzz_value(number)
  end
  puts result.join(', ')
end

def fizzbuzz_value(number)
  three, five = ['', '']
  three = 'Fizz' if number % 3 == 0
  five = 'Buzz' if number % 5 == 0
  three == 'Fizz' || five == 'Buzz' ? three + five : number
end

fizzbuzz(1, 15)

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

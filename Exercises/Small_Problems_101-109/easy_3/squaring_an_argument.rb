# multiplying_to_numbers.rb

#Understand the problem
#  - use the multiply method and write a method that computes the square of its
#  - argument.
#  - Input: 1 number
#  - Output: the square of the number
#
#Examples / Test Cases
#  - square(5) == 25  => true
#  - square(-8) == 64 => true
#
#Data Structures
#  - Input: integer
#  - Output: integer
#
#Algorithm / Abstraction
#  - input integer
#  - feed into both arguments of multiply method
#  - return square of integer

# Program
require 'pry'
def multiply(num1, num2)
  num1 * num2
end

def square(num)
  multiply(num, num)
end

puts square(5) == 25
puts square(-8) == 64

#Further Exploration
def raise_to_power(num, power=2)
  product = 1
  power.times { |_| product = multiply(product, num) }
  product
end

puts "Raise to any power: 3 ** 5 = #{raise_to_power(3, 5)}"

#Recursion Exercise
def raise_to_power_recursive(num, power=2)
  if power > 1
    num * raise_to_power_recursive(num, power - 1)
  else
    num
  end
end

puts "Using recursion: 3 ** 5 = #{raise_to_power_recursive(3, 5) }"

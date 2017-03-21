# even_numbers.rb

#Understand the problem
#  - print all even numbers from 1 to 99, inclusive. All numbers should be
#  - printed on separate lines
#  - Input: none
#  - Output: evens numbers printed on separate lines
#
#Examples / Test Cases
#  - 1
#  - 3
#  - 5
#  - 7
#  - 9
#  - ...
#
#Data Structures
#  - Input:
#  - Output: integers
#
#Algorithm / Abstraction
#  - get range
#  - if number in range is even, print it

# Program
(2..99).step(2) { |num| puts num }

# Further exploration
1.upto(99) { |num| puts num if num.even?}

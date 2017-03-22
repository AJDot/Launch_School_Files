# multiples_3_and_5.rb

#Understand the problem
# write a method that searches for all multiples of 3 or 5 that lie
# between 1 and some other number, then computes the sum of those multiples.
# Assume the number passed in is greater than 1.
#  - Input: integer
#  - Output:
#  - Return: sum of all multiples of 3 or 5
#
#Examples / Test Cases
#  multisum(3) == 3
#  multisum(5) == 8
#  multisum(10) == 33
#  multisum(1000) == 234168
#
#Data Structures
#  - Input: integer (num)
#  - Intermediate: array of integers
#  - Output:
#  - Return: integer
#
#Algorithm / Abstraction
#  - declare empty array (multiples)
#  - for each number in (1..num) if num % 3 == 0 || num % 5 == 0
#    - add num to multiples
#  - sum all integers in multiples

# Program
def multiple?(number, divisor)
  number % divisor == 0
end

def multisum(num)
  (1..num).inject(0) do |sum, number|
    (multiple?(number, 3) || multiple?(number, 5)) ? sum + number : sum
  end
end

puts multisum(3) == 3
puts multisum(5) == 8
puts multisum(10) == 33
puts multisum(1000) == 234168

#Further Exploration
# I wrote it using the #inject in the first place.
# I wouldn't call this the clearest solution but it makes perfect sense to me.

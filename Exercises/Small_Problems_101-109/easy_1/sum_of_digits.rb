# sum_of_digits.rb

# Understand the problem
#   take a positive integer and returns the sum of its digits
#
# Examples / Test Cases
#   puts sum(23) == 5
#   puts sum(496) == 19
#   puts sum(123_456_789) == 45
#
# Data Structures
#   Input: positive integer (n)
#   Output: (integer) sum of digits of integer
#
# Algorithm / Abstraction
#   n.to_s.split('') to get each digit as a string
#   turn each into digit with .to_i
#   sum digits

# Program
def sum(num)
  num.to_s.chars.map(&:to_i).reduce(:+)
end

puts sum(23) == 5
puts sum(496) == 19
puts sum(123_456_789) == 45

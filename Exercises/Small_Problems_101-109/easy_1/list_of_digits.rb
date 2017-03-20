# list_of_digits.rb

# Understand the problem
#   Take a positive number and return a list of the digits in the number
#
#   Input: a positive number
#   Output: list of digits in the number
#
# Examples / Test Cases
#   puts digit_list(12345) == [1, 2, 3, 4, 5]
#   puts digit_list(7) == [7]
#   puts digit_list(375290) == [3, 7, 5, 2, 9, 0]
#   puts digit_list(444) == [4, 4, 4]
#   All these tests should print true
#
# Data Structures
#   Input: positive number
#
#
# Algorithm / Abstraction
#   convert integer to string
#   get all chars of string (string.chars)
#   convert each character back to integer

# Program

def digit_list(num)
  num_str = num.to_s
  num_chars = num_str.chars
  num_chars.map! { |char| char.to_i}
end

puts digit_list(12345) == [1, 2, 3, 4, 5]
puts digit_list(7) == [7]
puts digit_list(375290) == [3, 7, 5, 2, 9, 0]
puts digit_list(444) == [4, 4, 4]

# LS Solution
def digit_list(num)
  num.to_s.chars.map(&:to_i)
end

puts digit_list(12345) == [1, 2, 3, 4, 5]
puts digit_list(7) == [7]
puts digit_list(375290) == [3, 7, 5, 2, 9, 0]
puts digit_list(444) == [4, 4, 4]

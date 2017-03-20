# odd.rb

# Understand the problem
#   Take a number (integer or float) (pos or neg) and check if it is odd.
#
#   Input: any number
#   Output: true or false
#
# Examples / Test Cases
#   puts is_odd?(2)   # => false
#   puts is_odd?(5)   # => true
#   puts is_odd?(-17) # => true
#   puts is_odd?(-8)  # => false
#
# Data Structures
#   Input: number
#
# Algorithm / Abstraction
#   convert number to integer if it is float
#   if number % 2 == 1 then number is odd
#   otherwise, number is even

# Program
def is_odd?(num)
  num.to_i % 2 == 1 ? true : false
end

puts is_odd?(2)
puts is_odd?(5)
puts is_odd?(-17)
puts is_odd?(-8)

# Further Exploration
def is_odd?(num)
  num.to_i.remainder(2).abs == 1 ? true : false
end

puts is_odd?(2)
puts is_odd?(5)
puts is_odd?(-17)
puts is_odd?(-8)

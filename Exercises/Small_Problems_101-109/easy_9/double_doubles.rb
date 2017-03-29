# double_doubles.rb

#Understand the problem
#  A double number is a number with an even number of digits whose left-side
#  digits are exactly the same as its right-side digits. For example, 44, 3333,
#  103103, 7676 are all double numbers. 444, 334433, and 107 are not.
#
#  Write a method that returns 2 times the number provided as an argument,
#  unless
#  the argument is a double number; double numbers should be returned as-is.
#
#Examples / Test Cases
#  twice(37) == 74
#  twice(44) == 44
#  twice(334433) == 668866
#  twice(444) == 888
#  twice(107) == 214
#  twice(103103) == 103103
#  twice(3333) == 3333
#  twice(7676) == 7676
#  twice(123_456_789_123_456_789) == 123_456_789_123_456_789
#  twice(5) == 10

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
def twice(number)
  chars = number.to_s.chars
  chars_count = chars.length
  first_half = 0...(chars_count / 2)
  second_half = (chars_count / 2)..chars_count
  if chars_count.even? && chars[first_half] == chars[second_half]
    number
  else
    number * 2
  end
end

puts twice(37) == 74
puts twice(44) == 44
puts twice(334433) == 668866
puts twice(444) == 888
puts twice(107) == 214
puts twice(103103) == 103103
puts twice(3333) == 3333
puts twice(7676) == 7676
puts twice(123_456_789_123_456_789) == 123_456_789_123_456_789
puts twice(5) == 10

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

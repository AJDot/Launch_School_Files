# rotation_part_2.rb

#Understand the problem
#  Write a method that can rotate the last n digits of a number.

#Examples / Test Cases
#  rotate_rightmost_digits(735291, 1) == 735291
#  rotate_rightmost_digits(735291, 2) == 735219
#  rotate_rightmost_digits(735291, 3) == 735912
#  rotate_rightmost_digits(735291, 4) == 732915
#  rotate_rightmost_digits(735291, 5) == 752913
#  rotate_rightmost_digits(735291, 6) == 352917

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
def rotate_array(array)
  array[1..-1] + [array[0]]
end

def rotate_rightmost_digits(integer, n)
  digit_str = integer.to_s.chars
  digit_str[-n..-1] = rotate_array(digit_str[-n..-1])
  digit_str.join.to_i
end

puts rotate_rightmost_digits(735291, 1) == 735291
puts rotate_rightmost_digits(735291, 2) == 735219
puts rotate_rightmost_digits(735291, 3) == 735912
puts rotate_rightmost_digits(735291, 4) == 732915
puts rotate_rightmost_digits(735291, 5) == 752913
puts rotate_rightmost_digits(735291, 6) == 352917

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

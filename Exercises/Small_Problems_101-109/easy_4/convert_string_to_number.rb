# convert_string_to_number.rb

#Understand the problem
# Write a method that takes a String of digits, and returns the appropriate
# number as an integer. You may not use any of the methods mentioned above.
# Don't worry about leading + or - signs, nor about invalid characters;
# assume all characters will be numeric.
# You may not use any of the standard conversion methods available in Ruby
# such as String#to_i, Integer(), etc. Your method should do this the
# old-fashioned way and calculate the result by analyzing teh characters in
# the string.
#  - Input: string of digits
#  - Output:
#  - Return: integer of corresponding digits
#
#Examples / Test Cases
#  string_to_integer('4321') == 4321
#  string_to_integer('570') == 570
#
#Data Structures
#  - Input: string
#  - Intermediate:
#  - Output:
#  - Return: integer
#
#Algorithm / Abstraction
#  - chars = string.chars
#  - ords = chars.map { |char| char.ord } # will give the ordinal each character
#  - digits = ords.map { |ord| ord - 48 } # will give numbers 0..9
#  - total = 0
#  - power = 0
#  - digits.reverse.each do |digit|
#    - total += digit * (10 ** power)
#    - power + 1
#  - end
#  - total

# Program
def string_to_integer(string)
  chars = string.chars
  ords = chars.map(&:ord)
  digits = ords.map { |ord| ord - 48 }
  total = 0
  digits.each do |digit|
    total = total * 10 + digit
  end
  total
end

puts string_to_integer('4321') == 4321
puts string_to_integer('570') == 570

# I honestly did not give it one thought to use a hash. I failed this one
# because I hunted for a method that would give me the ASCII numbers for
# each digit as a string. Thus the method above...

# LS Solution
puts "---------------------"
puts "LS Solution"
puts "---------------------"
DIGITS = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9
}
def string_to_integer(string)
  digits = string.chars.map { |char| DIGITS[char]}

  value = 0
  digits.each { |digit| value = 10 * value + digit }
  value
end

puts string_to_integer('4321') == 4321
puts string_to_integer('570') == 570

# Further Exploration
puts "---------------------"
puts "Further Exploration"
puts "---------------------"
HEXA_DIGITS = {
  '0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
  'a' => 10, 'b' => 11, 'c' => 12,
  'd' => 13, 'e' => 14,'f' => 15
}
def hexadecimal_to_integer(string)
  digits = string.chars.map { |char| HEXA_DIGITS[char.downcase]}

  value = 0
  digits.each { |digit| value = 16 * value + digit }
  value
end

puts hexadecimal_to_integer('4D9f') == 19871
puts hexadecimal_to_integer('febca312da') == 1094086496986

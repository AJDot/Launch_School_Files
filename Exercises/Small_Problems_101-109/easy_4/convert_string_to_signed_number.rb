# convert_string_to_signed_number.rb

#Understand the problem
# Extend the string_to_number! assignment to include signed numbers
# take a sting of digits and return the appropriate integer. String may have a
# leading + or - sign.
#  - Input: string of digits with possible sign
#  - Output:
#  - Return: integer of corresponding digits, positive or negative
#
#Examples / Test Cases
#  string_to_signed_integer('4321') == 4321
#  string_to_signed_integer('-570') == -570
#  string_to_signed_integer('+100') == 100
#
#Data Structures
#  - Input: string
#  - Intermediate: array of characters
#  - Output:
#  - Return: integer
#
#Algorithm / Abstraction
#  - check for leading '+' or '-'
#  - if chars[0] == '+'
#    - remove '+' and run string_to_integer method
#  - elsif chars[0] == '-'
#    - remove '-' and run string_to_integer * -1
#  - else
#    - run string_to_integer

# Program
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

def string_to_signed_integer(string)
  case string[0]
  when '+' then string_to_integer(string[1..-1])
  when '-' then -string_to_integer(string[1..-1])
  else          string_to_integer(string)
  end
end

puts string_to_signed_integer('4321') == 4321
puts string_to_signed_integer('-570') == -570
puts string_to_signed_integer('+100') == 100

# Further Exploration
puts "-------------------"
puts "Further Exploration"
puts "-------------------"

def string_to_signed_integer_further(string)
  negative = string[0] == '-'
  string_no_sign = string.delete('-+')
  int = string_to_integer(string_no_sign)
  int = -int if negative
  int
end

puts string_to_signed_integer_further('4321') == 4321
puts string_to_signed_integer_further('-570') == -570
puts string_to_signed_integer_further('+100') == 100
puts string_to_signed_integer_further('100') == 100
puts string_to_signed_integer_further('-100') == -100
puts string_to_signed_integer_further('-132456789') == -132456789

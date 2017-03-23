# convert_signed_number_to_string.rb

#Understand the problem
# Wrtie a method that takes an integer and converts it to a string
# representation
#  - Input: integer
#  - Output:
#  - Return: string representing the integer
#
#Examples / Test Cases
#  signed_integer_to_string(4321) == '+4321'
#  signed_integer_to_string(-123) == '-123'
#  signed_integer_to_string(0) == '0'
#
#Data Structures
#  - Input: integer
#  - Intermediate: array of digits, array of characters
#  - Output:
#  - Return: string
#
#Algorithm / Abstraction
#  - int = input integer
#  - if int > 0, prepend '+' after string conversion
#  - elsif int < 0, prepend '-' after string conversion
#  - else string conversion
#  -

# Program
DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
def integer_to_string(integer)
  result = ''
  loop do
    integer, remainder = integer.divmod(10)
    result.prepend(DIGITS[remainder])
    break if integer == 0
  end
  result
end

def signed_integer_to_string(integer)
  case integer <=> 0
  when -1 then "-#{integer_to_string(-integer)}"
  when +1 then "+#{integer_to_string(integer)}"
  else         integer_to_string(integer)
  end
end

puts signed_integer_to_string(4321) == '+4321'
puts signed_integer_to_string(-123) == '-123'
puts signed_integer_to_string(0) == '0'

# Further Exploration
puts "-------------------"
puts "Further Exploration"
puts "-------------------"

def signed_integer_to_string_further(integer)
  prefix = case integer <=> 0
           when -1 then '-'
           when +1 then '+'
           else         ''
           end
  string = integer_to_string(integer.abs)
  prefix + string
end

puts signed_integer_to_string_further(4321) == '+4321'
puts signed_integer_to_string_further(-123) == '-123'
puts signed_integer_to_string_further(0) == '0'

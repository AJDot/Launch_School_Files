# convert_number_to_reversed_array_of_digits.rb

#Understand the problem
#  Write a method that takes a positive integer as an arguments and returns that number with its digits reversed.
#
#Examples / Test Cases
#  reversed_number(12345) == 54321
#  reversed_number(12213) == 31221
#  reversed_number(456) == 654
#  reversed_number(12000) == 21 # Note that zeros get dropped!
#  reversed_number(1) == 1

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
def reversed_number(number)
  remainder = number
  reversed = 0
  while remainder > 0
    remainder, digit = remainder.divmod(10)
    reversed = reversed * 10 + digit
  end
  reversed
end

puts reversed_number(12345) == 54321
puts reversed_number(12213) == 31221
puts reversed_number(456) == 654
puts reversed_number(12000) == 21 # Note that zeros get dropped!
puts reversed_number(1) == 1

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def reversed_number_further(number)
  number.to_s.chars.reverse.join('').to_i
end

puts reversed_number_further(12345) == 54321
puts reversed_number_further(12213) == 31221
puts reversed_number_further(456) == 654
puts reversed_number_further(12000) == 21 # Note that zeros get dropped!
puts reversed_number_further(1) == 1

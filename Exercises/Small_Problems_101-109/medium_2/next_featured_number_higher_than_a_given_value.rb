# next_featured_number_higher_than_a_given_value.rb

#Understand the problem
#  A featured number (something unique to this exercise) is an odd number that
#  is a multiple of 7, and whose digits occur exactly once each. So, for
#  example, 49 is a featured number, but 98 is not (it is not odd), 97 is not (
#  it is not a multiple of 7), and 133 is not (the digit 3 appears twice).
#
#  Write a method that takes a single integer as an argument, and returns the
#  next featured number that is greater than the argument. Issue an error
#  message if there is no next featured number.

#Examples / Test Cases
#  featured(12) == 21
#  featured(20) == 21
#  featured(21) == 35
#  featured(997) == 1029
#  featured(1029) == 1043
#  featured(999_999) == 1_023_547
#  featured(999_999_987) == 1_023_456_987

#  featured(9_999_999_999) # -> There is no possible number that fulfills those requirements

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
def featured_num?(n)
  digits = n.digits
  0.upto(9) do |num|
    return false if digits.count { |digit| digit == num} > 1
  end
  n % 7 == 0 && n.odd?
end

def featured(n)
  n += 1
  n += 1 until n.odd? && n % 7 == 0

  next_feature = nil
  until next_feature
    n += 14
    return n if featured_num?(n)
    break if n >= 9_876_543_210
  end
  'There is no possible number that fulfills those requirements.'
end

puts featured(12)
puts featured(20)
puts featured(21)
puts featured(997)
puts featured(1029)
puts featured(999_999)
puts featured(999_999_987)
puts featured(9_999_999_999)

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

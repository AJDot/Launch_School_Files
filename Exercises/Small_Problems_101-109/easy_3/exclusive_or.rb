# exclusive_or.rb

#Understand the problem
#  - write a method named xor that takes two arguments and returns true if
#  - exactly one of its arguments is true, false otherwise
#  - Input: 2 arguments of any kind
#  - Output: true if exactly one of 2 arguments is true, false otherwise
#
#Examples / Test Cases
#  - xor?(5.even?, 4.even?) == true
#  - xor?(5.odd?, 4.odd?) == true
#  - xor?(5.odd?, 4.even?) == true
#  - xor?(5.even?, 4.odd?) == true
#Data Structures
#  - Input: anything
#  - Output: true or false
#
#Algorithm / Abstraction
#  - input ar1 and arg2 into method
#  - evaluate both arguments to true or false
#  - if only one argument is true, return true, otherwise return false

# Program
def xor?(arg1, arg2)
  (arg1 && !arg2) || (!arg1 && arg2)
end

puts xor?(5.even?, 4.even?) == true
puts xor?(5.odd?, 4.odd?) == true
puts xor?(5.odd?, 4.even?) == false
puts xor?(5.even?, 4.odd?) == false

#Further Exploration
#  - xor does not perform short-circuit evaluation. This type of evaluation
#  - always needs to check both arguments to make sure only one of the two
#  - arguments is true.
#  - In this case you are not looking to find a true value somewhere, you are 
#  - looking to find only one true value. To find only, one you have to check 
#  - all of them.
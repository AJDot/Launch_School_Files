# merge_sort.rb

#Understand the problem
# An Egyptian Fraction is the sum of a series of distinct unit fractions (no
# two are the same), such as:
#
# 1   1    1    1
# - + - + -- + --
# 2   3   13   15
# Every positive rational number can be written as an Egyptian fraction. For # example:
#
#     1   1   1   1
# 2 = - + - + - + -
#     1   2   3   6
# Write two methods: one that takes a Rational number as an argument, and returns
# an Array of the denominators that are part of an Egyptian Fraction
# representation of the number, and another that takes an Array of numbers in
# the same format, and calculates the resulting Rational number. You will
# need to use the Rational class provided by Ruby.

#Examples / Test Cases
# egyptian(Rational(2, 1))    # -> [1, 2, 3, 6]
# egyptian(Rational(137, 60)) # -> [1, 2, 3, 4, 5]
# egyptian(Rational(3, 1))    # -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 230, 57960]

# unegyptian(egyptian(Rational(1, 2))) == Rational(1, 2)
# unegyptian(egyptian(Rational(3, 4))) == Rational(3, 4)
# unegyptian(egyptian(Rational(39, 20))) == Rational(39, 20)
# unegyptian(egyptian(Rational(127, 130))) == Rational(127, 130)
# unegyptian(egyptian(Rational(5, 7))) == Rational(5, 7)
# unegyptian(egyptian(Rational(1, 1))) == Rational(1, 1)
# unegyptian(egyptian(Rational(2, 1))) == Rational(2, 1)
# unegyptian(egyptian(Rational(3, 1))) == Rational(3, 1)

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
require 'pry'
def egyptian(n)
  result = []
  while n.numerator >= 1 do
    next_d = (n.denominator / n.numerator.to_f).ceil
    if result.include?(next_d) then next_d = result.last + 1 end
    result << next_d
    n -= Rational(1, next_d)
  end
  result
end

def unegyptian(denominators)
  denominators.inject(Rational(0)) { |sum, d| sum += Rational(1, d) }
end

p egyptian(Rational(2, 1))    # -> [1, 2, 3, 6]
p egyptian(Rational(137, 60)) # -> [1, 2, 3, 4, 5]
p egyptian(Rational(3, 1))    # -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 230, 57960]
p unegyptian(egyptian(Rational(1, 2))) == Rational(1, 2)
p unegyptian(egyptian(Rational(3, 4))) == Rational(3, 4)
p unegyptian(egyptian(Rational(39, 20))) == Rational(39, 20)
p unegyptian(egyptian(Rational(127, 130))) == Rational(127, 130)
p unegyptian(egyptian(Rational(5, 7))) == Rational(5, 7)
p unegyptian(egyptian(Rational(1, 1))) == Rational(1, 1)
p unegyptian(egyptian(Rational(2, 1))) == Rational(2, 1)
p unegyptian(egyptian(Rational(3, 1))) == Rational(3, 1)


puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

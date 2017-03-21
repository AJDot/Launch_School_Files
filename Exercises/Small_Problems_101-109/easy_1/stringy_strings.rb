# stringy_strings.rb

# Understand the problem
#   take a positive integer and return a string of alternating 1s and 0s
#   always starting with 1. length of string matches integer
#   Input: integer (n)
#   Output: string of length n of alternating 1s and 0s starting with 1
#
# Examples / Test Cases
#   puts stringy(6) == '101010'
#   puts stringy(9) == '101010101'
#   puts stringy(4) == '1010'
#   puts stringy(7) == '1010101'
# Data Structures
#   Input: integeter
#   Output: string
#
# Algorithm / Abstraction
#   for numbers 1..n alternate adding 1 and 0 to end of string

# Program
def stringy(num)
  string = ''
  num.times do |index|
    number = index.even? ? '1' : '0'
    string << number
  end
  string
end

puts stringy(6)
puts stringy(9)
puts stringy(4)
puts stringy(7)

# Further Exploration
def stringy(num, lead=1)
  string = ''
  first, second = if lead == 1
                    first, second = ['1', '0']
                  elsif lead == 0
                    first, second = ['0', '1']
                  end
  num.times do |index|
    number = index.even? ? first : second
    string << number
  end
  string
end

puts stringy(6, 0)
puts stringy(9, 0)
puts stringy(4, 0)
puts stringy(7, 0)

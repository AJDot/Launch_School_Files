# get_the_middle_character.rb

#Understand the problem
#  Write a method that takes a non-empty string argument, and returns the
#  middle character or characters of the argument. If the argument has an odd
#  length, you should return exactly one character. If the argument has an
#  even length, you should return exactly two characters.
#
#Examples / Test Cases
#  center_of('I love ruby') == 'e'
#  center_of('Launch School') == ' '
#  center_of('Launch') == 'un'
#  center_of('Launchschool') == 'hs'
#  center_of('x') == 'x'

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
def center_of(string)
  char_count = string.length
  mid_index = char_count / 2
  char_count.even? ? string[mid_index - 1, 2] : string[mid_index, 1]
end

puts center_of('I love ruby') == 'e'
puts center_of('Launch School') == ' '
puts center_of('Launch') == 'un'
puts center_of('Launchschool') == 'hs'
puts center_of('x') == 'x'

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

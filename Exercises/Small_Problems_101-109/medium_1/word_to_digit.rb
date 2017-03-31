# word_to_digit.rb

#Understand the problem
#  Write a method that takes a sentences string as input, and returns a new
#  string that contains the original string with any sequence of the words
#  'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight',
#  'nine' converted to a string of digits.
#
#Examples / Test Cases
#  word_to_digit('Please call me at five five five one two three four.
#  Thanks.') == 'Please call me at 5 5 5 1 2 3 4. Thanks.'


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
DICTIONARY = {
  'one'   => '1',
  'two'   => '2',
  'three' => '3',
  'four'  => '4',
  'five'  => '5',
  'six'   => '6',
  'seven' => '7',
  'eight' => '8',
  'nine'  => '9'
}
def word_to_digit(string)
  DICTIONARY.keys.each do |word|
    string.gsub!(/\b#{word}\b/, DICTIONARY)
  end
  string
end

puts word_to_digit('Please call me at five five five one two three four. Thanks.') == 'Please call me at 5 5 5 1 2 3 4. Thanks.'

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
puts "\nIGNORE CASE\n\n"
def word_to_digit_further(string)
  # words to numbers
  DICTIONARY.keys.each do |word|
    string.gsub!(/\b#{word}\b/i, DICTIONARY[word])
  end

  string
end

puts 'Please call me at Five five Five one TWO thREE four. Thanks.'
puts word_to_digit_further('Please call me at Five five Five one TWO thREE four. Thanks.')

puts "\nREMOVE SPACE BETWEEN CONVERTED NUMBERS\n\n"
def word_to_digit_spaces(string)
  # Label digits already in string
  string.gsub!(/([0-9])/, '\1FREEZE')
  word_to_digit_further(string)
  # p string
  # Remove spaces from between digits
  string.gsub!(/(\d)\s*(?=\d)/, '\1')
  # Remove label
  string.gsub!(/([0-9]*)FREEZE/, '\1')
  string
end
p 'call 23 3 5  me at Five five Five one TWO thREE four nut. Thanks.'
p word_to_digit_spaces('call 23 3 5  me at Five five Five one TWO thREE four nut. Thanks.')

puts "\nFORMAT 10-DIGIT NUMBERS AS PHONE NUMBERS\n\n"
def word_to_digit_phone(string)
  word_to_digit_spaces(string)
  string.gsub!(/(\d{3})(\d{3})(\d{4})/, '(\1) \2-\3')
  string
end

p 'five one call 23 3  5 me at eight two nine Five five Five one TWO thREE four. Thanks.'
p word_to_digit_phone('five one call 23 3  5 me at eight two nine Five five Five one TWO thREE four. Thanks.')

# clean_up_the_words.rb

#Understand the problem
# Given a string that consists of some words and an assortment of
# non-alphabetic characters, write a method that returns that string with all
# of the non-alphabetic characters replaced by spaces. If one or more
# non-alphabetic characters occur in a row, you should only have one space in
# the result (the result should never have consecutive spaces).
#  - Input: a messy string
#  - Output:
#  - Return: cleaned up string
#
#Examples / Test Cases
#  cleanup("---what's my +*& line?") == ' what s my line '

#
#Data Structures
#  - Input: (string) filled with other non-alphabetic characters
#  - Intermediate:
#  - Output:
#  - Return:
#
#Algorithm / Abstraction
#  - use gsub with a regex


# Program
def cleanup(string)
  string.gsub(/[^a-zA-Z]+/, ' ')
end

puts cleanup("---what's my +*& line?") == ' what s my line '
puts "-------------------"
puts "Further Exploration"
puts "-------------------"
# Write the method without using regular expressions
ALPHABET = ('a'..'z').to_a
def cleanup_further(string)
  clean_str = ''
  string.each_char do |char|
    clean_str << (ALPHABET.include?(char.downcase) ? char : ' ')
  end
  clean_str.squeeze(' ')
end

puts cleanup_further("---what's my +*& line?") == ' what s my line '
puts cleanup_further("---what'''$%^&*'s my +*& li*@!)(ne?") == ' what s my li ne '

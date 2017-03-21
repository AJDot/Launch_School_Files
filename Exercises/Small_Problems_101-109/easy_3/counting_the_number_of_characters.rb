# arithmetic_integer.rb

#Understand the problem
#  - take an input of a word or multiple words and give back the number of
#  - characters. Spaces should not be counted as characters
#  - Input: a string of words
#  - Output: The number of characters in the string, excluding spaces
#
#Examples / Test Cases
#  input:
#
#  Please write word or multiple words: walk
#  output:
#
#  There are 4 characters in "walk".
#  input:
#
#  Please write word or multiple words: walk, don't run
#  output:
#
#  There are 13 characters in "walk, don't run".
#
#Data Structures
#  - Input: string
#  - Output: integer representing number of characters
#
#Algorithm / Abstraction
#  - get string of words
#  - split into array of words
#  - count character in each word
#  - sum all characters

# Program
def prompt(msg)
  puts "==> #{msg}"
end

def char_in_string(string)
  string.delete(' ').size
end

print 'Please write a word or multiple words: '
string = gets.chomp

prompt "There are #{char_in_string(string)} characters in \"#{string}\"."

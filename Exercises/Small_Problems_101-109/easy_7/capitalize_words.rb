# capitalize_words.rb

#Understand the problem
# Write a method that takes a single STring argument and returns a new string
# that contains the original value of the argument, but the first letter of
# every word is now capitalized. You may assume that words are any sequence
# of non-blank characters, and that only the first character of each word
# must be considered.
#  - Input: string
#  - Output:
#  - Return: string with every word capitalized
#
#Examples / Test Cases
#  word_cap('four score and seven') == 'Four Score And Seven'
#  word_cap('the javaScript language') == 'The Javascript Language'
#  word_cap('this is a "quoted" word') == 'This Is A "quoted" Word'

#Data Structures
#  - Input: (string) a string of characters
#  - Intermediate:
#  - Output:
#  - Return: string with every word capitalized
#
#Algorithm / Abstraction
#  - string.split(" ").map(&:capitalize)

# Program
puts "\n-------"
puts "Program"
puts "-------"
def word_cap(string)
  string.split.map(&:capitalize).join(' ')
end

puts word_cap('four score and seven') == 'Four Score And Seven'
puts word_cap('the javaScript language') == 'The Javascript Language'
puts word_cap('this is a "quoted" word') == 'This Is A "quoted" Word'

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
# How would you do this without the #capitalize method?
def my_capitalize(word)
  cap_word = word.downcase
  cap_word[0] = cap_word[0].upcase
  cap_word
end

def word_cap_further(string)
  string.split.map { |word| my_capitalize(word) }.join(' ')
end

puts word_cap_further('four score and seven') == 'Four Score And Seven'
puts word_cap_further('the javaScript language') == 'The Javascript Language'
puts word_cap_further('this is a "quoted" word') == 'This Is A "quoted" Word'

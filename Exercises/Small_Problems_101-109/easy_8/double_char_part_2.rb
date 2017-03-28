# double_char_part_2.rb

#Understand the problem
#  Write a method that takes a string, and returns a new string in which every consonant character is doubled. Vowels (a, e, i, o, u), digits, punctuation, and whitespace should not be doubled.
#
#Examples / Test Cases
#  double_consonants('String') == "SSttrrinngg"
#  double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
#  double_consonants("July 4th") == "JJullyy 4tthh"
#  double_consonants('') == ""


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
def double_consonants(string)
  string.gsub(/([a-zA-Z&&[^aeiou]])/, '\1\1')
end

puts double_consonants('String') == "SSttrrinngg"
puts double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
puts double_consonants("July 4th") == "JJullyy 4tthh"
puts double_consonants('') == ""

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

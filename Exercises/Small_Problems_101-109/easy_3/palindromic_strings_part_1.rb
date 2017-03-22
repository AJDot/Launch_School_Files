# palindromic_string_part_1.rb

#Understand the problem
#  - write a method that returns true if the string passed as an argument is a
#  - palidrome, false otherwise. case matters, and all characters matter.
#  - Input: string
#  - Output: boolean based on palindrome
#
#Examples / Test Cases
#  palindrome?('madam') == true
#  palindrome?('Madam') == false          # (case matters)
#  palindrome?("madam i'm adam") == false # (all characters matter)
#  palindrome?('356653') == true
#
#Data Structures
#  - Input: string
#  - Output: boolean
#
#Algorithm / Abstraction
#  - input string (string)
#  - reverse string (including spaces) and compare to original.
#  - if true, return true, otherwise return false

# Program
def palindrome?(string)
  string.reverse == string
end

puts palindrome?('madam') == true
puts palindrome?('Madam') == false          # (case matters)
puts palindrome?("madam i'm adam") == false # (all characters matter)
puts palindrome?('356653') == true

#Further Exploration
def palindrome_array?(array)
  array.reverse == array
end

puts palindrome_array?([1, 2, 3, 4, 5]) == false
puts palindrome_array?([1, 2, 2, 1]) == true
puts palindrome_array?([1, 2, 3, 2, 1]) == true
puts palindrome_array?([123, 456, 'abc', 456, 123]) == true

# It's the exact same method for string and array
def palindrome_arr_or_str?(agr1)
  arg1.reverse == arg1
end

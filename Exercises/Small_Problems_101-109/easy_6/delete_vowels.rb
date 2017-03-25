# delete_vowels.rb

#Understand the problem
# Write a method that takes an array of strings, and returns an array of the
# same string values, except with the vowels (a, e, i, o, u) removed.
#  - Input: array of strings
#  - Output:
#  - Return: array of string but with vowels removed
#
#Examples / Test Cases
#  remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
#  remove_vowels(%w(green YELLOW black white)) == %w(grn YLLW blck wht)
#  remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']
#
#Data Structures
#  - Input: (array)
#  - Intermediate:
#  - Output:
#  - Return: array with vowels removed from each element
#
#Algorithm / Abstraction
#  - array.map(&:gsub(/[aeiou]/, ''))

# Program
def remove_vowels(strings)
  strings.map { |str| str.gsub(/[aeiou]/i, '') }
end

puts remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
puts remove_vowels(%w(green YELLOW black white)) == %w(grn YLLW blck wht)
puts remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']

# leading_substrings.rb

#Understand the problem
#  Write a method that returns a list of all substrings of a string that start at the beginning of the original string. The return value should be arranged in order from shortest to longest substring.
#  - Input: string
#  - Output:
#  - Return: All substrings of string that start at index 0
#
#Examples / Test Cases
#  substrings_at_start('abc') == ['a', 'ab', 'abc']
#  substrings_at_start('a') == ['a']
#  substrings_at_start('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']

#Data Structures
#  - Input: (string)
#  - Intermediate:
#  - Output:
#  - Return: all substrings of string starting at index 0
#
#Algorithm / Abstraction

# Program
puts "\n-------"
puts "Program"
puts "-------"
def substrings_at_start(string)
  substrings = []
  1.upto(string.length) { |count| substrings << string.slice(0, count) }
  substrings
end

puts substrings_at_start('abc') == ['a', 'ab', 'abc']
puts substrings_at_start('a') == ['a']
puts substrings_at_start('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

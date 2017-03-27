# all_substrings.rb

#Understand the problem
#  Write a method that returns a list of all substrings of a string. The
#  returned list should be ordered by where in the string the substring
#  begins. This means that all substrings that start at position 0 should come
#  first, then all substrings that start at position 1, and so on. Since
#  multiple substrings will occur at each position, the substrings at a given
#  position should be returned in order from shortest to longest.

#  You may (and should) use the substrings_at_start method you wrote in the
#  previous exercise:


#
#Examples / Test Cases
#  substrings('abcde') == [
#    'a', 'ab', 'abc', 'abcd', 'abcde',
#    'b', 'bc', 'bcd', 'bcde',
#    'c', 'cd', 'cde',
#    'd', 'de',
#    'e'
#  ]

#Data Structures
#  - Input: (string)
#  - Intermediate:
#  - Output:
#  - Return: all substrings of string
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

def substrings(string)
  substrings = []
  char_count = string.length
  0.upto(char_count - 1) do |start|
    this_substr = substrings_at_start(string.slice(start..char_count))
    substrings.concat(this_substr)
  end
  substrings
end

puts substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde',
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

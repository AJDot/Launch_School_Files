# palindromic_substrings.rb

#Understand the problem
#  Write a method that returns a list of all substrings of a string that are
#  palindromic. That is, each substring must consist of the same sequence of
#  characters forwards as it does backwards. The return value should be
#  arranged in the same sequence as the substrings appear in the string.
#  Duplicate palindromes should be included multiple times.
#
#  You may (and should) use the substrings method you wrote in the previous
#  exercise.
#
#  For the purposes of this exercise, you should consider all characters and
#  pay
#  attention to case; that is, "AbcbA" is a palindrome, but neither "Abcba"
#  nor "Abc-bA" are. In addition, assume that single characters are not
#  palindromes.
#
#Examples / Test Cases
#  palindromes('abcd') == []
#  palindromes('madam') == ['madam', 'ada']
#  palindromes('hello-madam-did-madam-goodbye') == [
#    'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
#    'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
#    '-madam-', 'madam', 'ada', 'oo'
#  ]
#  palindromes('knitting cassettes') == [
#    'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
#  ]

#Data Structures
#  - Input: (string)
#  - Intermediate:
#  - Output:
#  - Return: all substrings that are palindromes
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

def palindrome?(string)
  string == string.reverse && string.size > 1
end

def palindromes(string)
  all_palindromes = []
  all_substrings = substrings(string)
  all_substrings.each do |substring|
    all_palindromes << substring if palindrome?(substring)
  end
  all_palindromes
end

puts palindromes('abcd') == []
puts palindromes('madam') == ['madam', 'ada']
puts palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
puts palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
# Can you modify this method (and/or its predecessors) to ignore
# non-alphanumeric characters and case?
def remove_non_alpha(string)
  string.chars.select { |char| char =~ /[a-zA-Z]/ }.join
end

def substrings_at_start(string)
  substrings = []
  1.upto(string.length) { |count| substrings << string.slice(0, count) }
  substrings
end

def substrings_further(string)
  string = remove_non_alpha(string)
  substrings = []
  char_count = string.length
  0.upto(char_count - 1) do |start|
    this_substr = substrings_at_start(string.slice(start..char_count))
    substrings.concat(this_substr)
  end
  substrings
end

def palindrome_further?(string)
  string == string.reverse && string.size > 1
end


def palindromes_further(string)
  all_palindromes = []
  all_substrings = substrings_further(string)
  all_substrings.each do |substring|

    all_palindromes << substring if palindrome_further?(substring)
  end
  all_palindromes
end

puts palindromes_further('abcd') == []
puts palindromes_further('madam') == ['madam', 'ada']
puts palindromes_further('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]
puts palindromes_further('stress"ed') == ['esse', 'ss']
puts palindromes_further('a@abb$ssd$$dee$ff$gg$$$hh$') == ['aa', 'bb', 'ss', 'dd', 'ee', 'ff', 'gg', 'hh']

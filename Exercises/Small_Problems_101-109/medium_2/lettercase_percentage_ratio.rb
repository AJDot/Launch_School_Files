# lettercase_percentage_ratio.rb

#Understand the problem
#  In the easy exercises, we worked on a problem where we had to count the
#  number of uppercase and lowercase characters, as well as characters that
#  were
#  neither of those two. Now we want to go one step further.
#
#  Write a method that takes a string, and then returns a hash that contains 3
#  entries: one represents the percentage of characters in the string that are
#  lowercase letters, one the percentage of characters that are uppercase
#  letters,
#  and one the percentage of characters that are neither.
#
#  You may assume that the string will always contain at least one character.

#Examples / Test Cases
#  letter_percentages('abCdef 123') == { lowercase: 50, uppercase: 10, neither:
#  40
#  }
#  letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5,
#  neither:
#    25 }
#  letter_percentages('123') == { lowercase: 0, uppercase: 0, neither: 100 }

#Data Structures
#  - Input: (string) = the word to test
#  - Intermediate: array of arrays for each block
#  - Output:
#  - Return: (boolean) = if the word can be formed from the blocks
#
#Algorithm / Abstraction
#  -

# Program
puts "\n-------"
puts "Program"
puts "-------"
def letter_percentages(string)
  counts = { lowercase: 0, uppercase: 0, neither: 0 }
  percentages = { lowercase: 0, uppercase: 0, neither: 0 }
  chars = string.chars
  char_count = string.length
  counts[:lowercase] = chars.count { |char| char =~ /[a-z]/ }
  counts[:uppercase] = chars.count { |char| char =~ /[A-Z]/ }
  counts[:neither] = chars.count { |char| char =~ /[^a-zA-Z]/ }

  calculate(percentages, counts, char_count)
  percentages
end

def calculate(percentages, counts, length)
  percentages[:lowercase] = (counts[:lowercase] / length.to_f) * 100
  percentages[:uppercase] = (counts[:uppercase] / length.to_f) * 100
  percentages[:neither] = (counts[:neither] / length.to_f) * 100
end

puts letter_percentages('abCdef 123') == { lowercase: 50, uppercase: 10, neither: 40 }
puts letter_percentages('AbCd +Ef') == { lowercase: 37.5, uppercase: 37.5, neither:   25 }
puts letter_percentages('123') == { lowercase: 0, uppercase: 0, neither: 100 }

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"


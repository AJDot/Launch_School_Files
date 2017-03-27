# lettercase_counter.rb

#Understand the problem
# Write a method that takes a string, and then returns a hash that contains 3
# entries: one represents the number of characters in the string that are
# lowercase letters, one the number of characters that are uppercase letters,
# and one the number of characters that are neither.
#  - Input: string
#  - Output:
#  - Return: hash with those 3 things
#
#Examples / Test Cases
#  letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
#  letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
#  letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
#  letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }

#Data Structures
#  - Input: string
#  - Intermediate:
#  - Output:
#  - Return: hash containing those three things
#
#Algorithm / Abstraction
#  - chars = string.chars

# Program
puts "\n-------"
puts "Program"
puts "-------"
def letter_case_count(string)
  hash = {}
  hash[:lowercase] = string.count("a-z")
  hash[:uppercase] = string.count("A-Z")
  hash[:neither] = string.count("^a-zA-Z")
  hash
end

puts letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
puts letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
puts letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
puts letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

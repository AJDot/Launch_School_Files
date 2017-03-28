# double_char_part_1.rb

#Understand the problem
#  Write a method that takes a string, and returns a new string in which every
#  character is doubled.
#
#Examples / Test Cases
#  repeater('Hello') == "HHeelllloo"
#  repeater("Good job!") == "GGoooodd  jjoobb!!"
#  repeater('') == ''


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
def repeater(string)
  string.gsub(/(.)/, '\1\1')
end

puts repeater('Hello') == "HHeelllloo"
puts repeater("Good job!") == "GGoooodd  jjoobb!!"
puts repeater('') == ''
puts repeater("I won't stop.") == "II  wwoonn''tt  ssttoopp.."


puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

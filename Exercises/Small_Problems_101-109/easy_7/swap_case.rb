# swap_case.rb

#Understand the problem
# Write a method that takes a string as an argument and returns a new string in
# which every uppercase letter is replaced by its lowercase version, and
# every lowercase letter by its uppercase version. All other characters
# should be unchanged.
#  - Input: string
#  - Output:
#  - Return: string with all cases swapped
#
#Examples / Test Cases
#  swapcase('CamelCase') == 'cAMELcASE'
#  swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'

#Data Structures
#  - Input: (string)
#  - Intermediate:
#  - Output:
#  - Return: string with cases swapped
#
#Algorithm / Abstraction
#

# Program
puts "\n-------"
puts "Program"
puts "-------"
def swapcase(string)
  characters = string.chars.map do |char|
    if char =~ /[a-z]/
      char.upcase
    elsif char =~ /[A-Z]/
      char.downcase
    else
      char
    end
  end
  characters.join
end

puts swapcase('CamelCase') == 'cAMELcASE'
puts swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

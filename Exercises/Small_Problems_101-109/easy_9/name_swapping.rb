# name_swapping.rb

#Understand the problem
#  Write a method that takes a first name, a space, and a last name passed as a
#  single String argument, and returns a string that contains the last name, a
#  comma, aspace, and the first name.
#
#Examples / Test Cases
#  swap_name('Joe Roberts') == 'Roberts, Joe'

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
def swap_name(name)
  name.split.reverse.join(', ')
end

puts swap_name('Joe Roberts') == 'Roberts, Joe'

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

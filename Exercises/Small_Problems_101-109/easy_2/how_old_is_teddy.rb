# how_old_is_teddy.rb

# Understand the problem
#   randomly generate and print Teddy's age between 20 and 200
#   Input: none
#   Output: Teddy is #{n} years old!
#
# Examples / Test Cases
#
# Data Structures
#   Input: none
#   Output: string
#
# Algorithm / Abstraction
#   get age using rand(20..200)

# Program
def random_age(name='Teddy')
  "#{name} is #{rand(20..200)} years old!"
end

puts "What is your name?"
name = gets.chomp
puts random_age(name)
puts random_age

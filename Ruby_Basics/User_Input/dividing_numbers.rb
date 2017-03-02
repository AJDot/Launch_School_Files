# Write a program that obtains two Integers from the user, then prints the
# results of dividing the first by the second. The second number must not be 0,
# and both numbers should be validated using this method:
#
# def valid_number?(number_string)
#   number_string.to_i.to_s == number_string
# end
# This method returns true if the input string can be converted to an Integer
# and back to a string without loss of information, false otherwise. It's not a
# perfect solution in that some inputs that are otherwise valid (such as 003)
# will fail, but it is sufficient for this exercise.
#
# Examples:
#
# $ ruby division.rb
# >> Please enter the numerator:
# 8
# >> Please enter the denominator:
# 2
# >> 8 / 2 is 4
#
# $ ruby division.rb
# >> Please enter the numerator:
# 8.3
# >> Invalid input. Only integers are allowed.
# >> Please enter the numerator:
# 9
# >> Please enter the denominator:
# 4
# >> 9 / 4 is 2
#
#
# $ ruby division.rb
# >> Please enter the numerator:
# 10
# >> Please enter the denominator:
# a
# >> Invalid input. Only integers are allowed.
# >> Please enter the denominator:
# 0
# >> Invalid input. A denominator of 0 is not allowed.
# >> Please enter the denominator:
# 5
# >> 10 / 5 is 2

# ANSWER
def valid_number?(number_string)
  number_string.to_i.to_s == number_string
end
numerator = nil
denominator = nil
loop do
  puts '>> Please enter the numerator:'
  numerator = gets.chomp
  break if valid_number?(numerator)
  puts 'Invalid input. Only integers are allowed.'
end

loop do
  puts '>> Please enter the denominator:'
  denominator = gets.chomp
  if denominator == '0'
    puts '>> Invalid input. A denominator of 0 is not allowed.'
  else
    break if valid_number?(denominator)
    puts 'Invalid input. Only integers are allowed.'
  end
end

quotient = numerator.to_i / denominator.to_i
puts "#{numerator} / #{denominator} is #{quotient}"

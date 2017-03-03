# Write a program that requests two integers from the user, adds them together,
#  and then displays the result. Furthermore, insist that one of the integers be
#   positive, and one negative; however, the order in which the two integers are
#    entered does not matter.
#
# Do not check for positive/negative requirement until after both integers are
# entered, and start over if the requirement is not met.
#
# You may use the following method to validate input integers:
#
# def valid_number?(number_string)
#   number_string.to_i.to_s == number_string && number_string.to_i != 0
# end
# Examples:
#
# $ ruby opposites.rb
# >> Please enter a positive or negative integer:
# 8
# >> Please enter a positive or negative integer:
# 0
# >> Invalid input. Only non-zero integers are allowed.
# >> Please enter a positive or negative integer:
# -5
# >> 8 + -5 = 3
#
# $ ruby opposites.rb
# >> Please enter a positive or negative integer:
# 8
# >> Please enter a positive or negative integer:
# 5
# >> Sorry. One integer must be positive, one must be negative.
# >> Please start over.
# >> Please enter a positive or negative integer:
# -7
# >> Please enter a positive or negative integer:
# 5
# -7 + 5 = -2

# ANSWER
def valid_number?(number_string)
  number_string.to_i.to_s == number_string && number_string.to_i != 0
end

def read_number
  loop do
    puts '>> Please enter a positive or negative integer:'
    num_str = gets.chomp
    return num_str.to_i if valid_number?(num_str)
    puts '>> Invalid input. Only non-zero integers are allowed.'
  end
end

num_1 = nil
num_2 = nil
loop do
  num_1 = read_number
  num_2 = read_number

  break if num_1 * num_2 < 0
    puts '>> Sorry. One integer must be positive, one must be negative.'
    puts '>> Please start over.'
end
sum = num_1 + num_2
puts "#{num_1} + #{num_2} = #{sum}"

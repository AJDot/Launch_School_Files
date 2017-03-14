# hard_1.rb

# Title each question when run
def display_q(num)
  Kernel.puts("=> Question \##{num}:")
end

display_q(1)
# Question 1
# What do you expect to happen when the greeting variable is referenced in the last line of the code below?
#
# if false
#   greeting = “hello world”
# end

# greeting

# Answer 1
# Error... or so I thought. Typically an error would be thrown but when a variable
# is initialize inside an if blaock, even if it doesn't get executed,
# it will be initialized to nil.

display_q(2)
# Question 2
# What is the result of the last line in the code below?
#
# greetings = { a: 'hi' }
# informal_greeting = greetings[:a]
# informal_greeting << ' there'
#
# puts informal_greeting  #  => "hi there"
# puts greetings

# Answer 2
# {:a => 'hi there'}

display_q(3)
# Question 3

# Answer 3
# A:  "one is: one"
#     "two is: two"
#     "three is: three"
# B:  "one is: one"
#     "two is: two"
#     "three is: three"
# C:  "one is: two"
#     "two is: three"
#     "three is: one"

display_q(4)
# Question 4
# Ben was tasked to write a simple ruby method to determine if an input string
# is an IP address representing dot-separated numbers. e.g. "10.4.5.11". He is
# not familiar with regular expressions. Alyssa supplied Ben with a method called
# is_an_ip_number? that determines if a string is a valid ip address number and
# asked Ben to use it.
#
# def dot_separated_ip_address?(input_string)
#   dot_separated_words = input_string.split(".")
#   while dot_separated_words.size > 0 do
#     word = dot_separated_words.pop
#     break unless is_an_ip_number?(word)
#   end
#   return true
# end
# Alyssa reviewed Ben's code and says "It's a good start, but you missed a few
# things. You're not returning a false condition, and you're not handling the
# case that there are more or fewer than 4 components to the IP address (e.g.
#   "4.5.5" or "1.2.3.4.5" should be invalid)."

# Answer 4
# def dot_separated_ip_address?(input_string)
#   dot_separated_words = input_string.split(".")
#   return false unless dot_separated_words.size == 4
#   while dot_separated_words.size > 0 do
#     word = dot_separated_words.pop
#     return false unless is_an_ip_number?(word)
#   end
#   true
# end

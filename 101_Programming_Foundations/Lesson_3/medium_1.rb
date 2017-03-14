# medium_1.rb

# Title each question when run
def display_q(num)
  Kernel.puts("=> Question \##{num}:")
end

display_q(1)
# Question 1
# Let's do some "ASCII Art" (a stone-age form of nerd artwork from back in the
# days before computers had video screens).
#
# For this exercise, write a one-line program that creates the following output
# 10 times, with the subsequent line indented 1 space to the right:
#
# The Flintstones Rock!

# Answer 1
10.times { |num| puts(" " * num + "The Flintstones Rock!")}

display_q(2)
# Question 2

# The result of the following statement will be an error:
#
# puts "the value of 40 + 2 is " + (40 + 2)
# Why is this and what are two possible ways to fix this?

# Answer 2
# The '+' method can't add a String and a Fixnum together. The likely solution
# is that 42 was supposed to be printed.
# Solution:

puts "the value of 40 + 2 is #{40 + 2}"
puts "the value of 40 + 2 is " + (40 + 2).to_s

display_q(3)
# # Question 3
# Fix this so it takes care of 0 and negative numbers
# def factors(number)
#   dividend = number
#   divisors = []
#   begin
#     divisors << number / dividend if number % dividend == 0
#     dividend -= 1
#   end until dividend == 0
#   divisors
# end

# Answer 3
def factors(number)
  dividend = number
  divisors = []
  while dividend > 0
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

# Bonus 1
# number % dividend == 0 checks if the divisor goes evenly into the dividend

# Bonus 2
# divisors at the end insures that the divisors array is the object returned
# from the method

display_q(4)
# Question 4
# def rolling_buffer1(buffer, max_buffer_size, new_element)
#   buffer << new_element
#   buffer.shift if buffer.size > max_buffer_size
#   buffer
# end
#
# def rolling_buffer2(input_array, max_buffer_size, new_element)
#   buffer = input_array + [new_element]
#   buffer.shift if buffer.size > max_buffer_size
#   buffer
# end

# Which one is better to create a rolling buffer? Using << or using + ?

# Answer 4
# Both options return the same buffer. However, the value of the buffer argument
# is changed when using << but not when using +

display_q(5)
# Question 5
# Alyssa asked Ben to write up a basic implementation of a Fibonacci
# calculator, A user passes in two numbers, and the calculator will keep
# computing the sequence until some limit is reached.
# #
# # Ben coded up this implementation but complained that as soon as he ran it,
# he got an error. Something about the limit variable. What's wrong with the code?
#
# limit = 15
#
# def fib(first_num, second_num)
#   while second_num < limit
#     sum = first_num + second_num
#     first_num = second_num
#     second_num = sum
#   end
#   sum
# end
#
# result = fib(0, 1)
# puts "result is #{result}"

# Answer 5
# limit is not defined inside the method because methods create their own
# scope. limit needs to the passed into the method for this to work.

display_q(6)
# Question 6
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"

  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"
# Answer 6

display_q(7)
# Question 7

# Answer 7

display_q(8)
# Question 8

# Answer 8

display_q(9)
# Question 9

# Answer 9

display_q(10)
# Question 10

# Answer 10

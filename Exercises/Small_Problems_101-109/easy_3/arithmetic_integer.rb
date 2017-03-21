# arithmetic_integer.rb

#Understand the problem
#  - get two positive integers from user and print the results of the following
#  - addition, subtraction, product, quotient, remainder, and power. No need
#  - to validate inputs
#  - Input: 2 integers
#  - Output: The result of each of the above calculations
#
#Examples / Test Cases
#  ==> Enter the first number:
#  23
#  ==> Enter the second number:
#  17
#  ==> 23 + 17 = 40
#  ==> 23 - 17 = 6
#  ==> 23 * 17 = 391
#  ==> 23 / 17 = 1
#  ==> 23 % 17 = 6
#  ==> 23 ** 17 = 141050039560662968926103
#
#Data Structures
#  - Input: 2 integers (num1..num2)
#  - several integers, one for each output
#  - Output: strings displaying each result
#
#Algorithm / Abstraction
#  - get 2 integers
#  - calculate each operation
#  - display results

# Program
def prompt(msg)
  puts "==> #{msg}"
end

def compute_all(num1, num2)
  results = {}

  results[:sum] = num1 + num2
  results[:difference] = num1 - num2
  results[:product] = num1 * num2
  results[:quotient] = (num2 != 0 ? num1 / num2 : 'undefined')
  results[:remainder] = (num2 != 0 ? num1 % num2 : 'undefined')
  results[:power] = num1 ** num2

  results
end

def display_result(num1, num2, results)
  prompt "#{num1} + #{num2} = #{results[:sum].round(2)}"
  prompt "#{num1} - #{num2} = #{results[:difference].round(2)}"
  prompt "#{num1} * #{num2} = #{results[:product].round(2)}"
  prompt "#{num1} / #{num2} = #{results[:quotient].round(2)}"
  prompt "#{num1} % #{num2} = #{results[:remainder].round(2)}"
  prompt "#{num1} ** #{num2} = #{results[:power].round(2)}"
end

num1, num2 = nil
loop do
  prompt 'Enter the first number:'
  num1 = gets.chomp
  if num1.to_i.to_s == num1
    num1 = num1.to_i
    break
  elsif num1.to_f.to_s == num1
    num1 = num1.to_f
    break
  end
end
loop do
  prompt 'Enter the second number:'
  num2 = gets.chomp
  if num2.to_i.to_s == num2
    num2 = num2.to_i
    break
  elsif num2.to_f.to_s == num2
    num2 = num2.to_f
    break
  end
end

results = compute_all(num1, num2)
display_result(num1, num2, results)

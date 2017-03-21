# searching_101.rb

#Understand the problem
#  - get 6 numbers from user and print a message that describes whether or not
#  - the 6th number appears amongst the first 5
#  - Input: 6 numbers
#  - Output: result of whether or not 6th number appears amongst the first 5
#
#Examples / Test Cases
#  ==> Enter the 1st number:
#  25
#  ==> Enter the 2nd number:
#  15
#  ==> Enter the 3rd number:
#  20
#  ==> Enter the 4th number:
#  17
#  ==> Enter the 5th number:
#  23
#  ==> Enter the last number:
#  17
#  The number 17 appears in [25, 15, 20, 17, 23].
#
#
#  ==> Enter the 1st number:
#  25
#  ==> Enter the 2nd number:
#  15
#  ==> Enter the 3rd number:
#  20
#  ==> Enter the 4th number:
#  17
#  ==> Enter the 5th number:
#  23
#  ==> Enter the last number:
#  18
#  The number 18 does not appear in [25, 15, 20, 17, 23].
#
#Data Structures
#  - Input: 6 integers (num1..num6)
#  -
#  - Output: string of array of 1st 5 integers and result
#
#Algorithm / Abstraction
#  - get 6 integers
#  - construct array of 1st 5
#  - search array to see if 6th integer is present
#  - display results

# Program
def prompt(msg)
  puts "==> #{msg}"
end

arr = []
prompt "Enter the 1st number:"
arr << gets.chomp.to_i
prompt "Enter the 2nd number:"
arr << gets.chomp.to_i
prompt "Enter the 3rd number:"
arr << gets.chomp.to_i
prompt "Enter the 4th number:"
arr << gets.chomp.to_i
prompt "Enter the 5th number:"
arr << gets.chomp.to_i
prompt "Enter the last number:"
last_num = gets.chomp.to_i

if arr.include?(last_num)
  puts "The number #{last_num} appears in #{arr}."
else
  puts "The number #{last_num} does not appear in #{arr}."
end

# Write a program that asks the user for their age in years, and then
# converts that age to months.
#
# Examples:
#
# $ ruby age.rb
# >> What is your age in years?
# 35
# You are 420 months old.

# ANSWER
puts ">> What is your age in years?"
years = gets.chomp.to_i
months = years * 12
puts "You are #{months} months old."

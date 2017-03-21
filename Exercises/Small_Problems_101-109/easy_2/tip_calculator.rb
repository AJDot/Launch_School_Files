# tip_calculator.rb

#Understand the problem
# => create a simple tip calculator to prompt for bill amount and tip rate
# => compute tip and display both
# => Input: bill and tip rate
# => Output: tip and total bill displayed with correct units
#
#Examples / Test Cases
# => What is te bill? 200
# => What is the tip percentage? 15
#
# => The tip is $30.0
# => The total is $230.0
#
#Data Structures
# => Input: two floats
# => Output: strings with calculated floats for total and tip interpolated
#
#Algorithm / Abstraction
# => get bill and tip rate
# => calculate tip and total
# => puts tip and total using correct units

# Program
print 'What is the bill? '
bill = gets.chomp.to_f
print 'What is the tip percentage? '
tip_rate = gets.chomp.to_f

tip = bill * (tip_rate / 100)
total = bill + tip
puts
puts "The tip is $#{format('%.2f', tip)}"
puts "The total is $#{format('%.2f', total)}"

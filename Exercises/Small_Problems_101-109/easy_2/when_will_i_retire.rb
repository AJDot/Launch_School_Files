# when_will_i_retire.rb

#Understand the problem
# => build a program to display when the user will retire and how many years
# => she has until retirement
# => Input: age and age for retirement
# => Output: year she will retire and number of years until then
#
#Examples / Test Cases
# => What is your age? 30
# => At what age would you like to retire? 70
# =>
# => It's 2016. You will retire in 2056.
# => You have only 40 years of work to go!
#
#Data Structures
# => Input: two integers (age, age_at_retire)
# => Output: two integers (year_retire, years_to_retire)
#
#Algorithm / Abstraction
# => get age and age_at_retire
# => age_at_retire - age = years_to_retire
# => current_year + years_to_retire = year_retire

# Program
print 'What is your age? '
age = gets.chomp.to_i
print 'At what age would you like to retire? '
age_at_retire = gets.chomp.to_i

current_year = Time.now.year
years_to_retire = age_at_retire - age
year_retire = current_year + years_to_retire

puts "It's #{current_year}. You will retire in #{year_retire}."
puts "You have only #{years_to_retire} years of work to go!"

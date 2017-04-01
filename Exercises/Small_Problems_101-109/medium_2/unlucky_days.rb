# unlucky_days.rb

#Understand the problem
#  Write a method that returns the number of Friday the 13ths in the year
#  passed in as an argument. You may assume that the year is greater than 1752 (
#  when the modern Gregorian Calendar was adopted by the United Kingdom), and #  you may assume tha tthe same calendar will remain in use for the foreseeable
#  future.

#Examples / Test Cases
#  friday_13th?(2015) == 3
#  friday_13th?(1986) == 1
#  friday_13th?(2019) == 2

#Data Structures
#  - Input:
#  - Intermediate:
#  - Output:
#  - Return:
#
#Algorithm / Abstraction
#  -

# Program
puts "\n-------"
puts "Program"
puts "-------"
require 'date'
def friday_13th?(year)
  thirteenth = Date.new(year, 1, 13)
  unlucky_count = 0
  12.times do
    unlucky_count += 1 if thirteenth.friday?
    thirteenth = thirteenth.next_month
  end
  unlucky_count
end

puts friday_13th?(2015) == 3
puts friday_13th?(1986) == 1
puts friday_13th?(2019) == 2
puts friday_13th?(2017)
puts friday_13th?(1980)

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

def friday_7th?(year)
  seventh = Date.new(year, 1, 7)
  unlucky_count = 0
  12.times do
    unlucky_count += 1 if seventh.friday?
    seventh = seventh.next_month
  end
  unlucky_count
end

puts friday_7th?(2015)
puts friday_7th?(1986)
puts friday_7th?(2019)
puts friday_7th?(2017)
puts friday_7th?(1980)
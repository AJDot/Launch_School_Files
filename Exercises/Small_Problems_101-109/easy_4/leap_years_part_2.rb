# leap_years_part_2.rb

#Understand the problem
#  - The British Empire adopted the Gregorian Calendar in 1752, which was a leap
#  - year. Prior to 1752, the Julian Calendar was used, where leap years occur
#  - in any year that is evenly divisible by 4.
#  - Input: integer
#  - Output:
#  - Return: boolean
#
#Examples / Test Cases
#  leap_year?(2016) == true
#  leap_year?(2015) == false
#  leap_year?(2100) == false
#  leap_year?(2400) == true
#  leap_year?(240000) == true
#  leap_year?(240001) == false
#  leap_year?(2000) == true
#  leap_year?(1900) == false
#  leap_year?(1752) == true
#  leap_year?(1700) == true
#  leap_year?(1) == false
#  leap_year?(100) == true
#  leap_year?(400) == true
#
#Data Structures
#  - Input: integer
#  - Intermediate:
#  - Output:
#  - Return: boolean
#
#Algorithm / Abstraction
#  - input integer (year)
#  - if year % 400 == 0
#    - true
#  - elsif year % 100 != 0 && year % 4 == 0
#    - true
#  - else
#    - false
#  - end

# Program
def leap_year?(year)
  if year < 1752 && year % 4 == 0
    true
  elsif year % 400 == 0
    true
  elsif year % 100 != 0 && year % 4 == 0
    true
  else
    false
  end
end

puts leap_year?(2016) == true
puts leap_year?(2015) == false
puts leap_year?(2100) == false
puts leap_year?(2400) == true
puts leap_year?(240000) == true
puts leap_year?(240001) == false
puts leap_year?(2000) == true
puts leap_year?(1900) == false
puts leap_year?(1752) == true
puts leap_year?(1700) == true
puts leap_year?(1) == false
puts leap_year?(100) == true
puts leap_year?(400) == true

#Further Exploration
# Germanic calendars were regional calendars used before the Julian calendar
# and were adopted in the Early Middle Ages. The German states adopted the
# Gregorian calendar in parts. First, Sunday, 18 Feb 1700 was followed by
# Monday, 1 March 1700 to adopt the solar portion of the calendar.
# The lunar portion wasn't adopted until 1774 because Easter was still
# calculated using the instant of the vernal equinox and the full moon.

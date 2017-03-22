# leap_years_part_1.rb

#Understand the problem
#  - Gregorian Calendar: leap years are years evenly divisible by 4, unless
#  - the year is also divisble by 100. It the year is even divisible by 100,
#  - then it is not a leap year unless teh year is even divisible by 400.
#  - Write a method to test for leap year for years greater than 0
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
#  leap_year?(1700) == false
#  leap_year?(1) == false
#  leap_year?(100) == false
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
  if year % 400 == 0
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
puts leap_year?(1700) == false
puts leap_year?(1) == false
puts leap_year?(100) == false
puts leap_year?(400) == true

#Further Exploration
# def leap_year?(year)
#   if year % 100 == 0
#     false
#   elsif year % 400 == 0
#     true
#   else
#     year % 4 == 0
#   end
# end

#  - Written this way, leap_year? will miss the years divisible by 400.
def leap_year_further?(year)
  if year % 4 == 0
    if year % 100 == 0
      if year % 400 == 0
        true
      else
        false
      end
    else
      if year % 4 == 0
        true
      else
        false
      end
    end
  else
    false
  end
end

puts "Further Exploration"
puts leap_year_further?(2016) == true
puts leap_year_further?(2015) == false
puts leap_year_further?(2100) == false
puts leap_year_further?(2400) == true
puts leap_year_further?(240000) == true
puts leap_year_further?(240001) == false
puts leap_year_further?(2000) == true
puts leap_year_further?(1900) == false
puts leap_year_further?(1752) == true
puts leap_year_further?(1700) == false
puts leap_year_further?(1) == false
puts leap_year_further?(100) == false
puts leap_year_further?(400) == true

#  - This is now a really complicated method when you test the most general
#  - case first.

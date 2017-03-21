# how_big_is_the_room.rb

# Understand the problem
#   get length and width of room, display the area in sq. m and sq. ft.
#   Input: two lengths (floats l, w)
#   Output: area (float a, a_ft) as part of sentence
#
# Examples / Test Cases
#   Enter the length of the room in meters:
#   10
#   Enter the width of the room in meters:
#   7
#   The area of the room is 70.0 square meters (753.47 square feet).
#
# Data Structures
#   Input: floats l, w
#   Output: strings with a and a_m embedded
#
# Algorithm / Abstraction
#   get l, w
#   calculate area in m and in ft
#   puts both areas

# Program
METER_TO_FOOT = 3.28084

puts "Enter the length of the room in meters:"
length = gets.chomp.to_f
puts "Enter the width of the room in meters:"
width = gets.chomp.to_f

area_m = (length * width).round(2)
area_ft = (area_m * METER_TO_FOOT**2).round(2)

puts "The area of the room is #{area_m} square meters (#{area_ft} square feet)."

# Further exploration
FOOT_TO_INCH = 12
FOOT_TO_CM = 30.48

puts "Enter the length of the room in feet:"
length = gets.chomp.to_f
puts "Enter the width of the room in feet:"
width = gets.chomp.to_f

area_ft = (length * width).round(2)
area_in = (area_ft * FOOT_TO_INCH**2).round(2)
area_cm = (area_ft * FOOT_TO_CM**2).round(2)

puts "The area of the room is:"
puts "  #{area_ft} square feet "
puts "  #{area_in} square inches."
puts "  #{area_cm} square centimeters."

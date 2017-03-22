# what_century_is_that.rb

#Understand the problem
#  - write a method that inputs a year and outputs the correct century is is in
#  - the return should have the correct ending, 'st', 'nd', 'rd', 'th'.
#  - new centuries begin in years that end with '01'. 1901-2000 is the 20th
#  - century
#  - Input: integer
#  - Output:
#  - Return: string representation of century
#
#Examples / Test Cases
#  century(2000) == '20th'
#  century(2001) == '21st'
#  century(1965) == '20th'
#  century(256) == '3rd'
#  century(5) == '1st'
#  century(10103) == '102nd'
#  century(1052) == '11th'
#  century(1127) == '12th'
#  century(11201) == '113th'
#
#Data Structures
#  - Input: integer
#  - Intermediate:
#  - Output:
#  - Return: string
#
#Algorithm / Abstraction
#  - input integer (year)
#  - find correct century number
#    - (year - 1) / 100 + 1 = century_num
#  - attach correct suffix to century number
#    - if century_num ends in 0, 4-9 or (11..13).include?(century_num)
#      - append 'th'
#    - elsif century_num ends in 1
#      - append 'st'
#    - elsif century_num ends in 2
#      - append 'nd'
#    - elsif century_num ends in 3
#      - append 'rd'
#  - return century

# Program

require 'pry'
def century(year)
  century = ((year - 1) / 100) + 1
  century.to_s + century_suffix(century)
end
def century_suffix(century)
  ones_digit = century % 10
  return 'th' if [11, 12, 13].include?(century % 100)

  case ones_digit
  when 1 then 'st'
  when 2 then 'nd'
  when 3 then 'rd'
  else 'th'
  end
end

puts century(2000) == '20th'
puts century(2001) == '21st'
puts century(1965) == '20th'
puts century(256) == '3rd'
puts century(5) == '1st'
puts century(10103) == '102nd'
puts century(1052) == '11th'
puts century(1127) == '12th'
puts century(11201) == '113th'

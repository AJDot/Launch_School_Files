# diamonds.rb

#Understand the problem
#  Write a method that displays a 4-pointed diamond in an n x n grid, where n
#  is an odd integer that is supplied as an argument to the method. You may
#  assume that the argument will always be an odd integer.

#Examples / Test Cases
#  Example with 5 lights:
# diamond(1)
#
# *
# diamond(3)
#
 # *
# ***
 # *
# diamond(9)
#
    # *
  #  ***
  # *****
 # *******
# *********
 # *******
  # *****
  #  ***
    # *

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
def print_row(n, mid)
  num_stars = n - 2 * mid
  star = '*'
  puts (star * num_stars).center(n)
end
def diamond(n)
  middle = n / 2
  middle.downto(0) { |row| print_row(n, row) }
  1.upto(middle)   { |row| print_row(n, row) }
end

diamond(1)
diamond(5)
diamond(9)
diamond(15)

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def print_row_further(n, mid)
  row_length = n - 2 * mid
  star = '*'
  if row_length == 1
    spaces = ''
    puts star.center(n)
  else
    spaces = ' ' * (row_length - 2)
    puts (star + spaces + star).center(n)
  end
end
def diamond_further(n)
  middle = n / 2
  middle.downto(0) { |row| print_row_further(n, row) }
  1.upto(middle)   { |row| print_row_further(n, row) }
end

diamond_further(1)
diamond_further(3)
diamond_further(5)
diamond_further(9)
diamond_further(15)

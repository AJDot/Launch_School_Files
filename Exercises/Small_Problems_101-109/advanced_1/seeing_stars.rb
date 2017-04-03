# seeing_stars.rb

#Understand the problem
# Write a method that displays an 8-pointed star in an n X n grid, where n is
# an odd integer that is supplied as an argument to the method. The smallest
# such star you need to handle is a 7x7 grid.

#Examples / Test Cases
#  star(7)
#
#  *  *  *
#   * * *
#    ***
#  *******
#    ***
#   * * *
#  *  *  *
#  star(9)
#
#  *   *   *
#   *  *  *
#    * * *
#     ***
#  *********
#     ***
#    * * *
#   *  *  *
#  *   *   *

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
def print_row(grid_size, dist_from_center)
  num_spaces = dist_from_center - 1
  spaces = ' ' * num_spaces
  output = Array.new(3, '*').join(spaces)
  puts output.center(grid_size)
end

def star(grid_size)
  max_dist = (grid_size - 1) / 2
  max_dist.downto(1) { |dist| print_row(grid_size, dist) }
  puts '*' * grid_size
  1.upto(max_dist) { |dist| print_row(grid_size, dist) }
end

star(7)
puts
star(9)
puts
star(31)

puts "\n-------------------"
puts "Print Circle"
puts "-------------------"

def print_row_circle(r, y)
  # y / x pixel heights of the fonts used in the command line I am using.
  scale = (18.0 / 8.0) # used to take a skewed output and make it 1:1
  num_spaces = 2 * Math.sqrt(r**2 - y**2) * scale
  # leave room for 2 stars unless row contains only 2 stars or less
  num_spaces -= 2 if num_spaces >= 2
  spaces = ' ' * num_spaces
  output = Array.new(2, '*').join(spaces)
  puts output.center((2 * r * scale))
end

def circle(d)
  r = d / 2
  r.downto(1) { |dist| print_row_circle(r, dist) }
  1.upto(r) { |dist| print_row_circle(r, dist) }
end

circle(25)

puts "\n-------------------"
puts "Print Sine Wave"
puts "-------------------"

def print_row_sine(amp, t, period, phase_shift, vert_shift=amp)
  omega = 2 * Math::PI / period
  y = amp * Math.sin( omega * t - phase_shift) + vert_shift
  # y / x pixel heights of the fonts used in the command line I am using.
  scale = (18.0 / 8.0) # used to take a skewed output and make it 1:1
  num_spaces = y / scale
  spaces = ' ' * num_spaces
  output = spaces + '|'
  puts output
end

def sine(amp, period, phase_shift)
  # print 2 periods
  0.upto(2 * period.round) { |t| print_row_sine(amp, t, period, phase_shift) }
end

sine(40, 10 * Math::PI, 0)

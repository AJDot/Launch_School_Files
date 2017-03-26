# right_triangles.rb

#Understand the problem
# Write a method that takes a positive integers, n, as an argument, and
# displays a right triangle whose sides each have n starts. The hypotenuse of
# the triangle should have one end at the lower-left of the triangle, and the
# other end at the upper-right.
#  - Input: a positive integer
#  - Output: a right triangle made of stars with hypotenuse of length input
#  - Return:
#
#Examples / Test Cases
#  triangle(5)
#
#      *
#     **
#    ***
#   ****
#  *****
#  triangle(9)
#
#          *
#         **
#        ***
#       ****
#      *****
#     ******
#    *******
#   ********
#  *********

#Data Structures
#  - Input: (hypotenuse) = integer length of hypotenuse of triangle
#  - Intermediate:
#  - Output: stars of appropriate length to make right triangle
#  - Return:
#
#Algorithm / Abstraction
#  - All we need is to puts " " * (hypotenuse - line_num) + "*" * line_num

# Program
puts "\n-------"
puts "Program"
puts "-------"
def triangle(hypotenuse)
  (1..hypotenuse).each { |line_num| puts "#{' ' * (hypotenuse - line_num)}" +
                                      "#{'*' * line_num}" }
end

triangle(5)
triangle(9)
triangle(2)

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def triangle_upside_down(hypotenuse)
  (0...hypotenuse).each { |line_num| puts "#{' ' * line_num}" +
  "#{'*' * (hypotenuse - line_num)}" }
end

triangle_upside_down(5)
triangle_upside_down(9)
triangle_upside_down(2)

puts "\n-------"
puts "Any Way"
puts "-------"
def triangle_any_way(hypotenuse, way)

  case way
  when 'top-left'
    first = '*'
    second = ' '
    first_num = hypotenuse
    second_num = 0
    first_dir = -1
    second_dir = 1
  when 'top-right'
    first = ' '
    second = '*'
    first_num = 0
    second_num = hypotenuse
    first_dir = 1
    second_dir = -1
  when 'bottom-left'
    first = '*'
    second = ' '
    first_num = 1
    second_num = hypotenuse - 1
    first_dir = 1
    second_dir = -1
  when 'bottom-right'
    first = ' '
    second = '*'
    first_num = hypotenuse - 1
    second_num = 1
    first_dir = -1
    second_dir = 1
  end

  hypotenuse.times do |n|
    puts (first * first_num) + (second * second_num)
    first_num += first_dir
    second_num += second_dir
  end

end

triangle_any_way(5, 'top-right')
puts
triangle_any_way(5, 'bottom-right')
puts
triangle_any_way(5, 'top-left')
puts
triangle_any_way(5, 'bottom-left')
puts

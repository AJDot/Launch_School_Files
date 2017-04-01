# tri_angles.rb

#Understand the problem
#  A triangle is classified as follows:
#
#  right One angle of the triangle is a right angle (90 degrees)
#  acute All 3 angles of the triangle are less than 90 degrees
#  obtuse One angle is greater than 90 degrees.
#  To be a valid triangle, the sum of the angles must be exactly 180 degrees,
#  and
#  all angles must be greater than 0: if either of these conditions is not
#  satisfied, the triangle is invalid.
#
#  Write a method that takes the 3 angles of a triangle as arguments, and
#  returns a
#   symbol :right, :acute, :obtuse, or :invalid depending on whether the
#  triangle
#   is a right, acute, obtuse, or invalid triangle.
#
#  You may assume integer valued angles so you don't have to worry about
#  floating
#  point errors. You may also assume that the arguments are specified in
#  degrees.

#Examples / Test Cases
#  triangle(60, 70, 50) == :acute
#  triangle(30, 90, 60) == :right
#  triangle(120, 50, 10) == :obtuse
#  triangle(0, 90, 90) == :invalid
#  triangle(50, 50, 50) == :invalid

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
def triangle(angle1, angle2, angle3)
  a1, a2, a3 = [angle1, angle2, angle3].sort
  types = {-1 => :acute, 0 => :right, 1 => :obtuse}
  if a1 > 0 && a1 + a2 + a3 == 180 # if angles can form a triangle
    types[a3 <=> 90]
  else  # if angles can't form a triangle
    :invalid
  end
end

puts triangle(60, 70, 50) == :acute
puts triangle(30, 90, 60) == :right
puts triangle(120, 50, 10) == :obtuse
puts triangle(0, 90, 90) == :invalid
puts triangle(50, 50, 50) == :invalid

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

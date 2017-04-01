# triangle_sides.rb

#Understand the problem
#  A triangle is classified as follows:

# equilateral All 3 sides are of equal length
# isosceles 2 sides are of equal length, while the 3rd is different
# scalene All 3 sides are of different length
# To be a valid triangle, the sum of the lengths of the two shortest sides
# must
# be greater than the length of the longest side, and all sides must have
# lengths
# greater than 0: if either of these conditions is not satisfied, the triangle
# is invalid.

# Write a method that takes the lengths of the 3 sides of a triangle as
# arguments, and returns a symbol :equilateral, :isosceles, :scalene, or
# :invalid
# depending on whether the triangle is equilateral, isosceles, scalene, or
# invalid.

#Examples / Test Cases
#  triangle(3, 3, 3) == :equilateral
#  triangle(3, 3, 1.5) == :isosceles
#  triangle(3, 4, 5) == :scalene
#  triangle(0, 3, 3) == :invalid
#  triangle(3, 1, 1) == :invalid

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
def triangle(side1, side2, side3)
  s1, s2, s3 = [side1, side2, side3].sort
  if s1 > 0 && s1 + s2 > s3  # if sides can form a triangle
    if s1 == s3
      :equilateral
    elsif s1 == s2 || s2 == s3
      :isosceles
    else
      :scalene
    end
  else  # if sides can't form a triangle
    :invalid
  end
end

puts triangle(3, 3, 3) == :equilateral
puts triangle(3, 3, 1.5) == :isosceles
puts triangle(3, 4, 5) == :scalene
puts triangle(0, 3, 3) == :invalid
puts triangle(3, 1, 1) == :invalid

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

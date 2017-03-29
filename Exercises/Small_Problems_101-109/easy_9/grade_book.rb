# grade_book.rb

#Understand the problem
#  Write a method that determines the mean (average) of the three scores passed
#  to it, and returns the letter value associated with that grade.
#
#  Numerical Score Letter	Grade
#  90 <= score <= 100	'A'
#  80 <= score < 90	'B'
#  70 <= score < 80	'C'
#  60 <= score < 70	'D'
#  0 <= score < 60
#
#  Tested values are all between 0 and 100. There is no need to check for
#  negative values or values greater than 100.

#Examples / Test Cases
#  get_grade(95, 90, 93) == "A"
#  get_grade(50, 50, 95) == "D"
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
def get_grade(s1, s2, s3)
  average = (s1 + s2 + s3) / 3
  case average
  when 90..100 then 'A'
  when 80...90 then 'B'
  when 70...80 then 'C'
  when 60...70 then 'D'
  else              'F'
  end
end

puts get_grade(95, 90, 93) == "A"
puts get_grade(50, 50, 95) == "D"

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def get_grade_further(s1, s2, s3)
  average = (s1 + s2 + s3) / 3
  case average
  when 80...90 then 'B'
  when 70...80 then 'C'
  when 60...70 then 'D'
  when 0...60  then 'F'
  else              'A'
  end
end

puts get_grade_further(95, 90, 93) == "A"
puts get_grade_further(50, 50, 95) == "D"
puts get_grade_further(105, 105, 95) == "A"

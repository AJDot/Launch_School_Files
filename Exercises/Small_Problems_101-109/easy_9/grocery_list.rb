# grocery_list.rb

#Understand the problem
#  Write a method which takes a grocery list (array) of fruits with quantities
#  and converts it into an array of the correct number of each fruit

#Examples / Test Cases
#  buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
#  ["apples", "apples", "apples", "orange", "bananas","bananas"]

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
def buy_fruit(array)
  result = []
  array.each { |(fruit, count)| result.concat(Array.new(count, fruit)) }
  result
end

def buy_fruit(array)
  array.map { |fruit, count| [fruit] * count }.flatten
end

buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]

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

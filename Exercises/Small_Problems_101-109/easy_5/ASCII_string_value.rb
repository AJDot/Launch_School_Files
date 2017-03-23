# ASCII_string_value.rb

#Understand the problem
# Write a method that determines and returns the ASCII string value of a string
# that is passed in as an argument. The ASCII string value is the sum of the
# ASCII values of every character int eh string. (String#ord can be used.)
#  - Input: string
#  - Output:
#  - Return: integer, sum of the ASCII values
#
#Examples / Test Cases
#  ascii_value('Four score') == 984
#  ascii_value('Launch School') == 1251
#  ascii_value('a') == 97
#  ascii_value('') == 0
#
#Data Structures
#  - Input: any string (string)
#  - Intermediate:
#  - Output:
#  - Return: integer (sum)
#
#Algorithm / Abstraction
#  - chars = string.chars
#  - ords = iterate through characters, obtaining ASCII value with char.ord
#  - sum = ords.inject(&:+)

# Program
def ascii_value(string)
  sum = 0
  string.each_char { |char| sum += char.ord }
  sum
end

puts ascii_value('Four score') == 984
puts ascii_value('Launch School') == 1251
puts ascii_value('a') == 97
puts ascii_value('') == 0

# Further Exploration
puts "-------------------"
puts "Further Exploration"
puts "-------------------"

puts "with characters..."
chars = %w[a s d f g]
chars.each_with_object([]) do |char, arr|
  arr << (char.ord.chr == char)
  if arr.length == chars.length then p arr end
end
puts
puts "with longer words..."
chars = %w[apple sausage donut fries gold]
chars.each_with_object([]) do |char, arr|
  arr << (char.ord.chr == char)
  if arr.length == chars.length then p arr end
end

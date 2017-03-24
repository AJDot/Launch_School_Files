# letter_counter_part_1.rb

#Understand the problem
# Write a method that takes an Array of Integers between 0 and 19, and return an
# Array of those Integers sorted based on the English words for each number:
# zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen
#  - Input: array of integers 1..19
#  - Output:
#  - Return: array of same length with same integers, but sorted according to
#    the English words for each number
#
#Examples / Test Cases
#  alphabetic_number_sort((0..19).to_a) == [
#    8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
#    6, 16, 10, 13, 3, 12, 2, 0
#  ]

#
#Data Structures
#  - Input: (numbers) integer array
#  - Intermediate: a hash to map number to word?
#  - Output:
#  - Return: (sorted_numbers) = numbers but sorted
#
#Algorithm / Abstraction
#  - sort array using the English words for each number
#    - use a hash to map each number to the English word
#    - sort based on the comparison of the English words
#  - return sorted array

# Program
puts "\n-------------------"
puts "Results"
puts "-------------------"

ENGLISH_WORDS = ['zero', 'one', 'two', 'three', 'four', 'five', 'six',
                'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve',
                'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen',
                'eighteen', 'nineteen']

def alphabetic_number_sort(numbers)
  numbers.sort_by { |number| ENGLISH_WORDS[number] }
end

 puts alphabetic_number_sort((0..19).to_a) == [
   8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
   6, 16, 10, 13, 3, 12, 2, 0
 ]

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

# We used Enumerable#sort_by instead of Array#sort_by! because the array we
# input isn't an object itself, not a reference to one? I'm not sure.

def alphabetic_number_sort_further(numbers)
  numbers.sort { |n1, n2| ENGLISH_WORDS[n1] <=> ENGLISH_WORDS[n2] }
end

puts alphabetic_number_sort_further((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0
]
puts alphabetic_number_sort_further([1, 4, 6, 5, 3, 9]) == [5, 4, 9, 1, 6, 3]

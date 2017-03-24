# letter_counter_part_1.rb

#Understand the problem
# Write a method that takes a string with one or more space-separated words and
# returns a hash that shows the number of words of different sizes.
# Words consist of any string of characters that do not include a space
#  - Input: string of words
#  - Output:
#  - Return: hash of word_length:frequency
#
#Examples / Test Cases
#  word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
#  word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
#  word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
#  word_sizes('') == {}

#
#Data Structures
#  - Input: (string) words
#  - Intermediate:
#  - Output:
#  - Return: (word_size_frequency) hash
#
#Algorithm / Abstraction
#  - words = string.split(' ')
#  - words.each { |word| find word length then increment hash.key(length) by 1}

# Program
def word_sizes(string)
  words = string.split(' ')
  word_size_frequency = Hash.new(0)
  words.each do |word|
    word_size_frequency[word.length] += 1
  end
  word_size_frequency
end

puts word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
puts word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
puts word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
puts word_sizes('') == {}

puts "-------------------"
puts "Further Exploration"
puts "-------------------"

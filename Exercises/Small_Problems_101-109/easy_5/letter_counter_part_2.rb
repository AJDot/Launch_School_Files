# letter_counter_part_2.rb

#Understand the problem
# Modify the word_sizes method to exclude non-letters when determining word
# size. For instance, the length of "it's" is 3, not 4.
#  - Input: string of words
#  - Output:
#  - Return: hash of word_length:frequency
#
#Examples / Test Cases
#  word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
#  word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
#  word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
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
def cleanup_word(string)
  string.gsub(/[^a-zA-Z]+/, '')
end

def word_sizes(string)
  words = string.split(' ')
  word_size_frequency = Hash.new(0)
  words.each do |word|
    word_size_frequency[cleanup_word(word).length] += 1
    # word_size_frequency[word.delete('^A-Za-z').length] += 1
  end
  word_size_frequency
end

puts word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
puts word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
puts word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
puts word_sizes('') == {}

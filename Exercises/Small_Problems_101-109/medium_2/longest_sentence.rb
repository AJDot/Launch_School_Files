# longest_sentence.rb

#Understand the problem
#  Write a program that reads the content of a text file and then prints the
#  longest sentence in the file based on number of words. Sentences may end
#  with periods (.), exclamation points (!), or question marks (?). Any
#  sequence of characters that are not spaces or sentence-ending characters
#  should be treated as a word. You should also print the number of words in
#  the longest sentence.

#Examples / Test Cases

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
def longest_sentence(file_path)
  # read in file
  file = File.read(file_path)
  # remove newline characters from file
  file.gsub!(/\n{2}/, "")
  file.gsub!(/\n/, " ")
  # split file into sentences
  sentences = file.split(/[\.!\?]/)
  longest_sentence = sentences.max_by { |sentence| sentence.split.size }
  num_of_words = longest_sentence.split.size
  puts "The longest sentence is:\n #{longest_sentence}"
  puts "It is #{num_of_words} words long."
end
longest_sentence('example_text_1.txt')


puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

def longest_word(file_path)
  # read in file
  file = File.read(file_path)
  # remove newline characters from file
  file.gsub!(/\n{2}/, "")
  file.gsub!(/\n/, " ")
  # split file into sentences
  sentences = file.split(/[\.!\?]/)
  # split into words
  words = sentences.map { |sentence| sentence.split }.flatten
  # find longest word
  longest_word = words.max_by { |word| word.size }
  num_of_chars = longest_word.size
  puts "The longest word is:\n #{longest_word}"
  puts "It is #{num_of_chars} characters long."
end

def longest_paragraph(file_path)
  # read in file
  file = File.read(file_path)
  # split into paragraphs
  paragraphs = file.split(/\n{2}/)
  # find longest paragraph
  longest_paragraph = paragraphs.max_by do |paragraph|
    paragraph.split.size
  end
  word_count = longest_paragraph.split.size
  puts "The longest paragraph is:\n #{longest_paragraph}"
  puts "It is #{word_count} words long."
end

longest_word('example_text_1.txt')
longest_paragraph('example_text_1.txt')

puts "\n----------------"
puts "For Frankenstein"
puts "----------------"

longest_word('example_text_2.txt')
longest_sentence('example_text_2.txt')
longest_paragraph('example_text_2.txt')

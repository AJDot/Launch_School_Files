# bannerizer.rb

#Understand the problem
# Write a method that will take a short line of text, and print it within a box.
#  - Input: string
#  - Output:
#  - Return: string printed inside a box
#
#Examples / Test Cases
#  print_in_box('To boldly go where no one has gone before.')
#  +--------------------------------------------+
#  |                                            |
#  | To boldly go where no one has gone before. |
#  |                                            |
#  +--------------------------------------------+
#  print_in_box('')
#  +--+
#  |  |
#  |  |
#  |  |
#  +--+

#
#Data Structures
#  - Input: (string)
#  - Intermediate:
#  - Output:
#  - Return: formatted string
#
#Algorithm / Abstraction
#  - dashes = string.length + 2

# Program


def print_in_box(string)
  box_width = string.length + 2
  horizontal_rule = "+#{'-' * box_width}+"
  empty_line = "|#{' ' * box_width}|"
  box_lines = Array.new(5, '')
  box_lines[0] = horizontal_rule
  box_lines[1] = empty_line
  box_lines[2] = "| #{string} |"
  box_lines[3] = empty_line
  box_lines[4] = horizontal_rule
  puts box_lines.join("\n")
end

print_in_box('To boldly go where no one has gone before.')
print_in_box('')

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def print_in_box_further(string)
  if string.length > 76
    string = string[0, 76]
  end
  box_width = string.length + 2
  horizontal_rule = "+#{'-' * box_width}+"
  empty_line = "|#{' ' * box_width}|"

  box_lines = Array.new(5, '')
  box_lines[0] = horizontal_rule
  box_lines[1] = empty_line
  box_lines[2] = "| #{string} |"
  box_lines[3] = empty_line
  box_lines[4] = horizontal_rule
  puts box_lines.join("\n")
end

print_in_box_further('To boldly go where no one has gone before. Where is no one going? Not sure. But it is not here.')
print_in_box_further('')

puts "\n--------------"
puts "Real Challenge"
puts "--------------"

def slice(string)
  chars = string.chars
  line_width = case chars.length
               when 0          then 1
               when (1..76)    then chars.length
               else                 76
               end

  text_lines = Array.new((chars.length / line_width) + 1, '')
  chars.each_with_index do |char, index|
    text_lines[index / line_width] += char
  end
  text_lines
end

def print_in_box_challenge(string)
  text_lines = slice(string)

  horizontal_rule = "+#{'-' * (text_lines[0].length + 2)}+"
  empty_line = "|#{' ' * (text_lines[0].length + 2)}|"

  puts horizontal_rule
  puts empty_line
  text_lines.each { |line| puts "| #{line.lstrip.ljust(text_lines[0].length)} |"}
  puts empty_line
  puts horizontal_rule
end

print_in_box_challenge('This example demonstrates a block quote. Because some introductory phrases will lead naturally into the block quote, you might choose to begin the block quote with a lowercase letter. In this and the later examples we use “Lorem ipsum” text to ensure that each block quotation contains 40 words or more. Lorem ipsum dolor sit amet, consectetur adipiscing elit. (Organa, 2013, p. 234)')
print_in_box_challenge('Modify this method so it will truncate the message if it will be too wide to fit inside a standard terminal window (80 columns, including the sides of the box). For a real challenge, try word wrapping very long messages so they appear on multiple lines, but still within a box.')
print_in_box_challenge('')

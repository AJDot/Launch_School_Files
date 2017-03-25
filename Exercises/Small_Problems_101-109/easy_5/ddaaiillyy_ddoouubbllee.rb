# ddaaiillyy_ddoouubbllee.rb

#Understand the problem
# Write a method that takes a string argument and returns a new string that
# contains the value of the original string with all consecutive duplicate
# characters collapsed into a single character.
#  - Input: string of characters
#  - Output:
#  - Return: string with all the consecutive duplicates removed.
#
#Examples / Test Cases
#  crunch('ddaaiillyy ddoouubbllee') == 'daily double'
#  crunch('4444abcabccba') == '4abcabcba'
#  crunch('ggggggggggggggg') == 'g'
#  crunch('a') == 'a'
#  crunch('') == ''

#
#Data Structures
#  - Input: (string)
#  - Intermediate:
#  - Output:
#  - Return: squeezed string
#
#Algorithm / Abstraction
#  - just squeeze the string

# Program
# def crunch(string)
#   string.squeeze
# end
def crunch(text)
  index = 0
  crunch_text = ''
  while index <= text.length - 1
    crunch_text << text[index] unless text[index] == text[index + 1]
    index += 1
  end
  crunch_text
end


puts crunch('ddaaiillyy ddoouubbllee') == 'daily double'
puts crunch('4444abcabccba') == '4abcabcba'
puts crunch('ggggggggggggggg') == 'g'
puts crunch('a') == 'a'
puts crunch('') == ''

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

# using #each_char or #char would not allow us to easily access the index
# beyond the length of the array.
# to use such methods, each iteration would need a record of the previous value,
# compare to that, if they are different then add it to the array. If they
# argument
# the same, then do nothing.

# Using regex
def crunch_regex(text)
  # (?=) is a positive look ahead. Looks ahead and matches but does not include
  # it in the result.
  text.gsub(/(.)(?=\1)/,"")
end

puts crunch_regex('ddaaiillyy ddoouubbllee') == 'daily double'
puts crunch_regex('4444abcabccba') == '4abcabcba'
puts crunch_regex('ggggggggggggggg') == 'g'
puts crunch_regex('a') == 'a'
puts crunch_regex('') == ''

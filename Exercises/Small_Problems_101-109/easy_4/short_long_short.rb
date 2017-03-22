# short_long_short.rb

#Understand the problem
#  - take two strings, determines the longest string and returns the result of
#  - concatenating the shorts string, the longer string, and the short string
#  - once again. You may assume the strings are of different lengths
#  - Input: 2 strings
#  - Output:
#  - Return: shorter + longer + shorter as a string
#
#Examples / Test Cases
#  short_long_short('abc', 'defgh') == "abcdefghabc"
#  short_long_short('abcde', 'fgh') == "fghabcdefgh"
#  short_long_short('', 'xyz') == "xyz"
#
#Data Structures
#  - Input: string
#  - Output:
#  - Return: string
#
#Algorithm / Abstraction
#  - determine longest string using string.length
#  - concatenate strings in correct order - short, long, short
#  - return concatenated strings

# Program
def short_long_short(str1, str2)
  if str1.length > str2.length
    str2 + str1 + str2
  else
    str1 + str2 + str1
  end
end

puts short_long_short('abc', 'defgh') == "abcdefghabc"
puts short_long_short('abcde', 'fgh') == "fghabcdefgh"
puts short_long_short('', 'xyz') == "xyz"

# matching_parentheses.rb

#Understand the problem
#  Write a method that takes a string as argument, and returns true if all parentheses in the string are properly balanced, false otherwise. To be properly balanced, parentheses must occur in matching '(' and ')' pairs.

#Examples / Test Cases
#  balanced?('What (is) this?') == true
#  balanced?('What is) this?') == false
#  balanced?('What (is this?') == false
#  balanced?('((What) (is this))?') == true
#  balanced?('((What)) (is this))?') == false
#  balanced?('Hey!') == true
#  balanced?(')Hey!(') == false
#  balanced?('What ((is))) up(') == false

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
require 'pry'
def balanced?(string)
  balance = 0 # positive = more left parens, negative = more right parens
  characters = string.chars
  characters.each do |char|
    balance += 1 if char == '('
    balance -= 1 if char == ')'
    break if balance < 0
  end
  balance == 0
end

# puts balanced?('What (is) this?') == true
puts balanced?('What is) this?') == false
puts balanced?('What (is this?') == false
puts balanced?('((What) (is this))?') == true
puts balanced?('((What)) (is this))?') == false
puts balanced?('Hey!') == true
puts balanced?(')Hey!(') == false
puts balanced?('What ((is))) up(') == false

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
BRACKETS = {')' => '(', '}' => '{', ']' => '[', "'" => "'", '"' => '"'}
OPENINGS = BRACKETS.values
CLOSINGS = BRACKETS.keys
QUOTES = ["'", '"']

def match_last?(array, char)
  array.last == char
end

def balanced_further?(string)
  unmatched_brackets = []
  string.chars.each do |char|
    if OPENINGS.include?(char)
      # quotes are a special case since the start/end values are identical
      # have to check whether the current quote is a start or end value
      QUOTES.include?(char) && match_last?(unmatched_brackets, char) ?
        unmatched_brackets.pop :
        unmatched_brackets << char
    elsif CLOSINGS.include?(char)
      match_last?(unmatched_brackets, BRACKETS[char]) ?
        unmatched_brackets.pop :
        (return false)
    end
  end
  # if the array is empty then all brackets were matched correctly
  unmatched_brackets.empty?
end

puts balanced_further?('What is) this?') == false
puts balanced_further?('What [is this?') == false
puts balanced_further?('"([What] (is {th}is))?"') == true
puts balanced_further?('((What)) (is this))?') == false
puts balanced_further?('Hey!{"[]"}sdf') == true
puts balanced_further?(')Hey!(') == false
puts balanced_further?('"What ((is))") up(') == false
puts balanced_further?('[(what is) "going" on?]') == true
puts balanced_further?('[(what "is going)" on?]') == false

# palindromic_string_part_2.rb

#Understand the problem
#  - same as part 1 but now case-insensitive and ignore all non-alphanumeric
#  - characters. May call palindrome? from part 1
#  - Input: string
#  - Output: boolean based on real_palindrome
#
#Examples / Test Cases
#  real_palindrome?('madam') == true
#  real_palindrome?('Madam') == true           # (case does not matter)
#  real_palindrome?("Madam, I'm Adam") == true # (only alphanumerics matter)
#  real_palindrome?('356653') == true
#  real_palindrome?('356a653') == true
#  real_palindrome?('123ab321') == false
#
#Data Structures
#  - Input: string
#  - Output: boolean
#
#Algorithm / Abstraction
#  - input string (str)
#  - modified_string = remove all non-alphanumeric characters from
#  - str using select
#  - modified_string = modified_string.downcase
#  - does modified_string == modified_string.reverse?
#  - if true, return true, otherwise return false

# Program
def palindrome?(str)
  str == str.reverse
end

def real_palindrome?(str)
  modified_str = str.downcase.scan(/[a-zA-Z]/).join
  palindrome?(modified_str)
end

puts real_palindrome?('madam') == true
puts real_palindrome?('Madam') == true           # (case does not matter)
puts real_palindrome?("Madam, I'm Adam") == true # (only alphanumerics matter)
puts real_palindrome?('356653') == true
puts real_palindrome?('356a653') == true
puts real_palindrome?('123ab321') == false

#Further Exploration
def real_palindrome_further?(str)
  modified_str = str.downcase.delete('^a-z0-9')
  palindrome?(modified_str)
end

puts real_palindrome_further?('madam') == true
puts real_palindrome_further?('Madam') == true           # (case does not matter)
puts real_palindrome_further?("Madam, I'm Adam") == true # (only alphanumerics matter)
puts real_palindrome_further?('356653') == true
puts real_palindrome_further?('356a653') == true
puts real_palindrome_further?('123ab321') == false

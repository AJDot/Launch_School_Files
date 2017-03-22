# palindromic_numbers.rb

#Understand the problem
#  - method that returns true if its integer argument is palindromic, false
#  - otherwise.
#  - Input: integer
#  - Output: boolean based on palindromic_number?
#
#Examples / Test Cases
#  palindromic_number?(34543) == true
#  palindromic_number?(123210) == false
#  palindromic_number?(22) == true
#  palindromic_number?(5) == true
#
#Data Structures
#  - Input: integer
#  - Output: boolean
#
#Algorithm / Abstraction
#  - input integer (num)
#  - num_arr = num.to_a
#  - num_arr.reverse == num_arr

# Program
def palindrome?(string)
  string.reverse == string
end

def palindromic_number?(num)
  palindrome?(num.to_s)
end

puts palindromic_number?(34543) == true
puts palindromic_number?(123210) == false
puts palindromic_number?(22) == true
puts palindromic_number?(5) == true

#Further exploration
#  - This method will not work if the number is padded in the front with 0s.

puts palindromic_number?(005500) == true

#  - The #to_s method removes the padding.

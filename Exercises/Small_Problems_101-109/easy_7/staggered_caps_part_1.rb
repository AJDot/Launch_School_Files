# staggered_caps_part_1.rb

#Understand the problem
#  Write a method that takes a String as an argument, and returns a new String
#  that contains the original value using a staggered capitalization scheme in
#  which every other character is capitalized, and the remaining characters
#  are lowercase. Characters that are not letters should not be changed, but
#  count as characters when switching between upper and lowercase.
#  - Input:
#  - Output:
#  - Return:
#
#Examples / Test Cases
#  staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
#  staggered_case('ALL_CAPS') == 'AlL_CaPs'
#  staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'

#Data Structures
#  - Input: (string)
#  - Intermediate:
#  - Output:
#  - Return: string with alternating capitalization
#
#Algorithm / Abstraction
#  -

# Program
puts "\n-------"
puts "Program"
puts "-------"
def staggered_case(string)
  staggered_string = ''
  string.chars.each_with_index do |char, index|
    staggered_string << if char =~ /[a-zA-Z]/
                          if index % 2 == 0
                            char.upcase
                          else
                            char.downcase
                          end
                        else
                          char
                        end
  end
  staggered_string
end

puts staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
puts staggered_case('ALL_CAPS') == 'AlL_CaPs'
puts staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def staggered_case_further(string, first_case)
  flip_case = if first_case == 'up'
                true
              elsif first_case == 'down'
                false
              end
  staggered_string = ''
  string.chars.each_with_index do |char, index|
    staggered_string << if char =~ /[a-zA-Z]/
                          if index % 2 == 0
                            flip_case ? char.upcase : char.downcase
                          else
                            flip_case ? char.downcase : char.upcase
                          end
                        else
                          char
                        end
  end
  staggered_string
end

puts staggered_case_further('I Love Launch School!', 'up') == 'I LoVe lAuNcH ScHoOl!'
puts staggered_case_further('ALL_CAPS', 'up') == 'AlL_CaPs'
puts staggered_case_further('ignore 77 the 444 numbers', 'up') == 'IgNoRe 77 ThE 444 NuMbErS'
puts staggered_case_further('I Love Launch School!', 'down') == 'i lOvE LaUnCh sChOoL!'
puts staggered_case_further('ALL_CAPS', 'down') == 'aLl_cApS'
puts staggered_case_further('ignore 77 the 444 numbers', 'down') == 'iGnOrE 77 tHe 444 nUmBeRs'

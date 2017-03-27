# staggered_caps_part_2.rb

#Understand the problem
#  Modify the method from the previous exercise so it ignores non-alphabetic
#  characters when determining whether it should uppercase or lowercase each
#  letter. The non-alphabetic characters should still be included in the
#  return value; they just don't count when toggling the desired case.
#  - Input:
#  - Output:
#  - Return:
#
#Examples / Test Cases
#  staggered_case('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
#  staggered_case('ALL CAPS') == 'AlL cApS'
#  staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'

#Data Structures
#  - Input: (string)
#  - Intermediate:
#  - Output:
#  - Return: string with alternating capitalization, ignoring non-alphabetic
#    characters
#
#Algorithm / Abstraction
#  -

# Program
puts "\n-------"
puts "Program"
puts "-------"
def staggered_case_without_non_alpha(string)
  staggered_string = ''
  need_upper = false
  string.chars.each do |char, index|
    staggered_string << if char =~ /[a-zA-Z]/
                          need_upper = !need_upper
                          if need_upper
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
puts staggered_case_without_non_alpha('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
puts staggered_case_without_non_alpha('ALL CAPS') == 'AlL cApS'
puts staggered_case_without_non_alpha('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def staggered_case_with_non_alpha(string)
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
def staggered_case(string, include_non_alpha = true)
  include_non_alpha ? staggered_case_with_non_alpha(string) : staggered_case_without_non_alpha(string)
end
puts staggered_case('I Love Launch School!', false) == 'I lOvE lAuNcH sChOoL!'
puts staggered_case('ALL CAPS', false) == 'AlL cApS'
puts staggered_case('ignore 77 the 444 numbers', false) == 'IgNoRe 77 ThE 444 nUmBeRs'
puts staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
puts staggered_case('ALL_CAPS') == 'AlL_CaPs'
puts staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'

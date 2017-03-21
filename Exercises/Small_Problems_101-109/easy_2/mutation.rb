# mutation.rb

#  What will the following code print out and why?
#  - array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
#  - array2 = []
#  - array1.each { |value| array2 << value }
#  - array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
#  - puts array2

#Answer
#  - Moe
#  - Larry
#  - CURLY
#  - SHEMP
#  - Harpo
#  - CHICO
#  - Groucho
#  - Zeppo

#Further Exploration
# To fix this we need to call the mutating method on the array itself and not
# on the values (references) in the array. Like so...
array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value }
array1.map! { |value| value.start_with?('C', 'S') ? value.upcase : value}
puts array1
puts array2

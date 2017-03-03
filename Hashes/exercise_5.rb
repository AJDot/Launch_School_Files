# What method could you use to find out if a Hash contains a specific value in
# it? Write a program to demonstrate this use.

puts "You can use the method 'has_value?'"

hash = {apple: 3,
  banana: 4,
  lemon: 1,
  chocolate: 17,
  grape: 87,
  orange: 6,
  lime: 2}

  puts "hash = #{hash}"
  puts "'hash.has_value?(4)' = #{hash.has_value?(4)}"
  puts "'hash.has_value?(85)' = #{hash.has_value?(85)}"

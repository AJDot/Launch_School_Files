# Using some of Ruby's built-in Hash methods, write a program that loops through
# a hash and prints all of the keys. Then write a program that does the same thing
#  except printing the values. Finally, write a program that prints both.

hash = {apple: 3,
  banana: 4,
  lemon: 1,
  chocolate: 17,
  grape: 87,
  orange: 6,
  lime: 2}

puts "MY ANSWER"
puts
puts "hash.keys.each ="
hash.keys.each {|k| puts k}
puts
puts "hash.values ="
hash.values.each {|v| puts v}
puts "hash.each ="
hash.each { |k, v| puts "I have #{v} #{k}#{v > 1 ? 's' : ''}."}
puts

puts "YOUR ANSWER"
hash.each_key { |key| puts key }
hash.each_value { |value| puts value }
hash.each { |key, value| puts "I have #{value} #{key}s."}

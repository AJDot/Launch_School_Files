# 99 Bottles of Beer on the Wall.
# Write a program that prints out the lyrics to that
# beloved classic, "99 Bottles of Beer on the Wall"

bottles = 99
while bottles > 1
  puts "#{bottles} bottles of beer on the wall. #{bottles} bottles of beer."
  print "Take one down and pass it around,"
  bottles -= 1
  puts " #{bottles} bottles of beer on the wall."
end

puts "1 bottle of beer on the wall. 1 bottle of beer."
puts "Take one down and pass it around, no more bottles of beer on the wall."
puts "No more bottles of beer on the wall. No more bottles of beer."
puts "Go to the store and buy some more, 99 bottles of beer on the wall."

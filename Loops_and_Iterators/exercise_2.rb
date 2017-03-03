# Write a while loop that takes input from the user, performs an action,
# and only stops when the user types "STOP". Each loop can get info from
# the user

answer = ""
puts "Why is the sky blue?"
while answer != "STOP"
  answer = gets.chomp
  puts "The sky is blue because #{answer.downcase}?"
  puts "but why?"
end

# Modify the code below so the loop stops iterating when the user inputs 'yes'.
#
# loop do
#   puts 'Should I stop looping?'
#   answer = gets.chomp
# end

# ANSWER

loop do
 puts 'Should I stop looping?'
 answer = gets.chomp
 break if answer == "yes"
 puts "I guess I'll keep going. Answer \"yes\" to stop."
end

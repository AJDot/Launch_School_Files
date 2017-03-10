=begin
  Improved ask method
  That ask method I showed you was OK, but I bet you could do better.
  Try to clean it up by removing the answer variable. You'll have to use
  return to exit from the loop. How do you like the resulting method?
  I usually try to avoid rusing return (a personal preference), but I might
  make an exception here.
=end

def ask question
  while true
    puts question
    reply = gets.chomp.downcase
    if (reply == 'yes' || reply == 'no')
      return reply
    else
      puts 'Please answer "yes" or "no".'
    end
  end
end

puts 'Hello, and thank you for...'
puts
ask 'Do you like eating tacos?'
ask 'Do you like eating burritos?'
wets_bed = ask 'Do you wet the bed?'
ask 'do you like eating chimichangas?'

puts
puts 'DEBRIEFING:'
puts 'Thank you for...'
puts
puts wets_bed

# Deaf grandma.
=begin
  Whatever you say to Grandma, she replies "HUH!? SPEAK UP, SONNY!"
  unless you shout it (capitalize), then she yells back, "NO, NOT SINCE 1938!"
  You can exit only when you tell her "BYE"
  You need to yell "BYE" 3 times before she stops ignoring it
=end

input = ''
count = 0
while true
  puts 'What do you want to tell Grandma?'
  input = gets.chomp

  if input == "BYE"
    count += 1

    if count == 3
      break
    end
  elsif input == input.upcase
    # Grandma can hear you.
    count = 0
    puts 'NO, NOT SINCE ' + (1930 + rand(21)).to_s + '!'
    puts ''
  else
    # Grandma can't hear you.
    count = 0
    puts 'HUH?! SPEAK UP, SONNY!'
    puts ''
  end
end

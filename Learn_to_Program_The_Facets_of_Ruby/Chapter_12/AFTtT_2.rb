=begin
  Happy birthday!
  Ask what year a person was born in, then the month, and then the day.
  Figure out how old they are, and give them a big SPANK!
  for each birthday they have had.
=end

puts 'What year were you born?'
year = gets.chomp.to_i
puts 'What month were you born?'
month = gets.chomp.to_i
puts 'What day were you born?'
day = gets.chomp.to_i

age = 1
while Time.local(year + age, month, day) <= Time.now
  puts "SPANK! (#{age})"
  age += 1
end

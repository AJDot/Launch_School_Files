=begin
  Write a program that asks for a starting year and an ending year
  and then puts all the leap years between them (and including them,
  if they are also leap years).
=end

puts 'Starting year:'
start = gets.chomp.to_i
puts 'Ending year:'
stop = gets.chomp.to_i

current = start

while current <= stop
  if current % 400 == 0
    puts current
  elsif current % 100 != 0 && current % 4 == 0
    puts current
  end
  current += 1
end

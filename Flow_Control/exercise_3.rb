puts "Input a number between 0 and infinity"
n = gets.chomp.to_i

if n < 0
  puts "That is not greater than 0."
elsif n <= 50
  puts "#{n} is between 0 and 50."
elsif n <= 100
  puts "#{n} is between 51 and 100."
else
  puts "#{n} is greater than 100."
end

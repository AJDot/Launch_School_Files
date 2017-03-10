=begin
  Building and sorting an array.
  Write a program that asks us to type as many words as we want (one word
  per line, continuing until we just press ENTER on an empty line) and then
  repeats the words back to us in alphabetical order.
=end

puts 'Enter a list of words. (One word per line, please.)'
puts 'When you are finished, press ENTER on a new line.'

array = []
while true
  input = gets.chomp
  if input == ''
    break
  end
  array.push( input )
end
puts array.sort

=begin
  Party like it's roman_to_integer 'mcmxcix'!

  Create a program that take roman numbers and prints the corresponding
  integer. Make sure to reject strings that aren't alid Roman numerals.
=end

def roman_to_integer roman

  roman_values = {'M' => 1000,
                  'D' => 500,
                  'C' => 100,
                  'L' => 50,
                  'X' => 10,
                  'V' => 5,
                  'I' => 1}

  int_arr = []

  # Take a roman number and split it into each letter
  roman_arr = roman.upcase.split('')

  # if every letter is a valid roman numeral
  roman_arr.each do |is_it|
    if !roman_values[is_it]
      puts 'This is not a valid roman numeral!'
      return
    end
  end

  # Match each letter with its integer value using a hash
  roman_arr.each do |letter|
    int_arr.push(roman_values[letter])
  end

  # check if current number is less than next number
  # if so, subtract it
  # if not, add it
  count = 0
  for n in 0...int_arr.length - 1
    if int_arr[n] < int_arr[n + 1]
      int_arr[n] *= -1
    end
    count += int_arr[n]
  end
  count += int_arr[-1]

  return count
end


puts 'Give me a roman number'
n = gets.chomp

puts "#{n} => #{roman_to_integer n}"

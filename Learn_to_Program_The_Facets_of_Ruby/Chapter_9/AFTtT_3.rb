=begin
  "Modern" Roman numerals.
  Eventually, someone thought it would be terribly clever if putting
  a smaller number before a large one meant you had to subtract the smaller
  one. Rewrite yoru previous method to return the new-style Roman numerals
  so when someone calls roman_numeral 4, it should return 'IV'.
=end

def roman_numeral(n)
  letters = [['M', 1000], ['D', 500], ['C', 100], ['L', 50], ['X', 10], ['V', 5], ['I', 1]]
  roman = ''
  thou = n / 1000
  hund = n % 1000 / 100
  ten = n % 100 / 10
  one = n % 10

  roman << 'M' * thou

  if hund == 9
    roman << 'CM'
  elsif hund == 4
    roman << 'CD'
  else
    roman << 'D' * (n % 1000 / 500)
    roman << 'C' * (n % 500 / 100)
  end

  if ten == 9
    roman << 'XC'
  elsif ten == 4
    roman << 'XL'
  else
    roman << 'L' * (n % 100 / 50)
    roman << 'X' * (n % 50 / 10)
  end

  if one == 9
    roman << 'IX'
  elsif one == 4
    roman << 'IV'
  else
    roman << 'V' * (n % 10 / 5)
    roman << 'I' * (n % 5 / 1)
  end

  puts roman

end

puts 'Give me a number 1-3000 and I\'ll give you some letters for it.'
n = gets.chomp.to_i

roman_numeral(n)

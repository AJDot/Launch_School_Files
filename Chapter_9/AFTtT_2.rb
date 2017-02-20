=begin
  Old-school Roman numerals
  No subtraction. Always biggest to littlest.
  Write a method that when passed an integer between 1 and 3000 (or so)
  returns a string containing the proper old-school Roman numeral.
=end


def roman_numeral(n)
  letters = [['M', 1000], ['D', 500], ['C', 100], ['L', 50], ['X', 10], ['V', 5], ['I', 1]]
  letters.each do |x|
    letter, worth = x
    if letter != "I"
      print letter * (n / worth)
      n %= worth
    else
      puts letter * (n / worth)
      n %= worth
    end
  end
end

puts 'Give me a number 1-3000 and I\'ll give you some letters for it.'
n = gets.chomp.to_i

roman_numeral(n)

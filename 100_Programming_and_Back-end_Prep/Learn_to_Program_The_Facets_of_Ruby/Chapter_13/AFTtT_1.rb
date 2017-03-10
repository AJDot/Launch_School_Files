=begin
  Extend the built-in classes.

  How about making your shuffle method on page 75 an array method?
  Or how about making factorial an integer method?
  4.to_roman, anyone? In each case, remember to use self to access
  the object the method is being called on (the 4 in 4.to_roman).
=end

class String
  def roman_to_integer

    roman_values = {'M' => 1000,
                    'D' => 500,
                    'C' => 100,
                    'L' => 50,
                    'X' => 10,
                    'V' => 5,
                    'I' => 1}

    int_arr = []

    # Take a roman number and split it into each letter
    roman_arr = self.upcase.split('')

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
end

class Array
  def shuffle

    shuffle_rec self, []
  end

  def shuffle_rec remaining, shuffled
    # if all have been shuffled, return the shuffled list
    if remaining.length <= 0
      return shuffled
    end
    # how many are left to shuffle?
    left = remaining.length
    # choose a random index to be the next item index
    next_item_idx = rand(left)
    new_arr = []

    # if the item index in remaining matches the random one, then add it
    # to the shuffled list
    # if not, add it to the new_arr which will become the new remaining list
    current_idx = 0
    remaining.each do |item|
      if current_idx == next_item_idx
        shuffled.push item
      else
        new_arr.push item
      end
      current_idx += 1
    end
    shuffle_rec new_arr, shuffled
  end
end

class Integer
  def to_roman
    n = self
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

  def factorial
    num = self
    if num < 0
      return 'You can\'t take the factorial of a negative number!'
    end

    if num <= 1
      1
    else
      num * (num - 1).factorial
    end
  end
end

puts 'MCMXCIX'.roman_to_integer
puts [1, 2, 3, 4, 5, 6, 7, 8, 9].shuffle.join(" ")
puts 3999.to_roman
[1, 2, 3, 4, 5, 6, 7 , 8, 9, 10].each do |n|
  puts "#{n}! = #{n.factorial}"
end

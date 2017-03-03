def english_number number

  # no negative numbers

  if number < 0
    return 'Pleases enter a number zero or greater.'
  end

  num_string = '' # This is the string we will return

  ones_place = ['one', 'two', 'three',
              'four', 'five', 'six',
              'seven', 'eight', 'nine']
  tens_place = ['ten', 'twenty', 'thirty',
                'forty', 'fifty', 'sixty',
                'seventy', 'eighty', 'ninety']
  teenagers = ['eleven', 'twelve', 'thirteen',
                'fourteen', 'fifteen', 'sixteen',
                'seventeen', 'eighteen', 'nineteen']

  # "left"  is how much of the number
  #         we still have left to write out.
  # "write" is the part we are
  #         writing out right now.

  left = number
  write = left / 100        # How many hundreds left?
  left = left - write * 100   # Subtract off those hundreds.

  if write > 0
    # Now here's the recursion:
    hundreds = english_number write
    num_string = num_string + hundreds + ' hundred'
    if left > 0
      # So we don't write 'two hundredfifty-one'...
      num_string = num_string + ' '
    end
  end

  write = left / 10           # How many tens left?
  left = left - write * 10    # Subtract off those tens

  if write > 0
    if write == 1 and left > 0
      num_string = num_string + teenagers[left - 1]
      left = 0
    else
      num_string = num_string + tens_place[write - 1]
    end

    if left > 0
      num_string = num_string + '-'
    end
  end

  write = left  # How many one left to write out?
  left = 0      # Subtract off those ones.
  if write > 0
    num_string = num_string + ones_place[write - 1]
  end

  if num_string == ''
    # The only way num_string could be empty
    # is if "number" is 0.
    return 'zero'
  end

  num_string
end

while true
  puts "Give me a number:"
  puts "Enter \"STOP\" to exit program."
  n = gets.chomp
  break if n.downcase == 'stop' || n.downcase == 'exit'
  puts english_number( n.to_i )
  puts
end

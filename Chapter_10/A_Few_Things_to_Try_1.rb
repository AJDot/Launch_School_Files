=begin
  Expanded english_number
  First, put in thousands; it should return 'one thousand' instead
  of (the sad) 'ten hundred' and 'ten thousand' instead of 'one hundred
  hundred'
  Now expand upon english-Number some more. For example, put in millions
  so you get 'one million' instead of 'one thousand thousand'. Then try
  adding billions, trillions, and so on.
=end

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
  suffixes = [['googol',             100],
              ['vigintillion',        63],
              ['novemdecillion',      60],
              ['octodecillion',       57],
              ['septendecillion',     54],
              ['sexdecillion',        51],
              ['quindecillion',       48],
              ['quattuordecillion',   45],
              ['tredecillion',        42],
              ['duodecillion',        39],
              ['undecillion',         36],
              ['decillion',           33],
              ['nonillion',           30],
              ['octillion',           27],
              ['septillion',          24],
              ['sextillion',          21],
              ['quintillion',         18],
              ['quadrillion',         15],
              ['trillion',            12],
              ['billion',              9],
              ['million',              6],
              ['thousand',             3],
              ['hundred',              2]]

  # "left"  is how much of the number
  #         we still have left to write out.
  # "write" is the part we are
  #         writing out right now.

  left = number


  suffixes.each do |item|
    suffix, size = item
    size = 10 ** size

    write = left / size       # How many zillions left?
    left = left - write * size   # Subtract off those zillions.

    if write > 0 # we have at least one zillion
      # find the hundeds, tens, and ones of zillions
      number_of = english_number write
      num_string = num_string + number_of + ' ' + suffix
      if left > 0
        num_string = num_string + ' '
      end
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

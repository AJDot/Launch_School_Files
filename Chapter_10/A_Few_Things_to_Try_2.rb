# 99 Bottles of Beer on the Wall.
# Write a program that prints out the lyrics to that
# beloved classic, "99 Bottles of Beer on the Wall"

def bottles(n, total = n)

  puts english_number(n).capitalize + " bottles of beer on the wall, " +
       english_number(n) + " bottles of beer."
  puts "Take one down and pass it around, " + english_number(n-1) +
       " bottle#{n-1==1 ? '' : 's'} of beer on the wall."
  puts

  # recursion
  if n > 2
    bottles(n-1, total)
  else
    puts "1 bottle of beer on the wall. 1 bottle of beer."
    puts "Take one down and pass it around, no more bottles of beer on the wall."
    puts
    puts "No more bottles of beer on the wall. No more bottles of beer."
    puts "Go to the store and buy some more, " + english_number(total) +
         " bottles of beer on the wall."
    puts
  end
end

# Here is the program to convert integers to their English form
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
  puts "How many bottles of beer are on the wall?"
  n = gets.chomp
  puts
  break if n == 'stop' || n == 'exit'
  bottles(n.to_i)
end

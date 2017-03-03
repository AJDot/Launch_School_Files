num = 3456
thousands = num / 1000
hundreds = num % 1000 / 100
tens = num % 100 / 10
ones = num % 10

puts "#{num} = #{thousands} thousands, #{hundreds} hundreds, #{tens} tens, and #{ones} ones"

# input
#   - positive integer
# output
#   - positive integer with digits reversed

# convert integer to string and split into digits as array
# reverse the array
# join array with no delimiter
# convert reversed string to integer

def reversed_number(number)
  digits = number.to_s.chars
  digits.reverse!
  digits.join.to_i
  
end


p reversed_number(12345) == 54321
p reversed_number(12213) == 31221
p reversed_number(456) == 654
p reversed_number(12000) == 21 # Note that zeros get dropped!
p reversed_number(1) == 1
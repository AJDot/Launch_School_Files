# Write a method that takes a positive integer as an argument and
# returns that number with its digits reversed. Examples:

def reversed_number(number)
  number.to_s.reverse.to_i
end



p reversed_number(12345) == 54321
p reversed_number(12213) == 31221
p reversed_number(456) == 654
p reversed_number(12000) == 21 # Note that zeros get dropped!
p reversed_number(1) == 1

def reversed_number(number)
  result = 0
  until number == 0
    number, remainder = number.divmod(10)
    result = result * 10 + remainder
  end
  result
end

p reversed_number2(12345) == 54321
p reversed_number2(12213) == 31221
p reversed_number2(456) == 654
p reversed_number2(12000) == 21 # Note that zeros get dropped!
p reversed_number2(1) == 1

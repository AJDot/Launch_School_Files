# Write a method that counts down to zero using recursion.

def count_to_zero(num)
  if num <= 0
    puts num
  else
    puts num
    count_to_zero(num - 1)
  end
end

count_to_zero(9)

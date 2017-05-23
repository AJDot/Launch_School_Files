# times.rb

# method implementation
def times(number)
  counter = 0
  while counter < number do
    yield(counter)
    counter += 1
  end

  number
end

# method invocation
times(5) do |num|
  puts num
end

# Output:
# 0
# 1
# 2
# 3
# 4
# => 5

# Code trace:
# 15
# 4
# 5
# 6 (while)
# 7
# 15
# 16
# 17
# 8 (end while)
# 10
# 11
# 12

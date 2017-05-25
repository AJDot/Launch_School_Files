factorial = Enumerator.new do |y|
  fact = 1
  idx = 1
  loop do
    y << fact
    # also could be...
    # y.yield(fact)
    fact *= idx
    idx += 1
  end
end

# External Iterator
7.times { puts factorial.next }

# Go back to start
factorial.rewind

# Internal Iterator
p factorial.take(7)

# Internal Iterator
factorial.each_with_index do |number, index|
  puts number
  break if index == 6
end

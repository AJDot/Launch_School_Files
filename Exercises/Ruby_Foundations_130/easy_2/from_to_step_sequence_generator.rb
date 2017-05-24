def step(start, stop, increment)
  current = start
  while current <= stop
    yield(current)
    current += increment
  end
  current
end

step(1, 10, 3) { |value| puts "value = #{value}" }
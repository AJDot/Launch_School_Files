def compute(element = nil)
  return 'Does not compute.' unless block_given?
  yield(element)
end

p compute(5) { |num| num + 3 } == 8          # => true
p compute('b') { |string| 'a' + string } == 'ab'   # => true
p compute == 'Does not compute.'  # => true

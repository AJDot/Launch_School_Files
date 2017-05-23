def compute
  return 'Does not compute.' unless block_given?
  yield
end

compute { 5 + 3 } == 8          # => true
compute { 'a' + 'b' } == 'ab'   # => true
compute == 'Does not compute.'  # => true

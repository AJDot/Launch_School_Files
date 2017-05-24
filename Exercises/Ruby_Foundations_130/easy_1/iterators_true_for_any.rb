def any?(collection)
  collection.each do |item|
    return true if yield(item)
  end
  false
end

p any?([1, 3, 5, 6]) { |value| value.even? } == true
p any?([1, 3, 5, 7]) { |value| value.even? } == false
p any?([2, 4, 6, 8]) { |value| value.odd? } == false
p any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
p any?([1, 3, 5, 7]) { |value| true } == true
p any?([1, 3, 5, 7]) { |value| false } == false
p any?([]) { |value| true } == false

# Further Exploration
require 'set'
puts '', '---- Further Exploration -----'
p any?({'a' => 1, 'b' => 2, 'c' => 3}) { |k, v| v == 3 } == true
p any?(Set.new [1, 2, 3, 4, 5]) { |value| value.even? } == true
p any?(Set.new [1, 2, 3, 4, 5]) { |value| value == 100 } == false
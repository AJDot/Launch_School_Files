def count(collection)
  count = 0
  collection.each do |item|
    count += 1 if yield(item)
  end
  count
end

p count([1,2,3,4,5]) { |value| value.odd? } == 3
p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count([1,2,3,4,5]) { |value| true } == 5
p count([1,2,3,4,5]) { |value| false } == 0
p count([]) { |value| value.even? } == 0
p count(%w(Four score and seven)) { |value| value.size == 5 } == 2

puts '---- Further Exploration ----'
def count_further(collection)
  collection.select { |item| yield(item) }.size
end

p count_further([1,2,3,4,5]) { |value| value.odd? } == 3
p count_further([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count_further([1,2,3,4,5]) { |value| true } == 5
p count_further([1,2,3,4,5]) { |value| false } == 0
p count_further([]) { |value| value.even? } == 0
p count_further(%w(Four score and seven)) { |value| value.size == 5 } == 2
def max_by(collection)
  return nil if collection.empty?

  max = collection.first
  max_yield = yield(max)
  collection.each do |item|
    item_yield = yield(item)
    if item_yield > max_yield
      max = item
      max_yield = item_yield
    end
  end
  max
end

p max_by([1, 5, 3]) { |value| value + 2 } == 5
p max_by([1, 5, 3]) { |value| 9 - value } == 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
p max_by([-7]) { |value| value * 3 } == -7
p max_by([]) { |value| value + 5 } == nil
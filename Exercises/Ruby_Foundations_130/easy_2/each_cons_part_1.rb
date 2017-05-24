def each_cons(collection)
  index = 0
  while index < collection.size - 1
    yield(collection[index], collection[index + 1])
    index += 1
  end
end
 # OR
# def each_cons(collection)
#   collection.each_with_index do |item, idx|
#     (break if idx >= collection.size - 1)
#     yield(item, collection[idx + 1])
#   end
# end


hash = {}
result = each_cons([1, 3, 6, 10]) do |value1, value2|
  hash[value1] = value2
end

p result == nil
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([]) do |value1, value2|
  hash[value1] = value2
end
p hash == {}

hash = {}
each_cons(['a', 'b']) do |value1, value2|
  hash[value1] = value2
end
p hash == {'a' => 'b'}
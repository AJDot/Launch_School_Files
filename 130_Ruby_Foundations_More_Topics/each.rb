# each.rb

def each(array)
  counter = 0

  while counter < array.size
    yield(array[counter])
    counter += 1
  end

  array
end

# can even chain methods since #each returns the calling object.
each([1, 2, 3, 4, 5]) { |num| "do nothing" }.select{ |num| num.odd? }

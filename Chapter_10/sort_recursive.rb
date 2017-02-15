def sort list
  sort_recursive list, []
end

def sort_recursive unsorted, sorted
  # if nothing left to sort
  if unsorted.length <= 0
    return sorted
  end

  smallest = unsorted.pop
  still_unsorted = []

  unsorted.each do |tested_object|
    if tested_object < smallest
      still_unsorted.push smallest
      smallest = tested_object
    else
      still_unsorted.push tested_object
    end
  end

  # Now smallest really does point to the smallest element in
  # unsorted.

  sorted.push smallest

  sort_recursive still_unsorted, sorted
end

list = ['x', 'd', 'c', 'c', 'Apple', 'banana', 'apple', 'orange', 'k', 'u']

print list.sort
puts ""
print sort list

def dictionary_sort list
  dictionary_sort_rec list, []
end

def dictionary_sort_rec unsorted, sorted
  # if nothing left to sort
  if unsorted.length <= 0
    return sorted
  end

  smallest = unsorted.pop
  still_unsorted = []

  unsorted.each do |tested_object|
    if tested_object.downcase < smallest.downcase
      still_unsorted.push smallest
      smallest = tested_object
    else
      still_unsorted.push tested_object
    end
  end

  # Now smallest really does point to the smallest element in
  # unsorted.

  sorted.push smallest

  dictionary_sort_rec still_unsorted, sorted
end

list = ['x', 'd', 'c', 'c', 'Apple', 'banana', 'apple', 'Orange', 'k', 'u']
list = ['can', 'Feel', 'singing', 'Like', 'a', 'can']

puts list.join(" ")
puts list.sort.join(" ")
print dictionary_sort(list).join(" ")
puts

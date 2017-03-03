def shuffle list
  unsorted = list.dup
  shuffle_rec unsorted, []
end

def shuffle_rec remaining, shuffled
  left = remaining.length

  if left >= 1
    next_item_idx = rand(0...left)
    shuffled << remaining[next_item_idx]
    remaining.delete_at(next_item_idx)
    shuffle_rec remaining, shuffled
  else
    return shuffled
  end
end
list = ['x', 'd', 'c', 'c', 'Apple', 'banana', 'apple', 'orange', 'k', 'u']


print list
puts
print shuffle list
puts

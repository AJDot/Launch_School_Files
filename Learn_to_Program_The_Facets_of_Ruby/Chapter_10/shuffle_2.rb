def shuffle list

  shuffle_rec list, []
end

def shuffle_rec remaining, shuffled
  # if all have been shuffled, return the shuffled list
  if remaining.length <= 0
    return shuffled
  end
  # how many are left to shuffle?
  left = remaining.length
  # choose a random index to be the next item index
  next_item_idx = rand(left)
  new_arr = []

  # if the item index in remaining matches the random one, then add it
  # to the shuffled list
  # if not, add it to the new_arr which will become the new remaining list
  current_idx = 0
  remaining.each do |item|
    if current_idx == next_item_idx
      shuffled.push item
    else
      new_arr.push item
    end
    current_idx += 1
  end
  shuffle_rec new_arr, shuffled
end

list = [1, 2, 3, 4, 5, 6, 7, 8, 9]

print list
puts
print shuffle list
puts

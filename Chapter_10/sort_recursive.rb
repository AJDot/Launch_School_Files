def sort list
  unsorted_list = list.dup
  sorted_list = []
  sorted_list << unsorted_list[0]
  unsorted_list.delete_at(0)
  sort_recursive unsorted_list, sorted_list
end

def sort_recursive unsorted_list, sorted_list
  new_item = unsorted_list[0]

  sorted_list.each_with_index do |sorted_item, idx|
    if unsorted_list.length == 0
      break
    end

    if new_item <= sorted_item
      sorted_list.insert(idx, new_item)
      unsorted_list.delete_at(0)
      sort_recursive unsorted_list, sorted_list
    elsif idx == sorted_list.length - 1
      sorted_list << new_item
      unsorted_list.delete_at(0)
      sort_recursive unsorted_list, sorted_list
    end
  end
  sorted_list
end

list = ['x', 'd', 'c', 'c', 'Apple', 'banana', 'apple', 'orange', 'k', 'u']

print sort list
puts ""
print list.sort

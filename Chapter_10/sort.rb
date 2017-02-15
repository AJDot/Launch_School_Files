
def sort_list list
  sorted_list = []
  # duplicate list
  unsorted_list = list.dup
  # add first item to sorted list
  sorted_list << unsorted_list[0]
  # delete first item from unsorted_list
  unsorted_list.delete_at(0)

  # run this loop for every item in unsorted_list
  unsorted_list.length.times do
    # run this for every item in sorted_list
    sorted_list.each_with_index do |item, idx|
      # insert unsorted item if it is <= the current sorted item
      if unsorted_list[0] <= item
        sorted_list.insert(idx, unsorted_list[0])
        unsorted_list.delete_at(0)
        break
      # if item is not less than anything, insert it at the end
      elsif idx == sorted_list.length - 1
        sorted_list << unsorted_list[0]
        unsorted_list.delete_at(0)
      end
    end
  end
  # return the sorted list
  sorted_list
end

list = ['x', 'd', 'e', 'c', 'r', 'c', 'Apple', 'banana', 'apple', 'orange', 'k', 'u']

print sort_list(list)
puts ""
print list.sort

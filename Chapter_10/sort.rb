
def sort list
  sorted_list = []
  sorted_list << list[0]
  list.delete_at(0)
  list.each do |item|
    if item <= sorted_list[0]
      sorted_list.insert(0, item)
      break
    end
  end

  sorted_list

end

list = ['x', 'd', 'e', 'c', 'r', 'c', 'd', 'g', 'h', 'j', 'k', 'u']

puts sort list

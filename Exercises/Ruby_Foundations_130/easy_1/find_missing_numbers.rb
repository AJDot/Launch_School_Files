# find_missing_numbers.rb

def missing(array)
  start = array.first + 1
  stop = array.last

  result = []
  (start..stop).each do |num|
    result << num unless array.include? num
  end

  result
end

p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
p missing([1, 2, 3, 4]) == []
p missing([1, 5]) == [2, 3, 4]
p missing([6]) == []

# LS Solution
def missing_ls(array)
  result = []
  array.each_cons(2) do |first, second|
    result.concat(((first + 1)..(second - 1)).to_a)
  end
  result
end

p missing_ls([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
p missing_ls([1, 2, 3, 4]) == []
p missing_ls([1, 5]) == [2, 3, 4]
p missing_ls([6]) == []

# Further Exploration
def missing_further(array)
  all_nums = (array.first...array.last).to_a
  all_nums - array
end

p missing_further([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
p missing_further([1, 2, 3, 4]) == []
p missing_further([1, 5]) == [2, 3, 4]
p missing_further([6]) == []

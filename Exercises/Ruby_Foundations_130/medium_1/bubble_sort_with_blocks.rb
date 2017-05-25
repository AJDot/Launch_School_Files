def bubble_sort!(array)
  stop = array.size - 1

  loop do
    swapped = false
    1.upto(stop) do |index|
      if block_given?
        next if yield(array[index - 1], array[index])
      else
        next if array[index] >= array[index - 1]
      end

      array[index], array[index - 1] = array[index - 1], array[index]
      swapped = true
    end

    stop -= 1
    break unless swapped
  end
end

array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
p array == [7, 5, 3]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = [6, 12, 27, 22, 14]
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
p array == [14, 22, 12, 6, 27]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
p array == %w(Kim Pete Tyler alice bonnie rachel sue)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)

puts '--- Further Exploration ---'
def bubble_sort_further!(array)
  stop = array.size - 1

  loop do
    swapped = false
    1.upto(stop) do |index|
      if block_given?
        next if yield(array[index - 1]) <= yield(array[index])
      else
        next if array[index] >= array[index - 1]
      end

      array[index], array[index - 1] = array[index - 1], array[index]
      swapped = true
    end

    stop -= 1
    break unless swapped
  end
end

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort_further!(array) { |value| value.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort_further!(array) { |value| value.upcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)

array = [-100, -2, -1, 0, 1, 2, 100]
bubble_sort_further!(array) { |value| value ** 2 }
p array == [0, -1, 1, -2, 2, -100, 100]
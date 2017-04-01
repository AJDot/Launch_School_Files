# bubble_sort.rb

#Understand the problem
#  Bubble Sort is one of the simplest sorting algorithms available. It isn't an
#  efficient algorithm, but it's a great exercise for student developers. In
#  this exercise, you will write a method that does a bubble sort of an Array.

#  A bubble sort works by making multiple passes (iterations) through the
#  Array. On each pass, each pair of consecutive elements is compared. If the
#  first of the two elements is greater than the second, then the two elements
#  are swapped. This process is repeated until a complete pass is made without
#  performing any swaps; at that point, the Array is completely sorted.

#  Write a method that takes an Array as an argument, and sorts that Array
#  using the bubble sort algorithm as just described. Note that your sort will
#  be "in-place"; that is, you will mutate the Array passed as an argument. You
#  may assume that the Array contains at least 2 elements.

#Examples / Test Cases
#  array = [5, 3]
#  bubble_sort!(array)
#  array == [3, 5]
#
#  array = [6, 2, 7, 1, 4]
#  bubble_sort!(array)
#  array == [1, 2, 4, 6, 7]
#
#  array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
#  bubble_sort!(array)
#  array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)

#Data Structures
#  - Input:
#  - Intermediate:
#  - Output:
#  - Return:
#
#Algorithm / Abstraction
#  -

# Program
puts "\n-------"
puts "Program"
puts "-------"
def bubble_sort!(array)
  check_count = array.length - 2
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      next if array[index] >= array[index - 1]
      array[index], array[index - 1] = array[index - 1], array[index]
      swapped = true
    end
    break unless swapped
  end
end

array = [5, 3]
bubble_sort!(array)
puts array == [3, 5]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
puts array == [1, 2, 4, 6, 7]

array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort!(array)
puts array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def bubble_sort_further!(array)
check_count = array.length - 2
stop = array.size - 1
loop do
  swapped = false
  1.upto(stop) do |index|
    next if array[index] >= array[index - 1]
    array[index], array[index - 1] = array[index - 1], array[index]
    swapped = true
  end
  stop -= 1
  break unless swapped
  end
end

array = [5, 3]
bubble_sort_further!(array)
puts array == [3, 5]

array = [6, 2, 7, 1, 4]
bubble_sort_further!(array)
puts array == [1, 2, 4, 6, 7]

array = %w(Sue Pete Alice Tyler Rachel Kim Bonnie)
bubble_sort_further!(array)
puts array == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)

puts "\n-------------------"
puts "Animation"
puts "-------------------"

def animate(array)
  system "clear"
  sort_display = []
  array.each do |n|
    sort_display << " " * n + "#{n}"
  end
  sort_display.reverse!
  puts sort_display
  sleep(0.02)
end

def bubble_sort_animation!(array)
check_count = array.length - 2
stop = array.size - 1
loop do
  swapped = false
  1.upto(stop) do |index|
    next if array[index] >= array[index - 1]
    array[index], array[index - 1] = array[index - 1], array[index]
    swapped = true

    animate(array)
  end
  stop -= 1
  break unless swapped
  end
end

numbers = (0..50).to_a.shuffle

bubble_sort_animation!(numbers)
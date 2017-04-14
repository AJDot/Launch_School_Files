# Write a method that selects an element from an array if its index is a fibonacci number
def fibonacci(n)
  first = 1
  second = 1
  
  return 1 if n <= 2
  (n-2).times do
    first, second = second, first + second
  end
  second
end


def fib_idx(array)
  fibs = (1..array.size).to_a.map { |idx| fibonacci(idx) }
  result = []
  array.each_with_index { |item, idx| result << item if fibs.include?(idx) }
  result
end
a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 ,26, 27, 28, 29, 30]

p fib_idx(a)
p fib_idx(a.reverse)
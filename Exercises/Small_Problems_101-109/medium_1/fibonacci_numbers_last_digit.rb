# fibonacci_numbers_procedural.rb

#Understand the problem
#  In this exercise, you are going to compute a method that returns the last
#  digit of the nth Fibonacci number.

#Examples / Test Cases
#  fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
#  fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
#  fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is
#  354224848179261915075)
#  fibonacci_last(100_001)   # -> 1 (this is a 20899 digit number)
#  fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
#  fibonacci_last(123456789) # -> 4

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
def fibonacci_last(nth)
  last_2 = [1, 1]
  3.upto(nth) do
    last_2 = [last_2.last, (last_2.first + last_2.last) % 10]
  end
  last_2.last
end

puts fibonacci_last(15)
puts fibonacci_last(20)
puts fibonacci_last(100)
puts fibonacci_last(100_001)
puts fibonacci_last(1_000_007)
# puts fibonacci_last(123456789)


puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

# Use fibonacci_last to calculate the ending the first 1500 fibonacci numbers
endings = []
1.upto(1500) do |nth|
  endings << fibonacci_last(nth)
end

# find when the pattern of endings repeat
cycles = []
1.upto(endings.length) do |span|
  if endings[1..span] == endings[(span + 1)..(2*span)]
    cycles << span
  end
end
p cycles
# answer is 60
# Therefore the cycle repeats every 60 numbers.
# Ex: #1 and #61 will have the same ending.
# Ex: #5 and #65 will have the same ending.

# All we need to do then is calculate fibonacci_last(nth % 60)
def fibonacci_last_instant(nth)
  fibonacci_last(nth % 60)
end

puts "Fibonacci number 123 end in: #{fibonacci_last_instant(123)}"
puts "Fibonacci number 123_456 end in: #{fibonacci_last_instant(123_456)}"
puts "Fibonacci number 123_456_789 end in: #{fibonacci_last_instant(123_456_789)}"
puts "Fibonacci number 123_456_789_987 end in: #{fibonacci_last_instant(123_456_789_987)}"
puts "Fibonacci number 123_456_789_987_745 end in: #{fibonacci_last_instant(123_456_789_987_745)}"

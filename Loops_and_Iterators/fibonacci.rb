# fibonacci.rb

def fibonacci(number)
  if number < 2
    number
  else
    fibonacci(number - 1) + fibonacci(number - 2)
  end
end

puts "What fibonacci number do you want to know?"
n = gets.chomp.to_i
puts "Fibonacci ##{n} is #{fibonacci(n)}."

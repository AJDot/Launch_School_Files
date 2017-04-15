# Example of when to use 'next' vs when to use 'break'

# Find the first n prime numbers

def prime?(n)
  result = true
  (2..n-1).each do |divisor|
    if n % divisor == 0
      result = false
      break
    end
  end
  result
end

def first_primes(n)
  result = []
  number = 1
  loop do 
    number += 1
    # next moves to next iteration if number is not prime
    # this prevents the execution of 'result << number' unless number is prime
    next if !prime?(number)
    result << number
    # break will stop the loop if the number of primes collected is equal to 
    # the method argument
    break if result.size == n
  end
  result
end

(1..20).each { |num| p first_primes(num) }
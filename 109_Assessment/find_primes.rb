def prime?(n)
  is_prime = true
  (2...n).each do |factor|
    if n % factor == 0
      return false
    end
  end
  is_prime
end

def find_primes(start, stop)
  (start..stop).select do |n|
    prime?(n)
  end
end

p find_primes(1, 20)

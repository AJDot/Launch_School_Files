class Sieve
  def initialize(limit)
    @limit = limit
  end
  # Using a hash
  # def primes
  #   list = {}
  #   (2..@limit).to_a.each { |num| list[num] = :unmarked }
  #   current_prime = 0
  #   loop do
  #     current_prime = list.keys.find { |num| list[num] == :unmarked && num > current_prime }

  #     break if current_prime.nil?

  #     (current_prime + 1..@limit).each do |num|
  #       list[num] = :marked if num % current_prime == 0
  #     end
  #   end
  #   list.keys.select { |num| list[num] == :unmarked }
  # end

  # Using a list
  def primes
    list = (2..@limit).to_a
    primes = []
    until list.empty?
      primes << list.shift
      list.reject! { |num| num % primes.last == 0 }
    end
    primes
  end
end

p Sieve.new(10).primes
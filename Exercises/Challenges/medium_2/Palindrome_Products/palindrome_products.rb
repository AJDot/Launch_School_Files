require 'pry'
class Palindromes
  attr_reader :all_palindromes
  def initialize(min_factor: 1, max_factor:)
    @max_factor = max_factor
    @min_factor = min_factor
  end

  def generate
    @all_palindromes = {}

    possibilities = (@min_factor..@max_factor).to_a.repeated_combination(2)
    possibilities.each do |x, y|
      product = x * y
      if palindrome?(product)
        @all_palindromes[product] ||= []
        @all_palindromes[product] << [x, y]
      end
    end
  end

  def largest
    largest_product = @all_palindromes.keys.max
    Palindrome.new(largest_product, @all_palindromes[largest_product])
  end

  def smallest
    smallest_product = @all_palindromes.keys.min
    Palindrome.new(smallest_product, @all_palindromes[smallest_product])
  end

  private

  def palindrome?(num)
    string = num.to_s.chars
    string == string.reverse
  end
end

class Palindrome
  attr_reader :value, :factors

  def initialize(value, factors)
    @value = value
    @factors = factors
  end
end

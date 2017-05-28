# class SumOfMultiples
#   def self.to(limit, factors = [3, 5])
#     (0...limit).select do |number|
#       factors.any? { |factor| number % factor == 0 }
#     end.reduce(:+)
#   end
#
#   def initialize(*factors)
#     @factors = factors
#   end
#
#   def to(limit)
#     class.to(limit, @factors)
#   end
# end

# OR

class SumOfMultiples
  def self.to(limit)
    new(3, 5).to(limit)
  end

  def initialize(*factors)
    @factors = factors
  end

  def to(limit)
    numbers = (0...limit).select do |number|
      @factors.any? { |factor| number % factor == 0 }
    end
    numbers.reduce(:+)
  end
end

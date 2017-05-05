# class Expander
#   def initialize(string)
#     @string = string
#   end
#
#   def to_s
#     self.expand(3)
#   end
#
#   private
#
#   def expand(n)
#     @string * n
#   end
# end
#
# expander = Expander.new('xyz')
# puts expander

# ANSWER
# self.expand(3) will call #expand as if from outside the class. This is not allowed because expand is a private method.
# Make 'self.expand(3)' be 'expand(3)'
class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander
